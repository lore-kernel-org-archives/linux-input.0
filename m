Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB14746C0;
	Fri,  2 Oct 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932450; cv=none; b=bFNRghNcp+3oqewlW2bdYCPo/ob4ONJ35661ceaSWJY/wDsGYfVK3D05JLGzOtYeVxw/HQsNnuPr8XZDzJf5LlTUMRC35VC/L4D+pMRxDuxxRs62CoiOVbZDLJuk2962iXSd+jEyRV1W323oyJh17uHuVxzDh+z+QYK8jzEGFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932450; c=relaxed/simple;
	bh=6w7p0BfG2jYtPDAOwtlu5d1p7jApbF64y3jWo5zY+Ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DjXsY54SyWK8vQtDvMnyWVLyKdA+zzwLr24x0knX28Vn7NQ2neUntxd5V/maeCtgtVXtyMFR5RLD1W+bSqydT7rSaZCSEJwngRsi8bg0+f3rtwEkpmE677YrWn9vwIrigVEO3SXKjM0GY7rVODebH2qePX6IWPq75AHbKahtbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0X6tQ/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0X6tQ/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5251F00893;
	Fri,  2 Oct 2026 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932448;
	bh=L1fwK2OIU/AHGs9rywlL9rlYivR8K78yXbd0B4XeOGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0X6tQ/PvxCf9xRIaKFvAj9LrYyxe3OPaiQF8pN760F8hNrnTOvKAcl4STq6LJJC7
	 s3d1vLrXnMFx2KWzdUv8bBY8kqwgCVs6l0uTKDkZHghLjiHZuxnr1uABy/DwWE6y/i
	 3O3jV5FLXIkoqzeb05oj/dy65uhYxSWbyAYCdH3m4AjIN4FtRxPZoU0SuHwsxgwcYG
	 60BL+EPDQn1Hw2lC+PNgzGyQyM2B2uvm/PJhOu46dpLo/EwwuRtqSagQv1DccvnDVN
	 2H8eL81RO1uIZl/YjVrFtlEhNCqFHe3uQNORHhK2JXA7sH/hOQKuwie/hn27jIXDTc
	 t/Hz6CuR/NV2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 02/12] bpf: split the kfunc, dtor kfunc and
 struct_ops registration bodies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-input@vger.kernel.org, gary@garyguo.net, linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org, ojeda@kernel.org, dmitry.torokhov@gmail.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev, linux-perf-users@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261001225214.12351-3-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-3-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:07 +0000
Message-Id: <20261002091408.5C5251F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Split __register_btf_kfunc_id_set(), register_btf_id_dtor_kfuncs() and
> __register_bpf_struct_ops() into the part that looks up the BTF for the
> owner and the part that adds the registration to a given BTF:
> btf_kfunc_id_set_add(), btf_dtor_kfuncs_add() and
> btf_struct_ops_register().
>=20
> In is_valid_value_type(), look up bpf_struct_ops_common_value in the btf
> the function was given rather than in the btf_vmlinux global.  The id is
> a vmlinux id and a module BTF resolves it through its base, so the result
> is the same; the function already uses the passed btf for every other
> lookup.
>=20
> No functional change.  With CONFIG_DEBUG_INFO_BTF=3Dm, registrations made
> from initcalls before the vmlinux BTF is available are queued and applied
> later by the BTF parsing code, which needs the add-to-this-btf half on
> its own; the struct_ops ones are applied before the parsed vmlinux BTF is
> published, i.e. while btf_vmlinux is still NULL.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D2

