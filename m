Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B043803CF;
	Sat, 12 Sep 2026 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202712; cv=none; b=jQSo3dkm3c1yl86scEXojFA0aG30VxtmrZiZxpz+i9qfxPXSQ1qvIyozxncgnmeRaQRWU3Up8gczlwkGynZiK7ir0F2UxY6T6iCLA8HmfkrQb1TMCEMaHagaFb6WHv0LvYf8qExTdlx1KsoHOe8O32zMjQvgKCCCv40XlLw2JW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202712; c=relaxed/simple;
	bh=FfX/IPSpkPQUJ5D5APA5+Eo9jCOJBw5wUj2YbvAu0YQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dg5t7Ah2U7DGiVdAycJRCqqqteiihlVhoVe8+NuApzr9JklL+pmXu9kn5ZSLZHPxVGs/r8n9zQM4CvUUQFenwlM7oUza8RbX79XFByrnuyKOSDEHZb04/0cSYpDv4nUhDGBXGI2AATPJaFGeAGW4SzmHFnGIQXFVGN2jQ06BpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTIEUS8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTIEUS8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52CE1F00893;
	Sat, 12 Sep 2026 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202710;
	bh=FfX/IPSpkPQUJ5D5APA5+Eo9jCOJBw5wUj2YbvAu0YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTIEUS8LEbJNdlctwDpm+RKw3wx6SRh08Cl2KUZzoznwoGglnauSpKZVz/53gp8ou
	 kKqjtkMBNsQYXyQFHUbmMVnFM4k5yk6Pnjt4x1TaPplrMUrrCIpGln3LI3PYrtyJAR
	 ASCBL0CIzb++E4/0MYWUP17ke4Zqv2l5QBCygMAPeCXJwvdhFsXwFkT6+4+nYutd0q
	 zu2zBV8uPqdqPgOqMyn6l2fFmZ/FX2FOcBiKd5yQlfHwop1xRXEMeMqRUp6dHdKs5U
	 2AS3KSEM4WFergRNca2e3qaMwWCszZVFAZYKf/JdPfEgF0xTxp74RJU97vPPdZgTDu
	 +kZaBh6DflJyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/20] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org, robh@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-1-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-1-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:45:09 +0000
Message-Id: <20260912084509.E52CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D1

