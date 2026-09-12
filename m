Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1739182A
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183386; cv=none; b=XJtPTVhf0eFI1OmbbKl9Tq6CpbMIGHoFEbzvzQiglepBDU0Rb7GaPBf4Sq0lNSq1+HfMaqj3bATYlQVGeQF0GLTmXm41g0IBe0ONsTCNeEaelb2pic0O3fJJSC4pCV328sO8rZ9xQ2cBk0lL6haR5T0nWOKRBjt3tQK3LkG04Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183386; c=relaxed/simple;
	bh=ATwV+mbkDFASTWkFNzUkcAziyP4H6MbHtjsc+RqDNzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnSNfeMXsuxn8TXCNVoMqmWh0DIlB5sk33gq7VuFI9Zf+Vf6bKJaM0i7Cifuih1sI1ztdNZJYm4N5ZTOhMBtTYVpvXtvP5KiWSpSvMenFqjqBeH62Wa8zcVFjrhM1uCF3fNiLAs4Bq4/NbF2YbwErFjBPa0YxmgXIEkjF6vlzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df2urVKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df2urVKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D051F000FF;
	Sat, 12 Sep 2026 03:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183383;
	bh=KdO6l84Ga8EWFevlo+Hvv3c//ZKrsUuc8i9d9q1dA1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Df2urVKGQYgwc+7YobpoPmaOYrswDRuwgjw+XsLtei4WvexFdainjwd4BgeupHt7G
	 bQQeBBl43+udEwhT4H4Z7VnxPgJnuPjlVcMv/Q3LvfBuyDiSCKS3eW8avLdQXN50zA
	 2ra6/lYtyT99yZbLBXryjeU0TBnbp6QQVu295eHHw0UcRmr8pOKYdbXHOeEd+mLjWt
	 1JHYybpp1/cJt5o/Hb5e4ByNSYl29zf+/Z2yt1sjw/d0C0kgVPKtuI1bkV4haXswa2
	 vwnbTLOV/F7h8RPKNw414Z+kmOxxtQNPBLHGx8Hk+UxhwfnbZYgJlem4P8khMI+NWn
	 IOR3c8+jXvMRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/12] Input: xbox_gip - Allow sending fragmented and
 ACME messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912030426.2997003-7-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:23:03 +0000
Message-Id: <20260912032303.63D051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Loop index typo in `gip_disconnect` causes OOB array access an=
d failure to cancel delayed work.
- [High] Retrying reliable (ACME) messages corrupts their headers due to in=
correct flag and length field encoding.
- [High] Teardown sequence race condition causing Use-After-Free of device =
structures due to URBs re-scheduling cancelled works.

Pre-existing issues:
- [High] AB-BA deadlock during device reset due to unregistering input devi=
ce under lock.
- [High] Teardown ordering race condition causing UAF of rumble_work and at=
tachment memory.
--

commit d64a449cbd12693ac78473a4f8297a24eb7916f4
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Allow sending fragmented and ACME messages

This patch adds support for sending fragmented and ACME (reliable) messages
in the xbox_gip driver. It sits on top of a reliable message transmission
flow for messages that exceed the MTU and handles the required sequence and
acknowledgment tracking.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> +static int gip_send_next_fragment(struct gip_attachment *attachment,
> +	struct gip_out_fragment *fragment)
> +{
> +	struct gip_interface *intf;
> +	int next_bytes;
> +	int flags =3D GIP_FLAG_FRAGMENT | fragment->flags | attachment->attachm=
ent_index;

[Severity: High]
Does this unconditionally force GIP_FLAG_FRAGMENT onto all retries? If an=20
unfragmented reliable message times out, retrying it with this flag will
cause gip_send_raw_message() to process it as a fragment. When processed as=
 a
fragment, it encodes the fragment_offset (which is 0) instead of the
total_length, resulting in a corrupted header that the hardware may reject.

> +	int mtu;
> +	int rc;
[ ... ]
> @@ -3144,17 +3179,17 @@ static void gip_shutdown(struct gip_device *gip)
>  {
[ ... ]
>  	for (i =3D 0; i < MAX_ATTACHMENTS; i++) {
>  		struct gip_attachment *attachment;
> =20
>  		mutex_lock(&gip->attachment_lock);
>  		attachment =3D gip->attachments[i];
>  		mutex_unlock(&gip->attachment_lock);
> =20
>  		if (!attachment)
>  			continue;
> =20
>  		cancel_delayed_work_sync(&attachment->metadata_next);
>  		cancel_delayed_work_sync(&attachment->in_fragment_timeout);
>  		cancel_work_sync(&attachment->rumble_work);
> =20
>  		guard(mutex)(&attachment->lock);
>  		gip_reset_attachment(attachment);

[Severity: High]
This is a pre-existing issue, but does this teardown sequence leave a race=
=20
window open for rumble_work to be rescheduled? The rumble_work is cancelled
before gip_reset_attachment() unregisters the input device. A concurrent=20
ioctl or ff-memless timer can call gip_play_effect() and reschedule the wor=
k=20
while the device is still registered, leading to a Use-After-Free when the=
=20
attachment memory is freed.

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of an AB-BA
deadlock here during device reset?

When a hardware reconnect triggers gip_receive_message() and eventually
gip_reset_attachment(), it acquires attachment->lock and calls
input_unregister_device() via gip_free_devices(). The unregistration process
synchronously removes sysfs groups, which blocks waiting for all active
kernfs references to drain.

If a local user concurrently writes to the LED sysfs brightness attribute,
gip_guide_led_set() acquires an active kernfs reference and then blocks
attempting to acquire attachment->lock, completing the deadlock.

>  		gip_reset_metadata(attachment);
>  	}
>  }
> =20
>  static void gip_disconnect(struct usb_interface *intf)
>  {
>  	struct gip_device *gip =3D usb_get_intfdata(intf);
> -	int i;
> +	int i, j;
> =20
>  	if (!gip)
>  		return;
> =20
>  	gip_shutdown(gip);
> =20
>  	usb_kill_anchored_urbs(&gip->data.out_anchor);

[Severity: High]
Is this the correct teardown sequence? If gip_shutdown() cancels the
send_fragment work before usb_kill_anchored_urbs() is called, active URBs
might complete in the window between them. If an URB completes and triggers
gip_urb_out(), it will reschedule the send_fragment work. After
gip_disconnect() frees the device structures, the rescheduled work could
execute and access freed memory. Should usb_kill_anchored_urbs() be called=
=20
before gip_shutdown()?

[ ... ]
> @@ -3206,8 +3217,8 @@ static void gip_disconnect(struct usb_interface *in=
tf)
>  		if (!attachment)
>  			continue;
> =20
> +		for (j =3D 0; j < MAX_OUT_FRAGMENTS; j++)
> +			cancel_delayed_work_sync(&attachment->out_fragments[i].timeout);

[Severity: Critical]
Does this inner loop mistakenly use the outer index i instead of j?
Iterating up to MAX_OUT_FRAGMENTS using the outer attachment index i could
lead to an out-of-bounds access when i is larger than the fragment array=20
bounds. Additionally, it fails to cancel the actual delayed work items at=20
indexes j, which could lead to a Use-After-Free if they execute after the=20
attachment is freed.

>  		devm_kfree(to_gip_device(attachment), attachment->uniq);
>  		devm_kfree(to_gip_device(attachment), attachment);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D6
