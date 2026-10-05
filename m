Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95E47DFB9;
	Mon,  5 Oct 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200016; cv=none; b=OA6b1DOp5X+myjozcRP3MVPfqEHdbuPDuxbFrqguE8AsjXMXP0N09p6x8lfV3zJwoudtm4ZXu6DG/XjdWzvaEMHX4zCkv5uHBrtYyA/N9zJ08C84MLjCAP/aScpo0kEpIW9Z9AUgUtjBKsffwqzR9NyD53KycH3H6AQYUC95XpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200016; c=relaxed/simple;
	bh=ahBIlnJEjw2sBwQJf8wwHpcKkVLVi+ixJDkQPGiwDsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK1thZL7s2A078pDYRxN+aKOO6rZV3pE3Yd2gZ4qXvqfYbd3qLC9/rgPnqSKBNR2Z0iGljhKpz2bTyMK6cqdVU/xmPsxKRoGO08QOUFmRAHpD7OTjw235fg5vccvTvM5Cfbu2mPPO3gxbdiqyaK3j3aZQcmIpH4LYe5lYBFNdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daXvwKBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daXvwKBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9607C1F000FF;
	Mon,  5 Oct 2026 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791200015;
	bh=44k8QmXo0RbzfFYGwBkCWl1z3Rv7AbzCxmoTN/2j7jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=daXvwKBfn45TTkPjYEogaW/8bzC7dWExtHjFuOSW+CTnZI8UZJqisOLHtEWUxdmjS
	 WfR76xQK5ZicHJnvrYGEoLXulXVsrCIzmDyJ9lsvn8Rzme4/ipxNWMP0d8csQdQyTH
	 qW0Up9Ia05nx3LwvkJ5rKWOUxTVuME3Q7ijIutS1DFPEMA2qqB/G/NducNpTv5StJI
	 EuTNz1S1c7ZbizJub5Xe5DXhXe87wAdSVK6m/xr550MJVVsJXo+zptvU1KjUHk/VFy
	 Ep4ud9da7IQSmdxwQ57Hqx3JmE1yzEUstTeqq86eR2N+WPAHxLwii/mxOSjLUaxaYk
	 r6mFtzcpuM+QA==
Date: Mon, 5 Oct 2026 13:32:52 +0200
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
Subject: Re: [PATCH bpf-next v4 09/12] bpf, trace, net: prepare
 CONFIG_DEBUG_INFO_BTF checks for a tristate
Message-ID: <asOK5Gl1Oe9d5bwr@derry.ads.avm.de>
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
 <20261001225214.12351-10-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001225214.12351-10-wanjay@amazon.com>

On Thu, Oct 01, 2026 at 10:52:11PM +0000, Jay Wang wrote:
> The next patch makes CONFIG_DEBUG_INFO_BTF a tristate.  With =m, Kconfig
> defines CONFIG_DEBUG_INFO_BTF_MODULE instead of CONFIG_DEBUG_INFO_BTF,
> so every check that must hold for both =y and =m has to be written for
> it:
> 
>  - #ifdef CONFIG_DEBUG_INFO_BTF becomes #if IS_ENABLED(...) where the
>    generated BTF and its id tables must be the same for =y and =m: the
>    .BTF_ids tables (btf_ids.h), the BTF type tags (compiler_types.h), and
>    the tracepoint and syscall BTF ids (trace_events.h, trace_syscalls.c).
>    Leaving them would silently produce empty id sets with =m.
> 
>  - obj-$(CONFIG_DEBUG_INFO_BTF) and include-$(CONFIG_DEBUG_INFO_BTF)
>    become $(subst m,y,...) where the object is built into the kernel
>    regardless: sysfs_btf.o, the netfilter and xfrm kfunc objects, and
>    scripts/Makefile.btf.  Otherwise =m would try to build them as
>    modules (xfrm_state_bpf.o fails modpost for lack of MODULE_LICENSE)
>    or skip the BTF generation flags.
> 
>  - "depends on !DEBUG_INFO_BTF" becomes "depends on DEBUG_INFO_BTF=n"
>    for RUST and GENDWARFKSYMS: with =m the BTF is generated as with =y,
>    so the pahole restrictions they express still apply, but !m is m,
>    which a bool option takes as y.
> 
> No functional change: CONFIG_DEBUG_INFO_BTF is still a bool, for which
> IS_ENABLED() and #ifdef agree, $(subst m,y,y) is y and "=n" is "!".
> 
> Signed-off-by: Jay Wang <wanjay@amazon.com>
> ---
>  Makefile                       | 3 ++-
>  include/linux/btf_ids.h        | 2 +-
>  include/linux/compiler_types.h | 2 +-
>  include/trace/trace_events.h   | 2 +-
>  init/Kconfig                   | 2 +-
>  kernel/bpf/Makefile            | 2 +-
>  kernel/module/Kconfig          | 2 +-
>  kernel/trace/trace_syscalls.c  | 6 +++---
>  net/netfilter/Makefile         | 6 +++---
>  net/xfrm/Makefile              | 4 ++--
>  10 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 751a08643bf8..f561516e1735 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1208,7 +1208,8 @@ endif
>  # include additional Makefiles when needed
>  include-y			:= scripts/Makefile.warn
>  include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
> -include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
> +# CONFIG_DEBUG_INFO_BTF is a tristate; BTF is generated for both y and m
> +include-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += scripts/Makefile.btf

Please drop the comment and use the shorter 'm' to 'y' conversion:

include-$(CONFIG_DEBUG_INFO_BTF:m=y)	+= scripts/Makefile.btf

and possibly also for kernel/bpf/Makefile and net/netfilter/Makefile.

Thanks


-- 
Nicolas
