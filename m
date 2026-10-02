Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36247472F71;
	Fri,  2 Oct 2026 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932454; cv=none; b=XL9SUHcSiR2i9lUAUyGiNSE3jqqLoTJwNqOWwT9N7R7Tuy01aiM44zy/k9c6keX/PhX0Mbapw1XPWo7/7+Vb1WpzmsZ7N583VCrD6drR936Yet0T2MbGJfsHEpfhX78y0U33uHhnlgE16LdwwJBPaPbvDiqe9JBCLX/IK2bVb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932454; c=relaxed/simple;
	bh=VM6MSlVh3jzBQPFjrXdc6pR9ehMicjLJtRznf8HwY3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qsmk1xbJE6WsUMiuPQhvz+1uNVT40FpFJzVALer11QHVIWnCgm7c1892Aj1XbDsE74rbI2iIzLVIO2Z2r2l9XyfXfauSrtimJ+1iOlccY2oiqMmXdbaZI3OtkbtPFH1cGeN4IQfCC5imzCzWlxjApVKxCibtUz1pe+Pq2xYdcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/MmYVh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/MmYVh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9262A1F00893;
	Fri,  2 Oct 2026 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932453;
	bh=g3xI0ZfRVma0vVgDDAPIVsW/WN8aWz4RHMfiSpVmGKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/MmYVh66kSQiBhN2eFF9NgP3IJgcLglfXA8Hi9+B/nGjl0T0MqCqWmmDQN6QfNV/
	 4txqkbO7x3nZeBnUzacoIqYqMbQRtbwFPb3SkoQRfrb2ukCw1u8yZcC0EwEUrqgk1F
	 pZ/yVAkHWvZS+wKEcCIaJog9+VmyAAcoQ9bqPjydM07UwNR/qei+VlgeIglncZtc+a
	 fAZjCNMJbtJf1q6tt/VDyPbM+xLmvKf0M31pCtbNFROTrXv5u6DoLcK2SkHXXINfPh
	 DDK1HGEcVBcO8lIgDNC3cSIknWS1Ppw8dVPiedOnnv8+Dbv65B+HYj8MI4EiywapZ6
	 H/Tob9EHzIKDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 07/12] bpf: keep module BTF until the
 vmlinux BTF is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: sched-ext@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-modules@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, dmitry.torokhov@gmail.com, linux-trace-kernel@vger.kernel.org, linux-input@vger.kernel.org, ojeda@kernel.org, bpf@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261001225214.12351-8-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-8-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:12 +0000
Message-Id: <20261002091412.9262A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Module BTF is split BTF against the vmlinux BTF and is parsed in the
> module notifier.  With CONFIG_DEBUG_INFO_BTF=3Dm the vmlinux BTF may not =
be
> loaded yet when a module loads, and the notifier cannot load btf_vmlinux
> (that would nest a module load in a module load).
>=20
> So a module loaded before the vmlinux BTF keeps a copy of its .BTF and
> .BTF.base and gets a list entry with btf =3D=3D NULL; its kfunc, dtor kfu=
nc
> and struct_ops registrations wait on that entry.  Without a .BTF.base
> the data is final and is exposed in /sys/kernel/btf right away (the raw
> bytes need no parsing); with one, parsing relocates the data in place,
> so its file is created once parsed, as with =3Dy.  The next patch creates
> that file earlier.
>=20
> When the vmlinux BTF arrives, btf_parse_deferred_modules() parses the
> kept copies (the copy is the one btf_parse_module() makes anyway, so an
> [ ... ]
> With =3Dy the BTF is present from boot and the notifier takes the existing
> path.  Still nothing is reachable until the Kconfig symbol becomes a
> tristate.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D7

