Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C04F93B3
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840449; cv=none; b=ABPOt2ofKiKKU6Dq5xgvef32jIMTF5R68phhQw0qI7Q/3gUVWOX9wPDL0ffx14vmHSoWxzaVhNE8awVKfb3wrI7txUuHcHajKSkDXPJXl9xOT50x6M1eXchdv1q1yBgjjE78sSL8dD8SFcX3GqbjGeMO7tkRO9Z+AIAarfeclMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840449; c=relaxed/simple;
	bh=T0j9JmA+MWXvLpStdbcIPg1E/xybwogp5DBc2jN2R/8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h9uZm/DwYJnmKeiG91FGQAPQHPLDpR1mxZgv/so4ty0eFoAfTZgDSk3K02tTn7ED9L/pwGp9uUk6pw/lVhsYkkFDcsAda9xLKCGepHnA7mzkxrFglSRSwHLk1hQm3e5ju003PamNflFF3UhyZNJBsU4QBCFhicvVTpVDSR/O6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMAmurKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMAmurKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA11F0089B;
	Mon, 12 Oct 2026 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840448;
	bh=A2K+gathfxooyV6Qr4Tvg9yVPGkSZsYFyVme1jTy9vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMAmurKjATynVHkAToHhcVLxebLoZCoZvsBHV84YfOolRTS5gwhhNQ5OOIV6hyR3w
	 BMqPfyPJ9rFJTAQVcJ43WYd/t+uDxem+HWdKbswNLtGY2Y/D+CP7OZwizyo5+GoBxA
	 JAGltR0LTNZClL95DgzHIi7YKjCbzFoDLvqDFkSgMvhOdslgI6sdCDLFuUUiDEqn2E
	 QuziVHPG/s3lYP6xIFN0uCPumxuNqRPN+KntPl9zHd1qW/WW1/xnaeDrb7E5xyOsp0
	 QCjFgi6dZtcQ/WSqWqsf6AjV6yUNaWSLrNIwW/qEbI4dudQX5I50D1oo45RC9kI3d+
	 fFgkSqesiFPcw==
Message-ID: <sashiko-outbox-168625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] HID: UNCTRL: keep a single battery when a mouse
 has multiple connections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bishwa Bhusan Saha" <contact@bishwasaha.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261013-b4-unctrl-m1-battery-v2-4-bd6752021753@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
 <20261013-b4-unctrl-m1-battery-v2-4-bd6752021753@bishwasaha.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 21:27:27 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: unctrl: use-after-free via concurrent battery handover to a s=
topped device
- [High] hid: unctrl: UAF in usbhid_output_report due to delayed worker can=
cel order
--

commit e4a86ecd29d9dc9de2cb5ac805fe6b509cef727d
Author: Bishwa Bhusan Saha <contact@bishwasaha.com>

HID: UNCTRL: keep a single battery when a mouse has multiple connections

The UNCTRL RAGE mouse can be connected over its 2.4 GHz dongle and its
wired connection at the same time. This patch avoids reporting two
separate batteries by registering the power supply only on the active
connection, handing it over dynamically when that connection goes away.

> diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
> --- a/drivers/hid/hid-unctrl-m1.c
> +++ b/drivers/hid/hid-unctrl-m1.c

[ ... ]

> @@ -302,20 +364,41 @@ static int unctrl_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>  static void unctrl_remove(struct hid_device *hdev)
>  {
>  	struct unctrl_dev *dev =3D hid_get_drvdata(hdev);
> +	struct unctrl_dev *other;
> =20
>  	/* Stop polling before the transport goes down. */
> -	if (dev) {
> -		cancel_delayed_work_sync(&dev->battery_work);
> +	if (dev)
>  		hid_hw_close(hdev);
> -	}
> =20
>  	hid_hw_stop(hdev);
> =20
>  	if (!dev)
>  		return;
> =20
> -	if (dev->battery)
> -		power_supply_unregister(dev->battery);
> +	/*
> +	 * Pass the battery to a capable connection without one, so that it
> +	 * keeps being reported when the owner disappears.
> +	 */
> +	mutex_lock(&unctrl_lock);
> +	list_del(&dev->list);
> +	/* out of the list, nothing can reach this device anymore */
> +	cancel_delayed_work_sync(&dev->battery_work);

[Severity: High]
Can this cause a use-after-free in the transport driver? By moving the
cancellation of the delayed worker battery_work to after hid_hw_stop(),
the self-rescheduling worker might run concurrently with or after the
transport is torn down.

For example, hid_hw_stop() invokes the transport driver's stop routine
like usbhid_stop(), which frees resources such as usbhid->urbout. If the
un-cancelled worker executes unctrl_battery_timer_tick() and calls
hid_hw_output_report(), the transport driver might evaluate its urbout
pointer without locking, creating a time-of-check to time-of-use race
that dereferences the freed pointer.

> +	if (dev->battery) {
> +		struct power_supply *battery;
> +
> +		scoped_guard(spinlock_irqsave, &dev->lock) {
> +			battery =3D dev->battery;
> +			dev->battery =3D NULL;
> +		}
> +		power_supply_unregister(battery);
> +		list_for_each_entry(other, &unctrl_connections, list) {
> +			if (!other->vendor || other->battery)
> +				continue;
> +			unctrl_battery_register(other);

[Severity: High]
Can this trigger a use-after-free if two devices are concurrently removed?

hid_hw_stop() is called before the device is removed from the
unctrl_connections list under unctrl_lock.

If Thread A is executing unctrl_remove() for Device A, it will call
hid_hw_stop(A->hdev).

If Thread B is concurrently executing unctrl_remove() for Device B, it might
acquire unctrl_lock before Thread A. Thread B will iterate the list, find
Device A, and hand the battery to it by calling unctrl_battery_register().

This triggers unctrl_fetch_battery(), which issues a hardware query via
hid_hw_output_report(). Since Device A's transport has already been stopped
by Thread A, accessing the hardware can trigger a use-after-free.

> +			break;
> +		}
> +	}
> +	mutex_unlock(&unctrl_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-unctrl-=
m1-battery-v2-0-bd6752021753@bishwasaha.com?part=3D4
