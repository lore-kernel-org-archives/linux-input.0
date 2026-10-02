Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D04746AE;
	Fri,  2 Oct 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932449; cv=none; b=OO8TE/65TBrPSF9+KEJ0yVUcOQh7InFpyyUHImbx0FouAD9ZYBIMw4KrVj4gJLG+B1Fp/Gu+UKzeCyq+E0tu0ij6Ptqj34V/oYnvCx1x2K79j84kwQI8YUuOs66IxmhPxBPzkjQGO60s2fMBQMftH0wcKz6RVePuOyb5YAAESHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932449; c=relaxed/simple;
	bh=i+L6umLn8Z+swB5e/ezod3yKaQQItgE1+v82GarEcf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJHN07UDTY4/FKol0tQ4KICptw9InHxZXS1BdWPBxkzz1+wFsxBDp4qbmpE43D2wYV5fEGmar/JZAXWfsJRo9wJYLe6A755Pl9Gn7kdsefsKbRAQ2LZbcAZpSdmVHMLDuOPldTPrXW6XY8FMADcG92kjS4S6q6ezzYCYq7eJQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PorT1Gxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PorT1Gxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1161F000FF;
	Fri,  2 Oct 2026 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932447;
	bh=5ellbPr8x94rTylTsDiFZddy2NzL3VmyKG0ClhU0u9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PorT1GxeCTQYPX519lAxP8lBCW/e9L3vsM3kOW2FhASinPrhK1PZgggB7nVem9Dye
	 38oJDlarSF3Qq99AtrLY0+hCkpnvDAAaVZSx1p7VNjh5TNTrKOHn3TCp1gy3dBoDB5
	 HiYwhacb6o12jQoncy8xM0Eut7oRcH+aGwKpWajJP8ISS1aLP5fH0GSR+yUyHCb3WT
	 id3CoqEvKNyFhgiCYk2hFH4GSC20biINPIzT7y5wCukbBu9p2Drpfk8mzDZw9D2J53
	 15qM3EqLY8CO0yXqJk031hNu6en2YgwCEeG8G19+DM0rs5PNXH4MPqIaHa1ABp+5l1
	 GItR7pK2y7ruA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 10/12] resolve_btfids: add --btf_link to
 fill in .BTF.link records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, gary@garyguo.net, linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20261001225214.12351-11-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-11-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:06 +0000
Message-Id: <20261002091407.4E1161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Alan Maguire <alan.maguire@oracle.com>
>=20
> With CONFIG_DEBUG_INFO_BTF=3Dm the vmlinux BTF is not part of the kernel
> image but carried by a module, and the kernel has to know, before that
> module is loaded, which module that is, how large the BTF is and which
> BTF it was built with.  It keeps that in a .BTF.link record (struct
> btf_link): the name of the module, NUL-padded to the target's
> __MODULE_NAME_LEN, the SHA-256 of the BTF, and its size in the byte
> order of the target.  Inline BTF delivered as a module, a planned
> follow-up, needs the same for its own section, in .BTF.inline.link.
>=20
> Fill these records in where .BTF_ids is patched, after the final link,
> when the BTF is final: the --patch_btfids pass takes one or more
>=20
>     --btf_link <section>:<module>:<raw BTF file>
> [ ... ]
>  inline BTF changes; take the ELF class and byte order from the ELF
>  header in patch_btf_link() rather than from elf_collect(), set up libelf
>  there too, report each failure, refuse an overlong section name and
>  --btf_link without --patch_btfids, document the option]
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D10

