# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools git-2 eutils

DESCRIPTION="Lightweight websever/benchmark tool"
HOMEPAGE="https://github.com/mamchits/phantom"
EGIT_REPO_URI="git://github.com/mamchits/phantom.git"
SRC_URI=

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+ssl dev debug"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS="AUTHORS README README.ru"

src_compile() {
	epatch "${FILESDIR}/debug-addrinfo_bfd.patch"
	epatch "${FILESDIR}/Makefile.jemalloc.params.patch"
	echoo "FAX"
	epatch "${FILESDIR}/code_style.patch"
    emake -R || die
}
src_install () {
	insinto "/usr/bin/"
	insopts -m0755
	doins bin/phantom
	insinto "/usr/lib/phantom/"
	doins lib/phantom/mod_io_client.so lib/phantom/mod_io_client_ipv4.so lib/phantom/mod_io_client_ipv6.so lib/phantom/mod_io_client_local.so lib/phantom/mod_io_client_proto_none.so lib/phantom/mod_io_client_proto_fcgi.so lib/phantom/mod_io_stream.so lib/phantom/mod_io_stream_ipv4.so lib/phantom/mod_io_stream_ipv6.so lib/phantom/mod_io_stream_proto_monitor.so lib/phantom/mod_io_stream_proto_echo.so lib/phantom/mod_io_stream_proto_http.so lib/phantom/mod_io_stream_proto_http_handler_null.so lib/phantom/mod_io_stream_proto_http_handler_static.so lib/phantom/mod_io_stream_proto_http_handler_proxy.so lib/phantom/mod_io_stream_proto_http_handler_fcgi.so lib/phantom/mod_io_benchmark.so lib/phantom/mod_io_benchmark_method_stream.so lib/phantom/mod_io_benchmark_method_stream_ipv4.so lib/phantom/mod_io_benchmark_method_stream_ipv6.so lib/phantom/mod_io_benchmark_method_stream_local.so lib/phantom/mod_io_benchmark_method_stream_proto_none.so lib/phantom/mod_io_benchmark_method_stream_proto_http.so lib/phantom/mod_io_benchmark_method_stream_source_random.so lib/phantom/mod_io_benchmark_method_stream_source_log.so

	if use ssl ; then
		insinto "/usr/lib/phantom/"
		doins lib/phantom/mod_ssl.so lib/phantom/mod_io_stream_transport_ssl.so lib/phantom/mod_io_benchmark_method_stream_transport_ssl.so
	fi

	if use debug ; then
		insinto "/usr/lib/phantom/"
		doins lib/phantom/mod_debug.so
	fi

	if use dev ; then
		insinto "/usr/lib/"
		doins lib/libpd-base.a lib/libpd-base.s.a lib/libpd-bq.a lib/libpd-bq.s.a lib/libpd-http.a lib/libpd-http.s.a
		insinto "/usr/include/pd/base/"
		doins pd/base/netaddr_local.H pd/base/list2.H pd/base/str.H pd/base/assert.H pd/base/ipv4.H pd/base/defs.H pd/base/log.H pd/base/in_fd.H pd/base/config_record.H pd/base/out.H pd/base/cmp.H pd/base/log_file_handler.H pd/base/config_switch.H pd/base/op.H pd/base/netaddr.H pd/base/in_buf.H pd/base/netaddr_ipv4.H pd/base/config_block.H pd/base/config_struct.H pd/base/config_helper.H pd/base/in.H pd/base/fd_tcp.H pd/base/config_list.H pd/base/thr.H pd/base/config_named_list.H pd/base/size.H pd/base/string.H pd/base/string_file.H pd/base/fd.H pd/base/trace.H pd/base/frac.H pd/base/uint128.H pd/base/list.H pd/base/config_syntax.H pd/base/config_enum.H pd/base/out_fd.H pd/base/queue.H pd/base/netaddr_ipv6.H pd/base/fbind.H pd/base/exception.H pd/base/time.H pd/base/fd_guard.H pd/base/ref.H pd/base/ipv6.H pd/base/config.H pd/base/random.H
		insinto "/usr/include/pd/bq/"
		doins pd/bq/bq_in.H pd/bq/bq_heap.H pd/bq/bq_job.H pd/bq/bq_conn.H pd/bq/bq_conn_fd.H pd/bq/bq_mutex.H pd/bq/bq_out.H pd/bq/bq_cont.H pd/bq/bq_cond.H pd/bq/bq_util.H pd/bq/bq.H pd/bq/bq_spec.H pd/bq/bq_thr.H
		insinto "/usr/include/pd/fixinclude/"
		doins pd/fixinclude/errno.h pd/fixinclude/pthread.h
		insinto "/usr/include/pd/http/"
		doins pd/http/server.H pd/http/http.H pd/http/client.H pd/http/limits_config.H
		insinto "/usr/include/phantom/"
		doins phantom/setup.H phantom/pd.H phantom/io_logger_file.H phantom/arena.H phantom/module.H phantom/obj.H phantom/logger.H phantom/scheduler.H phantom/io.H
		insinto "/usr/include/phantom/io_benchmark/"
		doins phantom/io_benchmark/method.H
		insinto "/usr/include/phantom/io_benchmark/method_stream/"
		doins phantom/io_benchmark/method_stream/transport.H phantom/io_benchmark/method_stream/proto.H phantom/io_benchmark/method_stream/source.H phantom/io_benchmark/method_stream/logger.H phantom/io_benchmark/method_stream/method_stream.H
		insinto "/usr/include/phantom/io_client/"
		doins phantom/io_client/proto.H phantom/io_client/link.H
		insinto "/usr/include/phantom/io_client/proto_fcgi/"
		doins phantom/io_client/proto_fcgi/proto_fcgi.H
		insinto "/usr/include/phantom/io_client/proto_none/"
		doins phantom/io_client/proto_none/proto_none.H phantom/io_client/proto_none/task.H
		insinto "/usr/include/phantom/io_stream/"
		doins phantom/io_stream/transport.H phantom/io_stream/proto.H phantom/io_stream/io_stream.H phantom/io_stream/acl.H
		insinto "/usr/include/phantom/io_stream/proto_http/"
		doins phantom/io_stream/proto_http/path.H phantom/io_stream/proto_http/handler.H phantom/io_stream/proto_http/logger.H
		insinto "/usr/include/phantom/io_stream/proto_http/handler_static/"
		doins phantom/io_stream/proto_http/handler_static/file_types.H	phantom/io_stream/proto_http/handler_static/path_translation.H
		insinto "/usr/share/phantom/"
		doins pd/library.mk phantom/module.mk test/test.mk opts.mk debian/package.mk
		if use debug ; then
			insinto "/usr/lib/"
			doins lib/libpd-debug.a lib/libpd-debug.s.a
			insinto "/usr/include/pd/debug/"
			doins pd/debug/addrinfo_bfd.H
		fi
		if use ssl ; then
			insinto "/usr/lib/"
			doins lib/libpd-ssl.a lib/libpd-ssl.s.a
			insinto "/usr/include/pd/ssl/"
			doins pd/ssl/ssl.H pd/ssl/bq_conn_ssl.H
			insinto "/usr/include/phantom/ssl/"
			doins phantom/ssl/auth.H
		fi
	fi
}
