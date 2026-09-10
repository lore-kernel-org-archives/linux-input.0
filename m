Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1E379C3C;
	Thu, 10 Sep 2026 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011871; cv=none; b=e4b2PfizVNbstAdNKa4Tf17TVUghGFdCCNS+qq9SR3zLXfBDAcIDH067k38s78nvd12Uu0gYu/mIbUnvBN6h33rjuFAWH/lNjs2QmWZcUgpqMaRYENlaiEsUfUzvzHfrLi1Q8vIaCwymKIooZjxHr8lF038eO+qQhY+YWDCCKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011871; c=relaxed/simple;
	bh=Dl4j+jOwZmHANAuxRBRGtO7Sc6Oqu+bg7JlW7yTLrQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CxkTOa2zX4EVWdkbOOxyofbrzqQdTfITK17dHoa61vxBQDhTfYUygv5OK1ERDjGybiMvcgU4ypEFesVGrqobWYmH7Sn/J58yD0nuEzaaEjUkC4I7KMKvGXDgh7hn1UI3v0Xs/RYB6Zct8MTei6A7HKIIk3RI1zjssHbSFDfzYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZiTznQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZiTznQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206241F000FF;
	Thu, 10 Sep 2026 03:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011867;
	bh=Q5FEAymUV2L+ubV0ZsAt3DkQItqPHw1qVaph/VxRekA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZiTznQ5uiXi57V+Gf00sj66IkWEdScI76ij/xWULpdNr8LwwjbCGtlCB7ITn/H7Q
	 4xMopQSASm0+2Q08O+OI+hWEdHE5r10heleKIq7rleqG8y2XR3el5B/4yjaiVucBE6
	 P/agxRdcGaEuWw1jvhgarOHwr3DIIhR8uPuhKMHSPmn8eQeunO+E6s2zECeDfxsS8n
	 5ctB9kPEnUMXz851UtqXleQ8/UlCWGG0ib75VOPKt3Wpa6hJKvfUoTQ8GIQsxefbcF
	 yLZbn9BQeqbkvx6wuWxmSQwJcBsGn5fK/nyFqGDI1ZciGU+lJxFoDcqU2gflNKJarK
	 2qB0K+hym421w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] HID: hid-oxp: represent RGB LEDs with a common
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910032115.28669-14-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-14-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:44:26 +0000
Message-Id: <20260910034427.206241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid cast to `usb_interface` without validating the transport v=
ia `hid_is_usb()`.
--

commit 4292fdde3cbe4b16ea52c7763677a6325b071bca
Author: Andrei Aldea <andrei1998@gmail.com>

HID: hid-oxp: represent RGB LEDs with a common array

Move the existing joystick-ring class device, color components, delayed
work, and cached settings into a per-LED wrapper owned by each HID
configuration. Use a tagged state pointer so later LED types can share
registration and work management without duplicating the lifecycle.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 48fa9169b84c7..55f8b4773e334 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c

[Severity: High]
This isn't a bug introduced by this patch (it was added earlier in the
series in patch 12/15), but it remains unfixed in the final state.

Does this code perform an invalid cast if the device is a virtual HID devic=
e?
In oxp_is_cfg_interface():

	if (hdev->bus !=3D BUS_USB)
		return false;

	intf =3D to_usb_interface(hdev->dev.parent);

If a malicious or buggy user-space application (e.g. via uhid) creates a
virtual HID device with BUS_USB, the parent device is the uhid character
device, not a USB interface.

Since the code does not validate the transport via hid_is_usb(), doesn't
this unconditional cast lead to type confusion and an out-of-bounds memory
read?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D13
