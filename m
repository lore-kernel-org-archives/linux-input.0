Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD679395AE2
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884618; cv=none; b=SC1IJNrohQskmGEcW6OTtHIb45LwJzjSAI73WPKDbl7vCuVGw5UL2DHoCsc+Cejkz5yfwtK4712Ozvkfk1jq3eISnt7q+izJOEgTtNgibZpYbwBqYpjBDMoKDX+iLp0h9kaXNaf+fhNa+RZ6vu/LHGOaUTrliZhMTbUnW7Altao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884618; c=relaxed/simple;
	bh=zV7yTWerURAH5yEc86eyr/Q0Vr1J/TKRZoOPHfHLaFo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iMDwFzwTwUxoZHobLMiWhSNScK88fUhVVPJIGKtmxEohX5kn1ZyQboMGb0ouFMlWwBZcR74usD5HkkDq0G6cOSRQ3v4yjoM+KL6rGbLAti+vhQCMO+EIActNltyBPJleb4BXbGJ63oAExI2kDcybEzoTeWYDy2tp8Hjw0+7GpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d55fP/QQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d55fP/QQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7463C1F000FF;
	Tue, 13 Oct 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884617;
	bh=9FZ54s2wB7cpj9GkQ45ML4w5GXbFFdN9JMBWnWIhQr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d55fP/QQacCr7EJlOg8lmMPdzgcUjnMzXmWjrcfgVy4LwMV1ikbvjs1fEL84Lxg0W
	 FaxLiMiqH2iHdW1R8eBG1rGTpRO0iAzsrwc/25h9RMDh8aYyHyuK6LXND3+lgZjo/2
	 Sshm8tYMVfcTDijIJD6eYFrugKyopCpDJqOQI7kTHbfKuLu49mPbk9tcy+u+M10wX/
	 Cw/DsPoic/g9uhmBBaN3yd9DPkeSW5kYOmeGgPX9HOUqhW+UQ5nBDtZi47KKCFNj5Z
	 9xwQndgBZhPQUxu5Y6rwpRmGpM9tKxqRvoQAjM/S60gWEnAyzptQi7sf3eetnm9miY
	 N7UPP9qyF4XQg==
Message-ID: <sashiko-outbox-169373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v6.1 2/6] HID: hid-steam: Make client_opened a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261013091204.529049-2-lee@kernel.org>
References: <20261013091204.529049-1-lee@kernel.org>
 <20261013091204.529049-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:43:37 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: redundant client_opened counter due to core refcounting
--

commit 60750525b808a9b3b327f3fb2200f042e05ff888
Author: Vicki Pfau <vi@endrift.com>

HID: hid-steam: Make client_opened a counter

This commit replaces the client_opened boolean flag with a counter to track
the number of open clients. It increments and decrements the counter in the
low-level open and close callbacks to ensure the driver does not incorrectly
assume there are no remaining clients when one of multiple clients closes.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 2f5e9d3e64991..4a0a13b0ae62f 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -634,7 +634,7 @@ static int steam_client_ll_open(struct hid_device *hd=
ev)
>  	struct steam_device *steam =3D hdev->driver_data;
> =20
>  	mutex_lock(&steam->mutex);
> -	steam->client_opened =3D true;
> +	steam->client_opened++;

[Severity: Low]
This introduces a manual counter increment here, assuming the callback can
be invoked concurrently or multiple times for the same device.

However, the HID core strictly serializes low-level operations using
hdev->ll_open_lock and internally refcounts them via hdev->ll_open_count.

Looking at hid_hw_open() in hid-core.c:

	if (!hdev->ll_open_count++) {
		ret =3D hdev->ll_driver->open(hdev);

This guarantees that the driver's .open callback is invoked exactly once on
the 0->1 transition.

Is it possible for steam_client_ll_open() to be called multiple times in an
unbalanced manner, or does the core refcounting make this counter redundant?

>  	mutex_unlock(&steam->mutex);
> =20
>  	steam_input_unregister(steam);
> @@ -654,12 +654,12 @@ static void steam_client_ll_close(struct hid_device=
 *hdev)
>  	spin_unlock_irqrestore(&steam->lock, flags);
> =20
>  	mutex_lock(&steam->mutex);
> -	steam->client_opened =3D false;
> -	if (connected)
> +	steam->client_opened--;

[Severity: Low]
Similarly, the HID core prevents unbalanced low-level closes.=20

Looking at hid_hw_close() in hid-core.c:

	if (!--hdev->ll_open_count)
		hdev->ll_driver->close(hdev);

This ensures the .close callback is invoked exactly once on the 1->0
transition.=20

The manual decrement relies on the premise that client_opened could
legitimately be greater than 1. With the core refcounting in place, it appe=
ars
it cannot. Could this counter be adding unnecessary code complexity based on
the false premise of multiple concurrent opens?

> -	if (connected)
> +	if (connected && !steam->client_opened)
>  		steam_set_lizard_mode(steam, lizard_mode);
>  	mutex_unlock(&steam->mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013091204.5290=
49-1-lee@kernel.org?part=3D2
