Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623056;
	b=d4CwzdbZGKfeNfuHlL9aEPdl689SmZ/stz+bm5HUv2qfY6SdDrUDwRCC9AgdQkoPdwDT
	 oOukKfcn+dTvRGJao+djwC3tBafwMWq+dAQgwfY7pX67LzS17zADixZjcxvjL9H4TfFuR
	 1RFReeraiIYJN64Y7UYQZPyOIFZ7FFs+508ARhxup77mMvNpM/FxKAoYmOXilYUaWz89+
	 P/hR8mT2IH8HZzFSK35lNYG5GKCUssKwLugorzq251TNKJBx4HLOfvG8tz/GSkDiPg0ba
	 ctvCvg9EtrczL9UYPiW4sLLjz+UdvNtSDgSu47739B7+OzWP4p4r4CNleUKoQljNVrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bS0sle4iqO617BPakUZXfVcB45KF5KpBrJxfvMi2AMM=;
	b=NdIzZP2Ryuo9ZxfnthVwUABvoEohcY6RiNfZCKuyfZZLHKF/J3KuGnIxWGhB3Z2bFpY3
	 g2TFkIWrbzSDq3ir5DJh9bjrJ+rN0v7Ke1FqTMhkeewaraDm7H3lE3tVIROuSjoLOciK6
	 yu9J+JPtDhak6VFfR8o2MG/Ovk7gAUguEHzgAumu/AhwYAWyvAsYRcglYuVFU68TZlBqB
	 itwM8SD6cHZBQ3CUC2ZtYg2FU1m8/8E+p+C3e8/Y7s5Ii6HlFGuroH8JGAxd2W8iXwP5F
	 ju0G2RfsBbrPlyr4lE2CL145Tw41VCHHq1hOf+EkQHBt8BnY+A/o9bajKZUilky1XoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpUHtXrR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D443606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpUHtXrR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E251F000C1;
	Wed, 21 Oct 2026 22:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623056;
	bh=bS0sle4iqO617BPakUZXfVcB45KF5KpBrJxfvMi2AMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpUHtXrRYT9Nsi+b5u6LKaFrkfwmt4jNY8Lxeq/6faR/MqYtmJpCTfnWg8qWpHkov
	 z4CTFYhdv2nD605blbI+SOc+Cz9eTZKl3UmhDrENPzo0poH1sKJWR+wj9nWRNcqbeH
	 y47A962Zflh0E4uZVPRQjvo2ctOkwETZ37RPasuB1PmvgH77cXFKXmySIim+pyF9Et
	 jALqO43425yjnnh5VDcVPY0QJ85y/FDwPkk5GFdUeo0qZ9kI88hwhjMLzF2vuVziKH
	 eMx9CBEe+ZHRJItQz1iFPzE0Cxbh682IUUW8id4UYrWSCMSSehZ00Faywom9CHuYhe
	 Fn0fEITwbTbDA==
Message-ID: <sashiko-outbox-180744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] Input: xpad - overhaul device data for wireless
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261021221009.361992-3-sanjay.govind9@gmail.com>
References: <20261015220126.102766-3-sanjay.govind9@gmail.com>
 <20261021221009.361992-3-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:50:55 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Input: xpad - premature registration in xpad_presence_work() on =
reconnect
- [Medium] Input: xpad - stale pad_info state on false-to-true presence and=
 suspend
--

commit 4f28e1c3111d72b61c99d3360763b2634a4795c8
Author: Sanjay Govind <sanjay.govind9@gmail.com>

Input: xpad - overhaul device data for wireless devices

This commit updates Xbox 360 wireless controller handling to defer input
device registration until link and capabilities discovery completes or a
500ms timeout expires, setting controller-specific vendor ID, product ID,
revision, and device name from the discovery reports. It also adds spinlock
protection, generation tracking, RCU pointer teardown on disconnect, and
suspend state reconciliation.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..41348e62fe19f 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -958,19 +995,20 @@ static void xpad360_process_packet(struct usb_xpad =
*xpad, struct input_dev *dev,
> =20
>  static void xpad_presence_work(struct work_struct *work)
>  {
> -	struct usb_xpad *xpad =3D container_of(work, struct usb_xpad, work);
> +	struct usb_xpad *xpad =3D container_of(work, struct usb_xpad, work.work=
);
> +	struct xpad360w_pad_info info;
>  	int error;
> =20
> -	if (xpad->pad_present) {
> -		error =3D xpad_init_input(xpad);
> -		if (error) {
> -			/* complain only, not much else we can do here */
> -			dev_err(&xpad->dev->dev,
> -				"unable to init device: %d\n", error);
> -		} else {
> -			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
> -		}
> -	} else {
> +	/*
> +	 * Take a consistent snapshot, as the reports are processed
> +	 * concurrently from the irq handler.
> +	 */
> +	scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +		info =3D xpad->pad_info;
> +	}
> +
> +	/* Remove the input device if its controller disconnected or changed. */
> +	if (xpad->input_created && (!info.present || xpad->input_gen !=3D info.=
gen)) {
>  		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
>  		synchronize_rcu();
>  		/*
> @@ -979,6 +1017,26 @@ static void xpad_presence_work(struct work_struct *=
work)
>  		 */
>  		xpad_deinit_input(xpad);
>  	}
> +
> +	if (info.present && !xpad->input_created) {
> +		error =3D xpad_init_input(xpad, &info);
> +		if (error) {
> +			/* complain only, not much else we can do here */
> +			dev_err(&xpad->intf->dev,
> +				"unable to init device: %d\n", error);
> +		} else {
> +			scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +				if (xpad->pad_info.present &&
> +				    xpad->pad_info.gen =3D=3D info.gen) {
> +					xpad->input_gen =3D info.gen;
> +					rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
> +					return;
> +				}
> +			}
> +
> +			xpad_deinit_input(xpad);
> +		}
> +	}
>  }
> =20
>  /*
> @@ -995,19 +1053,83 @@ static void xpad_presence_work(struct work_struct =
*work)
>   * 01.1 - Pad state (Bytes 4+) valid
>   *
>   */
> -static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data)
> +static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data, u32 len)
>  {
> +	struct xpad360w_pad_info *info =3D &xpad->pad_info;
>  	struct input_dev *dev;
>  	bool present;
> +	u16 parsed_vid;
> =20
>  	/* Presence change */
>  	if (data[0] & 0x08) {
>  		present =3D (data[1] & 0x80) !=3D 0;
> =20
> -		if (xpad->pad_present !=3D present) {
> -			xpad->pad_present =3D present;
> -			schedule_work(&xpad->work);
> +		guard(spinlock_irqsave)(&xpad->x360w_lock);
> +
> +		if (info->present !=3D present) {
> +			if (!present) {
> +				RCU_INIT_POINTER(xpad->x360w_dev, NULL);
> +				/* Forget everything we learned about the old pad */
> +				*info =3D (struct xpad360w_pad_info) { .gen =3D info->gen };
> +			}
> +			info->present =3D present;
> +			if (present) {
> +				info->gen++;
> +				/*
> +				 * Allow discovery to complete; some pads never
> +				 * send capabilities.
> +				 */
> +				mod_delayed_work(system_percpu_wq,
> +						 &xpad->work, msecs_to_jiffies(500));
> +			} else {
> +				mod_delayed_work(system_percpu_wq, &xpad->work, 0);
> +			}
> +		}
> +	}
> +
> +	/* Link report */
> +	if (len >=3D 26 && data[0] =3D=3D 0x00 && data[1] =3D=3D 0x0F) {
[ ... ]
> +	/* Capabilities report */
> +	if (len >=3D 21 && data[0] =3D=3D 0x00 && data[1] =3D=3D 0x05 && data[5=
] =3D=3D 0x12) {
> +		guard(spinlock_irqsave)(&xpad->x360w_lock);
> +
> +		info->flags |=3D data[20];
> +		/*
> +		 * Some vendors encode identification in the stick capabilities.
> +		 * Only trust it when the VID matches the link report.
> +		 */
> +		if (info->vid &&
> +		    get_unaligned_le16(data + 10) =3D=3D info->vid &&
> +		    get_unaligned_le16(data + 12)) {
> +			info->pid =3D get_unaligned_le16(data + 12);
> +			info->version =3D get_unaligned_le16(data + 14);
> +		}
> +
> +		if (info->present && delayed_work_pending(&xpad->work))
> +			mod_delayed_work(system_percpu_wq, &xpad->work, 0);
>  	}

[Severity: Medium]
Can a disconnect followed quickly by a reconnect cause xpad_presence_work()
to register the new controller prematurely using the fallback receiver
identity before link and capabilities discovery has completed?

Both immediate disconnect teardown (delay 0) and 500ms deferred discovery
registration share the single xpad->work delayed_work item:

1. When a controller disconnects (data[0] & 0x08 with present =3D=3D false),
   xpad360w_process_packet() clears xpad->pad_info, sets
   info->present =3D false, and queues xpad->work with delay 0.

2. Once a worker thread dequeues xpad->work to run xpad_presence_work(),
   a reconnect packet (present =3D=3D true) can arrive before
   xpad_presence_work() acquires xpad->x360w_lock.

3. In xpad360w_process_packet(), the reconnect sets info->present =3D true,
   increments info->gen, and calls:

       mod_delayed_work(system_percpu_wq, &xpad->work,
                        msecs_to_jiffies(500));

   Because the running worker already cleared WORK_STRUCT_PENDING_BIT when
   dequeuing xpad->work, mod_delayed_work() only arms the 500ms timer for a
   subsequent run and does not delay the already-executing
   xpad_presence_work().

4. The executing xpad_presence_work() then snapshots xpad->pad_info while
   info.present is true and info.gen has the new generation, but before the
   link (00 0F) and capabilities (00 05) reports have arrived, so vid, pid,
   sub_type, version, and flags are still zero.

5. After tearing down the old input device in synchronize_rcu() and
   xpad_deinit_input(xpad), xpad->input_created is false. Because
   xpad_presence_work() does not check delayed_work_pending(&xpad->work) or
   re-snapshot xpad->pad_info after teardown, it immediately enters:

       if (info.present && !xpad->input_created) {
               error =3D xpad_init_input(xpad, &info);

   using the unpopulated pre-teardown snapshot.

6. While xpad_deinit_input() and xpad_init_input() run without holding
   xpad->x360w_lock, incoming link and capabilities reports update
   xpad->pad_info in place without changing xpad->pad_info.gen. In addition,
   if a capabilities report (00 05) arrives while info->present is true
   before a link report has populated info->sub_type,
   xpad360w_process_packet() expedites xpad->work to delay 0 without
   checking whether info->sub_type has been set.

7. The post-registration check in xpad_presence_work() only verifies
   xpad->pad_info.present && xpad->pad_info.gen =3D=3D info.gen, which succ=
eeds
   and publishes xpad->x360w_dev with the fallback receiver identity. When
   the 500ms timer later fires, xpad->input_created is already true and
   xpad->input_gen =3D=3D info.gen, so the discovered controller identity is
   never applied. (This also appears to match the transient receiver-name
   fallback observed during battery-removal/reconnect testing.)

[ ... ]
> @@ -2263,8 +2471,20 @@ static int xpad_suspend(struct usb_interface *intf=
, pm_message_t message)
>  		 * Unless explicitly disabled, power them down
>  		 * so they don't just sit there flashing.
>  		 */
> -		if (auto_poweroff && xpad->pad_present)
> +		if (auto_poweroff && xpad->pad_info.present)
>  			xpad360w_poweroff_controller(xpad);
> +
> +		/* Finish teardown if suspend cancelled work for an old pad. */
> +		if (xpad->input_created &&
> +		    (!xpad->pad_info.present ||
> +		     xpad->input_gen !=3D xpad->pad_info.gen)) {
> +			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
> +			synchronize_rcu();
> +			xpad_deinit_input(xpad);
> +		}
> +
> +		/* A cancelled discovery must be restarted by the resume inquiry. */
> +		xpad->pad_info.present =3D xpad->input_created;
>  	} else {
>  		guard(mutex)(&input->mutex);
> =20

[Severity: Medium]
Could xpad->pad_info retain stale state across presence transitions or
suspend/resume cycles?

There appear to be three paths where pad_info and presence state can get out
of sync in drivers/input/joystick/xpad.c:

1. In xpad360w_process_packet(), pad_info is only cleared on a true-to-false
   presence transition:

       if (info->present !=3D present) {
               if (!present) {
                       RCU_INIT_POINTER(xpad->x360w_dev, NULL);
                       /* Forget everything we learned about the old pad */
                       *info =3D (struct xpad360w_pad_info) { .gen =3D info=
->gen };
               }

   However, the link report (00 0F) and capabilities report (00 05) handlers
   populate info->sub_type, info->vid, info->pid, info->version, and
   info->flags without checking info->present. If a late link or capabiliti=
es
   packet arrives after a disconnect packet (08 00) has already set
   info->present =3D false, those fields remain populated across the next
   false-to-true presence transition and would be used if the next
   controller falls back to the 500ms timeout.

2. In xpad_suspend(), if discovery work is cancelled by
   xpad360w_stop_input() before xpad->input_created becomes true (or after
   tearing down an old generation's input device in xpad_suspend()), settin=
g:

       xpad->pad_info.present =3D xpad->input_created;

   sets pad_info.present to false without clearing any vid, pid, sub_type,
   version, or flags already written into pad_info. A subsequent 08 00
   packet after resume sees info->present =3D=3D false and does not clear
   pad_info, and the next 08 80 (false-to-true) transition preserves those
   stale fields.

3. Conversely, when xpad->input_created is true on entry to xpad_suspend(),
   xpad_suspend() stops input, powers off the controller via
   xpad360w_poweroff_controller() when auto_poweroff is set, and leaves
   xpad->pad_info.present =3D true. If xpad_resume() runs without a full re=
set
   (for instance, if a later interface fails during usb_suspend_both()
   rollback) and a different controller is present when
   xpad_inquiry_pad_presence() runs, the resulting 08 80 presence packet wi=
ll
   see info->present =3D=3D true and will not increment info->gen or schedu=
le
   xpad->work to replace the old input_dev.

Would it make sense to clear the discovery fields on the false-to-true
presence transition (and require info->present when processing link and
capabilities reports), and how should xpad_suspend() handle pad_info when an
existing controller is powered off on suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021221009.3619=
92-3-sanjay.govind9@gmail.com?part=3D1
