Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBCE2E7394;
	Sat, 30 May 2026 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780118592; cv=none; b=AK59TkS3LiXx9xSzxz0ThYvMDBWE4qdvd8bAYObmyRcJ00fFpFjeCBJOL5j5H6IpPCeVNiuX0cHNnHkzRevE9mcaxpsZOGNaQlYHlta6EOFSj/lD0m2aVPkl5u2Mz68rDGmr+EXIozmQLL9s/pFfHJHj5dnMhbiykoVGs7c0q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780118592; c=relaxed/simple;
	bh=WfBNNESDWd38kwPxdmNA9G7DtcDh+kARY2pSLaaPLYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eSqHmWukAhrx2kLg46G1Weo7o8F5WhKDAsOILt7BaGAaRwuF+BcLj/PZznDrCy5yfTK9n6gqtrVldFiJI/lh7u3EljdjCYhpe2HTurMZ9PARzlhyZ1dEHwGaxFkSkkEu0r9wqNIhJOaU3Txab8mG7tMZSafebOfcARRpQDnBEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKuhlEzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKuhlEzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271791F00893;
	Sat, 30 May 2026 05:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780118591;
	bh=WfBNNESDWd38kwPxdmNA9G7DtcDh+kARY2pSLaaPLYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKuhlEzb9QvW8rsO7EXFggY+AmCcQwQ3g3oWkYaNi5eDIXi1rkSxeDOJvdHou5d2H
	 W4CFuHP7F1g3gkBnOND4gMu1wXC9tWWRv5MUgzIibUuDMjmPQtgwglBIGUjaqxVfwK
	 L066FgE3J2rEQgSdROUvdszl+7CAY/++ZDS0HiDzrFZZ7WF5zkYCSQawhAcR8cX56e
	 8nC1VG4ELt/pQNg0oVwUsG+5Pz3IbGo/ZbYhfe1JjPPKC+5Qb8I5QKDtJxXvU8XPHX
	 xLG29zXmCsakiBfsUMqi2rNa7HRJgKgmAaJjAFjDau4GYP2rdY822kuFOoDFaqPn39
	 B1kzHq3uz85Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: input: remove obsolete
 matrix-keymap.txt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akash Sukhavasi" <akash.sukhavasi@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260529052246.4934-5-akash.sukhavasi@gmail.com>
References: <20260529052246.4934-5-akash.sukhavasi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 05:23:10 +0000
Message-Id: <20260530052311.271791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message inaccurately claims that 'Eight files still refe=
rence matrix-keymap.txt', when only 6 files actually do.
--

commit eb5de2cbf16470ef87ea36fcd4695758a1c30a9f
Author: Akash Sukhavasi <akash.sukhavasi@gmail.com>

dt-bindings: input: remove obsolete matrix-keymap.txt

This commit removes the obsolete matrix-keymap.txt stub and updates all
remaining references across the input and mfd binding documentation to
point directly to the matrix-keymap.yaml schema.

> Eight files still reference matrix-keymap.txt, forcing readers
> through an extra hop to reach the .yaml. The stub has not been
> touched since June 2020. Update all references across input and mfd
> binding documentation to point directly to matrix-keymap.yaml and
> remove the stub.

[Severity: Low]
This isn't a bug, but the commit message states that eight files still
reference the text file. Looking at the patch, there are eight total
references updated, but they are spread across only six files since
tc3589x.txt contains three of those references.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529052246.4934=
-1-akash.sukhavasi@gmail.com?part=3D4
