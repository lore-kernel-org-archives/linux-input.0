Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B213630A4
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761321; cv=none; b=EEBJdKHeLHBjWh9ju717Vz/dWclaWpr/q4/UL7wzWVsPWIgu39dMVCBibSGohp1wf5yr/as1qRDYUTgz74moWsWZ72YlCmplovR7YAhkFru3Ww3n++g0p26iNzx2MEbuPMKPEPcf3RlAnliimAdcCMi4CZmQ30E23zutWk/lU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761321; c=relaxed/simple;
	bh=eZtOCMJvAORigbLGmsDuccuJYoHEwO/aL6EoT+GzDOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQwMcA3ld4mJGeH3vxsS6zh5C3uMpdw28R3XpSKZUOdzPINH6KBW3JmKN/XgDFMwFKtHaGgNDkJvMoxW8b4MwrH0kIy00KKiHZ23KoxHEfEawB7QKeyvuvO8N51lieQ9uotXyk/Ehn0XnSrLRwxyhjtznuxUHT4MH1at4piDjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3nMIwjI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3nMIwjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52C4C2BCB3;
	Thu, 14 May 2026 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778761321;
	bh=eZtOCMJvAORigbLGmsDuccuJYoHEwO/aL6EoT+GzDOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k3nMIwjIEjbn1rjwYrrswoW/ttQ5mFsNktNP0N+8AbkQNptaucaEnazaOj1y0cMte
	 OWwkvwmJF947WsPkF6JGhICadXBE7mghwjW5q4PNtvLfKHiEVDwUsVeIQq6mgf3Vz7
	 dA5Z3qQGUFTLprEHiCiE2gORUhubXttuvWD7YRKYyYkoSXo+XXKwgvbT+EP4QhZz26
	 sFzAReEj0dfm8W55PM5jAclmKxAdimlF5jD/uRlwNaeYkKnbyrYmL9hJ/QXF3CkX69
	 jBUgHEM4hc7k5UQmmrvKDnd+4efaVVMgTu6U0m/CgecBu/AWggnHCFPxY3Sg7XuXYf
	 dnhNPlH3cHT+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513231445.3213501-3-derekjohn.clark@gmail.com>
References: <20260513231445.3213501-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:22:00 +0000
Message-Id: <20260514122200.E52C4C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `cfg_mutex` guard in `claw_hw_output_report()` is scoped to an=
 `if` block, releasing the lock before the critical section executes.
- [High] Lockless concurrent access to `profile_pending` between process an=
d interrupt contexts causes data corruption and sequence mismatches on dela=
yed responses.
- [High] Unsafe assumption of USB transport in `claw_probe()` causes type c=
onfusion and invalid pointer dereference for non-USB devices.
- [High] Returning an error from `claw_profile_event()` for a spurious even=
t unconditionally triggers `complete()`, causing premature wakeups of unrel=
ated commands.
- [Medium] The function `claw_buttons_store()` illegally mixes scope-based =
`guard()` cleanup with `goto`-based error handling.
--

commit 42be71c046dc9b6b31d28598f5e0bb568d78b7a1
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

Adds attributes that allow for remapping the M-keys with up to 5 values
when in macro mode.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 8915942af15e6..13ba2747fdb66 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -125,6 +294,31 @@ static int claw_gamepad_mode_event(struct claw_drvda=
ta *drvdata,
>  	return 0;
>  }
> =20
> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	u8 *codes;
> +	int i;
> +
> +	switch (drvdata->profile_pending) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:
> +		codes =3D (drvdata->profile_pending =3D=3D CLAW_M1_PENDING) ?
> +			drvdata->m1_codes : drvdata->m2_codes;
> +		/* Extract key codes; replace disabled (0xff) with 0x00, which is (nul=
l) in _show */
> +		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> +			codes[i] =3D (cmd_rep->data[6 + i] !=3D 0xff) ? cmd_rep->data[6 + i] =
: 0x00;
> +		break;

Is it safe to read and modify profile_pending locklessly here in the
interrupt handler?

Since claw_buttons_show() modifies this state in process context under
profile_mutex, if a sysfs request times out and a subsequent request starts,
could the delayed ACK from the first request cause this handler to see the
new profile_pending state and corrupt the new request's buffer?

> +	default:
> +		dev_warn(&drvdata->hdev->dev,
> +			 "Got profile event without changes pending from command: %x\n",
> +			 cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	drvdata->profile_pending =3D CLAW_NO_PENDING;
> +
> +	return 0;
> +}
> +
>  static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_repor=
t *report,
>  			  u8 *data, int size)
>  {

[ ... ]

> @@ -146,6 +340,9 @@ static int claw_raw_event(struct claw_drvdata *drvdat=
a, struct hid_report *repor
>  	case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
>  		ret =3D claw_gamepad_mode_event(drvdata, cmd_rep);
>  		break;
> +	case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> +		ret =3D claw_profile_event(drvdata, cmd_rep);
> +		break;
>  	case CLAW_COMMAND_TYPE_ACK:
>  		break;
>  	default:

When claw_profile_event() returns -EINVAL for a spurious event,
claw_raw_event() breaks from the switch and unconditionally calls
complete(&drvdata->send_cmd_complete).

Could this prematurely wake up a thread waiting on a completely different
command, such as WRITE_PROFILE_DATA?

[ ... ]

> @@ -366,6 +563,161 @@ static ssize_t reset_store(struct device *dev, stru=
ct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(reset);
> =20
> +static int button_mapping_name_to_code(const char *name)
> +{

[ ... ]

> +static int claw_buttons_store(struct device *dev, const char *buf, u8 mk=
ey_idx)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[] =3D { 0x01, (drvdata->bmap_addr[mkey_idx] >> 8) & 0xff,
> +		      drvdata->bmap_addr[mkey_idx] & 0xff, 0x07,
> +		      0x04, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	size_t len =3D ARRAY_SIZE(data);
> +	int ret, key_count, i;
> +	char **raw_keys;
> +
> +	raw_keys =3D argv_split(GFP_KERNEL, buf, &key_count);
> +	if (!raw_keys)
> +		return -ENOMEM;
> +
> +	guard(mutex)(&drvdata->rom_mutex); /* all err_free paths must be in sco=
pe */
> +	if (key_count > CLAW_KEYS_MAX) {
> +		ret =3D -EINVAL;
> +		goto err_free;
> +	}
> +
> +	if (key_count =3D=3D 0)
> +		goto set_buttons;
> +
> +	for (i =3D 0; i < key_count; i++) {
> +		ret =3D button_mapping_name_to_code(raw_keys[i]);
> +		if (ret < 0)
> +			goto err_free;
> +
> +		data[6 + i] =3D ret;
> +	}
> +
> +set_buttons:
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DAT=
A, data, len, 8);

While reviewing the addition of these sysfs attributes, I noticed a
pre-existing issue in claw_hw_output_report() that is exacerbated by
the concurrent sysfs requests added here:

drivers/hid/hid-msi.c:claw_hw_output_report() {
    ...
    if (timeout) {
        guard(mutex)(&drvdata->cfg_mutex);
        reinit_completion(&drvdata->send_cmd_complete);
    }
    ...
}

Since guard() is scoped to the if block, the mutex is immediately released =
at
the closing brace.

Doesn't this mean hid_hw_output_report() and
wait_for_completion_interruptible_timeout() execute entirely without
the lock, defeating the intended serialization and allowing concurrent
requests to race?

> +	if (ret < 0)
> +		goto err_free;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL=
, 0, 8);
> +
> +err_free:
> +	argv_free(raw_keys);
> +	return ret;
> +}

Is it safe to mix goto-based error handling with scope-based guard() cleanup
in the same function?

According to the cleanup guidelines, functions should either convert
entirely to scope-based cleanup, for example by using a DEFINE_FREE
wrapper for argv_free, or not use guard() at all to avoid confusing
ownership semantics.

[ ... ]

> @@ -432,8 +796,31 @@ static void cfg_resume_fn(struct work_struct *work)
>  		dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode settings: %d\=
n", ret);
>  }
> =20
> +static void claw_features_supported(struct claw_drvdata *drvdata)
> +{

[ ... ]

>  static int claw_probe(struct hid_device *hdev, u8 ep)
>  {
> +	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_device *udev =3D interface_to_usbdev(intf);

Is it guaranteed that this device is always connected via USB?

If this driver is bound to a device connected over a non-USB transport like
I2C, Bluetooth, or UHID, hdev->dev.parent would not be a valid USB
interface, which could cause an invalid pointer dereference here.

Could this code check hid_is_usb(hdev) first or read the version from
hdev->version instead?

>  	struct claw_drvdata *drvdata;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.3213=
501-1-derekjohn.clark@gmail.com?part=3D2
