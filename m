Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77202857FA
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387158; cv=none; b=nOl/ZbUVD2A+6XLURJbCj2ZUa6Tq8/WDcL1aPbqPW/SWCuTx32XYpVzeWW53ZzTXgpXHJYSxb1T9DLMMajoc/43YOlerXG21KPZwvX2d4+IsQGtNixV5UqBuQpsqInae4KAKycl3XN1bgXSE6ND16kuhBK5Mj5jF0YDbEQlN7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387158; c=relaxed/simple;
	bh=LVjAu4rZkLQb/uJatyGJJkVUTj6tyirbVnUOOwZFsLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cOR3OZJtLJNrnT1EMF3k+59CUjmRqB2SqyUQ8cxY93dp6Zo8xxA93l0goh0OejT3yFo673aTcz8JjPEMmkvs5gOEB4xDTb9VHN71DAfDsNTsBbe+VINY9Ur2kCJa5aac1fsYYc77sKm1Q3ZOWgHwHXg09pkRivjHLjXiePJiL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW2XLcju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW2XLcju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7961F000E9;
	Thu, 30 Jul 2026 04:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785387157;
	bh=gw+fY9xyuLKIj2mhSVL8Dnd1lrielRq4p3s2ONNzxd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JW2XLcju9U7gbLZxa0qzMJH1cb8bxPeoTPKXuF1UzyvL8ZtVtKoRmLbWx0CL0mFHe
	 SiTYo8N2VMhZBeiS6w5jRe2QVby5ifOSGF0MUMT4tzQOeNUXff1qQV8i9qAZWDXwAt
	 zM49MfBOhf5cHTFxdw0nUP8BOevPic/4A6wgZOmXzWWqheZi9vUBhsZuV/0tKw2qok
	 8vjMienzIecbzvw+6SJ99B645is/qDS76UpE5d6QuhJ8toW8iag167CfhLNdUdY9ji
	 f3AAWqHsOD2MjKwOzqx/Mq79cgC2wvJaMdQuwzED5/lbxNCasq+DpgiHHRFyceNeKd
	 jo21HZfGEBRrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] HID: steam: Refactor and clean up report
 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730041251.1659029-3-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
 <20260730041251.1659029-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:52:36 +0000
Message-Id: <20260730045237.2E7961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Works (`work_connect` and `rumble_work`) can be re-armed after the=
y are cancelled during device removal, leading to a Use-After-Free.
--

--- Patch [2]: [PATCH v5 02/11] HID: steam: Refactor and clean up report pa=
rsing ---
commit b341becd37dc80cfee5384e2c463afc0e1624d32
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Refactor and clean up report parsing

This switches from a parsing style where each button or axis is parsed
individually out of a report using !!(byte & BIT(x)) style. This commit
switches it to a mostly unified approach of defining a list of individual
mappings in an array and passing it to a function that handles all of the
extraction. Theoretically this is more lines, but in practice it results in
(subjectively) cleaner code. Some exceptions still need to be made for
things like handling the lizard mode toggle key, but in general there's a
lot less manual code.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index a854d6360a0e3..75d6be0be0a29 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -43,6 +43,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/delay.h>
>  #include <linux/power_supply.h>
> +#include <linux/unaligned.h>
>  #include "hid-ids.h"
> =20
>  MODULE_DESCRIPTION("HID driver for Valve Steam Controller");

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing the driver's event handli=
ng=20
I noticed a potential use-after-free during device removal.

In steam_remove(), work_connect is cancelled before the hardware event=20
source is stopped:

steam_remove() {
    ...
    cancel_work_sync(&steam->work_connect);
    if (steam->quirks & STEAM_QUIRK_WIRELESS) {
        hid_info(hdev, "Steam wireless receiver disconnected");
    }
    steam_unregister(steam);
    hid_hw_stop(hdev);
}

If a wireless connect or disconnect report arrives after cancel_work_sync()=
=20
but before hid_hw_stop(), steam_do_connect_event() could process it:

steam_do_connect_event() {
    ...
    if (changed && schedule_work(&steam->work_connect) =3D=3D 0)
    ...
}

Could this re-arm the cancelled work, leading to it executing after the=20
devm-managed steam_device is freed? Would it be safer to call hid_hw_stop()=
=20
earlier in the function?

[Severity: High]
This is also a pre-existing issue, but I noticed a similar work queue order=
ing
issue in steam_unregister().

The rumble_work is cancelled before its producer, coalesce_rumble_work:

steam_unregister() {
    ...
    cancel_work_sync(&steam->rumble_work);
    cancel_delayed_work_sync(&steam->mode_switch);
    cancel_delayed_work_sync(&steam->coalesce_rumble_work);
    ...
}

If coalesce_rumble_work fires during this window, its callback
steam_coalesce_rumble_cb() unconditionally calls=20
schedule_work(&steam->rumble_work).=20

Could this cause the rumble_work to be re-armed and subsequently execute on=
=20
freed memory? Would reversing the cancellation order prevent this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730041251.1659=
029-1-vi@endrift.com?part=3D2
