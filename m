Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192347263B
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518240; cv=none; b=QKkh1BKAvuH83DnW18VJ3+3r7BUsW1w0uaVT5wGxYcYhzXkzQhLxhJe9KdnUBHQ6hBCOPVmf9BNOZyJiMMwkmFwFZ3yUO22dgkvNb2/mc4zyIhjmcfEssTL5wqC4tAVhiWc0O6fobqhkPPI7/xtSQwv+vpovSEPLixx+jZFlaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518240; c=relaxed/simple;
	bh=nm0Y76Kf1UYPA3K4iYmIONDTgt4UvatvqyyDmlWMpIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=toXDYDQuBKqiULgM3cwZDt+V0hNPbaGF95NyqFCyLYzD8pnsUiUJs9I36bd+Z+R8+HoipdOrsLkPr8Ol/QuhkUkGaY5N70hbajTjlnDVUCzAFgOFpoRwI+q0ilNN8vdZ5xyemXtpUBaGjyoq3gwfK4q2DXg5WVkuTzRu77pW1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAfrwaK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAfrwaK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E001F000E9;
	Mon, 20 Jul 2026 03:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784518238;
	bh=/2kRev/9C2CrFX60FTwYXPyOe5T8MBk8gXmoSsSRCTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAfrwaK4LsGTz4g8oJVzbmHyHbIKLusQSKfRJoKIpgUQz073MCb4bfhOsR2E8ev18
	 GATVP0hrmBR4b6Sbh8HGbFaXsyqiqoIf7qSZMygJ0X3cFDd2SkUoBzWeJ8F/JBWnRj
	 6ltNYo26k31uM+U1EvRWSCloK31+8dLY2vGnGo0HFdbf1Gl2nA811AkO06bvP4Ue60
	 bbct7cdkz1RrHEuRxo4TcpJmcLpT2RrZbTQl9Z4130r1YlCxMxcitU3r+iLptP6Lut
	 gTC/YsGIIMxyxQGkvSGLb8Ny+WJkX63jwGb0j8kLhx8QiaQZeCFG5VN2SiQiSKgQvY
	 ayAcquH5U9dkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720031549.2272658-5-derekjohn.clark@gmail.com>
References: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
 <20260720031549.2272658-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:30:38 +0000
Message-Id: <20260720033038.76E001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `__claw_hw_output_report` violates the cleanup subsyst=
em rules by mixing `goto`-based error handling with scope-based cleanup (`_=
_free(kfree)`).
--

--- Patch [4]: [PATCH v13 4/4] HID: hid-msi: Add Rumble Intensity Attribute=
s ---
commit 9f513aab0b37d6357132f5ca7a76ad690510bbc7
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

This commit adds intensity adjustment attributes for the left and right rum=
ble
motors on the MSI Claw device. It introduces sysfs store and show functions
to read and write rumble profile data to the hardware.

Link: https://patch.msgid.link/20260529072111.7565-5-derekjohn.clark@gmail.=
com

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 5cb85fc2f0534..3225d3bf61254 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -991,6 +1023,162 @@ static ssize_t button_mapping_options_show(struct =
device *dev,
>  }
>  static DEVICE_ATTR_RO(button_mapping_options);
> =20
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

[Severity: Low]
Does __claw_hw_output_report() mix goto-based error handling with scope-bas=
ed
cleanup?

Looking at __claw_hw_output_report(), which is called via
claw_hw_output_report() here:

	unsigned char *dmabuf __free(kfree) =3D NULL;
...
	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
	if (ret < 0)
		goto err;
...
err:
	scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
		drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
		drvdata->orphan_ack_pending =3D false;
	}
	return ret;

The cleanup subsystem guidelines in include/linux/cleanup.h state that the
expectation is to never mix "goto" and cleanup helpers in the same function.

Is it possible to convert the error path to use scope-based cleanup entirel=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720031549.2272=
658-1-derekjohn.clark@gmail.com?part=3D4
