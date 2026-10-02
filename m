Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59547DFB6;
	Fri,  2 Oct 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932460; cv=none; b=V0C03sGGtYIhWxuFqr9FZx6bX4mjrdMJM8jAJPIsAEqWaxC/oyqWWhQoirUb3ROzT+PaTj7F+xNpBR9Q3QqcqkpsqR/pK2R8aH7yLWJnoljjUlg/KcgFWw9Qp3KgrQ6AH1Eiztsmnkx8FCXiPk7PtcAGhh743KopMOTi7qt/Dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932460; c=relaxed/simple;
	bh=6LLoERE5mmTBnTyKdxkvpQ7laA3k7NXpLd1woM489hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0d8tewEcrVWV1NrgSNJ7PT54pOcHFMfnZ1vXLOkGvr2h9S5nA7fg8SPArYHt9vBoGCwjPTw88U4udAIio87Fug+tuk8hr5dYfWrZyYlCTpeF8mqmsFuLoXs/LPro57AKSiIPR+E9JeyDBGq3/rpcWRh/W5vLnbn9NEAjHEjpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7yXE30N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7yXE30N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50BE1F00893;
	Fri,  2 Oct 2026 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932459;
	bh=cQq6TJ7FB2XsH4yKqqJ3+HwNyn1vcDiZxDqoeOy618A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7yXE30N6ZHkDyUdGyoHNs1OtjsPwUJZqvVGtL3lK6bRhc209lxPl65MW+CO2Xv7z
	 afra4xmPCPkKCWDEhhtodSwgUHtJ1d4bmaGSuLCI3NoPVYzKRsjBT+QKtmiIgiLCV8
	 yZT1L/6edwtlG1EdkbsiucBLXxagH3NFh5TBSsRpge3/+gcNuPH3feaJ6bOTnkfRKT
	 B03pE9nmGJ6kbskWelb8ngBWvS9MG7/B/0MUHBke2i2etjIOhJ0wdn+ISWbZK1AkEz
	 cm5c+inkh6GL3ukbWDNT5jv03p237smB0qXeKkGgDmAtAmS2RAFTIH5bxtbshvnFKN
	 Sv53h8es84Dvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 08/12] bpf: expose deferred .BTF.base module
 BTF in sysfs from module load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-modules@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, ojeda@kernel.org, linux-perf-users@vger.kernel.org, sched-ext@lists.linux.dev, gary@garyguo.net, bpf@vger.kernel.org
In-Reply-To: <20261001225214.12351-9-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-9-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:18 +0000
Message-Id: <20261002091418.A50BE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> A module with a .BTF.base section (built out of tree) that is loaded
> before the vmlinux BTF only gets its /sys/kernel/btf file once the
> vmlinux BTF has been loaded and its BTF relocated, because the raw .BTF
> is only valid against the distilled base and relocation rewrites it in
> place.  Until then the module is missing from /sys/kernel/btf, unlike
> with =3Dy, and reading its file cannot trigger the load.
>=20
> Create the file at module load instead, with its final size: relocation
> only rewrites type ids and string offsets, never the length.  Its reader,
> btf_module_sysfs_read_deferred(), has the vmlinux BTF loaded, which parses
> and relocates the kept modules, then waits until this module's BTF is
> published (btf_mod->ready) before serving it, so no unrelocated or
> half-relocated data is ever visible.  If the module goes away or its BTF
> turns out unusable first (btf_mod->gone), or the vmlinux BTF cannot be
> loaded, the read fails with -ENODEV.
> [ ... ]
>=20
> Modules without .BTF.base are unchanged: their data is final and is
> served as is.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D8

