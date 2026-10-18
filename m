Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1F3FE37A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343463; cv=none; b=pKdYe5UtHbDHOxz2IP7zNHwgH1DlF6w9yka7lE6Ju5jMjTcAWDdCvl1f/eIXmNv2VoyxfyfqdAlE48YDUQPPYQggkI+pyFxClp0HDwnQluaIOndM6bL5SgwZ1U9IKDBJZ5jmG4LJyOIcRuKySE7Pwg045NaY1pHTRJxx6Pt3BaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343463; c=relaxed/simple;
	bh=mduY6HgdcQ75b916LUYe4gXKk+KkQRoSwIiSWRZW4GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAlRyfSDlEMEucZpgz+hNevQ51GPRFRZ/aNezgadPnymbiNO/IuBrIMqcTsFkvRNwlN/tbh1RGGhpjmKut9X28w/gT9WvMT/8Fyq6tDVamdWLZIlmuPlwttzIfQbnYZUWPp/jxqUr4cv1A2dppTZXPy+SNC1vdptGpxzS1xe1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K/4l1wIz; arc=none smtp.client-ip=91.218.175.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K/4l1wIz"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mduY6HgdcQ75b916LUYe4gXKk+KkQRoSwIiSWRZW4GY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792343459; v=1; x=1792948259;
 b=K/4l1wIzs87dAzoK2z8GBO/FheDddcI8Zk9bOcGd0PSCndpUefy0S2d09LoFGYTw3QMkHEam
 oXys1e0bmGJf8tY7PpXSBcUa96SXAip8Y7Kav42AAR/jc60Z9WHcaBVIzzOki8STYo4lukJCO2O
 JFuZ9n3Ebk32psP70P+KwVPI=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2aac9a6afb92554e;
	Sun, 18 Oct 2026 17:10:59 +0000
X-Mizu-Trace-ID: 2aac9a6afb92554e
X-Migadu-Flow: FLOW_OUT
Message-ID: <4bf9e6b0-4f6e-4faf-a2b6-a57143ef3f23@linux.dev>
Date: Sun, 18 Oct 2026 19:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard
 handshake after probe
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-8-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-8-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:40, Paolo Pisati wrote:
> From: Rebecca Mara Müller <rebecca.mara@posteo.de>
>
> When docked, the Zenbook Duo keyboard powers up in F-key mode and
> needs the "ASUS Tech.Inc." handshake to emit hotkeys at all. The
> handshake sent from probe is lost again when hid-multitouch configures
> the touchpad on the sibling USB interface, which resets the keyboard
> to F-key mode, so the hotkeys stop working as soon as the touchpad is
> set up.
>
> Re-send the handshake from delayed work two seconds after probe.


So this patch is based on an arbitrary wait that is based on the
assumption that some other device gets initialized...

Can you try making this deterministic? Maybe returning from
_probe a specific value will postpone binding of this driver after
all other drivers and you can comment in code why it was done...

Or perhaps you can setup some way of hid-multitouch to signal
completion?

Regardless I will also review what we have here in case this ends
up to be the best way to go.

> Assisted-by: LLM
> Signed-off-by: Rebecca Mara Müller <rebecca.mara@posteo.de>
> Link: https://lore.kernel.org/r/20260811125548.1975748-1-rebecca.mara@posteo.de
> [pisati: taken from Rebecca's standalone UX8407AA patch and adapted to
>  the current driver; initialize and cancel the work unconditionally]
> Assisted-by: LLM
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 503396963eeb..ce413eb011c4 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -173,6 +173,7 @@ struct asus_drvdata {
>  	unsigned long battery_next_query;
>  	struct asus_hid_listener listener;
>  	bool fn_lock;
> +	struct delayed_work reinit_work;

Why not reusing the workqueue we have already?

>  };
>  
>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
> @@ -1474,6 +1475,17 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
>  	return 0;
>  }
>  
> +static void asus_reinit_work(struct work_struct *work)
> +{
> +	struct asus_drvdata *drvdata = container_of(work, struct asus_drvdata,
> +						    reinit_work.work);
> +	int ret;
> +
> +	ret = asus_kbd_init(drvdata->hdev, FEATURE_KBD_REPORT_ID);
> +	if (ret < 0)
> +		hid_warn(drvdata->hdev, "Failed to re-initialize the keyboard: %d\n", ret);
> +}
> +
>  static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>  	struct hid_report_enum *rep_enum;
> @@ -1570,6 +1582,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  			is_vendor = true;
>  	}
>  
> +	INIT_DELAYED_WORK(&drvdata->reinit_work, asus_reinit_work);
> +
>  	ret = asus_worker_create(hdev, drvdata);
>  	if (ret) {
>  		hid_warn(hdev, "Failed to initialize worker: %d\n", ret);
> @@ -1605,6 +1619,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		}
>  	}
>  
> +	/*
> +	 * When docked, the Zenbook Duo keyboard drops back to F-key mode when
> +	 * hid-multitouch configures the touchpad on the sibling USB interface,
> +	 * which can happen after the handshake above. Send it again once the
> +	 * dust has settled.
> +	 */
> +	if (is_vendor && (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) &&
> +	    hid_is_usb(hdev))
> +		schedule_delayed_work(&drvdata->reinit_work, msecs_to_jiffies(2000));
> +
>  	/* Laptops keyboard backlight is always at 0x5a */
>  	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>  	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
> @@ -1639,6 +1663,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	return 0;
>  err_stop_hw:
> +	cancel_delayed_work_sync(&drvdata->reinit_work);
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> @@ -1654,6 +1679,7 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> +	cancel_delayed_work_sync(&drvdata->reinit_work);
>  	asus_worker_stop(drvdata->worker);
>  	hid_hw_stop(hdev);
>  }
