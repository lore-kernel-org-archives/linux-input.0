Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13DC3A8723
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041583; cv=none; b=Yj4XMsAMrhNLjBs2/XNwU5I7h8igVcSSIK3Mg/skBvdp2ogw6iF67BJlayimJo6QCyLilWHpIW5kws3jfgdCJ3v74q/1QkD8zV2x9JE6CvklgvyDUmCORIK2wkcadSgm4eEAJL6ub3r7t6O1uQpdXqhcO8MrGCXMu3U672G6OXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041583; c=relaxed/simple;
	bh=o6MOTcuPfSqWVtUdyxzAzXzkuZ1I06cvx6qhyPax08g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGY4uk/ZaxPzYZbl0ciZBgBT8+FEyR4RbRS4adl4V51/Wteyac0UkCk/9VGQoJdjT88bP9pdt8Mu0UHTL/Zx0qZB9nahyYLjOm6lJUsRpjWWLmOYFMfa6XNtJu1wxEIMEPyv34SyVoq8HOhbmI756L0dM+0uXEFXb5ufbmjMUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbATVBmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbATVBmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE61F00893;
	Fri, 29 May 2026 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780041581;
	bh=xeG1Y19VnQEWWghl6vhiZ7K/c/xQQmhBsVLILTPMcas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbATVBmzRl462kYQPEXSp9xW+yjAIRRvDYNvwKqST1dbiD7TdX4zy4v9BDt5ysk/W
	 qVe+72Aht3cuHIjH56pqwZ3PKTVFIfR7/8naBWzIgikFktrE9gXSGkd8VqgYPycCSu
	 6DD/FKLw+l690UPDo17jAsDt6o5GTnT0GshGwS9u2aW+agKkIM1b7tiYXOLbE6wTT0
	 X2ew54IP5zaTi3JMX1RxG8knF7Ro2UnZ27L1AwpckcXaP4wJVkaAD7lrSmvk5fJUnd
	 Op/S649gBarDJIE2m05e7QCvI2eJ6uf2Q0EFZlOfmNg7ESRIz89CxMbJVEvS4GyJNB
	 Pyt0dWPPEC5Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260529072111.7565-2-derekjohn.clark@gmail.com>
References: <20260529072111.7565-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 07:59:40 +0000
Message-Id: <20260529075941.60FE61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Mixing `goto`-based error handling with scope-based cleanup (`__fr=
ee`/`guard`).
- [High] TOCTOU race condition causing lost device configuration updates.
--

commit 5c893bbc0296560ff4fc46c1a17db05f45daeaf6
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration HID driver for the MSI Claw series of
handheld PCs. It introduces sysfs attributes to change the gamepad mode,
M-key behavior, and perform a device reset.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{
> +	unsigned char *dmabuf __free(kfree) =3D NULL;
> +	u8 header[] =3D { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
[ ... ]
> +	guard(mutex)(&drvdata->cfg_mutex);
> +	if (timeout) {
[ ... ]
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		goto err_clear_state;

[Severity: High]
Is it intended to mix goto-based error handling with scope-based cleanup
in this function?

The cleanup subsystem guidelines mention that functions should either
convert all resources that need cleanup to scope-based cleanup, or convert
none of them. Using guard and __free alongside a goto label can create
confusing ownership and lock lifetime semantics.=20

Could this be converted entirely to scope-based cleanup?

> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret)
> +		goto err_clear_state;
[ ... ]
> +err_clear_state:
> +	if (timeout) {
> +		guard(spinlock_irqsave)(&drvdata->cmd_lock);
> +		drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
> +		drvdata->waiting_for_ack =3D false;
> +	}
> +
> +	return ret;
> +}
[ ... ]
> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
> +{
[ ... ]
> +	data[0] =3D ret;
> +	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
> +		data[1] =3D drvdata->mkeys_function;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data=
, ARRAY_SIZE(data), 0);

[Severity: High]
Does this sequence introduce a time-of-check to time-of-use race condition?

The current state of mkeys_function is read while holding mode_lock, but the
lock is released before claw_hw_output_report() acquires cfg_mutex. If two
threads concurrently write to gamepad_mode and mkeys_function, both could
read the other's state before either acquires cfg_mutex.

This could result in the second thread sending a command that uses stale
data, silently reverting the first thread's update when the device
acknowledges the command.=20

Should the read of the current state and the device update be atomic under
a single lock?

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
[ ... ]
> +static ssize_t mkeys_function_store(struct device *dev, struct device_at=
tribute *attr,
> +				    const char *buf, size_t count)
> +{
[ ... ]
> +	scoped_guard(spinlock_irqsave, &drvdata->mode_lock)
> +		data[0] =3D drvdata->gamepad_mode;
> +	data[1] =3D ret;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data=
, ARRAY_SIZE(data), 0);

[Severity: High]
A similar sequence happens here. Can concurrent writes to these attributes
lead to lost device configuration updates due to the locks being acquired a=
nd
released separately?

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529072111.7565=
-1-derekjohn.clark@gmail.com?part=3D1
