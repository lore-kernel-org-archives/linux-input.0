Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794115750;
	b=WO+HFoqWbXbjesl1NOVQRvB6rKK7DdKV6V6jKk0sV3inp0Rz5Ct8QR2iA4bCHHtcSoQ/
	 kZLNf808Tl50v/TX5A9AS2Y1Q+zWNP/83owIjnVX79VT83J3R6pNBqOcbhvwPFN/3sblm
	 OKjGiK3lc5Zt4OAHAvgILqmA+WJoDtj/5yTQLPxrohZ6Z5wOxoULciZTf0/YnAFJDOV2O
	 Q7WNzaSP2o+vNqmj9bd0E7tDiUaULrNZfMenzHLIUrPY9S1J6Omh1H3Yt57m1SykLv1cY
	 9kISogw2gzYSYfSDo8V0fzRJxe94PXcMDNwSGNMcWBtq9nshHakyPt/A80BX4ebTtLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794115750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kp0sT8SmUsOFXTuK4zLCt64zPhaSL5YK0cGDEjRVp08=;
	b=lnz+N539kiE2xScHAmI0oMcH0RBk5MTpCDmW6JdxLvMX6mtgClAeuKM9rry9zF7C+wx9
	 7cVV64iTYNXOG9lamDIZu/cMG/aOKi+HV6dQ6OpjVt9USY4xiZPP507Q42YwUMeEWo1rc
	 zXsi9UIfdDa+TV8/du4a4OXz5yjHRbV27oL9JuMislXoCmN/9iNRo0lSrixbm0E3gytCj
	 LIE6ngfTslkSBpp548+oQ9JPNKx62Iv5mzNFEv1vGyjpB9yAxyxUjuj2eN2K67ud/R+25
	 5IfKxZnBsNESGrSl90/EknmqUmcI7z81lyxDrdYb8z4bK6EccDD83DtgdKH6NIySYug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNMj8hSx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E7606A31A
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNMj8hSx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C31F0089F;
	Sun,  8 Nov 2026 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794115750;
	bh=kp0sT8SmUsOFXTuK4zLCt64zPhaSL5YK0cGDEjRVp08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNMj8hSx/vwvvVnFEESNM332dHuJckKOLlOAgcxm2RPL6XnC5vu1H+0//ooBpJHnu
	 Zjz76UIVYV6UVzWUX2wCD7xhll6PxTnqPDv0x1qsz06muj3uLjuD/eYyOiaZM2fs7n
	 s5/k0Y00HDieMCuQxsZP9jTUDxWUy4GKZZG/H9Q8MKh0vZltFlSRS26BAV/NxGo/m/
	 XeJ1dPXS43HkEGm4ZBgSKxXxN7QPM8JneEHMmMkFiUrmEc6K+K7t+mbaCkritGA5Co
	 EB7UdrSb5ixU7+SFIArCU/y4lIAjpSOqZvEEpLokTY+J8Ati8+dEcbhIgrfVEIy3wP
	 LACXERO0Q2L9g==
Message-ID: <sashiko-outbox-203579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12] Input: xpad - overhaul device data for wireless
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108050056.424305-2-sanjay.govind9@gmail.com>
References: <20261108050056.424305-2-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 05:29:09 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] Input: xpad - missing xpad_stop_output() on xpad_probe()
  error path
- [Medium] Input: xpad - uncancelled discovery work on xpad_resume()
  error path
- [Medium] Input: xpad - use-after-free race on xpad_led in
  xpad_resume()
--

commit 8fc5697265d2347744860ac1eec114fe9c075964
Author: Sanjay Govind <sanjay.govind9@gmail.com>

Input: xpad - overhaul device data for wireless devices

This commit updates wireless Xbox 360 controller handling to populate input
device identification from link and capabilities reports, deferring input
device registration until discovery completes or times out and protecting
discovery state across connect, disconnect, and suspend/resume transitions.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 810e52782ae89..a273d820910e0 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2204,8 +2496,18 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
>  		 * we're waiting for.
>  		 */
>  		error =3D xpad360w_start_input(xpad);
> -		if (error)
> +		if (error) {
> +			/*
> +			 * Reports received before the inquiry failed may have
> +			 * queued discovery work, or even registered an input
> +			 * device. The irq is already stopped, so nothing can
> +			 * queue more work or use x360w_dev.
> +			 */
> +			cancel_delayed_work_sync(&xpad->work);
> +			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
> +			xpad_deinit_input(xpad);
>  			goto err_deinit_output;
> +		}

[Severity: Medium]
Can jumping to err_deinit_output without calling xpad_stop_output(xpad)
cause a use-after-free on xpad->irq_out, xpad->odata, and xpad?

Before xpad360w_start_input() kills xpad->irq_in on failure, an early link
report can submit xpad->irq_out via xpad_inquiry_pad_capabilities(), and
xpad_deinit_input() -> xpad_led_disconnect() -> led_classdev_unregister()
also submits xpad->irq_out to turn off the LED if an input device was
registered.  Because err_deinit_output calls xpad_deinit_output() and
kfree(xpad) without waiting for anchored output URBs to complete via
xpad_stop_output() (unlike xpad_disconnect()), xpad_irq_out() can
dereference the freed structures when the URB completes.

[ ... ]

> @@ -2262,6 +2565,7 @@ static int xpad_suspend(struct usb_interface *intf,=
 pm_message_t message)
>  {
>  	struct usb_xpad *xpad =3D usb_get_intfdata(intf);
>  	struct input_dev *input =3D xpad->dev;
> +	struct xpad360w_pad_info info;
> =20
>  	if (xpad->xtype =3D=3D XTYPE_XBOX360W) {
>  		/*
> @@ -2271,14 +2575,37 @@ static int xpad_suspend(struct usb_interface *int=
f, pm_message_t message)
>  		 */
>  		xpad360w_stop_input(xpad);
> =20
> +		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +			info =3D xpad->pad_info;
> +		}
> +
>  		/*
>  		 * The wireless adapter is going off now, so the
>  		 * gamepads are going to become disconnected.
>  		 * Unless explicitly disabled, power them down
>  		 * so they don't just sit there flashing.
>  		 */
> -		if (auto_poweroff && xpad->pad_present)
> +		if (auto_poweroff && info.present)
>  			xpad360w_poweroff_controller(xpad);
> +
> +		/* Finish teardown if suspend cancelled work for an old pad. */
> +		if (xpad->input_created &&
> +		    (!info.present || xpad->input_gen !=3D info.gen)) {
> +			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
> +			synchronize_rcu();
> +			xpad_deinit_input(xpad);
> +		}
> +
> +		/*
> +		 * The controller may have changed while input was stopped.
> +		 * Force resume to rediscover it instead of reusing stale data.
> +		 */
> +		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
> +			xpad->pad_info =3D (struct xpad360w_pad_info) {
> +				.gen =3D xpad->pad_info.gen,
> +			};
> +		}
>  	} else {
>  		guard(mutex)(&input->mutex);
> =20
> @@ -2297,8 +2624,15 @@ static int xpad_resume(struct usb_interface *intf)
>  	struct input_dev *input =3D xpad->dev;
> =20
>  	xpad->delayed_init_done =3D false;
> -	if (xpad->xtype =3D=3D XTYPE_XBOX360W)
> +	if (xpad->xtype =3D=3D XTYPE_XBOX360W) {
> +		/*
> +		 * Tear down the old input device even if the resume inquiry
> +		 * reports that no controller is currently present.
> +		 */
> +		mod_delayed_work(system_percpu_wq, &xpad->work, 0);

[Severity: Medium]
Can deferring xpad_deinit_input() to xpad->work during resume race with
dpm_resume() and cause a use-after-free on xpad->led?

When a wireless controller was present at suspend, xpad_suspend() leaves
xpad->input_created set (and xpad->led->led_cdev.dev on dpm_suspended_list)
while clearing xpad->pad_info.present.  During system resume, xpad_resume()
queues xpad->work to run xpad_deinit_input() asynchronously while
dpm_resume() moves on to resume the child LED device:

CPU0 (dpm_resume)                 CPU1 (system_percpu_wq)
device_resume(&udev->dev)
  ...
    xpad_resume()
      mod_delayed_work(..., &xpad->work, 0)
device_resume(led_cdev->dev)
  dpm_wait_for_superior()
                                  xpad_presence_work()
                                    xpad_deinit_input(xpad)
                                      xpad_led_disconnect(xpad)
                                        led_classdev_unregister()
                                        kfree(xpad_led)
  led_resume()
    led_classdev_resume(led_cdev)  <-- use-after-free

Since xpad_suspend() unconditionally clears pad_info to force rediscovery,
calling xpad_deinit_input() synchronously in xpad_suspend() whenever
xpad->input_created is true would avoid tearing down child devices
asynchronously during dpm_resume().

> +
>  		return xpad360w_start_input(xpad);
> +	}

[Severity: Medium]
If xpad360w_start_input(xpad) fails here after xpad->irq_in was briefly
submitted, can xpad->work remain scheduled and register an input device
while input is stopped?

Inside xpad360w_start_input(), usb_submit_urb(xpad->irq_in, GFP_KERNEL)
runs before xpad_inquiry_pad_presence().  If a presence or link report
arrives before xpad_inquiry_pad_presence() fails and kills xpad->irq_in,
xpad360w_process_packet() sets pad_info.present and arms xpad->work for
discovery.  Unlike the error path in xpad_probe(), xpad_resume() returns
the error without cancelling xpad->work, clearing pad_info, or calling
xpad_deinit_input().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108050056.4243=
05-2-sanjay.govind9@gmail.com?part=3D1
