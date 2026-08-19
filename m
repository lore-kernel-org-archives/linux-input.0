Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59253C1F41
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170268; cv=none; b=PL452BiH89HBNfVkBDVfVOp0tPKzU13vH7RytPKZDBrcHPX0iC90wosUDItRSBTLP4agl0MeH3LVxwqJB1bOyxchbzNIr3tp/fVEZyccUy47z/cUu4OynGpOAVE6BdJhvxf1lDAO5Qc/88RbLfkL+8t8EuPYfMs5s6hZGDKrtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170268; c=relaxed/simple;
	bh=u6WTnpDuObOGy9YOzCfbbN3nrU2K09chbWHEuH9PnfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f2RL9Ao/V4nrkL2OTIT2CeekqalUuYwrE2hPOjZwsTlFMS25uOmROhsHQ+4/+hzrIKZn/wKbEM0YWdTd863Jh5RYjjgyx0MSBF0q3sl8Ym0QKON0peqYvHwpSrhtr3udvVF8RbnuN1Qgqs4Itmg1kBC+V+gwf7bEx77rEfSIAE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gir+JSQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gir+JSQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5E31F00A3A;
	Wed, 19 Aug 2026 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170266;
	bh=1fmXBviGpWWmXkjr4VrK2nVHvB8Uds+wxai1SqeC9gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gir+JSQCrJT8kQO1dUIgBRMPJRiZbaPN2BfJyfLYpkhjbvQX9g7cDjuecrbO1ZARJ
	 6P4sdQTuj4gLgjF2cZKDU/HxKzQ2u9cB1WluwHeKZmeO/K9Ahfg1TkLB+W4yFRfxIt
	 wmG6/xS4hnSLG+cVt+RCNP4ojOWYfk/iOF6krnhRjC9EuGYVcUR61453PVYx3nXPQY
	 jR0cPMSnYBhkvttWpIqqyGBSQWUXPOKr96gE5eZVrmwXXCt+SiQzyMaER3jU07oDp5
	 LdGK4nAQ1IeF7tS/OWi371Fvfn7rouvlS+ptWz8zeCW2hwe+1rwYIzugFhPYfDNe/R
	 0YCVN/x+LXhZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819195835.1649657-3-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:11:05 +0000
Message-Id: <20260819201106.4B5E31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Cross-device pointer access causes a Use-After-Free race when the =
keyboard interface is unbound.
- [High] Custom keyboard events silently fail because keyboard_input is ext=
racted before the inputs list is populated.
- [High] The use of a global singleton `ally_drvdata` structure without enf=
orcing a single connected device allows malicious state overwrites and cros=
s-device Use-After-Free.
- [Medium] The custom Ally X gamepad input device lacks open and close call=
backs, risking runtime PM suspension.
--

--- Patch [2]: [PATCH v2 02/12] HID: asus: add support for ROG Ally handhel=
ds ---
commit e59e4270b19f2b93584009213d08bcb80cc4001c
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

Implement the core functionality for ASUS handhelds by extending hid-asus
functionality if the driver is enabled. The device is initialized to a ready
state, Ally X input mapping is implemented, and a proper event is emitted
for the AC button long press.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 9ce21fcc7d2e0..88b30726f6c67 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +/*
> + * Changes to ally_drvdata must lock: the raw_event callbacks, which may
> + * run in atomic (URB completion) context, also take this lock, so it mu=
st
> + * be a spinlock.
> + */
> +static DEFINE_SPINLOCK(ally_data_lock);
> +static struct ally_handheld ally_drvdata =3D {

[Severity: High]
Could using a single global ally_drvdata structure cause state corruption if
multiple ROG Ally devices are connected?

If a user plugs in two devices or a spoofed USB peripheral, the second probe
unconditionally overwrites the pointers for the first device. Unbinding them
later could lead to use-after-free or dangling pointers.

Should this state be allocated dynamically per device instance instead?

> +	.intf_mutex =3D __MUTEX_INITIALIZER(ally_drvdata.intf_mutex),
> +	/*
> +	 * Initialised statically so it is always safe to cancel, whichever
> +	 * of the interfaces probed or failed to probe.
> +	 */

[ ... ]

> +static bool handle_ally_event(struct hid_device *hdev, struct ally_handh=
eld *ally,
> +			      u8 *data, int size)
> +{

[ ... ]

> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		keyboard_input =3D ally->keyboard_input;
> +		spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +		if (!keyboard_input)
> +			return false;
> +
> +		input_report_key(keyboard_input, keycode, 1);

[Severity: High]
Is it possible for an input_dev use-after-free to occur here? The
keyboard_input pointer is fetched under ally_data_lock, but the lock is
dropped before calling input_report_key().

If the device is concurrently unbound, hid_asus_ally_remove() will clear the
pointer from the global state and the input core will free the input_dev,
meaning the concurrent event handler would access freed memory.

Would taking a reference to the input device before dropping the lock
prevent this race?

> +		input_sync(keyboard_input);
> +		input_report_key(keyboard_input, keycode, 0);
> +		input_sync(keyboard_input);
> +		return true;
> +	}

[ ... ]

> +static int ally_x_setup_input(struct hid_device *hdev, struct ally_handh=
eld *ally)
> +{
> +	struct input_dev *input =3D ally_x_alloc_input_dev(hdev);

[ ... ]

> +	input_set_capability(input, EV_KEY, KEY_F18);
> +	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
> +	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
> +
> +	ret =3D input_register_device(input);

[Severity: Medium]
Does the custom Ally X gamepad input device need open and close callbacks?

Usually, standard hid-input devices assign these callbacks to invoke
hid_hw_open() and hid_hw_close(). Without them, opening just the gamepad
node might not wake the hardware from suspend or prevent it from sleeping,
which could lead to dropped events or input latency during runtime PM
suspension.

> +	if (ret) {
> +		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
> +		goto ally_x_setup_input_err;
> +	}

[ ... ]

> +static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
> +{

[ ... ]

> +	case HID_ALLY_INTF_KEYBOARD_IN:
> +		spin_lock_irqsave(&ally_data_lock, flags);
> +		ally_drvdata.keyboard_hdev =3D hdev;
> +		if (!list_empty(&hdev->inputs)) {
> +			hidinput =3D list_first_entry(&hdev->inputs, struct hid_input, list);
> +			ally_drvdata.keyboard_input =3D hidinput->input;
> +		}

[Severity: High]
Will ally_drvdata.keyboard_input ever be populated here? Looking at
asus_probe(), hid_asus_ally_probe() is called before hid_hw_start().

At this point, the HID core has not yet called hidinput_connect(), so
hdev->inputs is guaranteed to be empty. Because of this, the keyboard_input
pointer remains NULL, and custom keyboard events might be silently discarded
in handle_ally_event().

Could this initialization be deferred until after hid_hw_start() populates
the inputs list?

> +		spin_unlock_irqrestore(&ally_data_lock, flags);
> +		break;
> +	default:
> +		/* This is normally supposed to happen */
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D2
