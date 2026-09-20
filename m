Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390613E51D4
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892685; cv=none; b=Ar4JJlBekXxZa/PcECR1YfIq5ery21q/7dUlL1twIUFlsYv3lM5agtUbLKnA2q+iHtdwIZZ900ek6/iPptFI4lRTQFRP7hNVQMVsnbFHsg6tTa2/Li6+plOO9odJL7i4mhsQs/L94V+bfmNfMBaGKoZZL0BWNIZpichYGjSoWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892685; c=relaxed/simple;
	bh=PQNKrVSSv5XrsWqLZAftkyNTidb+4k1YKsSYR2Qmqs8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SK8n1SAF64ftM9CAma8Kfxq8/E9A7CmTHGfxQpl8moudCRfNt18wnP6s4KNspdi2rp5CkkjYyQAQHcbFs9tO09EgzsOUQ7/tIafKyz5kkFZpa7KVf4rkQ7r424HX0XtBy6xcUrZ+DenDYBh6aIdmkGykl9CBPrDH9YLuidmuNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=lZrfkbzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaAoZY12; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="lZrfkbzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaAoZY12"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 828837A00D7;
	Sun, 20 Sep 2026 04:24:41 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789892680;
	 x=1789979080; bh=R604L43YzzAOIGDh0DoqUfAFIQHq1nWj8E5WaWMTRH4=; b=
	lZrfkbzcM9EI8k0NfUU/hUow+4Tt+JfniLwJvZnf67EZUk12CMkLDfwAgSElGcrN
	jJ8YLGNYsLzYZjF2Mx3ydEFX/idI9g39WCTZk7NKBjKHbtRFF9stckN6POFlYlt9
	SlXYQnhhuCJonmEImHmqGvyS/4H2UjBqQuXovK3ANLjgRgyBmz7RtjTnJoX/lgbN
	PgpxHCNs9TRlZzUjQq1ISLzbh2ZRrKWgk7xNk6zdDgyBAP503S07fQzq6Ngj9+9P
	2WBkjAIJ3SKKL7vE5wD1Z+oguZbARvSazBjt2wqQojHjNL8j50GJalFceNPgejhy
	O2GQBKCRfMLLeLm4LPFXvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789892680; x=
	1789979080; bh=R604L43YzzAOIGDh0DoqUfAFIQHq1nWj8E5WaWMTRH4=; b=J
	aAoZY12v6443F9P8l3K0VnBAiT+Npwk/I2rtMtBUxiwub6eg7BrzPUCrtITqN7nj
	LroBNU2ZSsP7n2Y69fA20bn3kWDRvzO2lutYZ4XwmlBgkwl/syY47vXeQ/X7YQl6
	M0K+ea4faHlUJrcpYoSKyRC7SFJCzKj1BBIAuv41/pb265k5v1+vW+h1/pMEw2Lg
	DrS6luDQrUa1fcwvi0G/huQNi3OA/DwEeeXo1sOSC5WtlkBXegQRdP9siEmsGupr
	PJhwoMamwbcBO0+VnO26NSBjTlpYj8a7purp14Dw8EPdPoIauQYXqgHXGfGU+zWz
	ITVWCQM2BC9wzw8JEghMA==
X-ME-Sender: <xms:RZivaoTl7EWHTOuLRV1wZZmRRj4CXEiRZGPAvBz4AgSDPNWAK5t4VQ>
    <xme:RZivagklUYXmiECbrN205APQ9qXb_HuR-ESd8zzYQAKkwnBD_XzeOsr3n4yqEFnPU
    kDW-HYGtTek_ePUYGNvWGRy0aujIBSIxgBN8cOjlgONnDLaXZA-Eg4T>
X-ME-Proxy-Cause: dmFkZTGCaH3m0xFSsaIpKqblQDB7Sc6CYd3ZkNYAXZwO6yLeGMBMxpsUWn0pnpmulJ++ah
    RowrN3VOJvQEYOGc5eVDCToM1jkewEdPPVyJazMJnQRSYWfXflrYnRdqvHEG/8Yr5J7R/+
    hQuaRVeJoqNx4aHc0l562/J9nGV+pO+2oc3XKcLMznuQqzWZ59HH1MRoOHaXowOCNuSm6O
    0XM3yUYcqWi1FKGuseEaRUElvpL8TLJtTsXrXf+3YanoefQ2BuB0J2KgZ5jqlXx5tGH1GG
    mWf5e7ifAqGx45DLt3jcEZt/xEwnvWRukkbxUd+WlhObojkMHUJIzRfYTbuVbTf/hzbOas
    AbE3YHt7NnRv750vkt8PmsDDUVWzRcW6QiSwrbkoEHEgSogTwz2UEeynHLKa7vUuji7TuB
    gYxO5Pb45eVkjQavwg/cyyzdjNX+uK2dQe+TFsHFyj0R0vpQlzsaHYVKeRMqrpUoMJPA6y
    jCpYDFfcEHl6Si02w1RqnW37XJpOnSq+GeTxexmcuccCw5enO5G3OJuvm53n546LxkLVxN
    6EkzFJQHPYSvFF7OLzQSLkojHyLTQ3dWCJLaLuoJ88ycYRMJecUqo8B/X3G8nyb1vRNH08
    uNal2yJt7EmXpKlgj4gnzaq0CWu23XM+veLNpTw7xjKObE8tT4hmQ1aOI5vA
X-ME-Proxy: <xmx:R5ivanI-rGltk7zWgDhknBKT16pQR_rQgRO4qc_EBtcT9ZqAmT7L1A>
    <xmx:R5ivar1wOLpzFsuDSR-FNcEUgpOCwJkFmj1S763XwESqpfxQKuMVeg>
    <xmx:R5ivat6iQhv8X5hPg7M4pT-pXaOr13Cgj_-9LRSxrrsuCnOpPMLGzQ>
    <xmx:R5ivak8sqHR62qOsAXzfwjXy07yqiBjsbHP_SOd3_2jqZUZJ4FowGA>
    <xmx:SJivat-fkLGRTnvvZESjLV32j9H6p9OfZTZUszfFXB5VASa4eqkBkywK>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BBF7532A0087; Sun, 20 Sep 2026 04:24:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AeEeCU3uhqow
Date: Sun, 20 Sep 2026 10:24:17 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>,
 "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <403be15d-c852-4fd7-b3bb-af900cf62609@app.fastmail.com>
In-Reply-To: <20260817213840.1053216-2-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-2-rafael@rcpassos.me>
Subject: Re: [PATCH v4 1/4] HID: wiimote: turn on the LEDs indicating the controller id
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Mon, Aug 17, 2026, at 11:38 PM, Rafael Passos wrote:
> The behavior in a Wii/Wii U console is to have each controller turn on
> a different LED indicating the controller id.
> This commit implements the same behavior using the ida struct.
> Unlike switch controllers, each ID only turns one LED (from 1 to 4).
>
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>  drivers/hid/hid-wiimote-core.c  | 52 +++++++++++++++++++++++++++++----
>  drivers/hid/hid-wiimote-debug.c |  5 +++-
>  drivers/hid/hid-wiimote.h       |  1 +
>  3 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c 
> b/drivers/hid/hid-wiimote-core.c
> index 63c4fa8fbb9b..acf31d8b6991 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -621,6 +621,13 @@ static const __u8 * const 
> wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
>  	},
>  };
> 
> +static const __u8 player_leds[] = {
> +	WIIPROTO_FLAG_LED1,
> +	WIIPROTO_FLAG_LED2,
> +	WIIPROTO_FLAG_LED3,
> +	WIIPROTO_FLAG_LED4
> +};
> +
>  static void wiimote_modules_load(struct wiimote_data *wdata,
>  				 unsigned int devtype)
>  {
> @@ -671,6 +678,12 @@ static void wiimote_modules_load(struct 
> wiimote_data *wdata,
>  	spin_lock_irq(&wdata->state.lock);
>  	wdata->state.devtype = devtype;
>  	spin_unlock_irq(&wdata->state.lock);
> +
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		/* after loading modules, set the Player ID LED cycling from 1 to 4*/
> +		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
> +	}
> +

Sorry, I unintentionally sent the previous review in private. Anyway, I also noticed that if you set LEDs unconditionally, you can drop the same call from `wiimod_led_probe()` (the entire block guarded by `ops->arg == 0`).

Not all wiimote devices have LEDs, but I think it is safe to always send the LED request, given that those are embedded in all data requests, IIRC.

Thanks
David

>  	return;
> 
>  error:
> @@ -855,11 +868,11 @@ static void wiimote_init_set_type(struct 
> wiimote_data *wdata,
> 
>  done:
>  	if (devtype == WIIMOTE_DEV_GENERIC)
> -		hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID: 
> %04x EXT: %04x\n",
> -			name, vendor, product, exttype);
> +		hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID: 
> %04x EXT: %04x (%d)\n",
> +			name, vendor, product, exttype, wdata->player_id);
>  	else
> -		hid_info(wdata->hdev, "detected device: %s\n",
> -			 wiimote_devtype_names[devtype]);
> +		hid_info(wdata->hdev, "detected device: %s (%d)\n",
> +			 wiimote_devtype_names[devtype], wdata->player_id);
> 
>  	wiimote_modules_load(wdata, devtype);
>  }
> @@ -1752,6 +1765,7 @@ static struct wiimote_data *wiimote_create(struct 
> hid_device *hdev)
>  	mutex_init(&wdata->state.sync);
>  	wdata->state.drm = WIIPROTO_REQ_DRM_K;
>  	wdata->state.cmd_battery = 0xff;
> +	wdata->player_id = 0; // min 1, u8 0 is unasigned id
> 
>  	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
>  	timer_setup(&wdata->timer, wiimote_init_timeout, 0);
> @@ -1759,12 +1773,17 @@ static struct wiimote_data 
> *wiimote_create(struct hid_device *hdev)
>  	return wdata;
>  }
> 
> +/* Global id allocator for wii remotes */
> +static DEFINE_IDA(wiimote_ida);
> +
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
>  	unsigned long flags;
> 
>  	wiidebug_deinit(wdata);
> 
> +	ida_free(&wiimote_ida, wdata->player_id);
> +
>  	/* prevent init_worker from being scheduled again */
>  	spin_lock_irqsave(&wdata->state.lock, flags);
>  	wdata->state.flags |= WIIPROTO_FLAG_EXITING;
> @@ -1834,7 +1853,14 @@ static int wiimote_hid_probe(struct hid_device *hdev,
>  	if (ret)
>  		goto err_free;
> 
> -	hid_info(hdev, "New device registered\n");
> +	ret = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
> +	if (ret < 1) {
> +		hid_err(hdev, "cannot allocate controller id\n");
> +		goto err_free;
> +	}
> +
> +	wdata->player_id = ret;
> +	hid_info(hdev, "New device registered (Wiimote %d)\n", ret);
> 
>  	/* schedule device detection */
>  	wiimote_schedule(wdata);
> @@ -1887,7 +1913,21 @@ static struct hid_driver wiimote_hid_driver = {
>  	.remove = wiimote_hid_remove,
>  	.raw_event = wiimote_hid_event,
>  };
> -module_hid_driver(wiimote_hid_driver);
> +
> +
> +static int __init wiimote_init(void)
> +{
> +	return hid_register_driver(&wiimote_hid_driver);
> +}
> +
> +static void __exit wiimote_exit(void)
> +{
> +	hid_unregister_driver(&wiimote_hid_driver);
> +	ida_destroy(&wiimote_ida);
> +}
> +
> +module_init(wiimote_init);
> +module_exit(wiimote_exit);
> 
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> index 5f74917781f2..fc847c2a1c1f 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -186,12 +186,14 @@ int wiidebug_init(struct wiimote_data *wdata)
>  	dbg->drm = debugfs_create_file("drm", S_IRUSR,
>  			dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
> 
> +	debugfs_create_u8("player_id", S_IRUSR,
> +		   dbg->wdata->hdev->debug_dir, &wdata->player_id);
> +
>  	spin_lock_irqsave(&wdata->state.lock, flags);
>  	wdata->debug = dbg;
>  	spin_unlock_irqrestore(&wdata->state.lock, flags);
> 
>  	return 0;
> -
>  }
> 
>  void wiidebug_deinit(struct wiimote_data *wdata)
> @@ -208,5 +210,6 @@ void wiidebug_deinit(struct wiimote_data *wdata)
> 
>  	debugfs_remove(dbg->drm);
>  	debugfs_remove(dbg->eeprom);
> +	debugfs_lookup_and_remove("player_id", dbg->wdata->hdev->debug_dir);
>  	kfree(dbg);
>  }
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 9c12f63f6dd2..8e5002f515e2 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -153,6 +153,7 @@ struct wiimote_data {
>  	struct input_dev *mp;
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
> +	u8 player_id;
> 
>  	union {
>  		struct input_dev *input;
> -- 
> 2.55.0
