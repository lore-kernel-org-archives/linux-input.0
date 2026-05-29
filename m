Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C15DF59
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048398; cv=none; b=tHSh73mLv6QJtQXz508e/JA07rK6D07tgKuOpg5cTF23Rt9NxaMijtzIoWA+ZEOOpWC1YucIIEDRO7GiXv7yl8AtLEARsy3wMMZSiIt3qfp+VnXYGcI4wOmfZyZWpFRUbZEZx8fQGLdz5NgLryCoTqzw8QV4CTQp0+CB/IL/QQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048398; c=relaxed/simple;
	bh=4H4N86cEy/QyRc6iuNK7Q3ikK8aQBNEc9BlQybvOJuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8s+o4bv6m8N5aaZKMIDjvl+ZTptdnpl4vGb5IqOZc/u2WGb2+T7rjF52qAMSNrPAaugi6KhIkTuVnTA33jVEBkpf0lQ9nLuF0v/Z09LtGoyr69Hj0N82zg1htHYYsc24/SIatzEF65vEyrNccEVcSn36yn7APc8/ky58O63R+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT8maUfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT8maUfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BF1F00893;
	Fri, 29 May 2026 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780048397;
	bh=sdgq7UaB6iP4A5CZSXIx9AzNO7vHvdCQRbPQbBGY4jA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oT8maUfU4uviGQOISZhKt4IfksmTy3oaRTmChxXQOygj7x3aOh9liRuepu1O3296c
	 irnjeQ0E7gvT5WG9e7BeIFluFhJZWrqPYoiBKObfEVg/U0PcJjQ3YuKBNcAbIgj/ul
	 3+ZqgT47AHqUWP2AXjuoLkJGuQGspWw9YQms75FtZGA1gsT8go5MZx9wgnMIvJmws3
	 gypFdYaLxXA+i/tYZX557e1u+NfLi2HH7YQrPcohstxh2vy5P+COK3Tzh2X/CZh8T+
	 lF8cwmaHzdavDBoaaDTZKDF2c4F2420CDDOjHcjPnX78voM6Lnsus+nAD3BnU+8FXQ
	 PsANRGXnAmDKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260529072111.7565-5-derekjohn.clark@gmail.com>
References: <20260529072111.7565-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:53:16 +0000
Message-Id: <20260529095317.5B3BF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unwaited ACKs from SYNC_TO_ROM commands can prematurely complete t=
he waits of subsequent unrelated commands.
--

commit 11fcab6387a146514df018948771932cc7f57ed2
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

This commit adds intensity adjustment attributes for the left and right
rumble motors on MSI Claw devices.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 96710d80543d4..f5c54cd62f3bb 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -930,6 +962,162 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
[ ... ]
> +static ssize_t rumble_intensity_left_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
[ ... ]
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DAT=
A,
> +				    (u8 *)&report, sizeof(report), 25);
> +	if (ret)
> +		return ret;
> +
> +	/* MCU will not send ACK until the USB transaction completes. ACK is se=
nt
> +	 * immediately after and will hit the stale state machine, before the n=
ext
> +	 * command re-arms the state machine. Timeout 0 ensures no deadlock wai=
ting
> +	 * for ACK that ill never come.
> +	 */
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL=
, 0, 0);

[Severity: High]
This is a pre-existing issue, but this patch propagates it to the new rumble
attributes.

If a SYNC_TO_ROM command is sent with a timeout of 0, the driver does not
wait for the hardware's ACK, but the hardware still sends a generic ACK
packet for it.

If userspace rapidly writes to multiple sysfs attributes (for example,
rumble_intensity_left then rumble_intensity_right), the second write will
send a WRITE_PROFILE_DATA command and wait for its ACK. Can the stray ACK
from the first SYNC_TO_ROM command arrive during this wait window?

Since the generic ACK doesn't indicate which command it belongs to, would
this cause the driver to falsely assume the WRITE_PROFILE_DATA command has
completed and prematurely wake the waiter? This could cause the driver to
send the next command while the hardware is still processing the previous
one, leading to dropped commands and device state desynchronization.

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529072111.7565=
-1-derekjohn.clark@gmail.com?part=3D4
