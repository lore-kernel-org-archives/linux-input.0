Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C32BEFEB
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781366669; cv=none; b=S7TqiyY3XikF7acm0ThMYYO1+MeId4vIBFHBV3s4Ntfk19SmkAwsM3DpSZV8aEXEf4ngloMvcWxjXs/cTS5HTXBfYRGLFNh//qP3F8D+0biSxvdGqy0p1gS8xfESZwNBjfC6aCTWhWR/m+GPf+TA79F8h6n8R+vYUR+9lkBaQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781366669; c=relaxed/simple;
	bh=unW2J/QnIQ7H2rAyLaFzWE2hcz2YxIeRqflJenvZuQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEmMZ0Qf3xFPh0IprILFXcKR9Uk2P5As1L5/76fmkb/m1QM2DouRvgI+G0cjnXaty6Oqt4HA1WEy7tcTFn56sWuvzH9UwlHFYIM1IxH1K6u05NisEWKFkj0uI+GHqbss89tmCuAhwlb+6UQh+NMK84xJhCKbb75AC0T1XRUN4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FhN0c5Mj; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FhN0c5Mj"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id BB0D0403C1
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 16:04:26 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 494AF403BA
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 16:04:26 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6660B1FEA8D
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 19:04:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781366665;
	bh=ja3aOi8fYHD9ujIWajrymG19Mwn0cxya02lN9TqtQBU=;
	h=Received:From:Subject:To;
	b=FhN0c5MjPyrift4EcFQRHuLWyfPic1j9T15a62qlV+cHs3+PNlQWvtJSghOavcZ1R
	 4dcXssl1vRyPnCmh0v5pVaAZnCAt68GP+iuw48kIdGRlA48e09gjuKnq/K/Fn0dOSK
	 mAsKS5cc0mby9sxFleqdh+lgrOOi17kq9sSGM5wo8x55iKWXKHt/urt5yQbZIiNsgl
	 BQ16GPICx0nItdpFlZf6FJJ+oUYWPKGovYNNgZwHLFAeZ8GvQQtN/GEFTApF6D2jFb
	 0y/2ldUmgrXFll/tTEoINuNUamadMdI8+GkP9fq8d0DT2i57NfdyHDk9nG4m6y9p0y
	 fecDuHmKoIx4g==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.52) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f52.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so1219747a91.1
        for <linux-input@vger.kernel.org>;
 Sat, 13 Jun 2026 09:04:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8Tv9mtIzWFDg3A+dZseSyj3N80GXzWjSK5HkPDc59eiLClxwr5KgvAqxKKAAVPpxLTs37K06rR9EZe9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+Q5etMBGu3EBUIOKaU878DP22TM78rRs6gtM37yC+sNZ5tiG
	gWS9YRTjwZOcz9URG2BzpKJ9rnXUPYyBvoUcAc7W7BT3SxeuQNVGxoixutVAJQ+MFzb8XoS3YhN
	8OeWtnvB2Ie+5bRpbU6MegANnLyaaYBU=
X-Received: by 2002:a17:90b:2547:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-37a03bd0b9cmr8263442a91.21.1781366663972; Sat, 13 Jun 2026
 09:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613153029.2559774-1-denis.benato@linux.dev>
 <20260613153029.2559774-7-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-7-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 13 Jun 2026 18:04:13 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEnUgUji__GdPpwZYJ6phQOKp2kY3v2F=BYDg6ZOG8wvg@mail.gmail.com>
X-Gm-Features: AVVi8CcbT49R-16ChNv48yXRgkg9CdPP4kj6rHV7F5my5Elpm6avTEs4akWNxUk
Message-ID: 
 <CAGwozwEnUgUji__GdPpwZYJ6phQOKp2kY3v2F=BYDg6ZOG8wvg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] HID: asus: prevent a late KEY_FN_ESC to trigger a
 use-after-free
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>, sahiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178136666573.1245244.6745240726466874332@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 13 Jun 2026 at 17:30, Denis Benato <denis.benato@linux.dev> wrote:
>
> A late KEY_FN_ESC event can trigger asus_event() and unconditionally call
> schedule_work() after the work was supposedly canceled.
>
> Once the driver is removed and drvdata is freed by devres, the workqueue
> could execute asus_sync_fn_lock() and dereference the freed drvdata.
>
> Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
> Reported-by: sahiko-bot@kernel.org
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index a6467172c455..a65a28137f0d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -148,6 +148,7 @@ struct asus_drvdata {
>         int battery_stat;
>         bool battery_in_query;
>         unsigned long battery_next_query;
> +       bool fn_lock_sync_work_disabled;
>         struct work_struct fn_lock_sync_work;
>         bool fn_lock;
>  #if IS_REACHABLE(CONFIG_ASUS_WMI)
> @@ -416,7 +417,7 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
>                 case KEY_KBDILLUMTOGGLE:
>                         return !asus_hid_event(ASUS_EV_BRTTOGGLE);
>                 case KEY_FN_ESC:
> -                       if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> +                       if (!drvdata->fn_lock_sync_work_disabled && (drvdata->quirks & QUIRK_HID_FN_LOCK)) {
>                                 drvdata->fn_lock = !drvdata->fn_lock;
>                                 schedule_work(&drvdata->fn_lock_sync_work);
>                         }
> @@ -1497,8 +1498,10 @@ static void asus_remove(struct hid_device *hdev)
>                 cancel_work_sync(&drvdata->kbd_backlight->work);
>         }
>
> -       if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> +       if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> +               drvdata->fn_lock_sync_work_disabled = true;
>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
> +       }

I am not sure this is a real bug. can _event be called during _remove?
Doesn't the core prevent that?

>  #if IS_REACHABLE(CONFIG_ASUS_WMI)
>         drvdata->wmi_work_disabled = true;
> --
> 2.47.3
>
>

