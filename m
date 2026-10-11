Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924582DB7B8
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733465; cv=none; b=pqQJu6Si0tgigEtz8RI6yzqqNNojG7dPWYr0CsearD+JML9j7OprGorx+DoGEkX/crTnf5F+EDESHEbMrCJvI2roXepWcTL3pypl5QQ6+2TFDzeq+cXGEjR45YT/CeAImsk0llYxpalVeHClgd83hDDz0K2Pzyr+XjAFa5GYIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733465; c=relaxed/simple;
	bh=pmHFr+laSN+G0v9qDu/lTH+7vt3iSr+UYMCu/syGo+k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BH0l7/O1WShBWXPxVBhMnUiXEYqZ0oPkDYi43bgRRFXwq+ClH+iO7tUEuQVdWojTLhooWqlXjoMEqotFA3ctp5/MXnD8JQieu29QwPFISnUADZ2t7kB7270z7/RF4T17g7wUsy6+D676qyevtpV7MnPe95NLl07o7KGwSuXmHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhJUgDBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhJUgDBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98831F0089B;
	Sun, 11 Oct 2026 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791733464;
	bh=td1xqRQ2HEA4cbq86iIpYHZJ8EhBNqs1XGJp6gUN+Ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhJUgDBwDR2A36HFyPupVmo5946JmmZ/I6CpPRcGgxhmBVmK0c47DRH8ACVZCPP+q
	 M7l0XR5eLYgy5xs+pyNSjXFRltwa1T7QLkw+Nc3TEOa1+nG5r/D61Lkhu0W0o1D8tc
	 ynQQfxVFMXuO6o4/iUZU9H95YR0vFZbpq1zK8VzuLBl4JTiG25yb0KZi+iliwquSej
	 /y5aVB+HamfMQe2CKOEcICuolsFi/YlQtDLkrPCXsEG3tbO/KMepqAJPUlUc6rfGDp
	 51cNG1iX2HbuAsoADpdX+U6kR66gOKzNn2FODdHHRct9sX1lEwG+RWp0s2H9PEZTvR
	 ffjbMnfXbZ+HA==
Message-ID: <sashiko-outbox-167303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add GameSir Nova Lite support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Orlando" <francesco.orlando99@libero.it>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261011153422.66844-1-francesco.orlando99@libero.it>
References: <20261011153422.66844-1-francesco.orlando99@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 15:44:23 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] xpad: xpad_device array is not sorted by product ID
--

commit 375f6defb6771387f96405b8a84408224531a65c
Author: Francesco Orlando <francesco.orlando99@libero.it>

Input: xpad - add GameSir Nova Lite support

This commit adds the vendor and product ID (0x3537:0x1040) for the GameSir
Nova Lite controller in XInput mode. This addition enables force feedback
rumble support for the device.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 6406ceab988ad..00a26693ded61 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -403,6 +403,7 @@ static const struct xpad_device {
>  	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
>  	{ 0x3507, 0x000b, "ZENAIM LEVERLESS", 0, XTYPE_XBOX360 },
>  	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
> +	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
>  	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
>  	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },

[Severity: Low]
This isn't a bug, but could this entry be placed further down to maintain t=
he
requested numerical sorting order?

The comment preceding the xpad_device array explicitly states:
/* Please keep this list sorted by vendor and product ID. */

The new entry for the GameSir Nova Lite with product ID 0x1040 is inserted
between 0x1004 and 0x100f. Since 0x1040 is numerically greater than 0x100f
and 0x1010, it should probably be placed after the entry for 0x1010 to
maintain the ascending numerical sort order for vendor 0x3537.

>  	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011153422.6684=
4-1-francesco.orlando99@libero.it?part=3D1
