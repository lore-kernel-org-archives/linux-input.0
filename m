Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F14746C0;
	Fri,  2 Oct 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932452; cv=none; b=kdFALHQ+NnxfwrLmIVLW50bfP/NXPQVYw7UqIzUXB/5axW2mqbCcJtVRfR3hITzG2aLxbUXKzhy4q+BTy56lh4UHy1ewtra3BFSMF10OgJU0DzaLZxeuag9oc96kxlx1zcl4Nt2XD11ghlY2XzRlzDON9HPKy14WTRj+vw7kxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932452; c=relaxed/simple;
	bh=z7oJHi2b6KBxNpvpAV4pWWI/jrgUwP1c2Pz4lp4oJzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bO5/nMG3I+tBeWWwjHqO/lh/DuwZ5YrUBRULivuiTImR1fPo+Qi5YyY89+3iRO6YFYSBcI2OeNPiyWBuu/asAumxQ2n0aJCpYxm246waXSDcLf2AyAquytycR6/TYVcEGwzwBIfGm03+ipqbjOUzy7Em0hDWRYuE7zcDrzmMEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaM0tclI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaM0tclI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729531F00893;
	Fri,  2 Oct 2026 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932451;
	bh=c8E0mCmZ0mJk9TGrJYs0AD7JsZnGf37WFWEUXzdR5Sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eaM0tclI+u2trSOBwMEeoKm3Pp4FvNt4emrMy54ujNUo/VSzbT7rwqLeJNF9vu2u4
	 GA0TXfK3Ak/7jl+IHY0YntFALPuYFIFx7pXigg6N12GsXcSD8L+u97Es2ZmC9Jm0UI
	 Yp6qvBkM/SVRLjQ4eVk+R5ps+6QP2tQh2yzM6z9A5wZHtqBDqcNo+Yp3YejJqc3yIg
	 RAtNe1ddYYt4mvFiHq7H9OY4vOICNRfP022SMsqnYDC1ElQ3xNNJWhmjACROqc83TS
	 Ltzsu+x1eF4uILJVPIzd9MJszvsrMqKOGYNAGAkuvvYeVxAqE0EJkxtjdopvvvsCfr
	 CgyTJ9t77ME/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 06/12] bpf: defer vmlinux kfunc and
 struct_ops registrations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: gary@garyguo.net, bpf@vger.kernel.org, linux-input@vger.kernel.org, sched-ext@lists.linux.dev, ojeda@kernel.org, linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, dmitry.torokhov@gmail.com, linux-perf-users@vger.kernel.org
In-Reply-To: <20261001225214.12351-7-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-7-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:10 +0000
Message-Id: <20261002091410.729531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> With CONFIG_DEBUG_INFO_BTF=3Dm the vmlinux BTF is loaded on first use.  F=
or
> that to save anything, nothing may pull it in at boot.  The verifier no
> longer does since the previous patches, but register_btf_kfunc_id_set(),
> register_btf_id_dtor_kfuncs() and register_bpf_struct_ops() for vmlinux
> run from initcalls and need the parsed BTF.
>=20
> Queue them instead (btf_defer_reg()) and apply them in
> btf_parse_vmlinux(), before the BTF is published, so that no program can
> see a vmlinux BTF without its kfuncs and struct_ops, not even by id: the
> id is reserved before the queue is applied, so that nothing can fail once
> it is, and installed afterwards (btf_reserve_id(), btf_install_id()).
> Applying a struct_ops runs its ->init(), which registers the kfunc sets
> of its hook; those land back on the queue, so it is drained in a loop
> until a pass adds nothing, and only then are new registrations applied
> directly.  The dtor arrays are copied: every caller in the tree builds
> [ ... ]
> together with deferring the module BTF itself.  With =3Dy the BTF is
> present from boot and nothing is queued.  Nothing here is reachable
> until the Kconfig symbol becomes a tristate.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D6

