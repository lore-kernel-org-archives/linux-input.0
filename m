Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A86363C60
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025900; cv=none; b=OgT8CCO0iWp7DpZXOVvz4yjLttCO6Xlrp4BqRIWN2Mpvm1r+gh5l03cn8FgrOYmJFX8QWsCpxxYTdmowiX9xzNhOOwb4nifwg0I4wJdfPNVhzMnKflLxWCBLROk/WPcE9nHLRopG3KitnBIjVrSS5UVt0tiR2wabNWegKEEDUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025900; c=relaxed/simple;
	bh=JsN/laj/QiYRuLutFlrTyIU3+nAyRzhL4DbPHNa37/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K+zpX8IsTEgbYu1D2jOIUk9nTh6lgt2NVWpQ3hSMz8SJaqdvX0Tf4MmrZV11edqXjC424UQwIkbZ2T7epBogwM6DdYKgmxC0WxnjlQFjGb3NsqjsPvKbfM1wBEIwEDA9zk5S1GI90fTWSifv4olOfF60PiQxOB11JiEFxlTgs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ+Mijd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ+Mijd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A741F000E9;
	Tue, 14 Jul 2026 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025899;
	bh=EEEV2YFxCIkum8/nAScdbH3uPdOlsy8HXvG16wLLGfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZ+Mijd6xevIYW380vgfod9h9A24YHXytx7snybDPRtJdKmchhLRRRfg8rft3e0FI
	 LV8c+ox+OGMYg1bN6eBcRib3Gmk/4eRdu1wI6AHn280zHoJ6cbplUs9Gwd+CdfKGNz
	 Z1KFp+F6dIb1oQA5OXz+kAlH/Z4+4KWZSNqSJ1FrdshE2NIZs4drHgJbQ2YFfTdis+
	 ulNASME0/Ya0qeMaCjEK4RavBJsyT0H3Uq+DunEbeXZzzN9SrURlmg4pFX3xAsYAiy
	 QYvfkB0MkcluMzP+YybZDeZnjsAPvfykYIB7M1crMHCnga7MceTPZMPG8rSXWQtdPl
	 aV60UlbbXq+vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714102640.18075-3-derekjohn.clark@gmail.com>
References: <20260714102640.18075-1-derekjohn.clark@gmail.com>
 <20260714102640.18075-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:44:58 +0000
Message-Id: <20260714104459.05A741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Non-atomic update of drvdata->profile_pending can overwrite concur=
rent state changes, leading to sysfs read failures.
- [High] Orphan ACKs from SYNC_TO_ROM commands are ignored and leave the `o=
rphan_ack_pending` flag set if they arrive while waiting for a READ command=
, causing the next WRITE command to time out.
--

--- Patch [2]: [PATCH v12 2/4] HID: hid-msi: Add M-key mapping attributes -=
--
commit 21a823af0d7845d277f06cccaf5818c1b1be1ce7
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

Adds attributes that allow for remapping the M-keys with up to 5 values
when in macro mode.

Link: https://patch.msgid.link/20260529072111.7565-3-derekjohn.clark@gmail.=
com

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 8a48ce099c1ca..9d3249fa50291 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -143,6 +327,39 @@ static int claw_gamepad_mode_event(struct claw_drvda=
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
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		profile =3D drvdata->profile_pending;
> +
> +	switch (profile) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:
> +		key =3D (profile =3D=3D CLAW_M1_PENDING) ? CLAW_KEY_M1 : CLAW_KEY_M2;
> +		mkeys =3D (struct claw_mkey_report *)cmd_rep->data;
> +		if (be16_to_cpu(mkeys->read_addr) !=3D drvdata->bmap_addr[key])
> +			return -EAGAIN;
> +		codes =3D (profile =3D=3D CLAW_M1_PENDING) ? drvdata->m1_codes : drvda=
ta->m2_codes;
> +		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> +			codes[i] =3D (mkeys->codes[i]);
> +		break;
> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;

[Severity: High]
Can this unconditionally clearing profile_pending overwrite concurrent
state changes?

If Thread A times out waiting for M1, and Thread B starts waiting for M2
by setting profile_pending =3D CLAW_M2_PENDING. If the delayed USB ACK
for M1 then arrives, claw_profile_event processes it and executes:

    scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
        drvdata->profile_pending =3D CLAW_NO_PENDING;

Doesn't this clobber Thread B's pending M2 state, causing the M2 ACK to
be rejected and Thread B to permanently time out?

> +
> +	return 0;
> +}
> +
>  static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_repor=
t *report,
>  			  u8 *data, int size)
>  {

[ ... ]

> @@ -171,9 +388,23 @@ static int claw_raw_event(struct claw_drvdata *drvda=
ta, struct hid_report *repor
>  			complete(&drvdata->send_cmd_complete);
>  		}
> =20
> +		break;
> +	case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> +		ret =3D claw_profile_event(drvdata, cmd_rep);
> +		/* Stale address received, ignore and keep waiting */
> +		if (ret =3D=3D -EAGAIN)
> +			return 0;
> +		if (drvdata->waiting_for_ack &&
> +		    drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PROFILE) {
> +			drvdata->cmd_status =3D ret;
> +			drvdata->waiting_for_ack =3D false;
> +			complete(&drvdata->send_cmd_complete);
> +		}
> +
>  		break;
>  	case CLAW_COMMAND_TYPE_ACK:
> -		if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE)
> +		if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PROFILE ||
> +		    drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE)
>  			break;
> =20
>  		if (drvdata->orphan_ack_pending) {

[Severity: High]
Does this early break for READ commands permanently skip processing
the orphan ACK?

If a WRITE_PROFILE_DATA command is sent followed by a SYNC_TO_ROM
command, orphan_ack_pending is set to true. If userspace then
immediately issues a sysfs read, setting waiting_cmd to
CLAW_COMMAND_TYPE_READ_PROFILE, and the generic orphan ACK arrives:

claw_raw_event() will evaluate the condition above, execute the early
break, and bypass clearing orphan_ack_pending.

Later, when another write is issued, won't its real generic ACK be
incorrectly consumed as the leftover orphan ACK, causing the new write
to time out since its completion is never signaled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714102640.1807=
5-1-derekjohn.clark@gmail.com?part=3D2
