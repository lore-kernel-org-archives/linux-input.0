Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67552E11C7
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372344; cv=none; b=f7DUtfLKaFPhqZ4Of2+wKeQzVwaR/OK2UCQ03S4Tc16CEt2mrkIlEesCxwYPHTORnt/e3lTwnoXXrLDY3m8MQGuGzLvX635qaVO9r5gtgViPQ/e9b2JVRUtUS9YWRZIzbZGQ/WbbnufryK9otLW4udQvvqlHrCklEinmgpi2jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372344; c=relaxed/simple;
	bh=IaF6aWeRYplncU365rbgkHXMqAU/7U2JiikPawmjre8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BX6pFqo+tbHxNFSpmUvEeMeOfnkQxK4RXjIlipyuuP/csgjk5Nd45wd/tEaMAENctC3lP4+9wdumxNcsTdrrff3kW5L8bIo9dBRFl0D4mzHyZrYDtT4MEWIXzxk4/DVCp6usNGDyGa9SPEjxQ9MxCaBpFpo4s22HhCwS6kJqcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDrrOQW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDrrOQW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3548E1F00A3B;
	Thu, 21 May 2026 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372341;
	bh=urMsBawSkAHBUO5DY9wM6ly8Ftz5eQuuJcTAOsbdoC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KDrrOQW9R8CeX9RVoqg2cA1gyPNhEC13gcge+WPU3i/GmFp1sWgRxCd6Ev5QoC2Q1
	 yHmKaCDkPyj+7Q0TFGM7aZRpKJ3OgxNhQ3NRhhmiZ3GzMTPVxkYnoHt3zu0Yn2cVGa
	 ZDoqa8t4Xg06ptIYciuwQ4EFAgUKOHcgS16Q+BnDxy1QVLhP/uHUjvM/OLa2b6tq3E
	 439Yzl0bYD59euszJCdWvSK/Ylb+OXtDjfwezYu3YWhnp+sU3MQL0Ok9Etn1LKbMuJ
	 nVDQc3guMcMecifvQqftQeM75m8g29uW3lVW2a3qTQ+8FCj4yGhMhyylLXnnl9cOGf
	 EbDup0neZ2NmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: appletb-kbd: add option to switch default layer on
 double pressing fn key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya08@proton.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260521132447.19241-1-gargaditya08@proton.me>
References: <20260521132447.19241-1-gargaditya08@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:05:40 +0000
Message-Id: <20260521140541.3548E1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Zero-initialized timestamp causes single keypresses to be erroneou=
sly treated as double-presses during the first 5 minutes of system uptime.
- [Medium] Dynamic, lockless modification of a read-only global module para=
meter from a per-device event handler.
- [Low] The module parameter `double_press_switch_time` is defined as a sig=
ned integer but used as an unsigned value, allowing negative values to caus=
e abnormally large timeouts.

Pre-existing issues:
- [High] The input event handler calls a function that can sleep, leading t=
o a schedule-while-atomic bug because input handlers execute with spinlocks=
 held and interrupts disabled.
--

commit ff52ac5f6303e0ff3ca2a68218cce8a8beb04bf2
Author: Aditya Garg <gargaditya08@proton.me>

HID: appletb-kbd: add option to switch default layer on double pressing fn =
key

This patch enables a user to switch the default layer from media to fn
keys and vice-versa upon double pressing the fn key within a configurable
time interval.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 462010a758993..4f900338b5871 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c
> @@ -56,6 +56,12 @@ static int appletb_tb_idle_timeout =3D 15;
>  module_param_named(idle_timeout, appletb_tb_idle_timeout, int, 0644);
>  MODULE_PARM_DESC(idle_timeout, "Idle timeout in sec");
> =20
> +static int appletb_tb_double_press_switch_layers;
> +module_param_named(double_press_switch_time,
> +		   appletb_tb_double_press_switch_layers, int, 0644);

[Severity: Low]
If this parameter is set to a negative value by root at runtime, will it
be implicitly cast to a massive unsigned value when passed to
msecs_to_jiffies() below?

This could result in an extremely large timeout (e.g. 49 days) where every
sequential press acts as a double-press. Should this parameter be typed as
a uint or have bounds checking applied?

[ ... ]
> @@ -250,15 +269,42 @@ static void appletb_kbd_inp_event(struct input_hand=
le *handle, unsigned int type
[ ... ]
> +			if (appletb_tb_double_press_switch_layers) {
> +				unsigned long now =3D jiffies;
> +
> +				if (time_before(now, kbd->last_fn_press +
> +					msecs_to_jiffies(appletb_tb_double_press_switch_layers))) {

[Severity: High]
Does this logic correctly handle the first 5 minutes of system uptime?

Because the kernel initializes jiffies to a large negative value (typically
-300 * HZ to detect wraparound bugs), and kbd->last_fn_press is initialized
and reset to 0, won't time_before() evaluate to unconditionally true during
early boot?

This might cause every single keypress to be falsely treated as a
double-press until the system has been running long enough for jiffies to
become positive.

> +
> +					appletb_tb_def_mode =3D
> +						appletb_switch_mode(
> +							appletb_tb_def_mode);

[Severity: Medium]
Is it safe to modify appletb_tb_def_mode here?

This variable is exposed as a module parameter with 0444 (read-only)
permissions. Modifying it programmatically alters the default state for all
current and future connected instances of the device based on a single
device's event.

Should this default mode be managed as a per-device state inside
struct appletb_kbd instead?

> +
> +					appletb_kbd_set_mode(kbd,
> +						appletb_tb_def_mode);

[Severity: High]
This is a pre-existing issue, but does calling appletb_kbd_set_mode() here
cause a scheduling while atomic bug?

This handler executes with dev->event_lock held and interrupts disabled.
However, appletb_kbd_set_mode() calls hid_hw_power(..., PM_HINT_FULLON),
which for USB HID devices invokes usbhid_power() and
usb_autopm_get_interface().

Since those functions lock a mutex and can sleep while waiting on power
management operations, calling them from an atomic context might cause a
kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521132447.1924=
1-1-gargaditya08@proton.me?part=3D1
