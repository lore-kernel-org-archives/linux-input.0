Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B426ED3E
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676634; cv=none; b=VZisP94QQ3vlZA+uYNwrjMepBZyFdT4tRTndZdUs1vBJEB1MURh880PPu5604MxBwVBYERsOhKtPCA4SuJ3U2n5g0TIysGYzBm4iU71HUzhPL3G1t8jp3Nz0JOP+Ld0tG1+0LEgchAS76MOwQ5nopX5ngaeu0cQBJCg8xoskveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676634; c=relaxed/simple;
	bh=aGIe5xmoZYdZYx1dyf/rJ4a1+uquWAuHD+CAiCC5+HE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TsiDyaeON7dDod/dCNmNJ1GEg5eWFw8nXFV0Nyx5U3ouAYk5aylEF4B4yHVTrO1MS9FC5iARbLDhEVkY0FIEYHx+ofLRcXbv9p2hObqLyOU9F3B04vPyP7rHjbyCbVhGYLTaqQinfnyZQh7MbJqeIvdVCet96DqaKAX+lrwXHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbLSSiXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbLSSiXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C131F000E9;
	Mon, 25 May 2026 02:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779676633;
	bh=ZEfsCqKXpFj/epjnTrwN0xwHYcZlx5E2DRhHgpGXJd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbLSSiXLsivjIP6sI/zZanJx/lrbCaaULgm0zM7X6Mfv7brDPizmEhd/sAVbIyzw7
	 R2wnxG6vbPHcccu78/b7aQ0u/0+O++2rZ/vtXNlmiREiVXbvlsIimdCK6KRSxiUo6G
	 3y2nrK7BuStvra5Yzp5re82aSm8/GWScDVeDyUJmq2qUM/cDA9xHvKd+MgZ5PrlAHk
	 8P+OQxzM2VqOskHVKLTwJK8BG/PzbQ4FSLOEgpG3tXKCubIEiVdsvE3/xktAWWp1be
	 9OKnK8Rv09MUwdNPrHp3SyChQ9HlFwdAGAyFX2JOnl5hoUSciYyD4FBnA7yF7QVauI
	 +IT1pgywQu6Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260525020543.519082-2-derekjohn.clark@gmail.com>
References: <20260525020543.519082-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 02:37:12 +0000
Message-Id: <20260525023712.E1C131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing goto-based error handling with scope-based cleanups (__fr=
ee, guard) in claw_hw_output_report.
--

commit 279964e3a8cf0a3835903d6bad7357f0ca42f523
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration HID driver for the MSI Claw series of
handheld PCs. It introduces the initial driver outline and attributes for
changing gamepad mode, M-key behavior, and resetting the device. It also
adds a completion bypass when the timeout is 0 to handle USB disconnects
gracefully.

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

[ ... ]

> +	guard(mutex)(&drvdata->cfg_mutex);

[ ... ]

> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		goto err_clear_state;

[Severity: Medium]
Is it intended to mix scope-based cleanups with goto statements in this
function? The subsystem guidelines recommend either converting all resources
that need a goto cleanup to scope-based cleanups, or converting none of the=
m.
Mixing __free() and guard() declarations with goto-based error handling in =
the
same function can create confusing ownership semantics.

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
> +	if (timeout) {
> +		guard(spinlock_irqsave)(&drvdata->cmd_lock);
> +		drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
> +		drvdata->waiting_for_ack =3D false;
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525020543.5190=
82-1-derekjohn.clark@gmail.com?part=3D1
