Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758947F2F8
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120374; cv=pass; b=Xy/q4LdxAl4fxstenbj0ygcVlm5Ik3uCQ6Jhnr/ePh5KIs3Fbrxn4cW1MpN7Tvu2ZvCiyeTBMwp2ixiAUBWKXhbKPuRjKk5LnM+EW/VZLn+IZ3xXmxRXZJrYae8+dVDqM3CtAKjjMYcCmQTg6W2DtRPpSfcHCERdTvw8cmn6zng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120374; c=relaxed/simple;
	bh=0JN4eWAeyH1DFvPDOFr1bp0SNGRTw2jc5rqIj+ZsVUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1ISagJD5VMCF3YSUoN9Q/3s0IP9RCctpLp7qfByB6ij1NBYOwgt03GroaO0lWkR20Lr+K5Ri+WOU/c+P5MSHZKxLIZ3fIb2RImA24S9t5bZPuug/IrExPvTnfjTn9xeTG2aG9e+9WWa7umFRzfhVwAvAftg41JdQ3kyjOWa89U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGueLnnv; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGueLnnv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso2115ad.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779120368; cv=none;
        d=google.com; s=arc-20240605;
        b=NcAzf+zMcJTu3cq++wlGIad1ntw1TzvDUphYnhQDn/mf+8OIpk/fL3EZ2bNcblD1+7
         UK8/QxqCy/j2wpug2qMDIlMikrIvx8TpoOO/FVjp04hqISk/I/AnYUWpWjxnrmZuDz8t
         +kM2d9fmAg5yf/6N5t34ZZgVr6Mg1wGk/Be8WNVRE5gK5bzYCBQiGVtM5PEDVQGSECjY
         eRMv6yByCiQQokWowTygAdXk0mqUeVdWsUaPXR2u8QS1Sc5xJnC26gaYAYINODosyvI8
         G6hVC3hAc7UDRScXeA9a19pAk/t8XeIIKqH1K4UaZS2PYs2uAcUIcV1eagWmDH7xfa14
         f5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/yL2S/NNFD9uZOxHwjkGhATRbJfyjLUg+vdf0l7wFBI=;
        fh=TfeGZ9tdO8yn3LT8q+QHTb2Z5xU9WPv7/+JbpJ7QtJw=;
        b=gTdZdlNsWmQfHW0lHJAHY3LDTWpLAIwgUTu/m8fc3Z+iqgoGDZ2Fhs/jrOAgnyRHms
         KL3CKFeAyT7ThhocC8VvTlDcqhdC/EZNikeNfu2S+ZEscY1czLjPOPDRFrQ2XDxNvwBR
         49gDBFKVzwQ4EPd/VlUJGiQsoLwCzsJofC5+vHFxM6xhJiq430nrBwh2CoB6QPSali5D
         wJaQ/r+arRcPPCASwjgZY4+RSiYsKy6RxPVbiW8o7tWBc6EMob7htNcdvUUtUjzhefyr
         2m+gZUaRFrVuuwu5FzaR6INMQpC3EsTL3xt5SEOa3sdeDhjHskgXLXA4j7aKvJuDTlou
         C9hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779120368; x=1779725168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yL2S/NNFD9uZOxHwjkGhATRbJfyjLUg+vdf0l7wFBI=;
        b=jGueLnnvGXPf0SEVFUOojzRtxCqeaOSe0Yzj+zD3sHWcSHCOPwqjC9HnKvg5/v8vvO
         re1A4G8Fh9asuAzg6hSNQholYgZA16S5Ssrud0W/kdtLOERIt95MnH1l3ORcirQBC9Yu
         oZ+mlJ1qvOaTU9/Ipx+JI4HCPUFBcbUzE4yU8akOhcl53ykTaj2qY/XzdzJX6F615JKL
         GuRfH+f1mYy1yL3L6lnz78pE6TCzJNFOAJS++nSyeSoB8m0C/l+f4Pdwnvfb6DP7qrY2
         N30usLFBRg+HJBllLX+Yxk/3tXlQZy5YufVqvEqHSjKTMhp0jh9zG95dxHQtX0yfIbHs
         O//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120368; x=1779725168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yL2S/NNFD9uZOxHwjkGhATRbJfyjLUg+vdf0l7wFBI=;
        b=gnl7KJgAcgXGTDxki5tTLjnWtLF5OnJq4wDzXcK7G2I4/o5uHT2Z2MwaedIkJINSZS
         QG7p/iShhdXWlS/r2rKYU24pT22NirycWA9z8kVZapifF/rjMlZDlc6noYrXCBXMtkG9
         z1C6F1LSYhtmfTKkQ2PP5WRCSlWb5eg/JIOUxrwhavS/io5sMg9CRLCF7uWQzne4Anu0
         qg3Vs70sMlMq6D65ns4+arv5qjCS+6m6pVHMJjBq56tqz2P9KmwS63BLcj1AV/W2jWSi
         hIHL8F0RDKnr1rrgGJMUuJsDnJhBXG3jtN5Zlm8+4KD3IwcUscuHO+i8QDkzQrFnK8c5
         28YQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qqRZpE2IRTOuF3nvc4sptnJBpgIqB6Nt+5H58UZ3Th89c9anZBZbQ388sfsB6869KT+s7mJaGBNJHeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzQ8y3wIl8OChuid5cQz/2HSUFnhcJph27XHC0NouRhXTaab1
	yG7+qzlp3FCm0CKCmD37YkgjkTcPU87w4E1lRtEM45BPUMmgWij/OM+8Lzsm2Bc78y805CaljSs
	9bB43KgAH7wMsfpSHfUPrtcZ++P1vr9y046XnrJQl
X-Gm-Gg: Acq92OFURX8A+PEMdoe5i0YPaMV0KX7mUn53thFLiiNK0LmkVfuu1rpkjnIaf4uxqWo
	ashzHlUqKiSIMe2+fR7i2XerJm9dGGmh1XJZa+aW9bo1k8SpDc2USF3fT3GE4MaPmgcSwguNoAr
	LqWxNqcyBaXv76RbIVDfsp6hkyrrMHQrxu8ZUrd3RVKcbFz0NuJCpGvxQ2c4TLN0ySP7iHzI/qU
	XR6NoOMkg2eoFJTPoxTGNza+/gXioEWjKWVDqK/HUOEnYO0LyVCNRNm8FO5ye7v7NLBgmW7vuez
	wWkZkxUefPewqh3lDDfZSr+oq6V570ZHOrsJbtCDiVy9COlr
X-Received: by 2002:a17:902:d2cf:b0:2bd:3c1b:3073 with SMTP id
 d9443c01a7336-2bdb041654emr3259205ad.16.1779120367385; Mon, 18 May 2026
 09:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org> <20260518-james-perf-llvm-version-v2-4-f12cc4f031d8@linaro.org>
In-Reply-To: <20260518-james-perf-llvm-version-v2-4-f12cc4f031d8@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 May 2026 09:05:55 -0700
X-Gm-Features: AVHnY4J8ZynnI8bourXp6ojaD0bCqutv1EZpQT8aGfrcInLJ1HrazyPhkbTF28U
Message-ID: <CAP-5=fWmXQEbLg=xGJwQ4s5q5xUZUTdxx2N1K71N0gztZunQrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] tools/build: Allow versioning LLVM readelf
To: James Clark <james.clark@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:04=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Documentation/kbuild/llvm.rst mentions that readelf is included in the
> LLVM toolchain, but it's not currently included in this block.
>
> Add it so that LLVM=3D... options also apply to readelf. Users in tools/
> were Perf which was hardcoding it, and another was the BPF makefile.
> Both already include Makefile.include so convert them to use the new
> variable.
>
> It also didn't have the cross compile prefix, so either readelf didn't
> mind opening cross binaries, or it wasn't working for cross builds.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

For the tools/perf/Makefile.perf part of this change.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the cleanup!
Ian

> ---
>  tools/lib/bpf/Makefile         | 8 ++++----
>  tools/perf/Makefile.perf       | 1 -
>  tools/scripts/Makefile.include | 2 ++
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 168140f8e646..180dca9c57c8 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -114,12 +114,12 @@ PC_FILE           :=3D $(addprefix $(OUTPUT),$(PC_F=
ILE))
>
>  TAGS_PROG :=3D $(if $(shell which etags 2>/dev/null),etags,ctags)
>
> -GLOBAL_SYM_COUNT =3D $(shell readelf -s --wide $(BPF_IN_SHARED) | \
> +GLOBAL_SYM_COUNT =3D $(shell $(READELF) -s --wide $(BPF_IN_SHARED) | \
>                            cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*/=
/' | \
>                            sed 's/\[.*\]//' | \
>                            awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {prin=
t $$NF}' | \
>                            sort -u | wc -l)
> -VERSIONED_SYM_COUNT =3D $(shell readelf --dyn-syms --wide $(OUTPUT)libbp=
f.so | \
> +VERSIONED_SYM_COUNT =3D $(shell $(READELF) --dyn-syms --wide $(OUTPUT)li=
bbpf.so | \
>                               sed 's/\[.*\]//' | \
>                               awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {p=
rint $$NF}' | \
>                               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | so=
rt -u | wc -l)
> @@ -182,12 +182,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>                      "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." =
\
>                      "Please make sure all LIBBPF_API symbols are"       =
\
>                      "versioned in $(VERSION_SCRIPT)." >&2;              =
\
> -               readelf -s --wide $(BPF_IN_SHARED) |                     =
\
> +               $(READELF) -s --wide $(BPF_IN_SHARED) |                  =
\
>                     cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |   =
\
>                     sed 's/\[.*\]//' |                                   =
\
>                     awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  =
\
>                     sort -u > $(OUTPUT)libbpf_global_syms.tmp;           =
\
> -               readelf --dyn-syms --wide $(OUTPUT)libbpf.so |           =
\
> +               $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so |        =
        \
>                     sed 's/\[.*\]//' |                                   =
\
>                     awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}=
'|  \
>                     grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             =
\
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0aba14f22a06..63276bf55856 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -215,7 +215,6 @@ FLEX    ?=3D flex
>  BISON   ?=3D bison
>  STRIP   =3D strip
>  AWK     =3D awk
> -READELF ?=3D readelf
>
>  # include Makefile.config by default and rule out
>  # non-config cases
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index e81e5b479c56..380ad84ac51e 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -73,6 +73,7 @@ ifneq ($(LLVM),)
>    $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
>    $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFF=
IX))
>    $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SU=
FFIX))
> +  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)=
)
>  else
>    # Allow setting various cross-compile vars or setting CROSS_COMPILE as=
 a prefix.
>    $(call allow-override,CC,$(CROSS_COMPILE)gcc)
> @@ -80,6 +81,7 @@ else
>    $(call allow-override,LD,$(CROSS_COMPILE)ld)
>    $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>    $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
> +  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
>
>    # Host versions aren't prefixed
>    $(call allow-override,HOSTAR,ar)
>
> --
> 2.34.1
>
