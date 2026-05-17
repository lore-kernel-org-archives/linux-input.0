Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEB1AA797
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778986564; cv=none; b=Wj/3gDaWtp9mwtOD0YKfibhkFFatQRx2YJfb2dZu8aITVrGFce4TOydW9fesYF9YyI0u0nGU/PzI6tl3jrS7nKvE3zKBC2QDPnY5u/QsxhdVyPkKMFrOsF7Wdk7HVrIV5FSiE87ovjdG3nHVvxHoUeNbQ0UX0wX11FyGnalA7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778986564; c=relaxed/simple;
	bh=YqZ1M+0th7UcvSHcWr0gFsNgoUtZqKrg4Umgozm7nZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjKJmpUMU2qxVhuM/hv79Kv7SLw51SNcFLhWsLfGtoCP6c0axdHpmQa4SDkPbTy1XDohYNWGDsA8V714Dn0CJvSjzvWA1aXsVBK55YjE0+sgYkqiU2wgMxjJhJTL0HalgRGAFaLSzOEEq5yx4XGtoSTqGKFWGknHhUOBJfsB62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRJftREO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRJftREO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7ECC19425;
	Sun, 17 May 2026 02:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778986563;
	bh=YqZ1M+0th7UcvSHcWr0gFsNgoUtZqKrg4Umgozm7nZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WRJftREOgRALFTU5kLGoZX9bjcNGeR1AaEoLwb25vTltYVvzGDlUkcIFPY/BZqg89
	 fArPfX3MCV2pPIztrPX0jv+R6o3ByYAKNV9GZo2RNE3e7iZ91xPwemL+xr1ti5dsUG
	 85B+7eMiNJLlNpY0aLroTSnJ1efmr1TUJTuOOs+g53dXWPwKBBRBgYLCN0eWmI23bo
	 3fJteExIh71MmlW5xEfupj/MnORG/qk3HtxNX0HMCZIwMb6NgHDZdkGTLHWe7ftXb/
	 D15Ee98T9qQdjLp7kq0l4+jslV1oAIy4ncZtuSvCpRyKDkF5/ZNxtGkaA5LshQDk3i
	 tn31m5yDmx+pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260517013925.3120314-3-derekjohn.clark@gmail.com>
References: <20260517013925.3120314-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 02:56:02 +0000
Message-Id: <20260517025603.4C7ECC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ABBA deadlock between cfg_mutex and sysfs active references during=
 device removal.
- [High] Race conditions and lockless access to profile_pending cause TOCTO=
U bugs and mismatched command responses.
- [Low] Redundant local redefinition of core cleanup wrapper for argv_free.
--

commit 1f541fdc7955ce5da7d37b9d253518245001f68a
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

Adds attributes that allow for remapping the M-keys with up to 5 values
when in macro mode. There are 2 mappable buttons on the rear of the
device, M1 on the right and M2 on the left.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 3f809dc70a4cc..991d5a25d3de0 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -128,6 +298,30 @@ static int claw_gamepad_mode_event(struct claw_drvda=
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

Could this cause a race condition since drvdata->profile_pending is read tw=
ice
locklessly?

If the state changes between the switch statement and the ternary operator,
could M1's profile response be incorrectly written to M2's buffer?

Is it possible to use an IRQ-safe spinlock here to protect profile_pending
and the profile buffers, given they are shared between process context and
the HID raw event context?

> +		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> +			codes[i] =3D (cmd_rep->data[6 + i]);
> +		break;
> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	drvdata->profile_pending =3D CLAW_NO_PENDING;
> +
> +	return 0;
> +}

[ ... ]

> @@ -149,6 +343,9 @@ static int claw_raw_event(struct claw_drvdata *drvdat=
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

Since claw_raw_event() unconditionally calls
complete(&drvdata->send_cmd_complete) for any recognized ACK type after this
switch statement, could it wake up claw_buttons_show() prematurely if a
delayed or generic ACK arrives while it is waiting for READ_PROFILE_ACK?

If claw_buttons_show() wakes up prematurely, could it read uninitialized or
stale data from the codes array and leave profile_pending in a dirty state
that corrupts subsequent reads when the real ACK finally arrives?

[ ... ]

> @@ -373,6 +570,164 @@ static ssize_t reset_store(struct device *dev, stru=
ct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(reset);
> =20
> +static int button_mapping_name_to_code(const char *name)
> +{

[ ... ]

> +DEFINE_FREE(argv, char **, if (_T) argv_free(_T))

Is it necessary to locally redefine this cleanup wrapper?

The core kernel header include/linux/string.h already provides the exact sa=
me
functionality via
DEFINE_FREE(argv_free, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T)).

Could this simply be declared as char **raw_keys __free(argv_free) =3D NULL;
to avoid duplicate code?

> +
> +static int claw_buttons_store(struct device *dev, const char *buf, u8 mk=
ey_idx)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[] =3D { 0x01, (drvdata->bmap_addr[mkey_idx] >> 8) & 0xff,
> +		      drvdata->bmap_addr[mkey_idx] & 0xff, 0x07,
> +		      0x04, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	char **raw_keys __free(argv) =3D NULL;
> +	size_t len =3D ARRAY_SIZE(data);
> +	int ret, key_count, i;

[ ... ]

> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    data, len, 8);

Could this cause an ABBA deadlock during device removal?

During removal, claw_remove() acquires drvdata->cfg_mutex and then calls
device_remove_group() to remove the sysfs attributes. This blocks waiting
for kernfs to drain any active references to the sysfs files.

Meanwhile, this sysfs store method (and the show methods) acquire the exact
same drvdata->cfg_mutex internally via claw_hw_output_report().

If a sysfs attribute is being accessed concurrently when device removal occ=
urs,
will the sysfs method block waiting for cfg_mutex while claw_remove() blocks
waiting for the sysfs method to drop its active reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517013925.3120=
314-1-derekjohn.clark@gmail.com?part=3D2
