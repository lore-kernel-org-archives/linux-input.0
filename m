Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA9367293
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619871; cv=none; b=X/VUowMDk0L/IhFW2DzYEhimYWiFJa+GsYWx53rdKIakfgZ/hxY2+N9idENJ00R7f1hyNh7Pgnfty/BT33Qf/nOI6zXXJX2WndySrxZ7jN8NgLs44b9HHpLf2R23DTD1jQ1FiZJC/ehjM7gsZAqm2UbMfvx8BY+feIi/9gJd6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619871; c=relaxed/simple;
	bh=3Vk7mKzSKmEp/zQZxZAZI39YyaSFDrnGSoBqwrGDM3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NHfuDyt9TurrG4eHqMIK3FU+IE4HfVAcjqRr8M9zLhOOwvfAkqJ4y+WibQ+RPkemoT2/zF2WIBXVVfKS2XfRwqCFZZl6m1QHxuy3FYCad5lt0G4WyiwMp72yxp/LIwAa16zP6YYMjpi3OkGMbS2ZdO0qNjgTfWtjAjyx4WnxpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq7bhwCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq7bhwCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86BB1F00A3A;
	Sat,  5 Sep 2026 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788619870;
	bh=5Ts4UJXPPsj3BkdBNRiXh+htF4Noa01M2JyZDDhCq6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gq7bhwCG5H+5ZzkVJt2xgeyocxEud8XnftDUYSQoVLRKa6yAjQpQ8KxT+L69FNkrK
	 dSj5baP3ud/dtB/oSraKCVJG3SFlZxcO/os14p0J7PYycZpssvDanVzZFTRHhOpV7l
	 2Gylf4GQNtm9zloYaC7cf9u7Vmj6e13cLP+78xOh0Tl6BasXk2lAw/twYtP+mVJ9sU
	 cF5z1HfY0XDwAapPN1IltxqenFsONfYruCttypTgqouYCqj3Nfs4usaDWlS5KBCIpw
	 fHP9DwNllhQ1ouZJMGjhSwz9yi2bOPFS/TGc9aI4ueh4lbjQbKb8erUQ6yavXMmWQv
	 LlHXfAyJl0lkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: appletb-kbd: support layer switching on Fn
 double press
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <aditya.garg@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260905143733.17819-1-aditya.garg@linux.dev>
References: <20260905143733.17819-1-aditya.garg@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 14:51:09 +0000
Message-Id: <20260905145109.C86BB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Logic Error / Jiffies Wrap. Zero-initialized timer incorrectly t=
riggers layer switch on every key press during early boot.
- [Low] Dead Code. The switch block contains unreachable break statements.

Pre-existing issues:
- [High] Sleeping in Atomic Context. The input event handler calls a sleepa=
ble HID power management function, causing a kernel panic.
--

commit 2e557c5f2297282525c11706211299ba134eef07
Author: Aditya Garg <aditya.garg@linux.dev>

HID: appletb-kbd: support layer switching on Fn double press

This commit adds an optional module parameter to allow a double press of th=
e Fn
key to persistently switch the Touch Bar's default layer, avoiding the need
to change the mode through sysfs.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 5cc27066f6026..f10d093c2b3e3 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c
[ ... ]
> @@ -243,6 +250,20 @@ static int appletb_kbd_hid_event(struct hid_device *=
hdev, struct hid_field *fiel
>  	return kbd->current_mode =3D=3D APPLETB_KBD_MODE_OFF;
>  }
> =20
> +static u8 appletb_switch_mode(u8 mode)
> +{
> +	switch (mode) {
> +	case APPLETB_KBD_MODE_SPCL:
> +		return APPLETB_KBD_MODE_FN;
> +		break;
[Severity: Low]
Are these break statements unreachable since the cases return directly?

> +	case APPLETB_KBD_MODE_FN:
> +		return APPLETB_KBD_MODE_SPCL;
> +		break;
> +	default:
> +		return mode;
> +	}
> +}
> +
>  static void appletb_kbd_inp_event(struct input_handle *handle, unsigned =
int type,
>  			      unsigned int code, int value)
>  {
[ ... ]
> +			if (appletb_tb_double_press_switch_time > 0) {
> +				unsigned long now =3D jiffies;
> +
> +				if (time_before(now, kbd->last_fn_press +
> +					msecs_to_jiffies(appletb_tb_double_press_switch_time))) {
[Severity: Medium]
Will this condition incorrectly evaluate to true on every key press during
early boot on 32-bit systems?

Since jiffies initializes to a large negative value (-300 seconds) on 32-bit
architectures, now will be negative. Because kbd->last_fn_press is initially
zero, time_before(negative, positive) will evaluate to true.

> +					appletb_tb_def_mode =3D
> +						appletb_switch_mode(appletb_tb_def_mode);
> +
> +					appletb_kbd_set_mode(kbd, appletb_tb_def_mode);
[Severity: High]
This isn't a bug introduced by this patch, but could calling
appletb_kbd_set_mode() from appletb_kbd_inp_event() result in sleeping
in atomic context?

The input subsystem invokes the ->event callback (which maps to
appletb_kbd_inp_event) with the per-device spinlock held and local interrup=
ts
disabled.

appletb_kbd_set_mode() calls hid_hw_power(hdev, PM_HINT_FULLON), which
resolves to usbhid_power() and uses pm_runtime_get_sync() (a sleeping
function).

> +
> +					kbd->saved_mode =3D appletb_tb_def_mode;
> +					kbd->last_fn_press =3D 0;
[Severity: Medium]
Might resetting last_fn_press to 0 guarantee the above time_before() bug wi=
ll
indefinitely trigger on every press during the 5 minute boot window before
jiffies crosses zero?

> +
> +					return;
> +				}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905143733.1781=
9-1-aditya.garg@linux.dev?part=3D1
