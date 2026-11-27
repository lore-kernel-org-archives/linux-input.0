Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800672;
	b=GV0PsHOeE2RbVRwjpYrst0vUD797iqPZlGORlkJNdGNnSbmAXYTRgclG0+s79Fy7RpxC
	 C3Tspc/PVPZcayjBryQei/KqSyJNLS3wArase1jloWQftEFmonlW0IC7izwyPaCyEANC/
	 kZlhVO52AaeL9uNwGGr51OTCsu2HN+A8xNzRwtHVPrhC0h0sSwOfwOfo+5Do5nCPrdR/A
	 z6Seihg2dKT1grN29rFOZI/KbInL5JjnM/PmqAn5sEztv7Aui6P36RQZTJb72SbHqsuoF
	 aSH1U8mGGYxNtj8RYhGsZcAKKue2FUUaUQiFnF2jGeUXHwOWV5Kx/DsieBDg1KqENxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DfgIzvgAZceALvNk1HQBFcXybDgpUlwOPXdHXsmG5yU=;
	b=lN+505C254GZxrWKELnTmv0xMrkIIt9vc3jZBKi1wpmR8x7d2U+hzNJtgNyFOY4dxn30
	 hdRuYA2ihnqhQ5eCbTF8rUBCgvBlAQVLMLtvUwBEuMkfkGhsIMLo6qysfYFAxB84a8Zqm
	 6ENueYp2R/ISPRCP68GF2//NdzPl7iRsIEY7KyrYNYewG0OHguJhg7xQFK7lEUAPf52fK
	 YlUpCIyKK6ZE8nVGU4UL98C22SDaY8Ei29riV0PvNuLRl4qUEn9gO84kcqQmq8jrfR3k/
	 DlccNzt1DonNY2YOGbuI9safNqWjWy8GVTj6CEvAcw2HvZdgdjNFBsLdRgceZIp7/oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbZsHkBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322D606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbZsHkBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36801F00897;
	Fri, 27 Nov 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800672;
	bh=DfgIzvgAZceALvNk1HQBFcXybDgpUlwOPXdHXsmG5yU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RbZsHkBAWzb6o/Dl5+C1JG4Wf9LXd4VayQMhg1mI8q0evXwUecKuq7KQkUtCRH6Nu
	 /5u6ogm/AsYzn48kFTWcSw57XRxZ6gPMUrZZZd+2KWsO3e6eV7PtUgwL8n/lptGJU4
	 tazh3Ajb5QXU+WSoverL1KcdfOza6QOdIOtEYeUHv9t3RS793loL1nvXh1OnZfFtaI
	 4lOV0TbugbF74jaIixpMrGuXvDHRmlr3Uo9slMZZh2oTw6TzFMLdLTXSrgxIGn2hOG
	 uuyBjsdgxotWrxR4QPHMbII8/tsc9IZotplmYddykTPQfOULK2ghqi5+YWzMVweKj+
	 B2qndiGjUwikw==
Message-ID: <sashiko-outbox-237993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] HID: wacom: Stop HID hardware before releasing
 resources on mode change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261127170712.3163443-9-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
 <20261127170712.3163443-9-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:31:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: wacom: hid_hw_stop() without driver_input_lock in
  wacom_mode_change_work()
--

commit 8829d08a1079cac40d2eeee82adefcbf5c67e3e6
Author: Lee Jones <lee@kernel.org>

HID: wacom: Stop HID hardware before releasing resources on mode change

This commit moves hid_hw_stop() ahead of wacom_release_resources() for
both the pen and touch interfaces in wacom_mode_change_work().

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2d2a4d56a8da7..121bead90147c 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2887,16 +2887,16 @@ static void wacom_mode_change_work(struct work_st=
ruct *work)
> =20
>  	if (pen) {
>  		wacom1 =3D hid_get_drvdata(pen);
> -		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);
> +		wacom_release_resources(wacom1);
>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}
> =20
>  	if (touch) {
>  		wacom2 =3D hid_get_drvdata(touch);
> -		wacom_release_resources(wacom2);
>  		hid_hw_stop(wacom2->hdev);
> +		wacom_release_resources(wacom2);
>  		wacom2->wacom_wac.has_mode_change =3D true;
>  		wacom2->wacom_wac.is_direct_mode =3D is_direct;
>  	}

[Severity: High]
Can calling hid_hw_stop() before wacom_release_resources() without holding
hdev->driver_input_lock cause a use-after-free on hdev->hidraw?

wacom_probe() does not call hid_device_io_start(), so hdev->io_started
remains false and hid_device_probe() releases hdev->driver_input_lock when
probe finishes.  When an input device is open in userspace, wacom_open()
calls hid_hw_open(), starting the low-level transport (such as
usbhid->urbin).

Previously, wacom_release_resources() unregistered the input devices
first, invoking wacom_close() -> hid_hw_close() to stop the transport
before hid_hw_stop() ran (when /dev/hidrawX was not open).  Now
hid_hw_stop() runs while the input devices are still open and delivering
reports:

drivers/hid/hid-core.c:hid_hw_stop() {
	if (hdev->io_started)
		hid_device_io_stop(hdev);
	hid_disconnect(hdev);
	hdev->ll_driver->stop(hdev);
}

Because hdev->io_started is false, hid_hw_stop() skips
hid_device_io_stop() (which would acquire driver_input_lock) and calls
hid_disconnect() before ll_driver->stop() kills active URBs.  If
/dev/hidrawX is not open (hidraw->open =3D=3D 0), hidraw_disconnect() ->
drop_ref() frees hdev->hidraw before hdev->claimed is cleared:

CPU0 (kworker)                    CPU1 (softirq)
wacom_mode_change_work()
  hid_hw_stop(hdev)
    hid_disconnect(hdev)
      hidraw_disconnect(hdev)
        drop_ref(hidraw, 1)
          kfree(hidraw)
                                  hid_input_report()
                                    down_trylock(&hdev->driver_input_lock)
                                    __hid_input_report()
                                      hid_report_raw_event()
                                        /* hdev->claimed & HID_CLAIMED_HIDR=
AW */
                                        hidraw_report_event()
                                          dev =3D hdev->hidraw;
                                          spin_lock_irqsave(&dev->list_lock)
                                          <-- use-after-free
      hdev->claimed =3D 0;
    hdev->ll_driver->stop(hdev)

Acquiring hdev->driver_input_lock around the teardown and re-registration
(or calling hid_device_io_stop() before hid_hw_stop()) would serialize
against concurrent hid_input_report() calls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127170712.3163=
443-1-lee@kernel.org?part=3D8
