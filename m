Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EF4825D8;
	Mon, 21 Sep 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014950; cv=none; b=K8P0KB/VxmgxbNwEEz0ufMKNIPlnMvMfjlV58dINyEHsMy4aW0mTnu9dOrfUkrbxJH8HL7sShAbjMEr+42vDoW5Hbj14z2qrqP41mPZwEp83AErvPxrqIcH7lvVvRByYH4da6DdwNm29haQ4S58+WOgE9noMJ6CnMgRY9C66mdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014950; c=relaxed/simple;
	bh=11RwB3c6QWVY/+H6SRJm2EfWY6ZRPTbVLBQktL1ZFR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=foO4T/Rj1QqDJXM+6QCkKpTDCYBMPxtL71aB6+ljI1ZcnzKv/mhkk7irW88DVvm1w6qoe24fn4BmMmIxf8r54JJPf2AExgztyjbVw64YVlJawQzvTW4w1X13wZZF4QmYW/o143eOmj+ujUm5vXLe+6LOKTjnxy1PznM5PXpDkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GofDL9sR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GofDL9sR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E19A1F000FF;
	Mon, 21 Sep 2026 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014949;
	bh=11RwB3c6QWVY/+H6SRJm2EfWY6ZRPTbVLBQktL1ZFR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GofDL9sR1hfGUzQSJsyAwBtWkgbbWwIW+NOliA+1w20eYG+TelwjvsXa8+PiGYobr
	 CaZuyelQk8VGAtwzb+jv9wQGVoYzxrUsZdqkKrqouOzKMq8UZeD9eLjBmMMWaziI10
	 0uwaW0V+G0HsskTeW2nOX4ETWG9TyPCnPCnGFqb858nYig8jwUZjATAmBBDi2z+ISF
	 q5eSo94bhLaqNAmmd2xw17R9GsJmbi/RFKl70jDelzuG4aOBSd9RusiQ0FE7uwprWF
	 0UlOCuPrBP5C2RlzN8jIFvwGya16Hp2gmYX++A4ESkxCUjccD5RkeNKzNCQYvXj9fz
	 pFZznom5eLdgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952
 IOMMU to SMMUv2 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-8-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-8-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:22:28 +0000
Message-Id: <20260921182228.9E19A1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D8

