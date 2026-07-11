Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54359175A79
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739102; cv=none; b=k9y9kWtZwVN7TulqJSSAByUowf87XDfHHTEhH4TOOpgGd0fEiHTsOPwXgrxkIa3C9L+/nGC9TrDkHMoJpaQuf1GgSOzB56jtEjSz65XwNwo0iN8L5Yp6lYjybrcCWmSll2PQ+Qib/TkrrOXfL+nE503eqCOZUtB64fwkjaKs8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739102; c=relaxed/simple;
	bh=kQdHKqKAOn2AeCrUcIhADXRpt1C3ufIQ84hbtdI3uR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FVv8tF8lWUC8sEg/dyYlH5VgLN2r5tvkpz+QH/5yUQHC5UQbCg1n9WPBOC8nDh47/ResZ3Wg1RIvjLQIUvma/2G+SVuydVHkHG8NVpO3rSRRxI34dI+arZUgQmaQSNM65pT9/96VUzDsPRVr+wiKeuepYtfY6HWzZdi8KZzM2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3Lm5JoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3Lm5JoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D01F00A3A;
	Sat, 11 Jul 2026 03:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783739101;
	bh=qMbjJG8+lE7s9MnMz+RA/BjQ3id1q/gUTWixhddCHok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3Lm5JoWavt3akS0k1kTwLMIZNXIGGRXCRS2cUy67zIpRv/MpCzhXLdwn65XEjY1b
	 0/wBrTOXXeh89ll5YUeL4bF2KfqDeV6k32VDpb20bSJRTHw+w14CMlFYVy6bzX+meK
	 1rsckILv6liCUURDpaZqXSStWos1KQ5bA+t71peYxoqI2SeTyxBtp6ccbzwCDjk5JT
	 5DBxtt4lk/xthzp1r6NUUQ7UXXSnqpNZIs0yVngH5Rh4EdVwDkRMT0VP9gU4XhxjxE
	 V4aWV3+5ImsASIAKL8U5Ww0A7O6r2iSV3Z+gLCI1bTvWnRsQ2HxqyRmno5cwc+n7Yq
	 FQcjcTrMzmuJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Input: qt1050 - wait for calibration to complete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miles Krause" <mileskrause5200@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710-qt1050-calibration-status-bit-v3-1-cc9ae3f0b2ec@gmail.com>
References: <20260710-qt1050-calibration-status-bit-v3-1-cc9ae3f0b2ec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:05:00 +0000
Message-Id: <20260711030500.CA9D01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Polling for a transient 'calibration started' state makes the prob=
e highly susceptible to random timeouts due to thread preemption or schedul=
ing delays.
- [High] The calibration is triggered and awaited before the soft reset and=
 firmware data application, rendering the calibration useless and leaving t=
he device uncalibrated.
- [High] Command register `QT1050_RES_CAL` is not volatile, leading to cach=
ed commands being erroneously re-written.
- [High] If `regmap_write()` fails during suspend, the IRQ remains disabled=
 indefinitely.
--

--- Patch [1]: [PATCH v3] Input: qt1050 - wait for calibration to complete =
---
commit ae3cb773621fc88acc85ed8d8f19253b64a18472
Author: Miles Krause <mileskrause5200@gmail.com>

Input: qt1050 - wait for calibration to complete

The CALIBRATE flag is set when calibration begins and clears when it
finishes. regmap_read_poll_timeout() stops when its condition becomes
true, so the existing condition returns when calibration starts instead
of waiting for it to finish.

First wait for the flag to become set, then wait for it to clear before
continuing with the soft reset. Use a 500 ms completion timeout to leave
margin beyond the usual calibration time.

Link: https://lore.kernel.org/r/20260711024428.ED7FF1F000E9@smtp.kernel.org

> --- a/drivers/input/keyboard/qt1050.c
> +++ b/drivers/input/keyboard/qt1050.c
[ ... ]
> @@ -498,9 +499,18 @@ static int qt1050_probe(struct i2c_client *client)
>  		return err;
>  	}
>  	err =3D regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
> -				 status >> 7 =3D=3D 1, 10000, 200000);
> +				 status & QT1050_DET_STATUS_CALIBRATE,
> +				 10000, 200000);

[Severity: High]
This is a pre-existing issue, but does polling for a transient state here
make the probe susceptible to random timeouts?

If calibration completes very quickly before the first read, or if the
kernel thread is delayed or preempted, could we miss the 1 state entirely
and time out after 200ms? Since this causes probe to fail with -ETIMEDOUT,
could this randomly leave the device unusable on faster buses?

> +	if (err) {
> +		dev_err(dev, "Calibration did not start: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
> +				       !(status & QT1050_DET_STATUS_CALIBRATE),
> +				 10000, 500000);
> +	if (err) {
> +		dev_err(dev, "Calibration did not complete: %d\n", err);
>  		return err;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the sequence in
qt1050_probe(), calibration is triggered before the soft reset and custom
firmware data application:

qt1050_probe() {
    ...
    err =3D regmap_update_bits(ts->regmap, QT1050_RES_CAL, 0x7f,
                             QT1050_RES_CAL_CALIBRATE);
    ...
    err =3D regmap_update_bits(ts->regmap, QT1050_RES_CAL,
                             QT1050_RES_CAL_RESET, QT1050_RES_CAL_RESET);
    ...
    err =3D qt1050_apply_fw_data(ts);
}

Does this logic render the calibration ineffective? Modifying the physical
capacitive tuning parameters usually requires recalibration after they are
set to establish accurate baselines, rather than before.

[Severity: High]
Also pre-existing, but do these read-modify-write operations modify a cached
command register and accidentally accumulate bits?

QT1050_RES_CAL is omitted from the volatile registers list in
qt1050_volatile_reg(). Triggering calibration caches BIT(1). Later,
triggering the soft reset causes regmap_update_bits() to read BIT(1) from
the cache, set BIT(7), and write BIT(7) | BIT(1) to the hardware.

Could this trigger both a calibration and a soft reset simultaneously and
cause unpredictable firmware behavior?

[Severity: High]
This is a pre-existing issue unrelated to the patch above, but looking at
qt1050_suspend(), if regmap_write() fails, does the IRQ remain permanently
disabled?

qt1050_suspend() {
    disable_irq(client->irq);
    ...
    return regmap_write(ts->regmap, QT1050_LPMODE,
                        device_may_wakeup(dev) ? 125 : 0);
}

If the I2C write fails, the function returns the error directly.
Since the PM core will not call resume for a device that failed to suspend,
enable_irq() is never called. Could this leave the touch panel permanently
dead until the module is reloaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-qt1050-cal=
ibration-status-bit-v3-1-cc9ae3f0b2ec@gmail.com?part=3D1
