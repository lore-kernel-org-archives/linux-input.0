Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973994;
	b=sTBLcckTboz1nqS9BocWcEa2zjIzBFgnHbxAjkSeveMZJfWMn8oCSO6HUjuAKrHqUepw
	 Xykn6j8xXC/+phCgwGFMS6icjbXF8SXgxdX7RdcqkcFk6HCiPYB1aSHy3pVQdOljvtRoq
	 5hXlhKe3jqr998W1OYwsfqMUhVM0aiDK4XnXto9aMqQGIC+flKvIfQMD6Jek2yEVE86lh
	 wJtHD3Ki43Szxpi9Y6HioPbYAxh48P5dnNphZTij6kWPYZwBOe5ZaDUnzM1itThBBGlAJ
	 jB3wpX/djWROzywGysCaq3mz4YvkrS8Ir/q6nl+IZjEUSFgWkn/0tKBE0Susi0kUpRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uMO68eIQtC4rnWnbt8ABAVa0AY7XnE607gTAZdQwyaw=;
	b=4+dtBP+wWSoTD6E4znCAuMUjaZiFFLNjdabb8IoaPzyhYAO+iNNpAG3CO1sWptcRIl/9
	 y65dOVe/xCBW7cbFKTe+Cjez2+ALF+Idqs+y1ejtiDrELCnT8lVMveL6iBj6t3n3a6TIX
	 tTq3cJRPFua0Dt2w1cFwSbqJ0aDEaFULaINk/0k61bJC/gELESRosgQACpdEMkJbp5UrZ
	 C9E6H+I/+JlnN9o5YVLLTSNMqB9UXM4pPzyr+tICQm4joHaip6F5QH6CFOSFn+RYNv3N4
	 9uAZ2Jf1tltKBdlD5jUaPeA8RLdzB5D+DQnqxmHvQobr5Uph3ETK6hXrHS4k8RTIXRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEoHmMjl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6A606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEoHmMjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7641F01825;
	Mon, 26 Oct 2026 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973993;
	bh=uMO68eIQtC4rnWnbt8ABAVa0AY7XnE607gTAZdQwyaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEoHmMjlYYEBoXVSuy73IEWoLcpOTpFeAvPovtUnrM8ZHLu9kw8PqUXc0SIi+GRNh
	 w99abjGZa7kFqSQ1+9kR1PuVX27PGtrtxx6jKBJMfrN6JkusUmve2FT9opAaSq14g3
	 1VdgkCVBCo0fe2+POdxdbqvL6gdGteZP1H2nX2Tk4XpIjoefMHQ1/a5w6UsintCqaU
	 K6Iyav75IXin7KlA5UWYEQEf18kX+nMbiU7fAvy+Iw9XyUoyHnT2evoyERbXYCbNg8
	 8zYlGzVLwWqcpKqq9HeUnx0MBs+TXCq7S5/97RbTK5l5ynqTfnZJExv+VJkyqH9Qz6
	 R+GcOSthllG6Q==
Message-ID: <sashiko-outbox-184559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/18] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-9-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-9-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:19:52 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] HID: asus: TOCTOU race on ally_x_hdev in hid_asus_ally_init() =
causes UAF
- [Medium] HID: asus: FF init race and missing error cleanup in ally_x_setu=
p_input()
- [Medium] HID: asus: race in hid_asus_ally_remove() and ally_x_ff_work_fn(=
) teardown
--

commit aa3d72be03857627e94d5d35f54f6366760f62af
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support to force feedback

This commit adds force-feedback (FF_RUMBLE) support for the ASUS ROG Ally X
gamepad interface using input_ff_create_memless() and a workqueue to send
output reports asynchronously.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e1883ee20413c..a3a21a1493aa8 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -2674,6 +2812,36 @@ static int ally_x_setup_input(struct hid_device *h=
dev, struct ally_handheld *all
>  	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
>  	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
> =20
> +	memcpy(&ally->ff_packet, ALLY_FORCE_FEEDBACK_OFF, sizeof(ally->ff_packe=
t));
> +	/*
> +	 * A play_effect() racing the previous teardown can have left the
> +	 * update latch set: a fresh interface must not inherit it, or the
> +	 * first rumble work would send a packet nobody asked for.
> +	 */
> +	ally->update_ff =3D false;
> +	ally->ff_work_initialized =3D true;
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +
> +	/*
> +	 * A registered device advertising FF_RUMBLE without the memless core
> +	 * behind it would crash input_ff_upload(): fail the whole setup instea=
d.
> +	 */
> +	ret =3D input_ff_create_memless(input, NULL, ally_x_play_effect);
> +	if (ret) {
> +		hid_err(hdev, "Failed to create force-feedback: %d\n", ret);
> +		goto ally_x_setup_input_err;
> +	}
> +
> +	/*
> +	 * Publish the interface before the input device becomes visible to
> +	 * userspace: an effect uploaded right after registration would
> +	 * otherwise find a NULL hdev and get dropped.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	ally->ally_x_hdev =3D hdev;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
>  	ret =3D input_register_device(input);
>  	if (ret) {
>  		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
> @@ -2687,20 +2855,61 @@ static int ally_x_setup_input(struct hid_device *=
hdev, struct ally_handheld *all
> =20
>  	return 0;
>  ally_x_setup_input_err:
> +	/*
> +	 * Unpublish like hid_asus_ally_remove() does, intf_mutex held: the
> +	 * cross-interface senders snapshot ally_x_hdev under ally_data_lock
> +	 * and send under intf_mutex, so the unpublish must take both in the
> +	 * same order to keep the handshake meaningful.
> +	 */
> +	scoped_guard(mutex, &ally->intf_mutex) {
> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		if (ally->ally_x_hdev =3D=3D hdev)
> +			ally->ally_x_hdev =3D NULL;
> +		spin_unlock_irqrestore(&ally_data_lock, flags);
> +	}
> +
>  	input_free_device(input);
>  	return ret;
>  }

[Severity: Medium]
In ally_x_setup_input(), ally->ff_packet, ally->update_ff, and
ally->ff_work_initialized are updated without holding ally->ff_lock. In
addition, if input_ff_create_memless() or input_register_device() fails and
jumps to ally_x_setup_input_err, ally->ff_work_initialized remains set to
true and ally->ff_work is not cancelled, while hid_asus_ally_probe() returns
an error before setting drvdata->rog_ally (leaving hid_asus_ally_remove() as
a no-op).

Also, ally_x_setup_input() publishes ally->ally_x_hdev and calls
input_register_device(input) before hid_asus_ally_probe() sends the initial
ally_x_send_ff_off(hdev) packet (and hid_asus_ally_probe() then assigns
ally_drvdata.ally_x_hdev =3D hdev a second time). If userspace opens the new
input device immediately upon registration and triggers an effect via
ally_x_play_effect() -> ally_x_ff_work_fn(), can the late
ally_x_send_ff_off(hdev) call in hid_asus_ally_probe() overwrite and silence
that active rumble effect?

Should the initial ally_x_send_ff_off(hdev) happen before registering the
input device, with ally->ff_packet, ally->update_ff, and
ally->ff_work_initialized initialized under ally->ff_lock and cleaned up on
the ally_x_setup_input_err path?

> =20
>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handh=
eld *ally)
>  {
> +	struct hid_device *x_hdev;
>  	struct ally_config *cfg;
> +	unsigned long flags;
>  	int ret;
> =20
> -	/* Failure at this point is non-critical */
> -	ret =3D ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
> -				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
> -	if (ret < 0)
> -		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +	/*
> +	 * Snapshot the gamepad interface and send the force-feedback "off"
> +	 * packet through it. usbhid_stop() frees urbout before NULLing it
> +	 * while usbhid_output_report() dereferences it unlocked, so a send
> +	 * overlapping the transport teardown would be a use-after-free: the
> +	 * device lock is taken around the send because the HID core holds
> +	 * it across remove() and the hid_hw_stop() that follows, making the
> +	 * two mutually exclusive. It is taken before intf_mutex, the same
> +	 * order the core's remove path uses, so no lock inversion exists.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	x_hdev =3D ally->ally_x_hdev;
> +	if (x_hdev)
> +		get_device(&x_hdev->dev);
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (x_hdev) {
> +		/* Failure at this point is non-critical */
> +		scoped_guard(mutex, &x_hdev->dev.mutex) {
> +			scoped_guard(mutex, &ally->intf_mutex) {
> +				ret =3D ally_x_send_ff_off(x_hdev);
> +
> +				if (ret < 0)
> +					hid_err(hdev,
> +						"Ally failed to init force-feedback off: %d\n",
> +						ret);
> +			}
> +		}
> +
> +		put_device(&x_hdev->dev);
> +	}

[Severity: Critical]
Can this sequence in hid_asus_ally_init() race with gamepad interface remov=
al
and cause a use-after-free of usbhid (x_hdev->driver_data)?

In hid_asus_ally_init(), x_hdev is snapshotted from ally->ally_x_hdev under
ally_data_lock before acquiring x_hdev->dev.mutex and ally->intf_mutex, and
ally->ally_x_hdev =3D=3D x_hdev is not re-checked after the mutexes are acq=
uired.

If the gamepad interface is concurrently being disconnected or unbound:

CPU 0 (cfg probe or reset_resume)       CPU 1 (gamepad disconnect / unbind)
---------------------------------       -----------------------------------
hid_asus_ally_init()
  spin_lock_irqsave(&ally_data_lock)
  x_hdev =3D ally->ally_x_hdev;
  get_device(&x_hdev->dev);
  spin_unlock_irqrestore(&ally_data_lock)
                                        usbhid_disconnect()
                                          hid_destroy_device(x_hdev)
                                            device_release_driver_internal()
                                              mutex_lock(&x_hdev->dev.mutex)
                                              asus_remove()
                                                hid_asus_ally_remove()
                                                  ally->ally_x_hdev =3D NUL=
L;
                                                hid_hw_stop(x_hdev)
                                                  usbhid_stop(x_hdev)
                                              mutex_unlock(&x_hdev->dev.mut=
ex)
                                          kfree(usbhid);
  mutex_lock(&x_hdev->dev.mutex)
  mutex_lock(&ally->intf_mutex)
  ally_x_send_ff_off(x_hdev)
    hid_hw_output_report(x_hdev, ...)
      usbhid_output_report(x_hdev, ...)
        usbhid =3D x_hdev->driver_data;
        if (!usbhid->urbout)  <-- UAF!

Because get_device(&x_hdev->dev) only pins struct hid_device and not
struct usbhid_device, usbhid_disconnect() frees usbhid as soon as
hid_destroy_device() releases x_hdev->dev.mutex:

drivers/hid/usbhid/hid-core.c:usbhid_disconnect() {
    ...
    hid_destroy_device(hid);
    kfree(usbhid);
}

When hid_asus_ally_init() then acquires x_hdev->dev.mutex and calls
ally_x_send_ff_off(x_hdev), usbhid_output_report() dereferences the freed
x_hdev->driver_data (or, on sysfs driver unbind without USB disconnect,
accesses a stopped transport after hid_hw_stop()).

Should hid_asus_ally_init() re-verify that ally->ally_x_hdev =3D=3D x_hdev =
under
ally_data_lock after acquiring x_hdev->dev.mutex and ally->intf_mutex before
calling ally_x_send_ff_off(x_hdev)?

[ ... ]
> @@ -3038,31 +3259,81 @@ static void hid_asus_ally_remove(struct hid_devic=
e *hdev, struct ally_handheld *
>  	cancel_delayed_work_sync(&ally->resume_work);
> =20
>  	spin_lock_irqsave(&ally_data_lock, flags);
> -	if (ally->ally_x_hdev =3D=3D hdev) {
> -		x_input =3D ally->ally_x_input;
> -		ally->ally_x_input =3D NULL;
> -		ally->ally_x_hdev =3D NULL;
> +	owns_xpad =3D ally->ally_x_hdev =3D=3D hdev;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (owns_xpad) {
> +		/*
> +		 * Stop queueing force-feedback work before the gamepad
> +		 * pointers are cleared: play_effect() tests the flag under the
> +		 * same lock, so no work can be queued past the cancel below.
> +		 */
> +		scoped_guard(spinlock_irqsave, &ally->ff_lock)
> +			ally->ff_work_initialized =3D false;
> +
> +		/*
> +		 * cancel_work_sync() may sleep: keep it out of ally_data_lock,
> +		 * but run it before the pointers are cleared so in-flight work
> +		 * cannot outlive the interface it sends through.
> +		 */
> +		cancel_work_sync(&ally->ff_work);
> +
> +		/*
> +		 * The input core can no longer stop effects through the
> +		 * disabled work: quiesce any rumble still playing ourselves,
> +		 * or the device would keep vibrating after being unbound.
> +		 *
> +		 * Serialize the packet with the other force-feedback senders:
> +		 * intf_mutex is taken again below for the pointer
> +		 * unpublishing, but the two critical sections never nest.
> +		 */
> +		scoped_guard(mutex, &ally->intf_mutex) {
> +			if (ally_x_send_ff_off(hdev) < 0)
> +				hid_warn(hdev,
> +					 "Failed to stop force-feedback\n");
> +		}
>  	}
> =20
>  	/*
> -	 * The keyboard interface is torn down before the config one, and
> -	 * its input_dev is freed with it. handle_ally_event() and
> -	 * ally_resume_work_fn() both report keys through it from the
> -	 * config endpoint, so drop the references here or they dangle.
> +	 * Serialize with hid_asus_ally_init(): it sends the force-feedback
> +	 * "off" packet through the gamepad interface recorded here, whose
> +	 * transport is stopped by hid_hw_stop() as soon as this function
> +	 * returns. Holding intf_mutex while the gamepad pointers are
> +	 * unpublished makes init's snapshot-and-send atomic with the
> +	 * removal: the packet either reaches a transport that is still
> +	 * running, or is not sent at all. The lock must be released before
> +	 * the sysfs teardown below, or an in-flight sysfs store blocked on
> +	 * it would deadlock against kernfs waiting for the callback.
>  	 */
> -	if (ally->keyboard_hdev =3D=3D hdev) {
> -		ally->keyboard_input =3D NULL;
> -		ally->keyboard_hdev =3D NULL;
> -	}
> +	scoped_guard(mutex, &ally->intf_mutex) {
> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		if (owns_xpad) {
> +			x_input =3D ally->ally_x_input;
> +			ally->ally_x_input =3D NULL;
> +			ally->ally_x_hdev =3D NULL;
> +		}

[Severity: Medium]
In hid_asus_ally_remove(), ally->ff_work_initialized is cleared,
ally->ff_work is cancelled, and ally->ally_x_hdev is set to NULL before
input_unregister_device(x_input) is called further down in the function.

Until input_unregister_device(x_input) disconnects evdev (flushing active
effects via input_flush_device() -> input_ff_flush() -> erase_effect() ->
ml_ff_playback()) and stops the ff-memless timer via ml_ff_stop(),
ally_x_play_effect() can still run on x_input. Because clearing
ally->ally_x_hdev releases the HID_ALLY_X_INTF_IN role reservation in
hid_asus_ally_probe(), a concurrent re-probe can enter ally_x_setup_input()
and re-enable ally->ff_work_initialized while x_input's teardown in
input_unregister_device(x_input) is still invoking ally_x_play_effect().

Similarly, in ally_x_ff_work_fn(), hdev =3D ally->ally_x_hdev is snapshotted
under ally_data_lock before acquiring ally->intf_mutex, without re-checking
that ally->ally_x_hdev =3D=3D hdev once ally->intf_mutex is held (which can=
 race
with the ally_x_setup_input_err unpublish path).

Would it be safer to unregister x_input before disabling and cancelling
ally->ff_work and clearing ally->ally_x_hdev, and to re-check
ally->ally_x_hdev =3D=3D hdev under ally->intf_mutex in ally_x_ff_work_fn()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D8
