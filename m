Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA847D945;
	Fri,  2 Oct 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932459; cv=none; b=rKiH25bAxGWx/tfNOuNwbpR9x2Ga/CO5fCHAJUL/AwVfQ4lDlP2Uw6dA/RcL41427orgMju1rIwmKIwHkIo24GdTjpHZvOX9PBj/BKZMRIIHm5g97PTi75d+m1z2pKYXYvBS9FHx9emUALSnRGrYPKhnXUW4lmUnGvElVRoiIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932459; c=relaxed/simple;
	bh=XjyjDRChXWEoKGYfHaRMuoeKKfhxkkaaKgR2eGBxRRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGF2DY1VwICVuFeOdRpqVyN9rYW+JoUF0nzHai0SLmFqVR3j4q8wGlVobQmGKTkxZkJ1GIIXdGt/YfOc0W2gBTYQ2qgRNQOxuykymRu5+dqrCb+UNUqVktm+zbwKDbgd2Omj/IUVI5+r8QPQUB7JkmrJqZhpUTpse8jdOFXbFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQEvSbo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQEvSbo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF81F000FF;
	Fri,  2 Oct 2026 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932458;
	bh=+wbx2VCOqDya/uz3hbbkEq6mvB2S+g/n0dSWYRBYzTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQEvSbo8FJeHsPQV9HjgNrgVsws/wscJtoNJfTCVUfIBPVLBZBh60vLq0z6f70ki1
	 Bw/jdUekWxgzEEhfWkqrhAHCBVQoNZvbCD5wVoKje+f1nmSXaoYQW42rxt5BHUIsYR
	 7NjTSMLmr5VuHGwfBQW67O/BXyJ7RamNLk5En0Ct1b0XEjAWyGUr1fAbGGQRzp/ZPq
	 +xUbHZV+UTDQ4yiydCJYESglJtRb32xL/w3/CPVYSnxRaFrMD5XYI+otQwpB3JFhBS
	 nw7XJcrlDHvs5c6w1PQiv73IQ3/wv8khBQIoITvy185YL/GvOqCmdXfT0412dfrUjD
	 /bHECetHLSqUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 12/12] kbuild, bpf: allow building the
 vmlinux BTF as a module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, linux-trace-kernel@vger.kernel.org, sched-ext@lists.linux.dev, bpf@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261001225214.12351-13-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-13-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:17 +0000
Message-Id: <20261002091417.8DFF81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: unprivileged local DoS via infinite request_module() spam
--

commit 83161d8b7e8e5c9b7cb283e38033cefcc6cf4b26
Author: Jay Wang <wanjay@amazon.com>

kbuild, bpf: allow building the vmlinux BTF as a module

Make CONFIG_DEBUG_INFO_BTF a tristate.  With =3Dm the vmlinux BTF is not
part of the kernel image: it is carried by a new module, btf_vmlinux, and
loaded the first time user space asks for something that needs it.
Otherwise it behaves as with =3Dy, with the exceptions btf.rst lists.

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 29de1222c3e73..7d44374b67ba0 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -1276,6 +1276,74 @@ format.::
>              .long   58
>              .long   8206                    # Line 8 Col 14
> =20
> +6.1 Kernel BTF
> +--------------
> +
> +With CONFIG_DEBUG_INFO_BTF=3Dy the BTF of the kernel is generated at lin=
k time
> +from its DWARF and placed in the .BTF section of vmlinux, which is read-=
only
> +data of the kernel image. It is available as /sys/kernel/btf/vmlinux and=
, if
> +CONFIG_DEBUG_INFO_BTF_MODULES is set, module BTF is generated as split B=
TF
> +against it and available as /sys/kernel/btf/<module>.
> +
> +With CONFIG_DEBUG_INFO_BTF=3Dm the same BTF is generated, but it is not =
part of
> +the kernel image or of the vmlinux ELF file (vmlinux.unstripped in the b=
uild
> +tree keeps it, for module BTF generation). It is delivered by the
> +btf_vmlinux module, which the kernel loads the first time user space ask=
s for
> +something that needs the BTF: reading /sys/kernel/btf/vmlinux, enumerati=
ng

[Severity: High]
Does this allow an unprivileged local denial of service through infinite
request_module() spam?

If the btf_vmlinux module is missing or fails to load, reading the
world-readable (0444) /sys/kernel/btf/vmlinux sysfs file will continually
trigger request_module() errors.

Since the failure is intentionally not cached:

kernel/bpf/sysfs_btf.c:btf_sysfs_vmlinux_read() {
	...
	void *data =3D btf_sysfs_vmlinux_load(&size);
	...
}

kernel/bpf/btf.c:btf_vmlinux_data() {
	...
	request_module("%s", btf_vmlinux_link.module_name);
	...
}

Can an unprivileged user loop read() syscalls on this file, bypass the
kmod_concurrent_max limit over time, or sequentially spawn modprobe usermode
helpers thousands of times per second, leading to a CPU/fork bomb effect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D12
