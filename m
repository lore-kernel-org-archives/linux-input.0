Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5162D9481
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678909; cv=none; b=RWvVvbUAySIYL+JpY8PGd8RsXTtd8/DNzrkSyl77VJQbdwrk7zbPZNUNJ7SHwm/2JFbjoc11vE3vdFscxZbeDQiIqgWrzDP9VTAjJsiR+uFPC2Bp0m8nkZQHIWblmB+P8l6sNvXS551ZAkLK1VMQm9Ly2XrEk5Nym6TrWpHUrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678909; c=relaxed/simple;
	bh=nqfycUFU3BixuyszdwWcJgzlpjkueISFI9yQFvEwZbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tkYtkF7hTXU3yu6p1pcHnW4SHT4UzG6NWV7ozAcUN4GNw/QYKig9XVtrQtqeeDPpbnp8gBH1hnzvAr3RXcSU8R4X9Wjj/ujCneCFELjoyh4iSBOIs3Nr/+jtxbRJxGKECP9PmnloxvGR22LorAK51oVZMPUScwHl0Gq0xlQRKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHpYdkOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHpYdkOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088AC1F000E9;
	Mon, 25 May 2026 03:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779678907;
	bh=vVEiCQWP2ZIfm93m+H+6lmkubWlU1d2YHu/WDcLhtSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHpYdkOfEoP4KhyixxllQ0C7gc7xmvrtMxaskhsWyTYjmgfRq2tBJrimbpH6CyNyN
	 jf6z2CNAp2zWz4ve0aTQh40f21wRzhgy3HBO2UMK+fSCgAGKGLmL6lLuy4OiUxK2cW
	 ioKdmsQPfB5h5z/dpRCx8q0rX3KB5Ou6/XLNdLdaSyAjhlOlxFFWBl7hgLwWP7LXWc
	 1PR1TOJG17tmXrr7LoLIKUMok6Hxw0SG91kgqmlJoDlX6lC82yoUOx6HbJIVRj2lV8
	 911vjndxwjhNCYC6pLGiKOZsCkS2q2tMX4QT4GnmGNBqjcjGxZnRYPYEh2hGF0bWF8
	 IG4L201lf7WkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260525020543.519082-3-derekjohn.clark@gmail.com>
References: <20260525020543.519082-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 03:15:06 +0000
Message-Id: <20260525031507.088AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Typographical error checking `gamepad_registered` instead of `gp_r=
egistered` causes newly added sysfs attributes to unconditionally return `-=
ENODEV`.
- [High] Dangling asynchronous ACK from `SYNC_TO_ROM` can prematurely compl=
ete subsequent commands, corrupting the device state machine.
- [Medium] Spurious or late `READ_PROFILE_ACK` packets incorrectly abort su=
bsequent profile reads with `-EINVAL`.
- [Medium] If `claw_hw_output_report()` fails in `claw_mkey_show()`, the fu=
nction exits without clearing the `profile_pending` state.
--

commit fe7de95a59af02c44e638aba1fcc1763f3b5354f
Author: Derek J. Clark <derekjohn.clark@gmail.com>

    HID: hid-msi: Add M-key mapping attributes
   =20
Adds attributes that allow for remapping the M-keys with up to 5 values whe=
n in
macro mode. Mapped events will fire from gamepad, keyboard, or mouse evdevs.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 3a176f44f2c43..5f20102eae69d 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -87,24 +249,47 @@ struct claw_command_report {
>  	u8 data[59];
>  } __packed;
> =20
[ ... ]
>  struct claw_drvdata {
>  	/* MCU General Variables */
> +	enum claw_profile_ack_pending profile_pending;
>  	struct completion send_cmd_complete;
[ ... ]
>  	/* Gamepad Variables */
>  	enum claw_mkeys_function_index mkeys_function;
>  	enum claw_gamepad_mode_index gamepad_mode;
> +	u8 m1_codes[CLAW_KEYS_MAX];
> +	u8 m2_codes[CLAW_KEYS_MAX];
> +	bool gamepad_registered;
>  	spinlock_t mode_lock; /* Lock for mode data read/write */
> +	const u16 *bmap_addr;
> +	bool bmap_support;
>  	bool gp_registered;
>  };
[ ... ]
> @@ -165,9 +383,20 @@ static int claw_raw_event(struct claw_drvdata *drvda=
ta, struct hid_report *repor
>  			complete(&drvdata->send_cmd_complete);
>  		}
> =20
> +		break;
> +	case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> +		ret =3D claw_profile_event(drvdata, cmd_rep);
> +		if (drvdata->waiting_for_ack &&
> +		    drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PROFILE) {
> +			drvdata->cmd_status =3D ret;
> +			drvdata->waiting_for_ack =3D false;
> +			complete(&drvdata->send_cmd_complete);
> +		}

[Severity: Medium]
If a spurious or late READ_PROFILE_ACK packet arrives, claw_profile_event()
will return -EINVAL. Does this unconditionally pass the error to cmd_status
and prematurely complete the wait for a valid, currently pending READ_PROFI=
LE
command?

> +
> +		break;
>  	case CLAW_COMMAND_TYPE_ACK:
[ ... ]
> @@ -442,6 +671,177 @@ static ssize_t reset_store(struct device *dev, stru=
ct device_attribute *attr,
[ ... ]
> +static int claw_mkey_store(struct device *dev, const char *buf, u8 mkey)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct claw_mkey_report report =3D { {0x01, cpu_to_be16(drvdata->bmap_a=
ddr[mkey])},
> +				   0x07, 0x04, 0x00, {0xff, 0xff, 0xff, 0xff, 0xff} };
> +	char **raw_keys __free(argv_free) =3D NULL;
> +	int ret, key_count, i;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		if (!smp_load_acquire(&drvdata->gamepad_registered))
> +			return -ENODEV;
> +	}

[Severity: High]
Does this check the newly added gamepad_registered field instead of the
already existing gp_registered field?

Since gamepad_registered is never set to true, it looks like this will
unconditionally return -ENODEV, rendering the sysfs attributes inaccessible.

> +
> +	raw_keys =3D argv_split(GFP_KERNEL, buf, &key_count);
[ ... ]
> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    (u8 *)&report, sizeof(report), 25);
> +		if (ret)
> +			return ret;
> +		/* MCU will not send ACK until the USB transaction completes. ACK is s=
ent
> +		 * immediately after and will hit the stale state machine, before the =
next
> +		 * command re-arms the state machine. Timeout 0 ensures no deadlock wa=
iting
> +		 * for ACK that ill never come.
> +		 */
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NUL=
L, 0, 0);

[Severity: High]
Since this command uses a timeout of 0, could the asynchronous ACK from
SYNC_TO_ROM arrive while the driver is waiting for a subsequent command
(like another WRITE_PROFILE_DATA)?

If the generic ACK arrives after the driver starts waiting for the next
command, it seems it could falsely complete the next command prematurely
and break the lock-step protocol between host and MCU.

> +	}
> +
> +	return ret;
> +}
> +
> +static int claw_mkey_show(struct device *dev, char *buf, enum claw_key_i=
ndex m_key)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct claw_mkey_report report =3D { {0x01, cpu_to_be16(drvdata->bmap_a=
ddr[m_key])}, 0x07 };
> +	int i, ret, count =3D 0;
> +	const char *name;
> +	u8 *codes;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		if (!smp_load_acquire(&drvdata->gamepad_registered))
> +			return -ENODEV;
> +	}
> +
> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_=
codes;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PEND=
ING
> +								  : CLAW_M2_PENDING;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
> +				    (u8 *)&report, sizeof(report), 25);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If claw_hw_output_report() fails or times out, this returns immediately.
Does this leave drvdata->profile_pending set to a pending state?

If the state is left dangling after the mutex is released, could a subseque=
nt
late or spurious profile packet be incorrectly accepted and parsed into the
local codes arrays?

> +
> +	for (i =3D 0; i < CLAW_KEYS_MAX; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525020543.5190=
82-1-derekjohn.clark@gmail.com?part=3D2
