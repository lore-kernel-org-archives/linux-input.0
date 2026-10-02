Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19B472535;
	Fri,  2 Oct 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932453; cv=none; b=a215bXnjZmBwduhLfXl+AqacgRUMFBTjiYN685oD10MQciCccEhK8jI6NyGzWDefqkn47piNLSFVftF5z85Wz4zbsuYNwyIsLzjRFQsZgKXH2OwQajofsdQc/B7eOIogscA5BqWNdMCyCRXnm+QGPvehupop7KWDeGQlKXxZ7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932453; c=relaxed/simple;
	bh=NZ0Fdraie6zZw3f+BgDLYyXC0I+HWhF5AWIPK6b5VYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptbBGurPctuURmFCisniHnnQsXskSm/TOC9N0Q2BiwCRJ1cVGv+10FU5AVIv7FALksOy+s5TFiIBH9hXzb+9i7k/DkkhckpAQfufMpPYCEJFg2CT0/S95D7DioP1CCc4i1jriwENfpuFlO27+KsSBzr+Tgv7tm9jG8MhUXNGEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8kIUEVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8kIUEVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8A31F000FF;
	Fri,  2 Oct 2026 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932452;
	bh=OvFFUO4YAHmw1KO9OrD3drwYtuojJu+eYYx3VuZ6GH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8kIUEVYgjzKHaBMbh8FFrMVjnas/SRt1vyVAYmR3x3gJw/RbFRUgCLLAjCtPylph
	 cHeT/Eqxu20lZNk+3hhCv5AUxOXltsKh7v0UCZWlAvkhgV9U/d9dfzYCS5S5efZVq9
	 3AmfPo2EeQNQ6qR9q+/AiUH1R5eWlVifGndUwa/8inw/wdhyWetBYWg/h9my+lXh0t
	 dL9nEnx0/hnsca2qIhGlnZ6XtdZtxCF9BC4sMJ88Jyoih8zF8qE2jvfq8P/IIz8WRe
	 1K8d02trAPrM66T9jlwa1klWokmCHvTLxSXpozKOioTqwEl193lW+TEolLklihpOoG
	 L+pmptpgFz8CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 11/12] tools, samples: take the vmlinux BTF
 from vmlinux.unstripped first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, ojeda@kernel.org, linux-perf-users@vger.kernel.org, linux-input@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, dmitry.torokhov@gmail.com, linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, gary@garyguo.net, sched-ext@lists.linux.dev
In-Reply-To: <20261001225214.12351-12-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-12-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:11 +0000
Message-Id: <20261002091411.7E8A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: missing VMLINUX_BTF_PATHS update in HID BPF Makefile
--

commit 2f39c92d5ae7cb936808a6ebbea40b69c54c9b41
Author: Jay Wang <wanjay@amazon.com>

tools, samples: take the vmlinux BTF from vmlinux.unstripped first

This commit updates several Makefiles to prioritize vmlinux.unstripped when
searching for BTF information. This prevents build failures for bpftool
skeletons when the kernel is built with CONFIG_DEBUG_INFO_BTF=3Dm, which
strips the .BTF section from vmlinux.

> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
> index 2f423de831473..8b85382be254b 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
[ ... ]
> @@ -81,8 +81,12 @@ endif
>  HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
>  RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> =20
> -VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)				\
> +# With CONFIG_DEBUG_INFO_BTF=3Dm only vmlinux.unstripped has the BTF
> +VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux.unstripped)			\
> +		     $(if $(O),$(O)/vmlinux)				\
> +		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
>  		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
> +		     ../../../../vmlinux.unstripped			\
>  		     ../../../../vmlinux				\
>  		     /sys/kernel/btf/vmlinux				\
>  		     /boot/vmlinux-$(shell uname -r)

[Severity: Low]
Was drivers/hid/bpf/progs/Makefile intentionally omitted from this patch?

Looking at drivers/hid/bpf/progs/Makefile, it still searches for the stripp=
ed
vmlinux and does not include the fallback for vmlinux.unstripped:

drivers/hid/bpf/progs/Makefile:
VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)				\
		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
		     ../../../../vmlinux				\
		     /sys/kernel/btf/vmlinux				\
		     /boot/vmlinux-$(shell uname -r)

Could this cause build regressions for HID BPF programs (which are built wh=
en
running tools/testing/selftests/hid/vmtest.sh) when the kernel is built with
CONFIG_DEBUG_INFO_BTF=3Dm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D11
