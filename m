Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B43F8EC9
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875692; cv=none; b=diUC3UndFFKlKJBA+Bo3wNdgCHz/Sccribd9KK7kCaknFWSJvfcFI/ucol5sUdSbNcuAyhmOHeI3rHDnunN/Wa8qIuuQ/AQ1co14FxWOEFgGAo8wo2V3ztZ2xaBnUQqaMV5oGrTGOlTFvaPHcisDTkhzj6KcSzjS5qNVpvkTZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875692; c=relaxed/simple;
	bh=4qKR/lVH98aUiCxijaSG2Vwi1+fEKwDhjXqpv8pRvHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJfEXPqyzXzWk7U7IoF4LexedhGEVQD3YcsCoSsWH9aEGUxuoZUSfkNhFR1fWWJSAlKNViixmuUJF34ib1TaePCXXo8F34+fjVSMxxXjGETAexONFw3aTPwJ7dbeh/iI1FUrwVfNN+E1ELWbjsCo5HvVZRUhPa9EI6jorRENGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euusNKZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euusNKZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E119D1F000E9;
	Tue,  4 Aug 2026 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785875691;
	bh=Nb5nkDdCQoDZzSziVZZLqPZkx9fKW2IUZnviB+/NrMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euusNKZckS2WKCSc6rBh4GPbmwqQhw6ZMxBQJhmj3Q0aBD3Oq2PBiKpZZtWUG+8Os
	 BmlwWKsjsWtDKYZb4TD+3ZPzGtzO24H1B5VlSCl7ZfSCQWHnFgw1Fe62dIpL9c8rHZ
	 6Z6LZINLg5zQQCu3Q1Tr6XFINFE2bph7NIeoI23ddg4AsNAZ8S8BZHXnT4aVXJKmNX
	 PXuSSiEj7Ye4kGDgivW4DA4UQAuY4lp713znJHKUxuMQiI9A3ihqVwFvxOgsXpY6Ty
	 ec80078bo4H6/fwjbHOLQDrgJV6YmmIOSIpHtiZpoLK9OX8xKkbMcbDN7ymwkv7deu
	 d8Mft+2XjoRUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: multitouch: Add report ID mismatch quirk for ASUS
 ROG Z13 Folio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lovekesh Solanki" <lovekeshsolanki00@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>
References: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:34:50 +0000
Message-Id: <20260804203450.E119D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing Race Condition leading to Use-After-Free in `mt_r=
emove` due to incorrect teardown ordering.
- [High] Pre-existing logic error in `mt_probe` completely wipes out class-=
specific multitouch quirks if device axes are inverted.
--

--- Patch [1]: [PATCH] HID: multitouch: Add report ID mismatch quirk for AS=
US ROG Z13 Folio ---
commit de9eab2643b8e246b68084a8a0196cbe33c078cf
Author: Lovekesh Solanki <lovekeshsolanki00@gmail.com>

HID: multitouch: Add report ID mismatch quirk for ASUS ROG Z13 Folio

This commit adds a quirk for the ASUS ROG Z13 Flow touchpad to tolerate
mismatched report IDs during feature fetches. This allows the device to
operate in full Touchpad Precision mode instead of falling back to a
limited mode.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221774

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index edb37b4c867e4..de421ae47848b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c

[ ... ]

> @@ -405,6 +407,16 @@ static const struct mt_class mt_classes[] =3D {
>  		.quirks =3D MT_QUIRK_ALWAYS_VALID |
>  			MT_QUIRK_CONTACT_CNT_ACCURATE |
>  			MT_QUIRK_ASUS_CUSTOM_UP },
> +	{ .name =3D MT_CLS_ASUS_ROG_Z13_FOLIO,
> +		.quirks =3D MT_QUIRK_ALWAYS_VALID |
> +			MT_QUIRK_IGNORE_DUPLICATES |
> +			MT_QUIRK_HOVERING |
> +			MT_QUIRK_CONTACT_CNT_ACCURATE |
> +			MT_QUIRK_STICKY_FINGERS |
> +			MT_QUIRK_WIN8_PTP_BUTTONS |
> +			MT_QUIRK_CONFIDENCE |
> +			MT_QUIRK_IGNORE_FEATURE_ID_MISMATCH,
> +		.export_all_inputs =3D true },

While reviewing these class quirk additions, I noticed a pre-existing issue
in the probe function where quirks are assigned:

drivers/hid/hid-multitouch.c:mt_probe() {
...
    if (hdev->quirks & (HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT) &&
        !((hdev->quirks & HID_QUIRK_X_INVERT)
          && (hdev->quirks & HID_QUIRK_Y_INVERT)))
        td->mtclass.quirks =3D MT_QUIRK_ORIENTATION_INVERT;
...
}

[Severity: High]
This is a pre-existing issue, but does this assignment mistakenly overwrite
the entire td->mtclass.quirks bitmask instead of appending to it?

If a device is probed with HID_QUIRK_X_INVERT or HID_QUIRK_Y_INVERT (but not
both), it looks like the driver assigns td->mtclass.quirks directly rather
than using the bitwise OR operator (|=3D).

Could this cause the device to lose core functionality derived from its cla=
ss
quirks (like MT_QUIRK_CONFIDENCE or MT_QUIRK_ALWAYS_VALID)?

[ ... ]

I also noticed another pre-existing issue during device teardown:

drivers/hid/hid-multitouch.c:mt_remove() {
...
    timer_delete_sync(&td->release_timer);

    sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
    hid_hw_stop(hdev);
...
}

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a race condition
here that could lead to a use-after-free?

Because hid_hw_stop(hdev) hasn't been called yet when timer_delete_sync()
is called, the hardware transport might still be processing events.

If a touch event is processed immediately after the timer is stopped,
couldn't mt_touch_report() re-arm the timer right before the devres-managed
td structure is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804202031.7573=
8-1-lovekeshsolanki00@gmail.com?part=3D1
