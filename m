Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871201EA7DB
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367348; cv=none; b=mh1O+JN05BVY1Ao+4X9qX6ylO5teJvUKnQZfV8NDagVJ/6vTqQ4WhrY3buzb3iBeFdLtmNcgSgT0wRTkpgskCVNcUvodRBFB88vflksZvc72oH4IA8Jqltyz1Tx2aMe6xVEFnWqlsZzNLpA9lrm0AUOiNb7FHQw5SEc0FfMTufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367348; c=relaxed/simple;
	bh=613Bsr45QmvFE8KWgnDQFIXhfYfo/a+LUrpzoJPv8cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbsvhUNS0HsIXsIVc7+NlzTYjyQj8j0djR4K+AP/KCguf4h7vvDNQA89oGfwaZVH83YpFmWA93xNOeIinrfIT3OlyKoq7+YspECSUCmosqZ//yWFCtBMr52q7qar9SItj7hwMNyaumwMUR+ZPOSG4Q/lPcGirQMgO16m6BE5MP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=dyhWtByN; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="dyhWtByN"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 8FBBC42058
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 19:15:45 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 4C3DE4205D
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 19:15:44 +0300 (EEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A856E1FEFD8
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 19:15:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781367343;
	bh=Taw5aWwO0Vxdal1KhvwtS2muQTYYZXChjhrxs1AuFmg=;
	h=Received:From:Subject:To;
	b=dyhWtByN+hUsq/uOPanGzcWNj1cOrmEtn9psWjEO9c28+G8eUgOIiUHJxcVzT1Boa
	 LnsKNPT21wXahQZxNUhfm3/QBqD760eoNxFCRyMoGn87/VXle4oanAxZ+jJw72H2Vo
	 jXRC2l3hyqv35VLbXMUrkfiRH8wN38PP9TBzwNLQvb9eaDf7R6JZB1k0JOv9u9rBSC
	 c1ecEpKeK1BYMScCHaFajUDQtHE0Lzg4Hd6JaRsqSKlRpyrMYe4dh59VxNursSD47r
	 K0r4CbMWhfqYlbswc6I+odpukUYiYrv5KrXjL39oMEt/mFRg/ojqwUAQWNOjI6ghKa
	 36r9PXLCGCzWQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f181.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2bf18c30bb2so15477855ad.0
        for <linux-input@vger.kernel.org>;
 Sat, 13 Jun 2026 09:15:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+l3BbHpmOGODaHRlUx46rv/N1h+L22uGR202rJzrGysKY/V+OpoA8Zks3sVoKT424sTad/0LAC9ZHLHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpz2GGLAwSp+Zjc1sszUCeytJ4IE0kyO6ISF1ijpkem7K/RJXo
	vRrDh73JPxeAsAHBLXNEK8TMEQHVX3ZuYZ1xi/aFaSKl2/pt9GCKbreua4x5muAa7sGZORmglyT
	Z1OodrLGePlla7x9Ge0hXa3TOzJZz0Ac=
X-Received: by 2002:a17:903:2351:b0:2c0:dd75:e824 with SMTP id
 d9443c01a7336-2c6641ca3cbmr47861655ad.4.1781367342283; Sat, 13 Jun 2026
 09:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613153029.2559774-1-denis.benato@linux.dev>
 <20260613153029.2559774-6-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-6-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 13 Jun 2026 18:15:31 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHXKosBi23oS8uvVrjr+fKZ+O+yUpHb0oT=acFCgRDwng@mail.gmail.com>
X-Gm-Features: AVVi8Ce5EGCgXH1j2dNbY77qzK5mk-a_s2nwJ61Mnqleu4aAk1wy7BgDesSWDH8
Message-ID: 
 <CAGwozwHXKosBi23oS8uvVrjr+fKZ+O+yUpHb0oT=acFCgRDwng@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] HID: asus: avoid sleeping calls in atomic context
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>, sahiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178136734387.1291238.1982705721460785141@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 13 Jun 2026 at 17:30, Denis Benato <denis.benato@linux.dev> wrote:
>
> Avoid possibly calling asus_wmi_send_event(): a method that can sleep in
> asus_raw_event() that is called in atomic context.
>
> This commit changes when methods are called, not method parameters:
> the driver behaves as before.

Observe the new AI guidelines and add assisted by tags if necessary.
Or write the patches manually for mainline. This sentence is an AI
euphemism

Who let 1489a34e97ef through? I implemented the plumbing for WMI
callbacks with asus_hid_event last year because WMI cannot be called
through HID. Brightness events had the exact same problem.
kbd_led_work/kbd_led_update_all could be renamed and used for this. I
would rather avoid introducing a new work queue. The one I added is
enough if not too much

Antheas

> Fixes: 1489a34e97ef ("HID: asus: Implement Fn+F5 fan control key handler")
> Reported-by: sahiko-bot@kernel.org
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 67 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f38b18ad65c6..a6467172c455 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -150,6 +150,13 @@ struct asus_drvdata {
>         unsigned long battery_next_query;
>         struct work_struct fn_lock_sync_work;
>         bool fn_lock;
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +       struct work_struct wmi_work;
> +       bool wmi_work_disabled;
> +       u8 wmi_data[FEATURE_KBD_REPORT_SIZE];
> +       int wmi_size;
> +       spinlock_t wmi_lock;
> +#endif
>         struct asus_xgm_led *xgm_led;
>  };
>
> @@ -338,6 +345,7 @@ static int asus_e1239t_event(struct asus_drvdata *drvdat, u8 *data, int size)
>         return 0;
>  }
>
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>  /*
>   * Send events to asus-wmi driver for handling special keys
>   */
> @@ -361,6 +369,32 @@ static int asus_wmi_send_event(struct asus_drvdata *drvdata, u8 code)
>         return 0;
>  }
>
> +static void asus_wmi_work(struct work_struct *work)
> +{
> +       struct asus_drvdata *drvdata = container_of(work, struct asus_drvdata, wmi_work);
> +       u8 report_data[FEATURE_KBD_REPORT_SIZE];
> +       int report_size;
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&drvdata->wmi_lock, flags);
> +       memcpy(report_data, drvdata->wmi_data, drvdata->wmi_size);
> +       report_size = drvdata->wmi_size;
> +       spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
> +
> +       ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
> +       if (ret) {
> +               if (ret != -ENODEV)
> +                       hid_warn(drvdata->hdev, "Failed to notify asus-wmi: %d\n", ret);
> +
> +               /* Fallback: pass the raw event to the HID core */
> +               hid_report_raw_event(drvdata->hdev, HID_INPUT_REPORT,
> +                                    report_data, report_size,
> +                                    report_size, 1);
> +       }
> +}
> +#endif
> +
>  static int asus_event(struct hid_device *hdev, struct hid_field *field,
>                       struct hid_usage *usage, __s32 value)
>  {
> @@ -397,6 +431,9 @@ static int asus_raw_event(struct hid_device *hdev,
>                 struct hid_report *report, u8 *data, int size)
>  {
>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +       unsigned long flags;
> +#endif
>
>         if (drvdata->battery && data[0] == BATTERY_REPORT_ID)
>                 return asus_report_battery(drvdata, data, size);
> @@ -422,19 +459,18 @@ static int asus_raw_event(struct hid_device *hdev,
>                          * pass to userspace so it can implement its own fan control.
>                          */
>                         if (data[1] == ASUS_FAN_CTRL_KEY_CODE) {
> -                               int ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
> -
> -                               if (ret == 0) {
> -                                       /* Successfully handled by asus-wmi, block event */
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +                               spin_lock_irqsave(&drvdata->wmi_lock, flags);
> +                               memcpy(drvdata->wmi_data, data, min_t(int, size, sizeof(drvdata->wmi_data)));
> +                               drvdata->wmi_size = size;
> +                               spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
> +
> +                               if (!drvdata->wmi_work_disabled) {
> +                                       schedule_work(&drvdata->wmi_work);
> +                                       /* Successfully handled asynchronously, block event */
>                                         return -1;
>                                 }
> -
> -                               /*
> -                                * Warn if asus-wmi failed (but not if it's unavailable).
> -                                * Let the event reach userspace in all failure cases.
> -                                */
> -                               if (ret != -ENODEV)
> -                                       hid_warn(hdev, "Failed to notify asus-wmi: %d\n", ret);
> +#endif
>                         }
>
>                         /*
> @@ -1350,6 +1386,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
>
>         drvdata->hdev = hdev;
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +       INIT_WORK(&drvdata->wmi_work, asus_wmi_work);
> +       spin_lock_init(&drvdata->wmi_lock);
> +#endif
>
>         if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
>                 ret = asus_battery_probe(hdev);
> @@ -1460,6 +1500,11 @@ static void asus_remove(struct hid_device *hdev)
>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
>
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +       drvdata->wmi_work_disabled = true;
> +       cancel_work_sync(&drvdata->wmi_work);
> +#endif
> +
>         if (drvdata->xgm_led)
>                 led_classdev_unregister(&drvdata->xgm_led->cdev);
>
> --
> 2.47.3
>
>

