Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794648273;
	b=Vrth8aZaBUoFFdgV5kWpEBiIctXCyEOB4xHaPaI/1msNHKKrGbEvE4Fqs4MY5kQ5AK5S
	 Nszfgc0wS7cwObwSDtsZQ7OcB0KxMLEGOhWffPYhKme6y9Rv3ynb83CpI9B3YhmHjriFm
	 Qe2N3n3pGPP2Yff1B4ENVxZ+TyD5T3GiKI7s/4BvEH3WtS9ptbell+jBd9gWoFCKa/GAL
	 eGliX0a6q1ocnAt2SuuqePbtGpL0eaOeD0kR2H4TjBwhwfJXCM4TWlCLcix+4gxDTsHTX
	 XMm3+YAhwaAqukbxkHADab9DzMNLNkuXsN5Guyebb9wr8SjJ9dpg6zC8OJdwiQ8ERfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nl40UHFefGLC8C6rlrXftGmGJVwA7X6uN0x7go3Df0A=;
	b=p1nJxYTbZhxcEeLxIzZtdE3ZPF4Pt7fmbAwNiXBxTEjoCpd4aLtRSh+S0tMRTt+oBFXr
	 dxOyE0qJJIaGoAGWhzwWI2M6WZeQxNT8t6yh3eJUCCnv271VHgTfdjuWSXf4j1RA4Ucfq
	 VYEElkjjCbFMtBt7mTrn68NZGNOK5dQNKgbAKvbyWPYUUii7u06+n3CsujGylIrUCAb6C
	 fEjJ5RALQ0nO5i792URsNg2aISxaZpUWvQpx2oLQWRLLrul7jJ7YCs12NSZ6aGXzYEHib
	 ngH0iKq7autD9nRlpNk+9KSRA6yKvXyAMSlJg6L4M5KM4RCPtg3tYSfJPNtPVMuO+Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/+QerMA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AD606A32D
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/+QerMA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DD21F000C4;
	Sat, 14 Nov 2026 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794648273;
	bh=nl40UHFefGLC8C6rlrXftGmGJVwA7X6uN0x7go3Df0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/+QerMAWjy++vXYdf0LPaLaR6j8KJEk4JV0/+ViDJiTEen1vOt/PlX1C/EBqiX7A
	 U8lbe+BBKSVF7wzH7GoxXuwxqFi8BhAr2/gIAbVHsjQu+6lyLjhBhiV1H1170iNebT
	 KqElJQcztdZmvt2guf46ECdPTbBMpSm/uwFmgpYmHdPMI2uo6hfzwTfwT+oVcwrIYc
	 i2HdWKGtDdPNvlWXzK6bS0QCBq66b5b0+GTuaUFItlyduzLaqDAT9k7AY5M7Ny9wA4
	 r72VTa21MVF+/GVPKfvRhfEvNVey60Y/nyLK7V5N/9+y2s8BYb+w/UaBD9YDyTMPUA
	 BlOlaYWBKbvSA==
Message-ID: <sashiko-outbox-214329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Input: synaptics - support the touchpad LED on RMI
 function $30
Reply-To: sashiko-reviews@lists.linux.dev
To: "ahmad baghereslami" <ahmad.b1995@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114090808.2572722-1-ahmad.b1995@gmail.com>
References: <20261106095658.44166-1-ahmad.b1995@gmail.com>
 <20261114090808.2572722-1-ahmad.b1995@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 09:24:32 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] Input: synaptics - LED left on in
  synaptics_rmi_led_unregister()
--

commit 8aa89954a3d89d6d5994f705dc23ae6d58848db8
Author: ahmad baghereslami <ahmad.b1995@gmail.com>

Input: synaptics - support the touchpad LED on RMI function $30

This commit adds support for the touchpad-disabled LED on Synaptics
touchpads that expose RMI function $30 over PS/2, registering an LED class
device and updating the hardware registers via a delayed work item under
psmouse_mutex.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index b007e642ea765..ce51fd8a25d16 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -589,6 +589,294 @@ static int synaptics_set_advanced_gesture_mode(stru=
ct psmouse *psmouse)

[ ... ]

> +static void synaptics_rmi_led_set(struct led_classdev *led,
> +				  enum led_brightness value)
> +{
> +	struct synaptics_data *priv =3D container_of(led, struct synaptics_data=
, rmi_led);
> +
> +	WRITE_ONCE(priv->rmi_led_on, value !=3D LED_OFF);
> +	mod_delayed_work(system_percpu_wq, &priv->rmi_led_work, 0);
> +}

[ ... ]

> +static void synaptics_rmi_led_unregister(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +
> +	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) || !priv->has_rmi_led)
> +		return;
> +
> +	led_classdev_unregister(&priv->rmi_led);
> +	cancel_delayed_work_sync(&priv->rmi_led_work);
> +
> +	/*
> +	 * The touchpad is in command mode here. Mode byte 0, which
> +	 * synaptics_reset() sets next, leaves RMI access but keeps the LED lit.
> +	 */
> +	if (priv->rmi_led_on)
> +		__synaptics_rmi_led_set(psmouse, false);
> +}

[Severity: Medium]
Can synaptics_rmi_led_unregister() leave the physical touchpad LED lit on
disconnect?

synaptics_rmi_led_set() clears priv->rmi_led_on before
synaptics_rmi_led_work() takes psmouse_mutex and updates the hardware
register.  Because synaptics_disconnect() runs with psmouse_mutex held,
any LED_OFF request queued while the LED is lit cannot run its work item.
For example, if a trigger is attached to the LED,
led_classdev_unregister() detaches it before checking
LED_RETAIN_AT_SHUTDOWN:

drivers/leds/led-class.c:led_classdev_unregister() {
    ...
#ifdef CONFIG_LEDS_TRIGGERS
	down_write(&led_cdev->trigger_lock);
	if (led_cdev->trigger)
		led_trigger_set(led_cdev, NULL);
	up_write(&led_cdev->trigger_lock);
#endif
    ...
}

led_trigger_set(led_cdev, NULL) calls led_set_brightness(led_cdev,
LED_OFF), which invokes synaptics_rmi_led_set() and sets priv->rmi_led_on
to false.  cancel_delayed_work_sync() then cancels the pending work before
it can write to the touchpad, and the check on priv->rmi_led_on is false,
so __synaptics_rmi_led_set(psmouse, false) is skipped and the hardware LED
stays on.

Calling __synaptics_rmi_led_set(psmouse, false) unconditionally in
synaptics_rmi_led_unregister() (as synaptics_rmi_led_init() does), or
tracking the committed hardware state separately from the requested state,
would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114090808.2572=
722-1-ahmad.b1995@gmail.com?part=3D1
