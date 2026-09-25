Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB64854F1
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328557; cv=none; b=YhsGT9snJeyPmD+adI35yQAT6NV2QOLylScL4uNpZDytlNBMYnjzun68Gu0S28cOfePfoFNigXqF7t7BgT/HQ4ljfBTsfkvwZjMlIHmJDniHGCXCnQOBK2/8R8UeERSCo0Cynkr7/tn3jwgaEHReZKQkeHffMMmuAyLaOAjK9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328557; c=relaxed/simple;
	bh=I+/YFvrHmfn5zGLNh/XMO2ExwXcn90m/duqh0RGZTAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJGJnEpeY9W2wbPEqbeHNdFez/nAY0pm5SvohC4S6M4Sw3fKZWuCvf3ExajXGvPLoBpnTqWCF07XCp766d3UlJQPk2+IFWP+rAgVg3Yx3PFP+42EkQcUi3RujtZz/DDy1qFfrwwrMRJKsOocMJx1zhXt2Dbq3bjBFSd58BfLn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpk76QPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpk76QPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A18E1F000FF;
	Fri, 25 Sep 2026 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790328555;
	bh=oitjqQBBagqQMN5q+NnOim6HG4Ip3+12d8y/H9FFzsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mpk76QPEdPZSjvWLixkHoWeiHRoIIxsKLLudC2z3mGTUDYh6oXJSgcYwfboCwh6Y7
	 fUPUo/21FCXZGmRbU47LyE9dy55wCBC8uYbxL/mR+uHB/8DunAVNALNHfuATaOACLi
	 eB2ACHaxX1YKuaW1LhRTBHiVfaQxsopTPZ8wvRc0hxaS3iJ7LjNO/b9aTmQ8VpRUIU
	 Tx5xsxISqX6sJMjIkZJ3J+KvDZdVtPyv17/gYT1qmN+Q5T5I/eP2+OhQLAaVoUjckX
	 2J6TEwTukHGeoePWSmwm6BFOxLYct5llQ6l23DvVI54pIO2f9iJibctiUVB+F+mYjO
	 iKH+XmJ1ZOnIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add support for 8BitDo Pro 2 Wired
 Controller for Xbox
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bihaan Sen" <stevewholikesthings@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260925092439.79904-1-stevewholikesthings@gmail.com>
References: <20260925092439.79904-1-stevewholikesthings@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 09:29:15 +0000
Message-Id: <20260925092915.7A18E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] input: xpad: out-of-order xpad_device array entry
--

commit db3ad191bb5f3c117f65ad725be0401f7c92d4d6
Author: Bihaan Sen <stevewholikesthings@gmail.com>

Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox

This commit adds a new VID/PID pair (0x2dc8/0x201e) to the xpad_device
table for a later hardware revision of the 8BitDo Pro 2 Wired Controller,
ensuring it is named correctly instead of defaulting to "Generic X-Box pad".

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..e7af88bfb8da5 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -371,6 +371,7 @@ static const struct xpad_device {
>  	{ 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
>  	{ 0x2993, 0x2001, "TECNO Pocket Go", 0, XTYPE_XBOX360 },
>  	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XB=
OXONE },
> +	{ 0x2dc8, 0x201e, "8BitDo Pro 2 Wired Controller for Xbox", 0, XTYPE_XB=
OXONE },
>  	{ 0x2dc8, 0x200f, "8BitDo Ultimate 3-mode Controller for Xbox", MAP_SHA=
RE_BUTTON, XTYPE_XBOXONE },

[Severity: Low]
Is this entry slightly out of order? The xpad_device array is typically kept
sorted numerically by Vendor ID and then Product ID. Since the Product ID
0x201e is greater than 0x200f, should this new entry be placed after it
instead?

>  	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", =
0, XTYPE_XBOX360 },
>  	{ 0x2dc8, 0x3109, "8BitDo Ultimate Wireless Bluetooth", 0, XTYPE_XBOX36=
0 },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925092439.7990=
4-1-stevewholikesthings@gmail.com?part=3D1
