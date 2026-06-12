Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037924E4B5
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275744; cv=none; b=n1uZmt7S7i9VZ+1APkRGwr210Z4RLOIFzwfNQk68B1qlylT/+nfiA2AxuelKUvNMXN7u/RWdj7LS+Iht9wftSh0HL7oN4g1KWJLLIA84PJ9/hB9PCEr7HCb5QaE9vxd3xsh5wDXmUcYC9RZ8JQpGEpzUaS9AyvtTvdv1BrWXdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275744; c=relaxed/simple;
	bh=QUAmSPJU7cHua7UlMWiPIRMzt7N685Vqxb93CgQVgdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeS+3kL4HoePY90VgJuqI67jIzOwgYT0Ios2bYoi0uv+Si66zRx7nf2pMoxpTZjEkFbJvMw/muRGRQm6wxCc9EGPnVxSSQLZgvtjlCo4b/jA7bLZ7b9DEu5f++mFM1J3OA4GBzX1GY8zo8IZaxVrVoK3CuX3bSxd/4dSIfmbWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AeMTxDzB; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AeMTxDzB"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 7E592BD5D2
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:48:55 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 99685BBF39
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:48:54 +0300 (EEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 244871FEFDB
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:48:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781275734;
	bh=bOhwhge0OfIcVNOTSaOmXKoYHaUY4sYvpcBrN+XLVIk=;
	h=Received:From:Subject:To;
	b=AeMTxDzBhayzxPewsljwuTJRf9fAbYmxS30SF1wc4go2EKSzpdgAflWPt5Mnooiwo
	 8WUaPtldPvAHcFNDEvhI2tQzpeBT0YBJxqH/iWbl5BpLBM2jgIbfPRPA3o4ryxt+kg
	 2Tve+g8Qc8oe3S1Ygrog+3AMyJG9etSt/6ZwT1VQ+k7i0cPfEWx3boaLbpwqWZg98J
	 94C6S3c44st0206xU6/ReFzq7z0DNLi81w2plnz3XZ97h1QQY2rDtP6VF1jXw1TAg/
	 1IkHHeYTg0lMLtnsVA43i9vYQDgUs6RyPyUc03KkqReFIeoiwMgZ+Jaihtvs/PNDMN
	 d0rliHpXXKIgA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f181.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c858961a8efso441824a12.2
        for <linux-input@vger.kernel.org>;
 Fri, 12 Jun 2026 07:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ86PZE4G6nho3w2XH4WmOdTfZruGx2s8mlHCK4UlGdl1Nh+5D7x1iOPOd/LaLOlfNE1b2Yu4bpsiD0Elw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFV+FhCbLrYfM7Z3PBgN2ugBHnkFxg2N47swnGs9uY01foSdOn
	/PyxoPQYiO5XUXWZ2sDBgMqplZVhAdrUHRdVviEp5ZuRkDdePkRIPuYsP952RRvaVMqIWlukIsM
	mLfRsadE7TKVWQ9UIFnCmZ2FSqMJD8pU=
X-Received: by 2002:a05:6a21:6d8f:b0:3b4:8c3a:c336 with SMTP id
 adf61e73a8af0-3b783b62e1fmr3881753637.10.1781275732942; Fri, 12 Jun 2026
 07:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612142326.1704858-1-denis.benato@linux.dev>
 <20260612142326.1704858-3-denis.benato@linux.dev>
In-Reply-To: <20260612142326.1704858-3-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 12 Jun 2026 16:48:42 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHjmwGHsXu2eZ_d5KK5jOhcO-7d6dR6HD0E8Kz2nnY4Mg@mail.gmail.com>
X-Gm-Features: AVVi8Cfxdd-1Fh70j3FG-vJ3fmw1at0n5KUW2Exqa-vlcEb2Rk27Ad6ItTo7YVs
Message-ID: 
 <CAGwozwHjmwGHsXu2eZ_d5KK5jOhcO-7d6dR6HD0E8Kz2nnY4Mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] HID: asus: prevent wrong pointer cast
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178127573432.2760344.16787307053008474099@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 12 Jun 2026 at 16:23, Denis Benato <denis.benato@linux.dev> wrote:
>
> The firmware version check for ROG ally devices assumes the parent device
> is a USB device, therefore prevent possible out-of-bounds access by using
> hid_is_usb() to mitigate possible out-of-bounds access.
>
> Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kernel.org/
>
> Fixes: 56d1b33e644c ("HID: asus: simplify RGB init sequence")

Proper fixes is:
Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")

56d1b33e644c just moved the block.

> Suggested-by: sashiko-bot@kernel.org
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 4d7110b892bd..323dc0b7f3ff 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>                         return ret;
>         }
>
> -       if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +       if (hid_is_usb(hdev) && (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)) {
>                 intf = to_usb_interface(hdev->dev.parent);
>                 udev = interface_to_usbdev(intf);
>                 validate_mcu_fw_version(hdev,
> --
> 2.47.3
>
>

