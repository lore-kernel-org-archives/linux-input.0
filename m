From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] drivers/hid: Convert timers to use timer_setup()
Date: Wed, 25 Oct 2017 09:33:29 +0200
Message-ID: <20171025073329.GF13605@mail.corp.redhat.com>
References: <1508867719-16157-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932184AbdJYHde (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Oct 2017 03:33:34 -0400
Content-Disposition: inline
In-Reply-To: <1508867719-16157-1-git-send-email-allen.pais@oracle.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Allen Pais <allen.pais@oracle.com>
Cc: dh.herrmann@googlemail.com, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Kees Cook <keescook@chromium.org>

On Oct 24 2017 or thereabouts, Allen Pais wrote:
> Switch to using the new timer_setup() and from_timer()
> for drivers/hid/*
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
> 
> Note:This patch is only compile tested.

Looks good enough for me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
>  drivers/hid/hid-appleir.c      | 8 ++++----
>  drivers/hid/hid-prodikeys.c    | 7 +++----
>  drivers/hid/hid-wiimote-core.c | 6 +++---
>  drivers/hid/usbhid/hid-core.c  | 8 ++++----
>  4 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
> index 07cbc70..1c913a7 100644
> --- a/drivers/hid/hid-appleir.c
> +++ b/drivers/hid/hid-appleir.c
> @@ -173,9 +173,9 @@ static void battery_flat(struct appleir *appleir)
>  	dev_err(&appleir->input_dev->dev, "possible flat battery?\n");
>  }
>  
> -static void key_up_tick(unsigned long data)
> +static void key_up_tick(struct timer_list *t)
>  {
> -	struct appleir *appleir = (struct appleir *)data;
> +	struct appleir *appleir = from_timer(appleir, t, key_up_timer);
>  	struct hid_device *hid = appleir->hid;
>  	unsigned long flags;
>  
> @@ -303,8 +303,8 @@ static int appleir_probe(struct hid_device *hid, const struct hid_device_id *id)
>  	hid->quirks |= HID_QUIRK_HIDINPUT_FORCE;
>  
>  	spin_lock_init(&appleir->lock);
> -	setup_timer(&appleir->key_up_timer,
> -		    key_up_tick, (unsigned long) appleir);
> +	timer_setup(&appleir->key_up_timer,
> +		    key_up_tick, 0);
>  
>  	hid_set_drvdata(hid, appleir);
>  
> diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
> index 49c4bd3..87eda34 100644
> --- a/drivers/hid/hid-prodikeys.c
> +++ b/drivers/hid/hid-prodikeys.c
> @@ -239,9 +239,9 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
>  	return;
>  }
>  
> -static void pcmidi_sustained_note_release(unsigned long data)
> +static void pcmidi_sustained_note_release(struct timer_list *t)
>  {
> -	struct pcmidi_sustain *pms = (struct pcmidi_sustain *)data;
> +	struct pcmidi_sustain *pms = from_timer(pms, t, timer);
>  
>  	pcmidi_send_note(pms->pm, pms->status, pms->note, pms->velocity);
>  	pms->in_use = 0;
> @@ -256,8 +256,7 @@ static void init_sustain_timers(struct pcmidi_snd *pm)
>  		pms = &pm->sustained_notes[i];
>  		pms->in_use = 0;
>  		pms->pm = pm;
> -		setup_timer(&pms->timer, pcmidi_sustained_note_release,
> -			(unsigned long)pms);
> +		timer_setup(&pms->timer, pcmidi_sustained_note_release, 0);
>  	}
>  }
>  
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index d003914..579884e 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -1226,9 +1226,9 @@ static void wiimote_schedule(struct wiimote_data *wdata)
>  	spin_unlock_irqrestore(&wdata->state.lock, flags);
>  }
>  
> -static void wiimote_init_timeout(unsigned long arg)
> +static void wiimote_init_timeout(struct timer_list *t)
>  {
> -	struct wiimote_data *wdata = (void*)arg;
> +	struct wiimote_data *wdata = from_timer(wdata, t, timer);
>  
>  	wiimote_schedule(wdata);
>  }
> @@ -1740,7 +1740,7 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
>  	wdata->state.cmd_battery = 0xff;
>  
>  	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
> -	setup_timer(&wdata->timer, wiimote_init_timeout, (long)wdata);
> +	timer_setup(&wdata->timer, wiimote_init_timeout, 0);
>  
>  	return wdata;
>  }
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 045b5da..640dfb93 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -101,10 +101,10 @@ static int hid_start_in(struct hid_device *hid)
>  }
>  
>  /* I/O retry timer routine */
> -static void hid_retry_timeout(unsigned long _hid)
> +static void hid_retry_timeout(struct timer_list *t)
>  {
> -	struct hid_device *hid = (struct hid_device *) _hid;
> -	struct usbhid_device *usbhid = hid->driver_data;
> +	struct usbhid_device *usbhid = from_timer(usbhid, t, io_retry);
> +	struct hid_device *hid = usbhid->hid;
>  
>  	dev_dbg(&usbhid->intf->dev, "retrying intr urb\n");
>  	if (hid_start_in(hid))
> @@ -1373,7 +1373,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
>  
>  	init_waitqueue_head(&usbhid->wait);
>  	INIT_WORK(&usbhid->reset_work, hid_reset);
> -	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
> +	timer_setup(&usbhid->io_retry, hid_retry_timeout, 0);
>  	spin_lock_init(&usbhid->lock);
>  
>  	ret = hid_add_device(hid);
> -- 
> 1.9.1
> 
