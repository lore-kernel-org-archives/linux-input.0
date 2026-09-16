Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E351122D;
	Wed, 16 Sep 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568903; cv=none; b=IBfAkszFXMHv9G+q4jUjgVHYqfU8m57XPLVkaZqINwUr9BdsTtImlj8F9aHCgzr0BNe+ILAXBu5f3m/1yJMn3J8i5b7xMDAZqfqJi5gD6xeKxlFsHXIT1P8DUVNuYso3i32M6iTqQC9MCzZErxydXIkhpydFfHglzN8CILRl9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568903; c=relaxed/simple;
	bh=4Ua0Sb0AU0yYVVorf+Eo5eHEeLu186qR55bCEvdTfHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NdNfVKy85g5UQdMgpUjgBACr7KYn13plyJ0m1ud7d7iFaJ8Ao0kb4+TJ/0hqu3ZqtlLjgma/Lm4hxfgSjmoSbgaY5pGvax7vNaaTvkGGF9ui/Uy2CwD9LwYqBSctegwIJNzIf+OMUeDxDHiQzUzMsYO7wMsYSHDhnotGMYOuItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf54z07L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf54z07L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A051F000FF;
	Wed, 16 Sep 2026 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568901;
	bh=4Ua0Sb0AU0yYVVorf+Eo5eHEeLu186qR55bCEvdTfHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jf54z07L54csh+edTnSJgZEDriJvvm3UMhCZhGA7WeF8B164ScaUkzCRwbKJU6jlZ
	 ZUkPOiRbVYdA0lQkGDF+TjTZX2hG5fPkYIxejSr8ohqH/yo3803EfcMSkRY8vqKKbr
	 tfhEZp7qehD3aanwWMJfgKwYHyblPtG9qu/CY1O43Jrabk+36kv1a3eez/KqAji1j4
	 CwEdGir6ZaGvr13ZjZq7Ia2U926dG+JBjFrijgtGpr2F++2Q9A+S2vRyIJNWbQktNK
	 5A9yfUsoCHLZtP5wSiaue2nxTwUOkOoMZuRjFHbnjvzFBNH7DM1NoVScNV6NkqzW9E
	 d9bVTNHHa3QXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952
 IOMMU to SMMUv2 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-8-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-8-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:28:20 +0000
Message-Id: <20260916142821.46A051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
> for the MSM8952 IOMMU which is compatible with Qualcomm's secure
> fw "SMMU v2" implementation.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D8

