Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD805437C5;
	Wed, 16 Sep 2026 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568871; cv=none; b=VWtyE2XZcAPGU4X7uAFx54KdKBBnf5v8OqvhekvbFcGjA28El9CTLHMlmWCzYeDHWBawMGFsyJ3Cepxabo9FX3/xDTcgaXHA3CbYER/aMycybJm5ZNhkh8dc856NOnKmNfBcfVBJ6V5xF3S01XVdG/Hrzt0/XokEABlCUu0RQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568871; c=relaxed/simple;
	bh=o9aI7w25aC9N0w0QyhQFz+Ff5xtQGpHAAEAfCW3AYiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PpACuqpHC61QR1XFR/dtvA/RuJsN04ov1iS2rB4kTnsJM4rGBXld4YtlNK3S8ZJealMCFxpcExOq/uWe75+vuPt/SflcAbFAvrzpJpUAkCRG1caKQcH3lVObpfP9zx6ftVCY7MOPni6Y6OKIYJfGp8kL45ERp8RKoiYFJxxk8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Uqvsg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Uqvsg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E1C1F00893;
	Wed, 16 Sep 2026 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568869;
	bh=o9aI7w25aC9N0w0QyhQFz+Ff5xtQGpHAAEAfCW3AYiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5Uqvsg+RQyEHPaxQJ72C2tUD0iLqQxtVVinY62GtOClT44Iq9USRXX8YtehqwVha
	 NLWvzkbjNkvCDXnhFYeTA/1P1/BHsHJZVQbbIxAjIJkSftRURdM1sGVMxhIVxpOtrs
	 utzU+h/OsMOY3LSspnY4BgWvO+AbuQCiym4JN3iQCUeN3yhqy+1vtmW4vPDnN0ZDnE
	 myKNYNe2A8oY1E+K5zEmJYRzR/R0yfJDe8QQdp2NBOMC605T6Jb0TriQ1XShEDxaNI
	 kWSB4am6PpQRTbaEzeQLU/S7zb6Y4ZRTFtbAS8C8cvgm7mIsx5wh6FLGhoyGE7pEIZ
	 6rQP1+42TdIuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/19] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, robh@kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-msm8952-initial-support-v2-11-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-11-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:48 +0000
Message-Id: <20260916142749.12E1C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the scm compatible for msm8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D11

