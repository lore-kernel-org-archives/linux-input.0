Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095083921D1
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654825; cv=none; b=NI9FSkqVUSc9sGVybx56uFjK7wn45yEP6MDrbKMeUWCnVJg6Ic5kwFdoBcFaA8xnXC5ld6O4FxHWz4r3HEZCHPBDHLKrD0UUBcoYaxPyzxm+JcwrmL88ZiEGC3mnWg064dEuGAGjBfMbCImmX/sH6V2Y5vIrGDZZ2CCiijxZghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654825; c=relaxed/simple;
	bh=O5s1gXP/zLZZQ9o05gU6wQsJ8lxQ3Kxsd7tbea/zxJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HifmgwfxIeK45AQSiINcBg0uSzfG/78XBO/+16GshkdPic0pUXoPs/IA+W82SEjaSu5llL9zl5mU9RWfK+Kk0gAJVJNHFDHualiX159z5RaHAtqK6bWX9ejOvC12yP9iBqPEmlW4s1/sfKdisIk0UtMhOBNlmPyDJaEGqyiWvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cykx8H2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cykx8H2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F151F000E9;
	Tue, 25 Aug 2026 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654823;
	bh=kTTJTwHNrTpB/Drm6XyA63ztpHUoF0Z2XTpPX1jVs3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cykx8H2XkqqP9uLXpbb44YZm8LaQv2ONcs1TOw4VBn1ipsSJQ093wgs7nX5hch++7
	 +bQ5aoGZSpm768UKYnv0PqbCQsBOFmqUDMLNAMBMgTYCBLhEZnKlyN2230lu50kbtC
	 n35UfE7qmrTO3QX7Fm+VQwbWkG4D8VMtgJ5drRaizxRSbcaVzrA4SpRt8mvIzMJNzI
	 UjoZiDTjMpNLkRZU+i/Pkgh1g3IR1xwJtpt66tMNVkHCzkv63DdpEVr/XYIZE+4zkT
	 07n8kfOb42h9pRxHblSij3o7uM2QtVbsDifwTxM3nrNWb5zo82sWfUCRo8ljE65rKZ
	 ZaxNAftKYeEfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: rmi: fix use-after-free of struct rmi_data via
 reset_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825103144.12356-1-98lawweijie@gmail.com>
References: <20260825103144.12356-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:47:02 +0000
Message-Id: <20260825104703.60F151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in `rmi_hid_read_block()` due to unvalidated de=
vice input.
- [High] Global state contamination in `rmi_probe()` affecting subsequently=
 probed devices.
--

--- Patch [1]: [PATCH v2] HID: rmi: fix use-after-free of struct rmi_data v=
ia reset_work ---
commit 9830b0c9b8478c73372950d4bfd3441d196438f1
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix use-after-free of struct rmi_data via reset_work

This patch resolves a use-after-free vulnerability involving struct rmi_data
and its reset_work. It unconditionally cancels the work in rmi_remove() and
prevents new work from being queued inappropriately during device removal.

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 2bd781f1e0f53..4df6d8cd2dc3c 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c

[ ... ]

drivers/hid/hid-rmi.c:rmi_hid_read_block() {
    ...
			read_input_count =3D data->readReport[1];
			memcpy(buf + bytes_read, &data->readReport[2],
				min(read_input_count, bytes_needed));
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but can this code cause an
out-of-bounds read?

A malicious device could advertise a small input_report_size via its HID
descriptor but send an input report with a large length field in data[1].

Because rmi_hid_read_block() uses this untrusted data->readReport[1] as
read_input_count, could it bypass boundary checks against the buffer's
actual allocated size during the memcpy?


drivers/hid/hid-rmi.c:rmi_probe() {
    ...
	if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
		rmi_hid_pdata.gpio_data.disable =3D true;

	data->xport.dev =3D hdev->dev.parent;
	data->xport.pdata =3D rmi_hid_pdata;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code modify the
global static rmi_hid_pdata struct instead of a device-specific local copy?

If a device with the RMI_DEVICE_HAS_PHYS_BUTTONS flag is probed, it sets
gpio_data.disable =3D true on the global struct.

If a different RMI device without this flag is subsequently probed on the
same system, could it incorrectly inherit the disabled GPIO state from this
contaminated global template?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103144.1235=
6-1-98lawweijie@gmail.com?part=3D1
