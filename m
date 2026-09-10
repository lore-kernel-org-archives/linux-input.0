Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057B379C3C;
	Thu, 10 Sep 2026 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011880; cv=none; b=f6Q8fmABIyyJOnbGD1VUeWilvqwxFBghLCmTQyB3Lb1THjDyNPowcunRoRPvwv7HiQpfMSQrbeKksq3v0BAuZRVm5PIliW8rXmcXZWpaGDCOQeoUY7txlCGC8XejD3Z5WDoCgECYYOVNymSLcNnL1qx1+XCHHwCZ0Dz0vCF/nMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011880; c=relaxed/simple;
	bh=/Asm9UjHOWQ6O+oZCWKvDs30r39z4Gwfv3jvFJA1FVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IxvIO3LEX04xiwFZnATPXlyo2SKhd66ZrkFGhy4+6KqbGrUsKOF2I3PsN+KMTlIe0dRKi0Fv3xdiyAPGZaRJlAIyVYEpMEYiAXdNp5E/lCjx+ci5ZiI1cHLhtXrVsnq+a08Vr3kIJzEIEXEBY4uFtHlhSTEis9D/ak336tLbJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POa2oCbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POa2oCbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6541F000FF;
	Thu, 10 Sep 2026 03:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011878;
	bh=e8YfXPnANzU6vt5NiGcri0KSXebkXwJaFbqzUMtb5Os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=POa2oCbMUSUSTEoPUw5TQmwIzVXOxfk8efsNeN0EzMucg9TZwxnYC//KteySaVEPc
	 8twykyjD/EHNQnYE+R9DUiNvnvM+i0tWspBDM8ugt8e2xrhc9zWTVWhMcjw5OAd3BX
	 kDvdLIaNc/PKmLFmYAM1nLFqHiRQwYBTsJvEOCUmqYufv42kTSPgo6Z1ptSBvhkaIH
	 xVBZ1a/loY1wxnbfVsXkwi7POqpjih/jeDXQEUNZ96N/UWkFWLZVdrtzvdsYBwskBy
	 b66gBxd0SI9MZYN2k+gPA8MJkk0TfHTyjfvRrJaVTQjByLc0gD/zNk/CBkzS+b4745
	 /Zkcras1akfSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] HID: hid-oxp: add X2 auxiliary RGB zones
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: lee@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org
In-Reply-To: <20260910032115.28669-16-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-16-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:44:37 +0000
Message-Id: <20260910034437.EB6541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver incorrectly checks `hdev->bus !=3D BUS_USB` before cast=
ing `hdev->dev.parent` to a USB interface. This violates HID subsystem guid=
elines and allows `uhid`-injected devices to cause a kernel crash.
--

commit 2e553029a2661e6b48c17a4d0a1f09df4448e068
Author: Andrei Aldea <andrei1998@gmail.com>
Subject: HID: hid-oxp: add X2 auxiliary RGB zones

This commit adds separate multicolor LED devices for the ONEXPLAYER X2 guide
button and rear logo using Gen3 zones 5 and 6. Each LED retains independent
color, brightness, and effect states. It also documents the new auxiliary
effects and the existing joystick-ring effects in the sysfs ABI.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 9a46602238aa3..757cef88e6c62 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c

[ ... ]

[Severity: High]
Does this code safely cast to a USB interface? In oxp_is_cfg_interface(),
the check for USB devices uses the bus type:

    if (hdev->bus !=3D BUS_USB)
        return false;

    intf =3D to_usb_interface(hdev->dev.parent);

If a userspace program injects a HID device with BUS_USB via /dev/uhid, the
bus check passes, but the parent device is not a valid USB interface. This
results in an invalid cast and causes a kernel crash when dereferencing
intf->cur_altsetting.

Should this use hid_is_usb(hdev) instead of checking hdev->bus to prevent
this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D15
