Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8135AC3E;
	Sat, 12 Sep 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203086; cv=none; b=GtyoUfBfvNRaPRz784wknw+CDxIqck4lXyeI8srPIx4LrnQyVxeVtK9oA8VWWdfMjY/Guw9n+HogdRxiYLcy4Y+sVhuM0qlbPHKo72xcXPVLuIfaGiXoDxFSTLRX1/Z/t8WS8ixvXIPtsaBC/U4GPweC0gh/+UEypHrOWGFBl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203086; c=relaxed/simple;
	bh=NVs8FkDQrv9XcaZ0C0mhTjpNGSaoxVuE8Bk8aJ2CN54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=em0eYGy2LsYTuci2WGalonSimgOYrV0wDTcWHCpnUXUzaIKAo1FA+CzlmD9+NPurlP5GAYmiSjytY+sAsiAtiErj53kTa0Op8hxKCk5n/sdDMc3QdUGID3OqzQsTo7RbEDXb/7BsAXBDpTkojTKKL88yXiAy9i2vxoq87AKshDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0M7bZFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0M7bZFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314901F00893;
	Sat, 12 Sep 2026 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203084;
	bh=NVs8FkDQrv9XcaZ0C0mhTjpNGSaoxVuE8Bk8aJ2CN54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0M7bZFGq2k7JxKpdSkSAk6LbjVqJcx18CGiRiXwo1oEKUlznn9KeXfKLlltQGBLY
	 4+Z+8oLd30jE+OkeREXpHxo6w5bA+xpnkkXLwF+B7gchI1krDAb5TMWFkY/srgCRw6
	 KzPy0wB/a2SjttklfsUx8tzDL7RZc+wiczcfI27EsIIthBkjdl54kQ6OI4WDQn2sQ2
	 5o66RzFaNT/zcm26DeAjjmKg5/9viyKxRa7NeFLt8ktgJiq5lPeuJL7gNFCB7OA2Lm
	 K6fCgU98V60KiNN8lCaG/SOpNB3x+KwyocAPvny70Bf8z3tRv3N7GFmkyVn2uamTm8
	 tiuPjkkWmi8OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/20] dt-bindings: thermal: tsens: Add MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, lee@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-16-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-16-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:51:23 +0000
Message-Id: <20260912085124.314901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add compatible string for tsens block found in MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D16

