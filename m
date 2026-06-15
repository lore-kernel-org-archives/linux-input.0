Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46E2E7631
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560215; cv=none; b=cGv/9ubyWk3GXBrvnPwW5nZiMf2BmIwnkkWxfXW3PClpBgTctCVANWBKFAyBrr0Pz/KqvoeRFyApZZMkxdcDm64ZsdqMpi07LD3MYvCTcFusI+S5cRjkIu8u4KMGlje1ebt17fBdVYHxq0yXLlqKViJ//d7mGuHSWvg1ivtkAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560215; c=relaxed/simple;
	bh=QOXS3hjLVEFTAS/fAw3YC+++hVwaiQKXLEtV5zXlO8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8+9dqa9PwHDlXO1xciJNjXb/zl7wJAbv/V/Rtha0qsviawMNyzPXQLOqUb/G1GAydZSShOZwrUTJAeZGWp/RIUz2YArD33MwgkZBbcl/OT2vGr2DzczSUcHEZanlbUpkPoOaF7vsRlbpj4U/Ohg9EjI1XzUgwVBXgJuIot+0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ifUJhBI1; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ifUJhBI1"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id CDA97BBF1C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:50:05 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 66E58BBEC9
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:50:04 +0300 (EEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 87BC81FFED4
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:50:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781560204;
	bh=m5yhuB4C0oMMJRtsKJmEPdmHnr9fxaDSnlr+oPuqE/s=;
	h=Received:From:Subject:To;
	b=ifUJhBI1Hw0IeuAhoekXfjLoLmW1AWYy1T1IjLmTrzVm2XpkHqqmvj2QKPlu8C5jR
	 lg6HZFZHfwEztqLzIRsOMi3mfz23uy+r3nF7oMgZfWRzDlQpNyi1dvJkMJsVKHF9SU
	 l9RO2xDPhXSjihUj/05RXqYIRcK2qtORIJFGYn4dx3gh7xTNjtOv3/4PE9A7kwfE45
	 dbCB121sqKn740llHHuuQmK6QazSyhAx4WYCcVUIkUHs4wF4cfkjOyyNkgX58d9wuR
	 AiGAg9bh8uuqvR5cInFkwdU70GljWd9MuEVQ78YNO4xrEy8vS1tzmS90XHzt+yvrSc
	 CB9yWnQ5fC7Kg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c86484d35d1so1350968a12.3
        for <linux-input@vger.kernel.org>;
 Mon, 15 Jun 2026 14:50:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/FunFaaCKip9KsRkbsu63gAA2LZkMZDw+1uGSNZ7EkGsT9vSxN/yy2073uuWQu4Zf2Xflbc+G92zV9yA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+nrmZVhbmxa7dUltRBw64/x0LxPV20iJWQ1VUbh1snrUSreQ
	5vFVhVHE8BWpcRr2yxoq2qX9s1w+Yyx3mMP4/T6udrIC2QQfl3U2y6SBn5i6lqnOqh+DhOO4Ga+
	TmePNvzA+6vopT7gYK6zcngacNzGjJbM=
X-Received: by 2002:a05:6a20:3953:b0:395:7fb:9362 with SMTP id
 adf61e73a8af0-3b79629f7efmr15104766637.19.1781560201231; Mon, 15 Jun 2026
 14:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615165058.3845-1-denis.benato@linux.dev>
 <20260615165058.3845-2-denis.benato@linux.dev>
In-Reply-To: <20260615165058.3845-2-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 15 Jun 2026 23:49:50 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHC8ni6BCeEigEt0NQL+Ys2CqLP4_tVSpfA_zF3x52y-A@mail.gmail.com>
X-Gm-Features: AVVi8CfHQ-TL59EubjYhAoMfcxFxGI-QhDSEjCZqHRU6WIlHULZB5_5N1ejIBAY
Message-ID: 
 <CAGwozwHC8ni6BCeEigEt0NQL+Ys2CqLP4_tVSpfA_zF3x52y-A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] HID: asus: refactor the two workqueues and init
 sequence
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>, sahiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178156020400.3290336.12117486496234011025@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 15 Jun 2026 at 18:51, Denis Benato <denis.benato@linux.dev> wrote:
>
> Multiple issues have been found within the hid-asus driver:
> - unchecked size in asus_raw_event()
> - unclean teardown of asus_probe on failure
> - possible use-after-free in asus_probe
> - multiple workqueue used for jobs where one was enough
> - sleeping calls in atomic context
> - packets of incorrect size being sent to the keyboard controller
>
> Join the two workqueues into one reusing the stopping mechanism
> of the brightness workqueue, use the joined workqueue to also
> move the asus_wmi_send_event() sleeping call away from atomic
> context and add a size check in asus_raw_event().
>
> Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
> Fixes: 1489a34e97ef ("HID: asus: Implement Fn+F5 fan control key handler")
> Fixes: b34b5945a769 ("HID: asus: listen to the asus-wmi brightness device instead of creating one")

I'm not sure b34b5945a769 caused an issue, perhaps drop it from fixes.
Does f631011e36b8 do a WMI from a hid interrupt? If not, perhaps it
does not need to be changed

But moreso, this patch is too large and will take a bit to review. Can
you send it separately after the rest of the series goes through
unless users report warnings?

Antheas

> Reported-by: sahiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260613154732.60A4B1F000E9@smtp.kernel.org/
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 393 +++++++++++++++++++++++++++++------------
>  1 file changed, 282 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d34d74df3dc0..05ca6665e0a4 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -109,11 +109,36 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>
>  #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
>
> -struct asus_kbd_leds {
> -       struct asus_hid_listener listener;
> +enum asus_work_action_type {
> +       FN_LOCK_SYNC,
> +       BRIGHTNESS_SET,
> +       WMI_FAN,
> +};
> +
> +struct hid_raw_event_data {
> +       u8 report_data[FEATURE_KBD_REPORT_SIZE];
> +       size_t report_size;
> +};
> +
> +struct asus_work_action {
> +       struct list_head node;
> +       enum asus_work_action_type type;
> +       union {
> +               /* Data for BRIGHTNESS_SET */
> +               unsigned int brightness;
> +
> +               /* Data for FN_LOCK_SYNC */
> +               bool fn_lock;
> +
> +               /* Data for WMI_FAN */
> +               struct hid_raw_event_data fan_hid_data;
> +       } data;
> +};
> +
> +struct asus_worker {
>         struct hid_device *hdev;
>         struct work_struct work;
> -       unsigned int brightness;
> +       struct list_head actions;
>         spinlock_t lock;
>         bool removed;
>  };
> @@ -133,7 +158,8 @@ struct asus_drvdata {
>         struct hid_device *hdev;
>         struct input_dev *input;
>         struct input_dev *tp_kbd_input;
> -       struct asus_kbd_leds *kbd_backlight;
> +       struct asus_worker *worker;
> +       unsigned int kbd_backlight_brightness;
>         const struct asus_touchpad_info *tp;
>         struct power_supply *battery;
>         struct power_supply_desc battery_desc;
> @@ -141,7 +167,7 @@ struct asus_drvdata {
>         int battery_stat;
>         bool battery_in_query;
>         unsigned long battery_next_query;
> -       struct work_struct fn_lock_sync_work;
> +       struct asus_hid_listener listener;
>         bool fn_lock;
>  };
>
> @@ -211,6 +237,29 @@ static const u8 asus_report_id_init[] = {
>         FEATURE_KBD_LED_REPORT_ID2
>  };
>
> +/*
> + * Send events to asus-wmi driver for handling special keys
> + */
> +static int asus_wmi_send_event(struct asus_drvdata *drvdata, u8 code)
> +{
> +       int err;
> +       u32 retval;
> +
> +       err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS,
> +                                      ASUS_WMI_METHODID_NOTIF, code, &retval);
> +       if (err) {
> +               pr_warn("Failed to notify asus-wmi: %d\n", err);
> +               return err;
> +       }
> +
> +       if (retval != 0) {
> +               pr_warn("Failed to notify asus-wmi (retval): 0x%x\n", retval);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
>  static void asus_report_contact_down(struct asus_drvdata *drvdat,
>                 int toolType, u8 *data)
>  {
> @@ -331,25 +380,71 @@ static int asus_e1239t_event(struct asus_drvdata *drvdat, u8 *data, int size)
>  }
>
>  /*
> - * Send events to asus-wmi driver for handling special keys
> + * Used in atomic contexts to schedule work involving sleeps operations or
> + * asus-wmi interactions.
> + *
> + * Caller is responsible to store relevant data in the structure to carry out
> + * the required action.
> + *
> + * This function must be called while the spin lock protecting the workqueue
> + * is already being held.
>   */
> -static int asus_wmi_send_event(struct asus_drvdata *drvdata, u8 code)
> +static void asus_worker_schedule(struct asus_worker *worker, struct asus_work_action *action)
>  {
> -       int err;
> -       u32 retval;
> -
> -       err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS,
> -                                      ASUS_WMI_METHODID_NOTIF, code, &retval);
> -       if (err) {
> -               pr_warn("Failed to notify asus-wmi: %d\n", err);
> -               return err;
> +       if (worker->removed) {
> +               kfree(action);
> +               return;
>         }
>
> -       if (retval != 0) {
> -               pr_warn("Failed to notify asus-wmi (retval): 0x%x\n", retval);
> -               return -EIO;
> +       list_add_tail(&action->node, &worker->actions);
> +       schedule_work(&worker->work);
> +}
> +
> +static int asus_kbd_fn_lock_set(struct asus_drvdata *drvdata, bool enabled)
> +{
> +       struct asus_work_action *action;
> +       unsigned long flags;
> +
> +       action = kzalloc_obj(struct asus_work_action);
> +       if (!action)
> +               return -ENOMEM;
> +
> +       drvdata->fn_lock = enabled;
> +       action->type = FN_LOCK_SYNC;
> +       action->data.fn_lock = drvdata->fn_lock;
> +       INIT_LIST_HEAD(&action->node);
> +
> +       spin_lock_irqsave(&drvdata->worker->lock, flags);
> +       asus_worker_schedule(drvdata->worker, action);
> +       spin_unlock_irqrestore(&drvdata->worker->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *report_data,
> +                                size_t report_size)
> +{
> +       struct asus_work_action *action;
> +       unsigned long flags;
> +
> +       if (report_size > FEATURE_KBD_REPORT_SIZE) {
> +               hid_err(drvdata->hdev, "Invalid report size for fan event: %zu\n", report_size);
> +               return -EINVAL;
>         }
>
> +       action = kzalloc_obj(struct asus_work_action);
> +       if (!action)
> +               return -ENOMEM;
> +
> +       action->type = WMI_FAN;
> +       action->data.fan_hid_data.report_size = report_size;
> +       memcpy(action->data.fan_hid_data.report_data, report_data, report_size);
> +       INIT_LIST_HEAD(&action->node);
> +
> +       spin_lock_irqsave(&drvdata->worker->lock, flags);
> +       asus_worker_schedule(drvdata->worker, action);
> +       spin_unlock_irqrestore(&drvdata->worker->lock, flags);
> +
>         return 0;
>  }
>
> @@ -357,6 +452,7 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
>                       struct hid_usage *usage, __s32 value)
>  {
>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +       int ret;
>
>         if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
>             (usage->hid & HID_USAGE) != 0x00 &&
> @@ -375,8 +471,11 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
>                         return !asus_hid_event(ASUS_EV_BRTTOGGLE);
>                 case KEY_FN_ESC:
>                         if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> -                               drvdata->fn_lock = !drvdata->fn_lock;
> -                               schedule_work(&drvdata->fn_lock_sync_work);
> +                               ret = asus_kbd_fn_lock_set(drvdata, !drvdata->fn_lock);
> +                               if (ret) {
> +                                       hid_err(hdev, "Error while toggling FN lock: %d\n", ret);
> +                                       return ret;
> +                               }
>                         }
>                         break;
>                 }
> @@ -389,6 +488,12 @@ static int asus_raw_event(struct hid_device *hdev,
>                 struct hid_report *report, u8 *data, int size)
>  {
>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +       int ret;
> +
> +       if (size < 2) {
> +               hid_dbg(hdev, "Unexpected keyboard report size %d\n", size);
> +               return 0;
> +       }
>
>         if (drvdata->battery && data[0] == BATTERY_REPORT_ID)
>                 return asus_report_battery(drvdata, data, size);
> @@ -414,19 +519,13 @@ static int asus_raw_event(struct hid_device *hdev,
>                          * pass to userspace so it can implement its own fan control.
>                          */
>                         if (data[1] == ASUS_FAN_CTRL_KEY_CODE) {
> -                               int ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
> +                               ret = asus_kbd_wmi_fan_send(drvdata, data, size);
>
> -                               if (ret == 0) {
> -                                       /* Successfully handled by asus-wmi, block event */
> +                               /* if execution deferred successfully block event */
> +                               if (ret == 0)
>                                         return -1;
> -                               }
>
> -                               /*
> -                                * Warn if asus-wmi failed (but not if it's unavailable).
> -                                * Let the event reach userspace in all failure cases.
> -                                */
> -                               if (ret != -ENODEV)
> -                                       hid_warn(hdev, "Failed to notify asus-wmi: %d\n", ret);
> +                               return ret;
>                         }
>
>                         /*
> @@ -569,59 +668,151 @@ static int asus_kbd_disable_oobe(struct hid_device *hdev)
>         return 0;
>  }
>
> -static int asus_kbd_set_fn_lock(struct hid_device *hdev, bool enabled)
> +static void asus_kbd_set_fn_lock(struct hid_device *hdev, bool enabled)
>  {
> -       u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xd0, 0x4e, !!enabled };
> +       const u8 buf[FEATURE_KBD_REPORT_SIZE] = { FEATURE_KBD_REPORT_ID, 0xd0, 0x4e, !!enabled };
> +       int ret;
>
> -       return asus_kbd_set_report(hdev, buf, sizeof(buf));
> +       ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
> +       if (ret < 0)
> +               hid_err(hdev, "Asus failed to set fn lock: %d\n", ret);
>  }
>
> -static void asus_sync_fn_lock(struct work_struct *work)
> +static void asus_kbd_set_brightness(struct hid_device *hdev, u8 brightness)
>  {
> -       struct asus_drvdata *drvdata =
> -       container_of(work, struct asus_drvdata, fn_lock_sync_work);
> +       const u8 buf[FEATURE_KBD_REPORT_SIZE] = {
> +               FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, brightness
> +       };
> +       int ret;
>
> -       asus_kbd_set_fn_lock(drvdata->hdev, drvdata->fn_lock);
> +       ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
> +       if (ret < 0)
> +               hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
>  }
>
> -static void asus_schedule_work(struct asus_kbd_leds *led)
> +static void asus_kbd_wmi_fan(struct hid_device *hdev, struct hid_raw_event_data *data)
>  {
> +       struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +       int ret;
> +
> +       ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
> +
> +       /*
> +        * Warn if asus-wmi failed (but not if it's unavailable).
> +        * Let the event reach userspace in all failure cases.
> +        */
> +       switch (ret) {
> +       case -ENODEV:
> +               break;
> +       case 0:
> +               return;
> +       default:
> +               hid_warn(hdev, "Failed to notify asus-wmi: %d\n", ret);
> +               break;
> +       }
> +
> +       /* Fallback: pass the raw event to the HID core */
> +       hid_report_raw_event(hdev, HID_INPUT_REPORT,
> +                            data->report_data, data->report_size,
> +                            data->report_size, 1);
> +}
> +
> +static void asus_kbd_backlight_set(struct asus_hid_listener *listener, int brightness)
> +{
> +       struct asus_drvdata *drvdata = container_of(listener, struct asus_drvdata, listener);
> +       struct asus_worker *worker = drvdata->worker;
> +       struct asus_work_action *action;
>         unsigned long flags;
>
> -       spin_lock_irqsave(&led->lock, flags);
> -       if (!led->removed)
> -               schedule_work(&led->work);
> -       spin_unlock_irqrestore(&led->lock, flags);
> +       drvdata->kbd_backlight_brightness = brightness;
> +
> +       action = kzalloc_obj(struct asus_work_action);
> +       if (!action) {
> +               hid_warn(drvdata->hdev, "Failed to allocate memory for backlight action\n");
> +               return;
> +       }
> +
> +       action->type = BRIGHTNESS_SET;
> +       action->data.brightness = brightness;
> +       INIT_LIST_HEAD(&action->node);
> +
> +       spin_lock_irqsave(&worker->lock, flags);
> +       asus_worker_schedule(worker, action);
> +       spin_unlock_irqrestore(&worker->lock, flags);
>  }
>
> -static void asus_kbd_backlight_set(struct asus_hid_listener *listener,
> -                                  int brightness)
> +static void asus_work(struct work_struct *work)
>  {
> -       struct asus_kbd_leds *led = container_of(listener, struct asus_kbd_leds,
> -                                                listener);
> +       struct asus_worker *worker = container_of(work, struct asus_worker, work);
> +       struct asus_work_action *action = NULL;
>         unsigned long flags;
>
> -       spin_lock_irqsave(&led->lock, flags);
> -       led->brightness = brightness;
> -       spin_unlock_irqrestore(&led->lock, flags);
> +       /* Save the action to be performed and clear the flag */
> +       spin_lock_irqsave(&worker->lock, flags);
> +       if (!list_empty(&worker->actions)) {
> +               action = list_first_entry(&worker->actions,
> +                                         struct asus_work_action, node);
> +               list_del(&action->node);
> +       }
> +       spin_unlock_irqrestore(&worker->lock, flags);
> +
> +       if (!action)
> +               return;
> +
> +       switch (action->type) {
> +       case BRIGHTNESS_SET:
> +               asus_kbd_set_brightness(worker->hdev, action->data.brightness);
> +               break;
> +       case FN_LOCK_SYNC:
> +               asus_kbd_set_fn_lock(worker->hdev, action->data.fn_lock);
> +               break;
> +       case WMI_FAN:
> +               asus_kbd_wmi_fan(worker->hdev, &action->data.fan_hid_data);
> +               break;
> +       default:
> +               hid_err(worker->hdev, "Invalid action type: %d\n", action->type);
> +               break;
> +       }
> +
> +       kfree(action);
>
> -       asus_schedule_work(led);
> +       /* Re-schedule if there are more pending actions */
> +       spin_lock_irqsave(&worker->lock, flags);
> +       if (!list_empty(&worker->actions))
> +               schedule_work(&worker->work);
> +       spin_unlock_irqrestore(&worker->lock, flags);
>  }
>
> -static void asus_kbd_backlight_work(struct work_struct *work)
> +static int asus_worker_create(struct hid_device *hdev, struct asus_drvdata *drvdata)
>  {
> -       struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
> -       u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
> -       int ret;
> +       drvdata->worker = devm_kzalloc(&hdev->dev, sizeof(struct asus_worker), GFP_KERNEL);
> +       if (!drvdata->worker)
> +               return -ENOMEM;
> +
> +       drvdata->worker->removed = false;
> +       drvdata->worker->hdev = hdev;
> +       INIT_LIST_HEAD(&drvdata->worker->actions);
> +
> +       INIT_WORK(&drvdata->worker->work, asus_work);
> +       spin_lock_init(&drvdata->worker->lock);
> +
> +       return 0;
> +}
> +
> +static void asus_worker_stop(struct asus_worker *worker)
> +{
> +       struct asus_work_action *action, *tmp;
>         unsigned long flags;
>
> -       spin_lock_irqsave(&led->lock, flags);
> -       buf[4] = led->brightness;
> -       spin_unlock_irqrestore(&led->lock, flags);
> +       spin_lock_irqsave(&worker->lock, flags);
> +       worker->removed = true;
> +       list_for_each_entry_safe(action, tmp, &worker->actions, node) {
> +               list_del(&action->node);
> +               kfree(action);
> +       }
> +       spin_unlock_irqrestore(&worker->lock, flags);
>
> -       ret = asus_kbd_set_report(led->hdev, buf, sizeof(buf));
> -       if (ret < 0)
> -               hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
> +       cancel_work_sync(&worker->work);
>  }
>
>  /*
> @@ -760,23 +951,11 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>                         le16_to_cpu(udev->descriptor.idProduct));
>         }
>
> -       drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
> -                                             sizeof(struct asus_kbd_leds),
> -                                             GFP_KERNEL);
> -       if (!drvdata->kbd_backlight)
> -               return -ENOMEM;
> -
> -       drvdata->kbd_backlight->removed = false;
> -       drvdata->kbd_backlight->brightness = 0;
> -       drvdata->kbd_backlight->hdev = hdev;
> -       drvdata->kbd_backlight->listener.brightness_set = asus_kbd_backlight_set;
> -       INIT_WORK(&drvdata->kbd_backlight->work, asus_kbd_backlight_work);
> -       spin_lock_init(&drvdata->kbd_backlight->lock);
> -
> -       ret = asus_hid_register_listener(&drvdata->kbd_backlight->listener);
> +       drvdata->listener.brightness_set = asus_kbd_backlight_set;
> +       ret = asus_hid_register_listener(&drvdata->listener);
>         if (ret < 0) {
> -               /* No need to have this still around */
> -               devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> +               hid_err(hdev, "Unable to register kbd brightness listener: %d\n", ret);
> +               drvdata->listener.brightness_set = NULL;
>         }
>
>         return ret;
> @@ -965,11 +1144,9 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>                 }
>         }
>
> -       if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> -               drvdata->fn_lock = true;
> -               INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
> -               asus_kbd_set_fn_lock(hdev, true);
> -       }
> +       if ((drvdata->quirks & QUIRK_HID_FN_LOCK) &&
> +           (asus_kbd_fn_lock_set(drvdata, true)))
> +               hid_warn(hdev, "Error while setting FN lock to ON\n");
>
>         if (drvdata->tp) {
>                 int ret;
> @@ -1004,11 +1181,9 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>
>         drvdata->input = input;
>
> -       if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> -               drvdata->fn_lock = true;
> -               INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
> -               asus_kbd_set_fn_lock(hdev, true);
> -       }
> +       if ((drvdata->quirks & QUIRK_HID_FN_LOCK) &&
> +           (asus_kbd_fn_lock_set(drvdata, true)))
> +               hid_warn(hdev, "Error while setting FN lock to ON\n");
>
>         return 0;
>  }
> @@ -1171,20 +1346,16 @@ static int asus_start_multitouch(struct hid_device *hdev)
>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>  {
>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> -       int ret = 0;
>
> -       if (drvdata->kbd_backlight) {
> -               const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4,
> -                               drvdata->kbd_backlight->brightness };
> -               ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
> -               if (ret < 0) {
> -                       hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
> -                       goto asus_resume_err;
> -               }
> -       }
> +       /*
> +        * If we have a backlight listener registered, restore the previous state,
> +        * in case of error do not fail: most models restore the backlight
> +        * automatically, and the error is non-fatal.
> +        */
> +       if (drvdata->listener.brightness_set)
> +               asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
>
> -asus_resume_err:
> -       return ret;
> +       return 0;
>  }
>
>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
> @@ -1294,6 +1465,12 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                         is_vendor = true;
>         }
>
> +       ret = asus_worker_create(hdev, drvdata);
> +       if (ret) {
> +               hid_warn(hdev, "Failed to initialize worker: %d\n", ret);
> +               return ret;
> +       }
> +
>         ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>         if (ret) {
>                 hid_err(hdev, "Asus hw start failed: %d\n", ret);
> @@ -1343,6 +1520,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>
>         return 0;
>  err_stop_hw:
> +       if (drvdata->listener.brightness_set)
> +               asus_hid_unregister_listener(&drvdata->listener);
> +
> +       asus_worker_stop(drvdata->worker);
>         hid_hw_stop(hdev);
>         return ret;
>  }
> @@ -1350,21 +1531,11 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  static void asus_remove(struct hid_device *hdev)
>  {
>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> -       unsigned long flags;
> -
> -       if (drvdata->kbd_backlight) {
> -               asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
> -
> -               spin_lock_irqsave(&drvdata->kbd_backlight->lock, flags);
> -               drvdata->kbd_backlight->removed = true;
> -               spin_unlock_irqrestore(&drvdata->kbd_backlight->lock, flags);
> -
> -               cancel_work_sync(&drvdata->kbd_backlight->work);
> -       }
>
> -       if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> -               cancel_work_sync(&drvdata->fn_lock_sync_work);
> +       if (drvdata->listener.brightness_set)
> +               asus_hid_unregister_listener(&drvdata->listener);
>
> +       asus_worker_stop(drvdata->worker);
>         hid_hw_stop(hdev);
>  }
>
> --
> 2.47.3
>
>

