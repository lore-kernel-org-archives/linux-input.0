Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343403;
	b=y2DVUpdS5bJX082VGXYOxGDwJFARfrVGOL1uOMLUqfH0tYYIFpSykgQt9CWix11vEI21
	 3u4YRhtxYErQHjr3UmbyJz4PHDwHJW6kA2CbWRkMSW+xjkJwDp1wjy1FlzbOBJTZw8Bcd
	 OQ+xu4Gu7kybWIp/gtn2k2EpTDmzkld+nyQRHR2ux5dBppd4gW9lMn9fW8/AU0eaJxSGw
	 QEED5FFSGPdFebfIa8o37iroep6UrigQVG+KHXR8IEAnBvpDNbCTtacZqn2Z+x+chtFl6
	 x0k3kP1j5RGRbZDueEaMxMKjI+AObT93ILsFK3kog5PjdoeFc7xG1xtlD6EBTpJJ7Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+GXkmliMb0pbkgqK+cpyywyXPEZol+AlIICdHVm6q2c=;
	b=rApJ/GyHPuYhVbs+QX9ucpKh6VxggDn05VmOFES6u8XBFlLz1IgFYskCExTTCTgRJ+AO
	 1VrrtpD+bDHNSsAE18dTnn/NXJKSdYAWIZb/S0biIZlMPopGX5XeoECBiYS9mqZARPCzt
	 VrsZeb3XClsrajvxjdAiqmZwhBeD9mYqfcqEohVFCO9869aEn5Uy3lZNncCXVRP6YCQgi
	 xxXJQQpRtEqyeSH1axPwq64ozHzXNv+gmF9Cik8DYZ3sFGqgCuxFGA730bQMfmUbNKhV6
	 HBw50u4mxjw0LTuwM1HbkHXQMI56Y2mUg5RkNEGDUQXaCUtiI4W/1NM2DHpw+8G2CgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kH/iExS2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F9606A31E
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kH/iExS2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E61F000C1;
	Fri, 30 Oct 2026 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793343402;
	bh=+GXkmliMb0pbkgqK+cpyywyXPEZol+AlIICdHVm6q2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kH/iExS2d/PNdb6HDbokMmhuPpX01u0jPduFS1ycaBsU194e1YsSPAlY6Rp+8bXU0
	 +Knx3qGtEutuCTMMUGkkg3pORVmejYUFloqvXM1M84MG+8n/BiRa9qHN11oV7OGlmK
	 j7RFMA190/6Qv7UUOKwMYxjI3lhHu9Bplu9t+5pADpPKEgxCNBHLa7cSu+McZ+qOW8
	 PNzmMTIyldFFw5ylbFESZtEofE8ScAc2MT4072nYFkldNDmeh42zwEEZXXK9ZfkFQi
	 3WyhgXVJ9nJ2aUv7RIhCe3DddUb82XagvuR4VKMNpQBhyV41f224uvxGe80a8P0Hiz
	 L3wicC602bVQw==
Message-ID: <sashiko-outbox-190621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: steelseries: Add Rival 3 Wireless battery
 reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin Oberleiter" <martin.oberleiter@netixx.it>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030-rival3-battery-v1-2-6b1feeaf1f52@netixx.it>
References: <20261030-rival3-battery-v1-0-6b1feeaf1f52@netixx.it>
 <20261030-rival3-battery-v1-2-6b1feeaf1f52@netixx.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:56:42 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] HID: steelseries: missing suspend and runtime PM handling for batt=
ery_work
- [High] HID: steelseries: UAF on probe failure after steelseries_resume() =
arms work
- [High] HID: steelseries: race between steelseries_remove() and steelserie=
s_resume()
- [Medium] HID: steelseries: deprecated system_wq mismatch in steelseries_r=
esume()
--

commit bd1d30fd1ed7cb8e4a6c8b3c38fe5d24efafb14d
Author: Martin Oberleiter <martin.oberleiter@netixx.it>

HID: steelseries: Add Rival 3 Wireless battery reporting

This commit adds power_supply battery reporting for the SteelSeries Rival 3
Wireless mouse in 2.4 GHz receiver mode by polling vendor interface 3 via a
delayed work item and parsing the asynchronous input report replies.

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index 7292da0313e11..9fa70d21f49de 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
[ ... ]
> +static void steelseries_rival3_battery_work(struct work_struct *work)
> +{
> +	struct steelseries_device *sd =3D container_of(work,
> +			struct steelseries_device, battery_work.work);
> +	static const u8 request[] =3D { 0x00, 0xaa, 0x01 }; /* report ID 0 */
> +	bool was_online, was_charging, online, changed;
> +	unsigned long flags, timeout;
> +	u8 old_capacity;
> +	u8 *buf;
> +	int ret;
> +
> +	spin_lock_irqsave(&sd->battery_lock, flags);
> +	was_online =3D sd->battery_online;
> +	was_charging =3D sd->battery_charging;
> +	old_capacity =3D sd->battery_capacity;
> +	spin_unlock_irqrestore(&sd->battery_lock, flags);
> +
> +	buf =3D kmemdup(request, sizeof(request), GFP_KERNEL);
> +	if (!buf) {
> +		ret =3D -ENOMEM;
> +		goto update;
> +	}
> +
> +	spin_lock_irqsave(&sd->battery_lock, flags);
> +	reinit_completion(&sd->battery_reply);
> +	sd->battery_awaiting_reply =3D true;
> +	spin_unlock_irqrestore(&sd->battery_lock, flags);
> +
> +	ret =3D hid_hw_raw_request(sd->hdev, 0x00, buf, sizeof(request),
> +				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> +	kfree(buf);
> +	if (ret >=3D 0) {
> +		timeout =3D msecs_to_jiffies(STEELSERIES_RIVAL3_WIRELESS_REPLY_TIMEOUT=
_MS);
> +		ret =3D wait_for_completion_timeout(&sd->battery_reply, timeout) ? 0 :=
 -ETIMEDOUT;
> +	}
> +
> +update:
> +	spin_lock_irqsave(&sd->battery_lock, flags);
> +	/* A reply may still have arrived right after the timeout. */
> +	if (ret && sd->battery_awaiting_reply) {
> +		/* Keep the last level; the mouse is off or asleep. */
> +		sd->battery_awaiting_reply =3D false;
> +		sd->battery_online =3D false;
> +	} else {
> +		ret =3D 0;
> +	}
> +	online =3D sd->battery_online;
> +	changed =3D online !=3D was_online ||
> +		  sd->battery_charging !=3D was_charging ||
> +		  sd->battery_capacity !=3D old_capacity;
> +	spin_unlock_irqrestore(&sd->battery_lock, flags);
> +
> +	if (ret)
> +		hid_dbg(sd->hdev, "No battery reply: %d\n", ret);
> +	if (changed)
> +		power_supply_changed(sd->battery);

[Severity: High]
What happens when steelseries_rival3_battery_work() in
drivers/hid/hid-steelseries.c runs during system suspend, suspend-to-idle
(s2idle), or USB runtime autosuspend?

Because steelseries_driver registers .resume and .reset_resume callbacks
without a matching .suspend callback and queues sd->battery_work on a
non-freezable workqueue, steelseries_rival3_battery_work() can fire after
usbhid's hid_suspend() has stopped I/O and usb_suspend() has cleared
udev->can_submit (or while the system is in s2idle).

When hid_hw_raw_request() fails with -EHOSTUNREACH (or
wait_for_completion_timeout() times out with -ETIMEDOUT),
steelseries_rival3_battery_work() sets sd->battery_online =3D false. If the
mouse was previously online (was_online =3D=3D true), changed becomes true =
and
power_supply_changed(sd->battery) is called:

    steelseries_rival3_battery_work()
      power_supply_changed(sd->battery)
        pm_stay_awake(&psy->dev)

Because battery_cfg.no_wakeup_source is left false in
steelseries_rival3_battery_register(), __power_supply_register() initializes
sd->battery->dev as a wakeup source, so pm_stay_awake() will abort system
suspend or wake the system from s2idle while also dropping the poll interval
to 1 minute.

In addition, usbhid enables USB runtime autosuspend and usbhid_open() drops
its usb_autopm reference before returning. Unlike
steelseries_msi_rgb_set_blocking() in the same file,
steelseries_rival3_battery_work() does not wrap the transfer and reply wait
with hid_hw_power(sd->hdev, PM_HINT_FULLON) and hid_hw_power(sd->hdev,
PM_HINT_NORMAL). Consequently, polls while the receiver is runtime-suspended
fail without waking the interface, and every runtime autoresume invokes
hid_resume() -> steelseries_resume(), resetting the 10-minute poll timer to
1 second.

Should steelseries_driver provide a .suspend callback that cancels
sd->battery_work, and should steelseries_rival3_battery_work() hold
hid_hw_power(sd->hdev, PM_HINT_FULLON) across the request and completion
wait?

> +
> +	schedule_delayed_work(&sd->battery_work, msecs_to_jiffies(online ?
> +			STEELSERIES_RIVAL3_WIRELESS_POLL_ONLINE_MS :
> +			STEELSERIES_RIVAL3_WIRELESS_POLL_OFFLINE_MS));
> +}
> +
> +static int steelseries_rival3_battery_register(struct steelseries_device=
 *sd)
> +{
[ ... ]
> +	power_supply_powers(battery, &hdev->dev);
> +	sd->battery =3D battery;
> +	sd->battery_iface =3D true;
> +
> +	return 0;
> +}
[ ... ]
> @@ -593,17 +811,38 @@ static int steelseries_probe(struct hid_device *hde=
v, const struct hid_device_id
>  		}
>  	}
> =20
> +	if (sd->quirks & STEELSERIES_RIVAL3_WIRELESS &&
> +	    !steelseries_rival3_is_battery_iface(hdev))
> +		sd->quirks &=3D ~STEELSERIES_RIVAL3_WIRELESS;
> +
>  	ret =3D hid_parse(hdev);
>  	if (ret)
>  		return ret;
> =20
> +	if (sd->quirks & STEELSERIES_RIVAL3_WIRELESS) {
> +		ret =3D steelseries_rival3_battery_register(sd);
> +		if (ret) {
> +			hid_warn(hdev,
> +				 "Failed to register battery: %d, continuing without battery reporti=
ng\n",
> +				 ret);
> +			sd->quirks &=3D ~STEELSERIES_RIVAL3_WIRELESS;
> +		}
> +	}
> +
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D hid_hw_open(hdev);
> -	if (ret)
> -		goto err_stop;
> +	/* Only the Rival 3 Wireless battery interface needs to stay open. */
> +	if (hdev->product !=3D USB_DEVICE_ID_STEELSERIES_RIVAL_3_WIRELESS ||
> +	    sd->battery_iface) {
> +		ret =3D hid_hw_open(hdev);
> +		if (ret)
> +			goto err_stop;
> +	}

[Severity: High]
Can a failed probe in steelseries_probe() in drivers/hid/hid-steelseries.c
leave sd->battery_work armed after devres frees sd?

In __hid_device_probe(), hdev->driver is set to &steelseries_driver before
steelseries_probe() runs. In steelseries_probe(),
steelseries_rival3_battery_register() sets sd->battery_iface =3D true before
hid_hw_start() and hid_hw_open() are called.

If the parent usb_interface is runtime-suspended when hid_hw_open() is
called, usbhid_open() calls usb_autopm_get_interface(usbhid->intf), which
synchronously runs:

    usbhid_open()
      usb_autopm_get_interface()
        hid_resume()
          hid_driver_resume()
            steelseries_resume()
              mod_delayed_work(system_wq, &sd->battery_work, ...)

Because sd->battery_iface is already true, steelseries_resume() arms
sd->battery_work. If hid_hw_open() then fails (for example, when
hid_start_in() fails and usbhid_open() returns -EBUSY), steelseries_probe()
jumps to err_stop and returns without cancelling sd->battery_work, after
which __hid_device_probe() frees sd via devres_release_group() while the
delayed work timer is still pending.

Would it be safer to register the battery and set sd->battery_iface =3D true
only after hid_hw_start() and hid_hw_open() have succeeded (or cancel
sd->battery_work in the error path)?

[ ... ]
> @@ -632,10 +873,32 @@ static void steelseries_remove(struct hid_device *h=
dev)
>  		return;
>  	}
> =20
> -	hid_hw_close(hdev);
> +	sd =3D hid_get_drvdata(hdev);
> +	if (sd->battery_iface)
> +		cancel_delayed_work_sync(&sd->battery_work);
> +
> +	if (hdev->product !=3D USB_DEVICE_ID_STEELSERIES_RIVAL_3_WIRELESS ||
> +	    sd->battery_iface)
> +		hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
Could steelseries_resume() race with steelseries_remove() in
drivers/hid/hid-steelseries.c and re-queue sd->battery_work during driver
unbind?

In hid_device_remove(), hdrv->remove(hdev) is called first, followed by
devres_release_group(&hdev->dev, hdev->devres_group_id), and hdev->driver is
only set to NULL afterwards. Meanwhile, usbhid's hid_resume() and
hid_reset_resume() invoke steelseries_resume() on the parent usb_interface
without holding device_lock(&hdev->dev) or hdev->driver_input_lock.

Because steelseries_remove() calls cancel_delayed_work_sync() rather than
disable_delayed_work_sync() and leaves sd->battery_iface true while
hid_hw_close(), hid_hw_stop(), and devres_release_group() execute, a
concurrent runtime resume or reset_resume on the USB interface can see
sd && sd->battery_iface and call mod_delayed_work() after
cancel_delayed_work_sync() has already returned, re-arming sd->battery_work
on memory that devres_release_group() is freeing.

Should steelseries_remove() use disable_delayed_work_sync(&sd->battery_work)
to prevent sd->battery_work from being re-queued once teardown begins?

> =20
> +static int steelseries_resume(struct hid_device *hdev)
> +{
> +	struct steelseries_device *sd;
> +
> +	if (hdev->product !=3D USB_DEVICE_ID_STEELSERIES_RIVAL_3_WIRELESS)
> +		return 0;
> +
> +	/* Polls during suspend fail, so do not wait for the next one. */
> +	sd =3D hid_get_drvdata(hdev);
> +	if (sd && sd->battery_iface)
> +		mod_delayed_work(system_wq, &sd->battery_work,
> +				 msecs_to_jiffies(1000));

[Severity: Medium]
In steelseries_resume() in drivers/hid/hid-steelseries.c, mod_delayed_work()
queues sd->battery_work onto system_wq, whereas steelseries_probe() and
steelseries_rival3_battery_work() use schedule_delayed_work(), which queues
onto system_percpu_wq.

In kernel/workqueue.c, system_wq and system_percpu_wq are separate
workqueue_struct instances, and system_wq is marked with __WQ_DEPRECATED,
causing __queue_work() to emit a runtime deprecation warning when the timer
expires:

    workqueue: work func steelseries_rival3_battery_work enqueued on deprec=
ated workqueue. Use system_{percpu|dfl}_wq instead.

Mixing two different workqueue_struct instances for the same delayed_work
also bypasses __queue_work()'s single-workqueue non-reentrancy check
(worker->current_pwq->wq =3D=3D wq), allowing steelseries_rival3_battery_wo=
rk()
to execute concurrently on two CPUs and race on
reinit_completion(&sd->battery_reply) and sd->battery_awaiting_reply.

Should steelseries_resume() pass system_percpu_wq to mod_delayed_work() so
all scheduling of sd->battery_work uses the same non-deprecated workqueue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-rival3-bat=
tery-v1-0-6b1feeaf1f52@netixx.it?part=3D2
