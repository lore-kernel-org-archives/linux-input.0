Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C7418A43;
	Sat, 12 Sep 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202608; cv=none; b=sGFsANxxjaWiWzu8aIzp3rw43sccALQip216KzCk1fGsSU8ZEGjITsTxDvOckOyaM+KLY9RbVZcSPEbYg0FcOEt/eabLoN43hWkBvl0l4MN3OshenSJPSygu8WlmL0X5l6XE16Lkoh7OEnUxwJ2F0pIVNa5cCP0aS9dYWuxIMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202608; c=relaxed/simple;
	bh=v64bmT+cyd0qVHY50C42iHjtQZxXRShQEMFyaVISt7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CKefmd0lvRxutBzuhPRtZsCkRud57QgkoRreuI+/6a9TomLFYZv4uiGy7LZVIcjtV6aKy65bNU/me5M4r9x7PHTBMY7OHkqXPEwHRY0SemTOUsrxI7Btz0ENlu6yoj6ibbw1is+g2foXZe2nB1wsgOilCTY83PjFoUbTIr4Q+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwqfsQSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwqfsQSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558841F00893;
	Sat, 12 Sep 2026 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202606;
	bh=v64bmT+cyd0qVHY50C42iHjtQZxXRShQEMFyaVISt7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwqfsQSnincZSakTDhW2BU/TleMF+04GiKFXzu5RUqx6XP/kbiWhRfz0FjeI2dTW5
	 5m3p+XcIA2zd0XGaXUaxP2j1M9v8tHC0TS7y8k/CaGASP/VTG1IrZoeo/kE+YQkyY6
	 rzIJjEVK7aoJp8RPJjmW4UCr+vFgn40v3sR/teh1iNrV7aPUO/h4hD5xD3LIfQuT68
	 4oGu62OJg+nm791um3RRZemSpcqX71kq65AUaT8+l9bIzws0o+8+xeRpbczzaeEd2s
	 EldlM93xvaJ1Hiu8Pk2NbNH7rUbQs9i9ST9FcllJuEt9vrjgECyz3C1w7E038uji4f
	 atDSB1yu27KEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:43:25 +0000
Message-Id: <20260912084326.558841F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D15

