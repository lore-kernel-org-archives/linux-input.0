Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B443B6FE;
	Thu, 20 Aug 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229878; cv=none; b=XWN5aTR3105SwKypgm4XsgFvUZZo54MCW5tW2LuGOWzGRGdPkfQPK9/QjcjkmppZLZPW27g0cwxyo3PHfOvcKdFOCTKtrDxr5bkcSHVzIwwQJWxX2agr0LQUGUsHEPcsukOK3eM+/EdyyXz9lNOp31DLd4FqLplH23k8fJIPA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229878; c=relaxed/simple;
	bh=kSXi31RZZPx2P4aLMraLnm0aFSqlKHGLxf1F5grtI5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tOgFQhKEmsyEM76Sn2VJuu0ERSDUkZXjg79NnWxAnJWUpYztz6u8qDfZcnvUyLmLzaNytcQSSBCq7Iet6E3pc0CFad+kyuxU83kvqDN0u6YLVbbFT/XtWe+a9IadZtMNjkt80Mahn55Wxh1znNIU9Dv6gf5TirK/74BfhImOdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsjaBuBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsjaBuBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6691F000E9;
	Thu, 20 Aug 2026 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229876;
	bh=kSXi31RZZPx2P4aLMraLnm0aFSqlKHGLxf1F5grtI5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CsjaBuBvlsWAFCTcNk+gAS77QvshNSVD18IHpBcwVwNHNVLe2S2IBJ/h9Ls5iEmL/
	 yBuhTTMcr2hvTYGLFmmW90YxgwZyUYpeGuNa0z9kHhP0DqeUelXumIKwVOGcc2zpZZ
	 vgoj75qzSA5ElxTDhWE8mvuVI0SU2Q1ij/euDesqEypWCWuMw0ZrKberElKG3fxBli
	 dTG6iAJw6F9V7cv5CyLsYJvg1OV+xM46lezmGZgf+zRG4LHYz+va8aJ/A+aWeoRkp4
	 KEopOGnGHSPNuuhQr0BaUcGzs/qXL5XCtFSl9585BpLI2xB6zENIyjCD4HGI9lom3A
	 F/I/BOV6pHwxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392
 PMIC keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260820122242.120039-3-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:44:35 +0000
Message-Id: <20260820124436.4B6691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Fabien Parent <parent.f@gmail.com>
>=20
> Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.
>=20
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D2

