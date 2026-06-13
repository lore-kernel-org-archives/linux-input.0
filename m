Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BD313534
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781366261; cv=none; b=ovIPj/we9x550x7Bni4hELTRicBF+ulReRBUxVblnDpXKqxOZJhHswbrMwnNJmwfnHdCVosCQwq3c5TgaKPzPtO92tNKMo84NElLNP5QeAuFlFnNe50SPypWS3iiB0b9hMJS4c5ruJhX3GAj0+ZIQikoQ1syN94MHpEvk21nM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781366261; c=relaxed/simple;
	bh=p+33npNpBuyWiyLdtp6wk0VbOL1SrdRyEgtoP0L6cNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/Yr3WtbiWRTbeJnGoO2EEbUQUuBcRiX3Re9Rsct82pi0rPAy1Qrc1nr4D/YebfDgKJMcimrZPS0Mzx76XINDeaLkdy1oFQtsIdt2YLlWRq+cIBVGhsZrcS8f6ufyhkExzX2vDOZrbEDkqaY6w9beC3B1bWL9csYIE2bxhKbWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=P5lnXp6d; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="P5lnXp6d"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 0A1BA4201C
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 18:57:35 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 6733B42021
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 18:57:34 +0300 (EEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A7C421FEFDF
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 18:57:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781366253;
	bh=j++bP6+9AJt3KQtXdrANVMjHGdzHQXZGnBnWFEWygGg=;
	h=Received:From:Subject:To;
	b=P5lnXp6drm8oboKspNY4AHDSaHiHOhMUL3uI/52jr2yN1gtz8BaVXZuCHcGn6VBu8
	 KZ53ELWIWZsQcbjg/sm8nTIGGE+o/lAx3iGRgIkw2GxUs0sl6h6agXtH50PWVuuyrx
	 8yK2By7yF5SEZlKGniJu1IS30AjQJ072aiJoejZ4M1cZbQhBB0ZlE+NLlx9IaamhiO
	 lACSYwV16zi5MGjAXh3GNF9Hz0Y2c3d1MFkD3DN8hO5M4qZF67I0d5ZgQGxnUTzY9K
	 JwydmSUtlO8Tkan+NeQ4qbz4ccoJQu0x4PFy+1nFD5gecTZQ4qBhl8sqnpAJlbPsBG
	 dd/HXQQiBX5bw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2c0c20f0c0aso13892425ad.0
        for <linux-input@vger.kernel.org>;
 Sat, 13 Jun 2026 08:57:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ82vS87/APTIQb0sj76VcrGsihYo1RzNIYr0uSepGGdoBFwGUUGoOKQjBoUYpNZRTi5EoU4jb4X/4IETw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXizaKLcTe9loI5EI016X/+wadOz2kWvMxn4NUULXQF15E2+w
	RT5WO+HszOWdQjLKosj4tyfKLgyrFCDEzbiniLAfmfmwQIoCC0q54Z1ziP/NYmf6KmVsfrgulZo
	o8hR04mM0okFj5srQ+2i8FWG0wgy+B64=
X-Received: by 2002:a17:903:2f04:b0:2c0:bcb3:86f with SMTP id
 d9443c01a7336-2c6641488d3mr47435825ad.6.1781366252099; Sat, 13 Jun 2026
 08:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613153029.2559774-1-denis.benato@linux.dev>
 <20260613153029.2559774-5-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-5-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 13 Jun 2026 17:57:20 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGsDUh_pGjf-NcX6JiYfg8GhbADUcFTFs_E5BsuktdKaA@mail.gmail.com>
X-Gm-Features: AVVi8CdOa2SfWiwmFx7Sa60sO7J2KSZvH70QLDLNU-y8cYWCCuHV7esHByvrRZs
Message-ID: 
 <CAGwozwGsDUh_pGjf-NcX6JiYfg8GhbADUcFTFs_E5BsuktdKaA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] HID: asus: cleanup keyboard listener on failure:
 avoid use-after-free
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>, sahiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178136625386.1211982.10104299561193308261@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 13 Jun 2026 at 17:30, Denis Benato <denis.benato@linux.dev> wrote:
>
> asus_kbd_register_leds(), I noticed it registers a listener to a global list
> and uses devm_kzalloc(). If a subsequent initialization step in asus_probe()
> fails the driver returns without unregistering the listener, and the devres
> subsystem will automatically free the memory, leaving a dangling pointer
> in the global list.
>
> Fixes: b34b5945a769 ("HID: asus: listen to the asus-wmi brightness device instead of creating one")
> Reported-by: sahiko-bot@kernel.org
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 0a6c97155549..f38b18ad65c6 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1426,11 +1426,17 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 if (drvdata->tp) {
>                         ret = asus_start_multitouch(hdev);
>                         if (ret)
> -                               goto err_stop_hw;
> +                               goto err_unregister_backlight;
>                 }

This block currently does two things, rename and init the touchpad.
Instead,  you may pull the touchpad init to be below the hid_hw_start
block and keep the same bail.

>         }
>
>         return 0;
> +err_unregister_backlight:
> +       if (drvdata->kbd_backlight) {
> +               asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
> +               devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> +               drvdata->kbd_backlight = NULL;
> +       }
>  err_stop_hw:

OR add asus_hid_unregister_listener(&drvdata->kbd_backlight->listener) here.

Here, you'd also drop err_unregister_backlight, devm_kfree, and
nulling. The driver is closing. It is not necessary.

err_stop_hw is only used once, you do not need a secondary tag.

>         hid_hw_stop(hdev);
>         return ret;
> --
> 2.47.3
>
>

