Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50205472F71;
	Fri,  2 Oct 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932456; cv=none; b=KFxRmiWQzA9+V0olCr5/mYgx8wxV08Aut6St1DK7Taecr3ZCvhhSkOjJiDXvk/pvcweM1ReM9EtkoadgiMBgqm8LtSeOJjsW3XdnAin6Tt2XNATcbZDh1pqZCw6CwmDdrHQHDSgNmIsuJIUldv7EWyrer8OiBzAmteKUEtUJMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932456; c=relaxed/simple;
	bh=JGWnBvTL/tazdianXboc0+bQAs5iP7aKGiWdkpd0iWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4HnJGLQqLYWjZ1jbPF+JV/VRPGXT4MAYBm/RETmrvZKW3eX2F+m7lpI1POoU9ibAbObG0InSamFiVk3EXiwfHBg8ii7B7VcDXEUBsZ8+nl6J04t/lnpAtvk8luibDlBXoP18KTcBmOYzCUQ7QME98sEOi/3pFEQpWBq2iXdmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luHCADfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luHCADfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FF1F00893;
	Fri,  2 Oct 2026 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932455;
	bh=fyM2cQ7ItIL8C8ZMAcWkOhvNanevRH+k3AD9FSOQztk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luHCADfJCgUvLsX4TrxOJ16Vjdh2o93u7KyKzPOT1dWI09/kCXVrXZeJJLUtC5Gdi
	 8ryqxgBSZYKNqHV8aBaZJZPNlnu2hT016eq9zMqZbtORK7nrf7UlqNRdffLSTdrIgy
	 L5y8JU/5TgFeS3l4p+2AJf4FgB2tO+DQyBqEmoVtHTVSExaf/DrVy6EVCfmwIUlGgy
	 4MeS6VHcvYkv6uVywDXI6qPz0w4LOCm/kYxi9jj9mAMtg113dbb5kNTk0AD4tH+dfU
	 t5990Zfqwf88iAAon3OH/uxesIXDAYLUPVnMRdWiLvMPxvJpArJ/gL9QRYoe9teJeA
	 P3Jwc5Y/N0RMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 04/12] bpf: take the vmlinux BTF from the
 btf_vmlinux module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-modules@vger.kernel.org, dmitry.torokhov@gmail.com, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, sched-ext@lists.linux.dev, gary@garyguo.net, "Petr
 Pavlu" <petr.pavlu@suse.com>, bpf@vger.kernel.org, ojeda@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261001225214.12351-5-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-5-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:14 +0000
Message-Id: <20261002091414.A81FF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Add the runtime side of delivering the vmlinux BTF as a module: with
> CONFIG_DEBUG_INFO_BTF=3Dm the BTF is carried by a module named btf_vmlinux
> and installed by the BTF module notifier when it loads.  Nothing in this
> patch is reachable yet: CONFIG_DEBUG_INFO_BTF is still a bool and every
> new path is under IS_MODULE(CONFIG_DEBUG_INFO_BTF); the kbuild side and
> the Kconfig change follow.
>=20
> With CONFIG_DEBUG_INFO_BTF=3Dy the vmlinux BTF, 5.4 MiB on x86-64 with a
> distribution config, is part of the kernel image and resident from boot
> whether anything uses it or not.  Most systems never do.  Carrying it in
> a module that is loaded on first use makes the memory a cost of using
> BTF rather than of having a kernel that supports it.
>=20
> btf_vmlinux_data() hands out the raw vmlinux BTF: from __start_BTF with
> =3Dy, or with =3Dm from a vmalloc_user() copy that the notifier makes when
> [ ... ]
> maps the probed file.  Before the BTF is loaded mmap() fails, and libbpf,
> which tries mmap() first, falls back to read(); afterwards it maps the
> vmalloc_user() copy with remap_vmalloc_range().
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D4

