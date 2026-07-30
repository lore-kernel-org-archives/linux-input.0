Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E63C379F
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416148; cv=none; b=su7rbna2e24a/LQD7XOPBds/Kef+FGxNIBDGF2MYP7yMTADhqYygbPPnNUxN+3Z1axXmsXoI0lrQVPmjuBnJSVpneFgjgaSAilc8VTcinuegpWG06LU6RZzkNxZtY38YtWFsRYysSzFR7h7eTY2pCjMbZL3EbGtP3501nng4aIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416148; c=relaxed/simple;
	bh=nXSzq7NcSI8XpLEEcbdRfFctn1lW3xw+TzwBFGKWEt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KEBXXVIrk2c8QW7k60IYho5tUlWrVG+qUd48JDiAQRgEFm6GvxrBr+CwIe+tB2YQlkvNbo6XhjF1qtGODV2flaQHiIyigqukZ5WroRwFe2za87JAXkfNykR9kpnmpw7NezyFeaX9sRTHYjxRPHoRkbBMtV6xWLlNku8yz+Nq7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv9yTqov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv9yTqov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF31F00A3A;
	Thu, 30 Jul 2026 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785416147;
	bh=IdYmDr/IOLKnCkpMkw4IGtYU/0kzQslwcj8rRkAtonI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wv9yTqovpuu+E8rxp54u01619xQcDWg48iMVQa8RiorOHCs4Oh1rjaZiZYjucyS7/
	 lHdpLIZ88ndQONjsRNM0yRVqe/C43XXuVhcPxqGxOOdmCDP7yTF+CTH6bh/Ufy2c3B
	 bCDNae1EoNLGITSEERnfk747t//0Rbg+Ptuqn4437fe2IGcNbhX6dYL6k2lbUBcPml
	 M6AEun5hSv49qB4Rm2FCvYO3i749CB1/bHbONkLbFO/OtkDtrQs7EeDSa1EmMYWJeT
	 wAZ7VT+Mc8N1U7cOAkp2Pba512o8Ff7eP0NVuieTTrwJ1rLpjVJ9u/RQxUg1266mLO
	 bT0YKe3NHwiZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: multitouch: Fix stale MT slots when contact
 count drops to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Carey" <carvsdriver@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260730124336.637339-1-carvsdriver@gmail.com>
References: <20260730124336.637339-1-carvsdriver@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:55:46 +0000
Message-Id: <20260730125547.26FF31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting teardown race condition in mt_remove() where the stick=
y fingers release timer can be re-armed after deletion, leading to a Use-Af=
ter-Free.
--

--- Patch [1]: [PATCH v3] HID: multitouch: Fix stale MT slots when contact =
count drops to zero ---
commit de5f919b17036295856b898ddbe48949c82b0650
Author: Dave Carey <carvsdriver@gmail.com>

HID: multitouch: Fix stale MT slots when contact count drops to zero

The INGENIC 17EF:6161 touchscreen reports a contact count of 0 in the frame
immediately following the last finger lift. This commit fixes an issue where
the driver left num_expected at its previous value, preventing stale slots
from being released. It resolves this by explicitly resetting num_expected =
to
0 for a new multi-report frame.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index edb37b4c867e4..418925b03691b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1321,21 +1321,18 @@ static void mt_touch_report(struct hid_device *hi=
d,
>  	 * Includes multi-packet support where subsequent
>  	 * packets are sent with zero contactcount.
>  	 */
> -	if (contact_count >=3D 0) {
> +	if (contact_count > 0)
> +		app->num_expected =3D contact_count;

[ ... ]

> +		app->num_expected =3D 0;
>  	}
>  	app->prev_scantime =3D scantime;
> =20

[Severity: High]
This is a pre-existing issue, but while looking at mt_touch_report(), I not=
iced
a potential race condition during device teardown that might lead to a
use-after-free.

In mt_remove(), the release timer is deleted before stopping the hardware:

drivers/hid/hid-multitouch.c:mt_remove() {
    ...
	timer_delete_sync(&td->release_timer);

	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
	hid_hw_stop(hdev);
    ...
}

Since hid_hw_stop() hasn't been called yet, the hardware is still active and
can generate events. If an incoming HID report is processed concurrently by
mt_touch_report(), it can re-arm the timer:

drivers/hid/hid-multitouch.c:mt_touch_report() {
    ...
	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
		if (!bitmap_empty(td->active_slots, td->maxcontacts))
			mod_timer(&td->release_timer,
				  jiffies + msecs_to_jiffies(100));
    ...
}

After mt_remove() completes, the devm-managed mt_device structure (td) is f=
reed.
If the re-armed timer expires 100ms later, could mt_expired_timeout() execu=
te
on the freed td structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730124336.6373=
39-1-carvsdriver@gmail.com?part=3D1
