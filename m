Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FF1DF248
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420464; cv=none; b=J1BhljSKlP9rezVLR0cpi/ChSL4/8wQyOghlaLvYzwfIxKv5DCEt1bmV5ODxqAz6H/JY41fqPi7jmjs2V9gjsCOec2OjnNKQbGkXrbTsa7VlvFj8Vyw7S6HTlQBR7ZrprUYw1NwWrtMDogdB1oxpiWuhEPzlVdWLE7DN7VoyNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420464; c=relaxed/simple;
	bh=hv6pM0wvSzSfeq2/6KZasTZUNCFZvAglO3VsXdLZiew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X3vETm2w2Y0u426I3teIkaKhcQ6k+H2/AOeY6xrWVnfPrj07ZyFjFijuZ6DkQEruzLxVS5eeHQ30JcxcaVfMWoe9DkZVrQ9K7RsCorvRZjo7tBebLcZFBEaxmdN99yu2fEzeaokHb7N6dEWafdOdAGTxzNCV9Ww3zah/WLsMiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZZTJeBn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZZTJeBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFA71F000E9;
	Fri, 22 May 2026 03:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779420463;
	bh=tOacYG4Ijdq2HsSIHns23Fv8A4HANouPlXUIru5F+mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZZTJeBnDAsBLIenODJjUXTWmq2O6i74s5F3nPKOmLh8hsjqb8IGJ4/j7eaSeMVG0
	 qC1rKxw32fXWNgC5+LXoNM3jgbe0q8Q92nyV3T36MArpda0iCcu9IMUavXZUhXtAW6
	 xBork6TxGQW7JY43neHM9D2Kxdzka+hjc/l1RVwAFqoWuf/GVPqJSCTSd+A8Ua+b1h
	 6iUipBpfT4kfKr9d7FGt0vxHIPIZcCs5Ns/aeWCLX+MyZUnnB7b42ickJDyG3o+Wkb
	 dMufLj5XlNhW+PYjgukpOFi2hcdD2krs9/n2qMNSDY3ZS6dmkcTk4afdoXwC8hI9J1
	 JnfV6f8OCDhvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260522015518.1111290-3-derekjohn.clark@gmail.com>
References: <20260522015518.1111290-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 03:27:42 +0000
Message-Id: <20260522032742.EEFA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Command synchronization cross-talk due to unconsumed generic ACKs =
from `SYNC_TO_ROM`
- [Medium] TOCTOU race in `claw_profile_event` unconditionally overwrites `=
profile_pending`
- [Low] Invalid anonymous struct declaration in `struct claw_mkey_report`
--

commit b8dd002e01cbcbf34fdd54df7543cbafb1207a47
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

This commit adds attributes that allow for remapping the M-keys with up to =
5=20
values when in macro mode. It adds support for mappings from the gamepad,=20
keyboard, or mouse event devices.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 40b16253abbb3..b9901869075f6 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -87,25 +249,47 @@ struct claw_command_report {
>  	u8 report_id;
>  	u8 padding[2];
>  	u8 header_tail;
>  	u8 cmd;
>  	u8 data[59];
>  } __packed;
> =20
> +struct claw_profile_report {
> +	u8 profile;
> +	__be16 read_addr;
> +} __packed;
> +
> +struct claw_mkey_report {
> +	struct claw_profile_report;

[Severity: Low]
Does this act as a forward declaration rather than an embedded field? Under
standard C11 and GNU C, a struct with a tag cannot be an anonymous embedded
member without specific compiler extensions. Will this cause a compilation
error when accessing fields like mkeys->read_addr later?

> +	u8 padding_0;
> +	u8 padding_1;
> +	u8 padding_2;
> +	u8 codes[5];
> +} __packed;

[ ... ]

> @@ -137,6 +321,39 @@ static int claw_gamepad_mode_event(struct claw_drvda=
ta *drvdata,
>  	return 0;
>  }
> =20
> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	enum claw_profile_ack_pending profile;
> +	struct claw_mkey_report *mkeys;
> +	u8 *codes, key;
> +	int i;
> +
> +	scoped_guard(spinlock, &drvdata->profile_lock)
> +		profile =3D drvdata->profile_pending;
> +
> +	switch (profile) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:

[ ... ]

> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	scoped_guard(spinlock, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;

[Severity: Medium]
Could this unconditionally overwrite a new state if a timeout occurs? If a
command times out, the waiting thread might drop profile_mutex, allowing a
new thread to enter claw_mkey_show() and set profile_pending for a new
operation. If the delayed ACK from the first command arrives at that moment,
will this clear the new thread's state and cause its operation to fail?

> +
> +	return 0;
> +}

[ ... ]

> @@ -442,6 +670,177 @@ static ssize_t reset_store(struct device *dev, stru=
ct device_attribute *attr,

[ ... ]

> +static int claw_mkey_store(struct device *dev, const char *buf, u8 mkey)
> +{

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
Can this lead to command synchronization cross-talk? Since timeout is 0,
the driver won't wait for the ACK. If a user rapidly issues another sysfs
write, the next operation could take rom_mutex and send its own command.

Because generic ACKs appear to lack command IDs, will claw_raw_event()
blindly consume the orphaned ACK from this command and prematurely complete
the new command's wait before the MCU has actually processed it?

> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522015518.1111=
290-1-derekjohn.clark@gmail.com?part=3D2
