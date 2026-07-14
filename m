Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49733D6C0;
	Tue, 14 Jul 2026 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007273; cv=none; b=t5w83J719lfcLWgGDh6a0MaPdAneLLaMRdc8oO+IyPyHyAhKT8O8avDNgld8iWSiWO5siabfhX7JX9E/R1+5XUWrqT0hUGyIVldKS/4MxyOlNelgXaKsmQHPWHLPOtwTmIyH/M/a/eIY+uDD2Jc518tq/NZMnNxVneNQm5rJ5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007273; c=relaxed/simple;
	bh=fAKzaWM9e86Ewv++wa6J+o8ohBSjIl+3I4rl4uPVMYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AKR8Z7ufR5x7Kltddlj0ilfgq9isHZNfgalWW/UcHfiBTKac8bvyi2cdpWlkgmwlquYWMvsINYZmpD/C/y2+1zVSHlJzz9cRBzBi9NR7O80MXhVEbaaGO0hcsrxg6Iq9WV8nZNI1z/RAmZlCvugEyns7uL/ZGNmXJ7XWRX8Ry98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxHfukhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxHfukhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D371F00A3E;
	Tue, 14 Jul 2026 05:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007271;
	bh=FvR1ya1mJMTyVnXZUOmEiSjTpEukiZQ/KKcJQDRNUic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxHfukhQ8jiz1AHg5NHA94sXzyEw7FWRID2/HtCAyyoYX8bCfQHxF1t6tOaHM2EQw
	 DROkk+0phsK98nKRHmT8/DrrDgMYa/u2eQ/gh7w1nKcBmzTCVfk21ceqEfHJtdWT33
	 oo08uCOxlWd0dyTgZ90+bfT2i9pQ/SQUg+f+FKtK8ZUBGjTER4/WUmgsElg4J355Z9
	 fgakmIE+sEr4Ivvz6s8wseIJxc8xZ+C1mnJVWvZjAWxNmkfdzdP12DXYWIL5w07MkS
	 MjYksty9Avb2kxk5SdXkBbq62f+TO8v4pCVgsvlnSbH1yM1OO4aNYwL6Woq11dWjam
	 ABZBd/NbSh0WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] input: misc: Add Qualcomm SPMI PMIC haptics
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260713-qcom-spmi-haptics-v3-3-c931bb7cb94f@oss.qualcomm.com>
References: <20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com>
 <20260713-qcom-spmi-haptics-v3-3-c931bb7cb94f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:34:30 +0000
Message-Id: <20260714053431.45D371F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] AB-BA deadlock in the error path of haptics_start_fifo() between `=
h->fifo_lock` and `disable_irq()`.
- [High] Failure to write to the FIFO in the IRQ handler leaves the interru=
pt condition asserted, leading to an interrupt storm.
- [Medium] Stop requests for inactive effects incorrectly terminate the cur=
rently playing effect.
- [Low] Mixing `goto`-based error handling with `guard()` scope-based clean=
up in `haptics_start_fifo()`.
--

--- Patch [3]: [PATCH v3 3/3] input: misc: Add Qualcomm SPMI PMIC haptics d=
river ---
commit 516c3c8b367d0b2e322ea97c78aee0907ed541f0
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

    input: misc: Add Qualcomm SPMI PMIC haptics driver
   =20
    Add an initial driver for the Qualcomm PMIH0108 PMIC haptics module,
    named as HAP530_HV. This module supports several play modes, including
    DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
    and hardware data handling logic.

> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/=
qcom-spmi-haptics.c
> new file mode 100644
> index 0000000000000..ffbef7453459a
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c
> @@ -0,0 +1,1160 @@

[ ... ]

> +static int haptics_start_fifo(struct qcom_haptics *h, int effect_id)
> +{
> +	struct qcom_haptics_effect *eff =3D &h->effects[effect_id];
> +	u32 vmax =3D eff->vmax_mv ? eff->vmax_mv : h->vmax_mv;
> +	u32 init_len;
> +	bool data_done;
> +	int ret;
> +
> +	if (!eff->fifo_data || !eff->data_len)
> +		return -EINVAL;
> +
> +	ret =3D haptics_clear_faults(h);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable auto-resonance for FIFO mode */
> +	ret =3D cfg_update_bits(h, HAP_CFG_AUTORES_CFG_REG, AUTORES_EN_BIT, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D haptics_set_vmax(h, haptics_gain_scaled_vmax(h, vmax));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ptn_update_bits(h, HAP_PTN_FIFO_PLAY_RATE_REG,
> +			      FIFO_PLAY_RATE_MASK,
> +			      FIELD_PREP(FIFO_PLAY_RATE_MASK, eff->play_rate));
> +	if (ret)
> +		return ret;
> +
> +	/* Flush FIFO before loading new data */
> +	ret =3D ptn_write(h, HAP_PTN_MEM_OP_ACCESS_REG, MEM_FLUSH_RELOAD_BIT);
> +	if (ret)
> +		return ret;
> +	ret =3D ptn_write(h, HAP_PTN_MEM_OP_ACCESS_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&h->fifo_lock);
> +
> +	/* Write the initial chunk and initialise streaming state */
> +	init_len =3D min_t(u32, eff->data_len, FIFO_INIT_FILL);
> +	ret =3D haptics_write_fifo_chunk(h, eff->fifo_data, init_len);

[Severity: Low]
Is it intended to mix goto-based error handling with scope-based guard()
cleanup here? The subsystem cleanup guidelines specify that functions should
use either goto-based cleanups or scope-based cleanups, but never both in
the same function.

> +	if (ret)
> +		return ret;
> +
> +	h->fifo_data    =3D eff->fifo_data;
> +	h->data_len     =3D eff->data_len;
> +	h->data_written =3D init_len;
> +
> +	/*
> +	 * Set empty threshold.  When threshold > 0 the hardware fires the
> +	 * FIFO-empty interrupt when occupancy drops below the threshold,
> +	 * allowing the driver to refill.  A threshold of 0 disables the IRQ.
> +	 */
> +	data_done =3D (h->data_written >=3D h->data_len);
> +	if (!data_done) {
> +		ret =3D ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG,
> +				FIFO_EMPTY_THRESH / FIFO_THRESH_LSB);
> +		if (ret)
> +			goto free_fifo;
> +
> +		haptics_fifo_irq_enable(h, true);
> +	}
> +
> +	ret =3D cfg_write(h, HAP_CFG_SPMI_PLAY_REG,
> +			 PLAY_EN_BIT | FIELD_PREP(PAT_SRC_MASK, PAT_SRC_FIFO));
> +	if (ret) {
> +		dev_err(h->dev, "trigger FIFO play failed, ret=3D%d\n", ret);
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +	haptics_fifo_irq_enable(h, false);
> +free_fifo:
> +	h->fifo_data =3D NULL;
> +	return ret;
> +}

[Severity: High]
Can this sequence cause a deadlock? In haptics_start_fifo(), h->fifo_lock is
still held via the guard() scope when jumping to the fail label.

The code then calls haptics_fifo_irq_enable() which disables the IRQ
synchronously using disable_irq().

If the threaded IRQ handler haptics_fifo_empty_irq() is concurrently runnin=
g,
it will block waiting for h->fifo_lock, while disable_irq() blocks waiting
for the handler to complete.

[ ... ]

> +static irqreturn_t haptics_fifo_empty_irq(int irq, void *dev_id)
> +{
> +	struct qcom_haptics *h =3D dev_id;
> +	u32 sts, to_write;
> +	int ret;
> +
> +	ret =3D regmap_read(h->regmap,
> +			  h->cfg_base + HAP_CFG_INT_RT_STS_REG, &sts);
> +	if (ret || !(sts & FIFO_EMPTY_BIT))
> +		return IRQ_HANDLED;
> +
> +	guard(mutex)(&h->fifo_lock);
> +
> +	if (!h->fifo_data)
> +		return IRQ_HANDLED;
> +
> +	/* Refill: write the next chunk */
> +	to_write =3D min_t(u32, h->data_len - h->data_written,
> +			 h->fifo_len - FIFO_EMPTY_THRESH);
> +	ret =3D haptics_write_fifo_chunk(h, &h->fifo_data[h->data_written], to_=
write);
> +	if (ret) {
> +		dev_err(h->dev, "refill FIFO samples failed, ret=3D%d\n", ret);
> +		return IRQ_HANDLED;
> +	}

[Severity: High]
If haptics_write_fifo_chunk() fails here, could this cause an interrupt
storm?

By returning IRQ_HANDLED without writing samples to the FIFO or disabling
the empty threshold via ptn_write(), the hardware FIFO occupancy remains
below the threshold.

Once the IRQ is unmasked upon return, the hardware will immediately trigger
the interrupt again.

[ ... ]

> +static void haptics_play_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h =3D container_of(to_delayed_work(work),
> +					      struct qcom_haptics, play_work);
> +	struct haptics_play_req *req =3D haptics_dequeue_play_req(h);
> +	bool rearmed =3D false;
> +	u32 length_us;
> +	int ret;
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	if (req && req->play) {
> +		ret =3D haptics_start_locked(h, req->effect_id);
> +		if (ret) {
> +			dev_err(h->dev, "play haptics failed, ret=3D%d\n", ret);
> +		} else {
> +			/*
> +			 * Re-arm the work to stop the play or advance
> +			 * to next play after the play duration
> +			 */
> +			length_us =3D h->effects[req->effect_id].length_us;
> +			if (length_us) {
> +				schedule_delayed_work(&h->play_work,
> +						      usecs_to_jiffies(length_us));
> +				rearmed =3D true;
> +			}
> +		}
> +	} else {
> +		haptics_stop_locked(h, false);
> +	}

[Severity: Medium]
Will this unconditionally stop the active effect even if the stop request
was for a different effect?

Since the ff-core tracks multiple effects, an application might send a stop
command for an inactive effect. The else block here does not verify if
req->effect_id matches h->active_effect_id before terminating the hardware
playback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-spmi-=
haptics-v3-0-c931bb7cb94f@oss.qualcomm.com?part=3D3
