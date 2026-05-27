Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944638A706
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922612; cv=none; b=EVSMmxMcdcOxIAomm+zRZsorpDOgWcC+BklVZVG/x+wv/L43oLvKpPX88TG4i39q96idAqnoBsblyCdnOWneJgIwu8VS2iJt4XNgek+126ieJnOwvnISIjA0N0xP4EUD2dKba5/Asx0dDMvKTJvbW9o2VUc0HwgACP/xQjEuVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922612; c=relaxed/simple;
	bh=5qBI3OHU4raM6fqlPk9i5dyxNcg6NyJWJfbpG1KEuko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=msaHHJWmc4e6GvTP9Adh/4AbugT43vCOglXlGteQQp4K1XEh44ZkLJG3u4tBDkcLqbNcGuadzzmPLZnBUsYZOo4Kz11cEu+4PjOeS0yPbdGHbTgRbShxyoCSKp0h6KuWvPpSJceMtDGJfiZ8wFv41rfJnFKMib8SAVUjbyLIouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST4baBqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST4baBqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9AF1F000E9;
	Wed, 27 May 2026 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779922611;
	bh=X4+SzCLaP9c8Z4Ss9rDy02XiI6N9JKZElMCGhYDpz64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ST4baBqHPTng88NFsez/bEhrQy0xpmrEx2wS78cmeIOZmfQjTv126tQBnPi1IgVAW
	 TMbYfwvk2LCW0FOz+xejw+QmKXneTnF9fNJ12N1Z+puYCH8l7G+A2stuiPjPoTsOaQ
	 93akvTqFhgogTnj5bmZ663yzrqmERFPEwAIfi4GIYpQDwQHnYrfTw1GpvyDyN3bIN+
	 T1SYCTMi0/K87K1AfR/hWncTXh3Ucn+fStvtXqpvdoBvN3J6ZSlsyk1jy+oQV5uOFV
	 0fxKYmrO4oEConirjESIaRlNM7aVGWfhbXno02YeFf84i4vqYOCpVKv0NpX3e9Wn4V
	 YsHEMEGDUA1tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260527222122.10620-2-derekjohn.clark@gmail.com>
References: <20260527222122.10620-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 22:56:50 +0000
Message-Id: <20260527225651.3C9AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing `goto`-based error handling with scope-based cleanup (`__=
free()` and `guard()`) in the same function.
--

commit 99c97f725ca1423e8aa76228aadfc2b109079d67
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration HID driver for the MSI Claw series of
handheld PCs. It provides attributes for changing the gamepad mode, M-key
behavior, and resetting the device, using a bypass for completion handling
to handle expected USB disconnects.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..3a176f44f2c43
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{
> +	unsigned char *dmabuf __free(kfree) =3D NULL;
> +	u8 header[] =3D { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	size_t header_size =3D ARRAY_SIZE(header);
> +	int ret;
> +
> +	if (header_size + len > CLAW_PACKET_SIZE)
> +		return -EINVAL;
> +
> +	/* We can't use a devm_alloc reusable buffer without side effects durin=
g suspend */
> +	dmabuf =3D kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	memcpy(dmabuf, header, header_size);
> +	if (data && len)
> +		memcpy(dmabuf + header_size, data, len);
> +
> +	guard(mutex)(&drvdata->cfg_mutex);
> +	if (timeout) {
> +		reinit_completion(&drvdata->send_cmd_complete);
> +		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
> +			drvdata->waiting_cmd =3D index;
> +			drvdata->waiting_for_ack =3D true;
> +			drvdata->cmd_status =3D -ETIMEDOUT;
> +		}
> +	}
> +
> +	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
> +		CLAW_PACKET_SIZE, dmabuf);
> +
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		goto err_clear_state;
> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret)
> +		goto err_clear_state;
> +
> +	if (timeout) {
> +		ret =3D wait_for_completion_interruptible_timeout(&drvdata->send_cmd_c=
omplete,
> +								msecs_to_jiffies(timeout));
> +
> +		dev_dbg(&hdev->dev, "Remaining timeout: %u\n", ret);
> +		ret =3D ret > 0 ? drvdata->cmd_status : ret ?: -EBUSY;
> +	}
> +
> +err_clear_state:

[Severity: Medium]
Is it intentional to mix goto-based error handling with scope-based cleanup
helpers in the same function?

This function uses __free(kfree) for dmabuf and guard(mutex) for the
cfg_mutex, but also uses a goto err_clear_state label for error handling.

The kernel cleanup subsystem guidelines recommend that usage of goto and
cleanup helpers never be mixed in the same function to avoid confusing
ownership semantics.

> +	if (timeout) {
> +		guard(spinlock_irqsave)(&drvdata->cmd_lock);
> +		drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
> +		drvdata->waiting_for_ack =3D false;
> +	}
> +
> +	return ret;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527222122.1062=
0-1-derekjohn.clark@gmail.com?part=3D1
