Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23021DED5C;
	Sun,  6 Sep 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713262; cv=none; b=Z29D4fbHphsFs78n6DQ4tPfWnPgFo7HCSeR1GNH4FwzNotqabcghCAgEY/ZNt+CeByWdiZdM7QJrLpTQRZT6a77uc0whsZq23Ir99vM0D3dRMBvTgoxGt/8x68BiaN8Xe0mw7BG8pIPsBfuj8i98Fh9hMNaRxcX05M7cjPbztN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713262; c=relaxed/simple;
	bh=iO2iNDMvK+7iGs4XhZWoNdjcG3hvsd5MsgwJDVFENjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eoGO46cJ4RxvBE9hsZO/JRO3nPUthTS5jc0YOgaOsQkTFKXFO4SAWkexVeE6hcIBCpB7pIZkDO06822qVGFJqteXr7UTGKqkN0ZQQiqC4slA6386G2E0MnfWqMceXe9MwKEtINuWCRZxUAkBOIYD7xcjt49erK5mTTqKRTPsoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KljccAnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KljccAnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E611F00A3A;
	Sun,  6 Sep 2026 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788713261;
	bh=FrYbBt/LgfMPRNEs8bretlQ4hfXyoQ+b95HLALywZr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KljccAnbzXGrWJCek4uqwD4CZJFvtyREJQScx9XR2RYP5BUYo62xSUYSAM8UOpytV
	 MChilxK7hyotqA/speiqhLKsyusrYmePqr14aK71E/a0IiLsuP5yooH/TWTnG7WLk6
	 RZu5msYSpl+himbfEsD/2GCsiJw7iNMKJ5YgEcnjiPfU1gExyYppP9lPVEqUORq94Q
	 hY2LPUYNfYGAxaC3zB8PsviCe6mvjOx04jMUi8W648Ubg9nHpntbrafceNRCkPAFnC
	 w4Phs8G849c92kbfVesxGBIcC+FZ2QH7dkLS9XFwVtXsJAa1B7OetsI1IhmLnLvdPV
	 zqvWb/LfV1NFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] Input: stmfts - support FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260906-stmfts5-v6-2-50fbf6af8718@ixit.cz>
References: <20260906-stmfts5-v6-0-50fbf6af8718@ixit.cz>
 <20260906-stmfts5-v6-2-50fbf6af8718@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:47:40 +0000
Message-Id: <20260906164740.E9E611F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing capability initialization for ABS_MT_TOOL_TYPE causes st=
ylus and palm events to be silently dropped.

Pre-existing issues:
- [High] System resume leaves an active device in hardware sleep mode.
--

commit b210ef23e8e26cf6ac531eb08d54cae1f1a1de1d
Author: David Heidelberg <david@ixit.cz>

Input: stmfts - support FTS5

This patch adds support for the FTS5 touchscreen controller to the stmfts
driver. It introduces a mode-switch GPIO to switch between AP and SLPI mode=
s,
and handles the new FTS5 event format.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> index 972687797f826..019945f64c48b 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
[ ... ]
> @@ -205,6 +254,97 @@ static void stmfts_report_contact_release(struct stm=
fts_data *sdata,
[ ... ]
> +static void stmfts5_report_contact_event(struct stmfts_data *sdata,
> +					 const u8 event[])
> +{
[ ... ]
> +	input_mt_slot(sdata->input, touch_id);
> +	input_mt_report_slot_state(sdata->input, tool, true);

[Severity: Medium]
Will these tool type events be silently dropped by the input core?
The driver attempts to emit tool type events (like MT_TOOL_PEN or
MT_TOOL_PALM) via input_mt_report_slot_state(), but the ABS_MT_TOOL_TYPE ax=
is
does not seem to be registered.

[ ... ]
> @@ -623,11 +834,25 @@ static int stmfts_power_on(struct stmfts_data *sdat=
a)
> =20
>  err_disable_irq:
>  	disable_irq(sdata->client->irq);
> -err_disable_regulators:
>  	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies), sdata->supplies);
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does system resume leave an active device=
 in
hardware sleep mode?

The PM core invokes the stmfts_resume() sleep callback, which unconditional=
ly
calls stmfts_power_on(). Inside stmfts_power_on(), just above the error
cleanup path shown here, the code issues a STMFTS_SLEEP_IN command.

If the device was active (open) prior to system suspend, it appears it is
forced back into sleep mode without restoring the active scanning state (no
STMFTS_SLEEP_OUT or set_scan(true) is called). Because the PM core already
considers the device active upon return, it doesn't trigger a subsequent
pm_runtime_resume(), leaving the touchscreen unresponsive until userspace
closes and reopens the device.

[ ... ]
> @@ -640,6 +865,48 @@ static void stmfts_power_off(void *data)
[ ... ]
> +static int stmfts5_setup_input(struct stmfts_data *sdata)
> +{
[ ... ]
> +	/* Enable stylus support if requested */
> +	sdata->stylus_enabled =3D device_property_read_bool(dev, "stylus-enable=
d");
> +
> +	return input_mt_init_slots(sdata->input, STMFTS_MAX_FINGERS,
> +				   INPUT_MT_DIRECT);
> +}

[Severity: Medium]
Should the ABS_MT_TOOL_TYPE capability be initialized here?
If a stylus is supported, it seems input_set_abs_params() would be needed f=
or
the ABS_MT_TOOL_TYPE axis so the input core doesn't filter out the events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-stmfts5-v6=
-0-50fbf6af8718@ixit.cz?part=3D2
