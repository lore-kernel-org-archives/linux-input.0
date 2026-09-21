Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F64F649C;
	Mon, 21 Sep 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014897; cv=none; b=q8hrRdgiC1onekD9Xj8B1yFUCMWMjL1o9iIDx42MsUg5fy6jkYUTyb1FY/9OxWIwo5Z6z9e9Obu4HIWQ0gMKF+BFgyIbWv2p8F3opg5vkN4pLZMW313t2i4doe0ryp6d3iWeTZLr+LjoNbd2P2yjN0XvRs0bSEiKpdmz4SATVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014897; c=relaxed/simple;
	bh=tl/SN7niuliyPiFDiKzUFi/iUVdUbwbZFtPxhW0NIdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QiBLNfqbv5R1WvHpDcBlxqIi7AR7RWSlDmg76v4q5Zyy//nhJq+cbUHMd5vfLraTQfOuntVWp5IoxdllAcFQnQ8/XcT3HNg3aHDvg5ko2QfSLQXPwcIXZF7gnedGravapT3NQa8Vfbwyupl6NGEriMgnZtqDQJGhtmZ86eucFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWA65oIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWA65oIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9561F000FF;
	Mon, 21 Sep 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014895;
	bh=tl/SN7niuliyPiFDiKzUFi/iUVdUbwbZFtPxhW0NIdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWA65oIbxE4RZkAbMFHsqauaTwoPJ/okdY3sxMqhA0fF/OHlpzNMZ+7O+FyxbtGII
	 9K4doNboA0a7QJz3IMlVsVpuGNSxfXE1nsuVAgp7Shhd9B1+BBPp/NsMhMfbfjHNNB
	 pwSuK+YVET/HyEMZdLMOZkrnvaelIB0u93RJQMaxDgbOBAZLyTu7QdL2i172NreXdA
	 Vfy3G7kxzwwMrBz2y5hcj7cNztL2WDaN/c/zVqRNjJKuB9SePt37YUnj5yk7/WdWDw
	 D8AzbXXqD7beUarkZ3B2DrvSappftJ8Zj32P16Vf8CtbiM4eAWe+8S9rxxMHA97fHL
	 IxM60iSZ0HxJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/19] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:34 +0000
Message-Id: <20260921182135.4A9561F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D11

