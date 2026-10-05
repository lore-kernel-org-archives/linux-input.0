Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C631F989;
	Mon,  5 Oct 2026 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200013; cv=none; b=nBW5HHe91frdpTjpBoYu2VeOtTD/4KQoaRmB90jUD5xR06gQgLcEYK1IguOBkmaxVGkrt2jMeot+Wuht0+VKPtfNNanbAmmS7RBUzRV1+vztcZwycKJNpfbn7X1uC7bsTCvYNBP9TR6MsjwPMkonUCEqbEoeASMbITl7PkvqVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200013; c=relaxed/simple;
	bh=Wpr48c94oU5+NvzPcit0pqXalaVgtcp9KdCZNclssVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8jMVXeL7TlbVEZsbJU9uWLOhXOpOt6JMsIWa0kVWvta6QAIRxZBeQp76aBGFsT410PsnH523H6O8PimdwY2XCCX2vaxYkBdzKHnPmM1AYzNH5AWj2chZzdbBs0uoPz6Y4Og8ucCp+52nC2GBBm9pyfajJQ5K1VTYvzl0HV1mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAIHjFWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAIHjFWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80CC1F000FF;
	Mon,  5 Oct 2026 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791200012;
	bh=CDSI1fzd06xogRlRsAAlSIYZUx/yG6yhOmXVab/hmYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DAIHjFWAxf3xmj/jwYqfZwZ3E1mfmWBY9gBGxuEz+hac12tLDEw1xFYEQai0vqGXr
	 jv3ltiorrhLfi+YBk4d0asUZKPAWiQQzrw3Qbx9y9k0u9CBjZmqR3vQRqM0A4YxSAE
	 iiovdQT0LoDxmYm/9q/caD/w+O/o18v1JgDKvZVuQmdQbgeZt13oSKtalEfh6pWnCq
	 xyqUqNNRIsn3ptFwE7sm24QRwi1YS6P5LeHZxFJBCmGMhsTKS0RYmsY9vQ+HsINNyY
	 QVInw/TGlIBjwKHGRD6i6noNqm8SLkI6cm2x1sWh+Q0ojxZRHXJIvUw0d5RPUF7AkF
	 PYy1fF/7cq7zw==
Date: Mon, 5 Oct 2026 13:17:12 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Jay Wang <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Heusel <christian@heusel.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Bjoern Doebel <doebel@amazon.de>,
	Martin Pohlack <mpohlack@amazon.de>, jay.wang.upstream@gmail.com
Subject: Re: [PATCH bpf-next v4 11/12] tools, samples: take the vmlinux BTF
 from vmlinux.unstripped first
Message-ID: <asOHOPlWCp1kKZiT@derry.ads.avm.de>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Jay Wang <wanjay@amazon.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Heusel <christian@heusel.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Bjoern Doebel <doebel@amazon.de>,
	Martin Pohlack <mpohlack@amazon.de>, jay.wang.upstream@gmail.com
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-12-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001225214.12351-12-wanjay@amazon.com>

On Thu, Oct 01, 2026 at 10:52:13PM +0000, Jay Wang wrote:
> With CONFIG_DEBUG_INFO_BTF=m, which the next patch makes possible, the
> vmlinux BTF is not part of vmlinux: scripts/Makefile.vmlinux strips .BTF
> from it, and only vmlinux.unstripped, from which vmlinux is made, keeps
> it.  The tools and samples that generate vmlinux.h from a kernel build
> tree take the first vmlinux they find, so after an =m build they would
> pick one without BTF and fail, e.g. the bpftool skeletons when bpftool is
> built from the kernel tree right after the kernel.
> 
> Look for vmlinux.unstripped before vmlinux in each of these lists.  Every
> kernel build produces it, and with =y it carries the same BTF as vmlinux,
> so nothing changes there.  perf filters the candidates for a .BTF
> section, but its unanchored grep also matches .BTF_ids and .BTF.link,
> which vmlinux keeps with =m; match the section name exactly.
> 
> Signed-off-by: Jay Wang <wanjay@amazon.com>
> ---
>  samples/bpf/Makefile                       | 6 +++++-
>  samples/hid/Makefile                       | 6 +++++-
>  tools/bpf/bpftool/Makefile                 | 6 +++++-
>  tools/perf/bpf_skel.mak                    | 8 ++++++--
>  tools/sched_ext/Makefile                   | 6 +++++-
>  tools/testing/selftests/bpf/Makefile       | 6 +++++-
>  tools/testing/selftests/hid/Makefile       | 6 +++++-
>  tools/testing/selftests/sched_ext/Makefile | 6 +++++-
>  8 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index c28e65046986..fb5cd2d5b6f8 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -305,8 +305,12 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>  
>  -include $(BPF_SAMPLES_PATH)/Makefile.target
>  
> -VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
> +# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
> +VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux.unstripped))		\
> +		     $(abspath $(if $(O),$(O)/vmlinux))				\
> +		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped))	\
>  		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
> +		     $(abspath $(objtree)/vmlinux.unstripped)			\
>  		     $(abspath $(objtree)/vmlinux)

(out-of-scope for the concrete patch)

I am surprised that of these multi-ambiguous path list.  It looks to me
as if samples/bpf/ and samples/hid/ are always built via Kbuild, thus
there is proper management of variables like O, KBUILD_OUTPUT and
objtree already.  I'd expect 

		     $(abspath $(objtree)/vmlinux.unstripped)			\
  		     $(abspath $(objtree)/vmlinux)

to be enough here.  But I may be missing something.


Kind regards,
Nicolas
