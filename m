Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E892E7179
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498531; cv=none; b=fd56eIjDDmH97coURbO/KRCX5FzjNxjRHa6ugwiAubHb68pD5FKRDjaWryvPLqXCfFU5SiE8MVo1bh7/J2IxkBtCbS6rI0mco9dvt9ikDzzV+t60mLSzGlYXo8jbqHJj4P5LL9pbb+XkXgDZhF3f1zr906txK9bIyvtQT3oBYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498531; c=relaxed/simple;
	bh=DN5B6VhmzXtzRv4lKlY18skFw5zbz/bI89vcf7mKXg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ioKYz58G6EGj1KuP8TEp8bUuwYetez3Hf+d+J3uFzw1ZjeZUWO5Vwe7RoX3umegdA+NR8F5ywhxR3Fgcgefa2NxTgi5BXReeo70XjeOMCQNGhf+E3ZsDHg+TLr9aggzYP2+A1kbIooYWL+RTnKK6GtZJQDZwUVs+8hu1B10ksfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdPIfWck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdPIfWck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739ED1F000E9;
	Wed, 12 Aug 2026 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498530;
	bh=vwb3j5QVPA/URMMY2nEpzHakhe6RrtrwxItX0BaPEEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hdPIfWcktqGSqEuZ5AFv4NAFmgIxntgRR1v2eC7SXm3ws4hjpleoUOq5oqGc8bxxA
	 YS6k43x4nHnhAJC/Adzo4v0qxW1PIeSIHBo85m/2OMbLtYZ+01l8XXIUF/vxqMqDoZ
	 Tk5+fVEs2UGDlNczxAlpBSuX8+wHnrGsnDZ8BbvdBgXfMBQfDz9nkTnCQTqAG1rvQp
	 mhVYUTDG7gaftBbH2fqwxPbuU1FyqRNH3fuyiB5INpVd9AWhiUryx2U6A/8p4a2aAS
	 F2I/OzFGZvvfJ7bJM3IhVArT17X3veEC4owsAnQYEwoWVL+ynkb0GtFm6VYZAXkDl0
	 rEomBKPFbDnGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260812012037.3251614-3-vi@endrift.com>
References: <20260812012037.3251614-1-vi@endrift.com>
 <20260812012037.3251614-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 01:35:30 +0000
Message-Id: <20260812013530.739ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Rumble workqueue catch-up loop causes extreme HID bus spam and del=
ayed haptics.
--

--- Patch [2]: [PATCH v13 2/3] HID: nintendo: Add rumble support for Switch=
 2 controllers ---
commit 0c691726864354d8749a514212fbc109cdbf67d2
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers
   =20
This adds rumble support for both the "HD Rumble" linear resonant actuator
type and eccentric rotating mass haptics used in Switch 2 controllers. It
adds a delayed workqueue to dispatch periodic rumble updates to the hardwar=
e.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 78c9ad3c16104..4f58b6f9df38a 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3209,6 +3263,128 @@ static void switch2_kref_put(struct kref *refcoun=
t)
[ ... ]
> +static void switch2_rumble_work(struct work_struct *work)
> +{
[ ... ]
> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(4);
> +		uint64_t current_jiffies =3D get_jiffies_64();
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_jiffies;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +
> +		/* Reschedule a little early to make sure the buffer never underruns */
> +		interval -=3D msecs_to_jiffies(2);
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);
> +		else
> +			schedule_delayed_work(&ns2->rumble_work, 0);

[Severity: High]
Will this loop continuously without delay if switch2_rumble_work() falls
behind?

If CPU scheduling delays the worker or there is lock contention,
ns2->last_rumble_work might fall far behind current_jiffies. Because
ns2->last_rumble_work is only incremented by 4ms each run, the else branch
will reschedule the work with a 0 delay over and over until it catches up.

Can this spam the HID transport with stale synchronous commands and delay
input events, or cause haptics to continue playing long after the intended
effect stops?

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812012037.3251=
614-1-vi@endrift.com?part=3D2
