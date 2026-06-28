Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D940D579
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782609286; cv=none; b=M/pHnRsJHtv84gXn5fQA/jqxAi1ZH6RHaVN6Hau4MNXJ8SN0tYZismqtVbmLzX6lwS6hKlRNVpxefPz88uHJwpxFWsi4usPp+OpMqY1JQTqmXbLr/DXKeExrbeLBDKLJTBkz4A74G+bQ/QczvL0iL8wayLjoD5r+FNhB8vxNEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782609286; c=relaxed/simple;
	bh=AfraEgTt6c2qHWOqJlCwFIA9Z7WBdlzwEbLr9maPR6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EeBWdCtq9c17NSwavq/KNGlvuS5NsZPGePoQmS3kX63HSn5xN7AT+UAznu/zH1HLcpxpN4hTdCJ9fkaRgvX19v9WGKAH/CL+euNMqvQMwU+ZDHUTC5kPdWYwklWO7f17MlbPO3G0lNUf4lmSAu9RPmq1ujO8emY/d6yInsaF5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB3i16D4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB3i16D4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61B11F000E9;
	Sun, 28 Jun 2026 01:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782609284;
	bh=lWRXP1vjkZQURX0GWpKzCx0FJmTb55KnadFS39Pv6Wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AB3i16D4SL2zqOstPVUNyEortr05ojJmEhVqSSJM/ts4BK8j+BtTtzfd5Zw0V+Lq/
	 d0GIRN3osRKzq/IXSXy7ZwX50CUdXO4yyPNBwAleYQDr+rt7WpXu5JD3B4ji6yesXe
	 JIrYo+nPR4rCuCyqq8Y7zdA07D31rWNjkDmhLny/g/aqe7MtPRxg4JEfCSXxpfTxTh
	 dMwTgOtc9nRyh3NHjE7nyD/3P6qDpe8Jwd0OD4LTRXKdbvX53j4BtB9ZRq7c+Fm03B
	 M+JErpKkVMVFQIPahPCEVqW/v6QtiO3w7LL6wsG73gkPbBcy7Kzz5jbK8IQEyI1Fjy
	 CWPxKonbjp2tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: synchronize input before cleaning up a failed
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628005846.31248-1-alhouseenyousef@gmail.com>
References: <20260628005846.31248-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 01:14:44 +0000
Message-Id: <20260628011444.A61B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in hidraw_report_event() due to drivers calling hid=
_hw_stop() before hid_device_io_stop() on probe error paths.
--

commit 6c338032433c7e95cf76d26b6790e7b5f487a9b4
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: synchronize input before cleaning up a failed probe
   =20
hid_device_io_start() allows reports to run concurrently with probe. If
the probe subsequently fails, __hid_device_probe() releases driver
resources and clears hdev->driver without first excluding those report
callbacks.

Closes: https://syzkaller.appspot.com/bug?extid=3D9eebf5f6544c5e873858

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 41a79e43c82b3..469b849b7a2a4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2835,6 +2835,8 @@ static int __hid_device_probe(struct hid_device *hd=
ev, struct hid_driver *hdrv)
>  	 */
> =20
>  	if (ret) {
> +		if (hdev->io_started)
> +			hid_device_io_stop(hdev);

[Severity: High]
This is a pre-existing issue, but does this fix cover all the cases where t=
he
use-after-free can occur?

If drivers call hid_hw_stop(hdev) in their own probe error paths before
returning an error, they might bypass the core's new hid_device_io_stop()
cleanup.

hid_hw_stop() unconditionally calls hid_disconnect(), which frees the hidraw
object. If HID_QUIRK_ALWAYS_POLL is set (or for Bluetooth devices), polling
continues, and a concurrent report could enter hidraw_report_event() with a
dangling pointer before driver_input_lock is taken.

For example, this pattern appears in nintendo_hid_probe():

drivers/hid/hid-nintendo.c:nintendo_hid_probe() {
    ...
err_close:
	hid_hw_close(hdev);
err_stop:
	hid_hw_stop(hdev);
    ...
}

And similarly in corsairpsu_probe():

drivers/hwmon/corsair-psu.c:corsairpsu_probe() {
    ...
fail_and_close:
	hid_hw_close(hdev);
fail_and_stop:
	hid_hw_stop(hdev);
    ...
}

Could these drivers also trigger the use-after-free by tearing down the
hardware and freeing hidraw while IO is still started and driver_input_lock
is unheld?

>  		devres_release_group(&hdev->dev, hdev->devres_group_id);
>  		hid_close_report(hdev);
>  		hdev->driver =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628005846.3124=
8-1-alhouseenyousef@gmail.com?part=3D1
