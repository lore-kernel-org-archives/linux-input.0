Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D75438026
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633298; cv=pass; b=u6msL1+iTcRpZjBpGDryIn4na3G1hO5M3rmW13GAp5oOEbNIH0y3aQW5lc/CwjzeIvOFM7sSkoAp/7ZJaksWtKebbg3+UkmKKcJpSEFhqIDiYA/8ISeb1hw+6ehhktiCdErrLr5d5tDqV/E9LJqWf0h287cc/JHmpyX1GqNjsoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633298; c=relaxed/simple;
	bh=SzImJYMfymE8sykAXPSv/mWUCQ+vfnBooY/CiPR+OCU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=d48FugKb8awc7UBOTeNrL/1EoB7CZP1y/oSuve/DBG0LLmnHqaZnZdTlCDE+881FI+xzE55w9smVRpqctjc7864wXyEvepceHxmwiDZFMOMFikl5KwnI+yDfgqtgqaZf40fbu9nZjvshZQBo5Z0P/N6vPQCaKx8Yhm1DbhqbLac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qikb6KAM; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qikb6KAM"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso334878a91.2
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 15:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790633296; cv=none;
        d=google.com; s=arc-20260327;
        b=E9b6dggwM3fVP8/Xdbps3FthL+UJBkkpPJIpRCWvGNP599cfGkqjg/Su+xxNTS/Twi
         76tZOE3lSESMxG6XQn2J57v8zWxDEJP7NjS44zeE/RFCmjIWCu9IJPg+qqvNN3Jfxi0J
         HJ9dZocWuDQLiHe/y0dW3Wh8TbtfO9zDaGH+h5yyO2BVh/ZeczHP0N4LFGCaqwmrTLFO
         b9nCuG/yyyFBgv+kCexqeqEUjsH3iVi7t21CzMFGy5i2iKPDvBbV7CwruQ1w2LkSFhhK
         hGvE0N0rpMwx+Khb/B8WmpsIIxGtyR27oLyfMk1x2s8f1Jvc5OEdygGNIJ1YF/oAqhwl
         dcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=D1ze9HPfjWfjvyQJHsSv47RyPM7ssoFWycdCeIx1780=;
        fh=OL+PI8V9MpGaqm2EHzfNTKdupb1riUl/GXRL6yLD4l8=;
        b=oehtOgmF3plPHBbcOsDGwfi6rwCpUYyuPelYShJvM2Wk5mAg74BJHg+Ptzque144rF
         NmHHpvNaZRBj7lqIocGfKsmiUDzDQ0hRYb9Fp2B2E+9+9a2W+Lq5LzumAp607NJvom73
         fQmsizs7JXIVWhAkdN7kXsVpzfcGXnqL+SuCwVJoGl4un/gDyZRXq51f7eZSlTyVbKUT
         bYBmnO7FnlZu1BvfxJubQZ83gqnvQ4xK8zMjGS1t+0VX8qTl1+nQl1RTJeUVnHB0kH6X
         z9zQlAwr2LOZHadK3mW5uhPkKRDkUWK/wVdXlGav0SNBK5Ml8LcsmMARE3Bgkus307qP
         +HJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633296; x=1791238096; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1ze9HPfjWfjvyQJHsSv47RyPM7ssoFWycdCeIx1780=;
        b=Qikb6KAMKnC8mMpkAilSXDMVjjwlwI3ElYJLTF8kVEzGPAVQnsgu9FEIjbYsLBQqSL
         C78/InFEuCFMtM+4LW++uT1zY5wNnAQvBDi27aRmXMChJrObueMBI0Ixn2sD6Mk3/gD0
         xLOI+k11NkdWd/oKH7DASp+D7CQFZKKJvmhH2hZ/k+L7BLqMCftHAXsBHynfXDEkxH2V
         2BCorx6mnTXifLdkceqimzY1CixMJH8TmOgfABeOWBUw2SeEwCH++v9qe7KxR3iq7EBB
         J+qD4tJXG7U93Ju6n/OetsDRf7oqD/HZcMXuwcbQFmGrtCEcXZM+ROEvZyKjOdEwFnx2
         Rc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633296; x=1791238096;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D1ze9HPfjWfjvyQJHsSv47RyPM7ssoFWycdCeIx1780=;
        b=yuMnAiCFOYZH4jEjsEx+4yo4UfEaWI8mD2Ps3YbzuZaYzfehKC9ifjzojuITcaXyHb
         bChSmh+UdMewUilmLaJTBUrnRpKLKtAQoGwWDG9g2p2vSNf55uyEgnuqpnJQ+78lJ6+7
         UlAGBLAz2B3CY3ycYIHmiwRbDHX1hVuAfsmbwyoVyTeCpUI5eCRe5nCCr8Jqg59xJhxW
         rLRgOm1Ue0nMrZ8ux/g0jguSIB0cwPWwvXmsWbfhcKWxu0mAR6yMyMmlBMM+yfpTMsYU
         AUSpc6aLzScFB+6QshtYXZKhvNoCf0IX+OZuGrDGe6SZu3VdYH0Bxln1FHu/L8pOGRk/
         4uDQ==
X-Gm-Message-State: AFq9FYKkn5ruDsFbeKQnK7ITwHC83l18+ChqDogwkmMzbIaMQ+plXxeH
	+mTbgzRb82e4t+9HAAvJmp5jyc33wo1KLzuw5oaFz3qd6ZoMMFgJ/o3ONnPrFQy+UDtK2RdAfAu
	lKC6cU3Y9IDlHPCHT3sq3CCPWbRKbYfDs4Q==
X-Gm-Gg: AYBFou3EsabR9OdmJLb1hp+INlea/p7uKh2VH7+OUyHh2N4tJdffAGMmRmLivsOsPW6
	4VU/ECxfMSPIY/Xx0dpJVWPjm1bQvPvk1ESgkjNt2mzcMW3sWg3wKMhg9iLCLEcaUy5w/mfpujC
	4XWRIB9e4eBw/2KFlXw2KYUwrBH7Nwzi5ecF4CrJhsRJMuk36ZOUeYJRz2ECPkrcJy1eKG57cYp
	fMVEoW1iLf+zw9me57mhCSCMMNn4kxzxmZA2/vrPZs3DByNtEnVivlSlDxfV3RgpYr3Cy5b5GBt
	dX/ZKyiSvGOt5Yumuv6GdAFnLEdUaeqWITq0nKPnalJfIr7TkW1kIQw4j92/N+0KR8aYK6pie9j
	ROgWKYvksgQGtNaAbZvdt
X-Received: by 2002:a17:90a:ec8c:b0:39e:2e7c:d43c with SMTP id
 98e67ed59e1d1-3a0bb552ff6mr8388164a91.7.1790633296328; Mon, 28 Sep 2026
 15:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haris Khan <hariskhan936.hk@gmail.com>
Date: Tue, 29 Sep 2026 03:08:05 +0500
X-Gm-Features: AclHuK8nfD3n1L-P--ReJiOhAWtcSF00GXexEk-BbySvWubtT0hOi-mHhOLkupc
Message-ID: <CAPWg44R8LrM95GSC+m3M9vux-LG3SoxdBftjHyuLtYftO1yJ3w@mail.gmail.com>
Subject: ThinkPad P14s Gen 2 AMD: Synaptics LEN2073 stuck on PS/2, SMBus
 companion not ready
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, 
	andi.shyti@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a Lenovo ThinkPad P14s Gen 2 AMD with a Synaptics LEN2073
touchpad, and I appear to be hitting the previously reported
SMBus/RMI4 issue on this platform.

Hardware/system:

Laptop: Lenovo ThinkPad P14s Gen 2 AMD
Touchpad: Synaptics LEN2073
Synaptics board ID: 3471
Current kernel: 7.2.8-1
libinput: 1.32.0

Under Linux the touchpad is detected as:

SynPS/2 Synaptics TouchPad

The PS/2 interface exposes only two multitouch position slots:

ABS_MT_SLOT:
Min 0
Max 1

It can detect additional fingers through BTN_TOOL_TRIPLETAP,
BTN_TOOL_QUADTAP, and BTN_TOOL_QUINTTAP, but only two fingers have
independent positional data.

In practice:

- One-finger tracking works well.
- Two-finger scrolling is smooth.
- Three-finger GNOME workspace/overview gestures are noticeably janky.
- Windows on the same machine provides significantly smoother multitouch
  behavior.

The kernel also reports:

psmouse serio1: synaptics: Your touchpad (PNP: LEN2073 PNP0f13)
says it can support a different bus. If i2c-hid and hid-rmi are not
used, you might want to try setting psmouse.synaptics_intertouch to 1

I have tested:

psmouse.synaptics_intertouch=1

but the RMI/SMBus device does not become available and reports the
previously documented "SMBus companion is not ready yet" condition.

This appears related to the existing P14s Gen 2 AMD reports involving
the AMD FCH i2c-piix4 controller and SMBus Host Notify support.

Previous related discussions:

https://www.spinics.net/lists/linux-input/msg75885.html
https://www.spinics.net/lists/linux-input/msg101577.html

I would like to help determine whether this issue can now be fixed
upstream.

In particular:

1. Is I2C_FUNC_SMBUS_HOST_NOTIFY support for the AMD FCH / i2c-piix4
   controller still the blocker for RMI4/SMBus on this hardware?
2. Is there any current patch series or experimental branch that would
   be useful to test on this P14s Gen 2 AMD?
3. If useful, I am willing to build and test patched kernels and provide
   libinput recordings, dmesg output, PCI information, ACPI tables, or
   other diagnostics.

Relevant current psmouse parameters:

psmouse.proto=auto
psmouse.rate=100
psmouse.resolution=200
psmouse.synaptics_intertouch=-1

Thank you,

Haris Khan
