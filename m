Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3443E0C47
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892496; cv=none; b=AnWaLS205rKFH70YUHElYKcwiN70UublTsgAM83LJB/bPu5vUvlmoQmW7oXONGtW3yxBtmdbw7FevouXsX4VTyIOvPvig6g4LlZw3GgeOfk3CHsrC9m/Drw7Uf/2/xcDT4WWFECr2Qufwp6QDpdycT028ZYZyFhdZPPs18AAvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892496; c=relaxed/simple;
	bh=HLSbA0y0kzYwRpoPRYwiuICjEKnVoKMnAfarxmos7WY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZN3JKfCntY10TRF/nFO7wpD+0zNuKCM7+4p0uR5B2Y8ju6q4ixWrNFDPbx3R8wMKCvCVPJ7EmbUdjtXMSojhUaHC46fCGh/L9OE9kQNA6FChtgmCrFuxfq+rk5+GlUauyofG1+sgxijt5pJI8LZWv0llUtHrGegnsegwOw8hjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=COh0O5BH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WKzSxCbT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="COh0O5BH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKzSxCbT"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FCAD1D0009D;
	Sun, 20 Sep 2026 04:21:30 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789892489;
	 x=1789978889; bh=AKFBjAOscnozIhJzIUf+6O/T9Uklj5ZGAFbmFyUKE+A=; b=
	COh0O5BHNSo3oj10LB3baq6FKyl0vCrgZ215JWwbuJEIXPyMDk6eEpIS9RYEBKRQ
	tmIB1py5ifQdm3moqRUw6W0RTATaYoUfgsoKIAtIn8njzo98fxiB3i8A3sb2ZUB7
	I0i1O6FKZqdoXMai4gydv+fcZig08ZtxIqYkMu5CkzBKYt+Uv/2As/pbRTnazafZ
	pMngk9MJU3YrXfLjlX4WcWr0WMGyw0W20ydEa8RdqlgxTRHuzAI1HLjR6Mfgpb6e
	E5vAMQ9J9ddGwOMngQd9oSydlJtLAy8YwfSH3uPz4gjkyFrAjn2oU3bcRzKVx/Dv
	t96B+/LXy4sB9ivs5ss8Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789892489; x=
	1789978889; bh=AKFBjAOscnozIhJzIUf+6O/T9Uklj5ZGAFbmFyUKE+A=; b=W
	KzSxCbTMrHAWTJECBW2v5FORg4QqPjWz5rfCeUHOYn4Wi0DiZmx1fKJ9gZMnJu4F
	TmDtiNn84GP5NNa0Xm4f/EfaWD1lMBq+UF83XQ2kPaozzLjz4X1odNibJXt1XaEV
	wIB67aBNrez4Q0xyXOiZ7aMylo07Wvb9fX8HSXqxrZ8+++bnBESEVmmBj3tcjKrD
	KFHvFMRu+UGPBfS/p0xEGpnG5hrHmU8mXArs7JSK5Qmc+MSWvrw9VR7FxjEYNU5H
	JOpghA5edDqbH5ZLGq1Gzj5bqbi9SjLfNycPz5Ag03ESXwRvKR17VWFtJaRCDsVz
	g+/RzHQshoqySQYHIrD6w==
X-ME-Sender: <xms:h5evarioq3rovqvRhLQJ_naldhdH79hedCNMVKsn_ClAo0kP4OwoAw>
    <xme:h5evai362mkps9Hg9V8LUUajUHnPlTxIqFQ5BhPxXGbtrASf3JqwiG7L3Otm8z2f9
    zL8FnUhva-12WVGQBfa5znQ-NVd3ZTIoUHjSHBxr7PSg9yHWwWRRkJBdg>
X-ME-Proxy-Cause: dmFkZTF3+KI0QmB0NAhlLZCiIzzRmsFzFijUvRykDNWblNInQfhfUTZOAjBguf1FO++A6r
    0GogVScokLdICa5sxMBiqMFUMi1tKNsTVV/bE/eE475vkCASIT1k2aESNONoRh2+zDixq+
    6VR+OPoUEffEWIAYb4x/WgNfb//Pwj7FByRO1gd75z8IdZh7KaPgrB869sui75qkeJNy6N
    QUG+2a5KAUrKcKr5XPSTRo9AbgMUUMOaMoCAxgftS5Y3+IjV9iOgav1I6HFEOayU7JyL8H
    KJwYNpDdZgJ3izLJT7YIGaM91aF6SQ1HgnJRN9yCrqfch4lagUmRYcHTXo6pNHuADYR9jZ
    eGtQnyJ/XXek4cSEycMBvVgBxvcFGLDbrNr84B8oFF8mjUPloKhdUJ5nertsM52LenCvOn
    mP+X+PwRInVgBNZMDaQw/cM3+0zLEM0Vs+HbsMK9FAr8UXhbTZ86s3sjS804pd/L9UE2iO
    De0D+Y/QILxg7aYGlJH1GjNKrK02UnMuEE9W8Cpdc/5ct3RHMUzSpB844A1JOcLTGzbIiv
    /h9PFYwxUFvG8GXoQoiNqrh7Ftv+J6afKNRUpZsqdMO8clTOyhYqpxCA8fKvxwDfnqQbdQ
    scz5Dew87MVthPl/CSLjD+G7mEFEdMC7kqcEAY/5DsrVx11dNP04jWizuSNA
X-ME-Proxy: <xmx:iJevakHL_XlVzKNdPwfFgWmM5WGK_BBSD7e3b8s7iUXX_mC3pLZe5w>
    <xmx:iJevahLFTPvzPGUV9U-Pc5QbWb6E4SFrLolEtZJptpqf4jaM7it5ig>
    <xmx:iJevanN0o5M56KfyQMSdsbFHvjU_MTdC4m_BqaENr_fjeJ1pe3nHXA>
    <xmx:iJevaplCFj9xcofpDaUk1loP9gLbFK5iw7N25GaPtnT0NefvbKTbuw>
    <xmx:iZevaqdl5H_0meNWpYmeRUfcOwNnX7XdOK6Jde7eBzYSk7r85VPw604n>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E456032A008C; Sun, 20 Sep 2026 04:21:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2u1MfG_RU7N
Date: Sun, 20 Sep 2026 10:21:06 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>,
 "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <efe87355-ad73-401b-b236-18eb9e398498@app.fastmail.com>
In-Reply-To: <20260817213840.1053216-5-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-5-rafael@rcpassos.me>
Subject: Re: [PATCH v4 4/4] HID: wiimote: wiimote_probe with scoped cleanup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Mon, Aug 17, 2026, at 11:38 PM, Rafael Passos wrote:
> Use the safer scoped cleanup with a single destroy function.
> A new bitmask was introduced to track probing state.
> This is needed because the hid_hw calls cannot be made with null.
>
> A few other functions are safe to call without checking.
> These cases are annotated with comments above them.
>
> Also, a new debugfs entry was added tracking this new state (bitmask).
>
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>

I am really not sold on this. This does not make the code any simpler, does it? IMO, the goto-paths are much easier to read than tracking the state at runtime.

Do you think this makes the code easier to understand? Am I off here?

Thanks
David

> ---
>  drivers/hid/hid-wiimote-core.c  | 78 +++++++++++++++++++--------------
>  drivers/hid/hid-wiimote-debug.c |  4 ++
>  drivers/hid/hid-wiimote.h       |  9 ++++
>  3 files changed, 58 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index 05f8ddb7909b..044da4daa010 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -679,6 +679,8 @@ static void wiimote_modules_load(struct wiimote_data *wdata,
>  		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
>  	}
> 
> +
> +	wdata->init_state |= WIIMOTE_MODULES_LOADED;
>  	return;
> 
>  error:
> @@ -742,6 +744,8 @@ static void wiimote_ext_load(struct wiimote_data 
> *wdata, unsigned int ext)
> 
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock)
>  		wdata->state.exttype = ext;
> +
> +	wdata->init_state |= WIIMOTE_EXT_LOADED;
>  }
> 
>  static void wiimote_ext_unload(struct wiimote_data *wdata)
> @@ -774,6 +778,8 @@ static void wiimote_mp_load(struct wiimote_data *wdata)
> 
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock)
>  		wdata->state.mp = mode;
> +
> +	wdata->init_state |= WIIMOTE_MP_LOADED;
>  }
> 
>  static void wiimote_mp_unload(struct wiimote_data *wdata)
> @@ -1751,39 +1757,56 @@ static DEFINE_IDA(wiimote_ida);
> 
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
> +	if (!wdata)
> +		return;
> +
> +	// safe, debugfs checks IS_ERR_OR_NULL
>  	wiidebug_deinit(wdata);
> 
> -	ida_free(&wiimote_ida, wdata->player_id);
> +	if (wdata->player_id)
> +		ida_free(&wiimote_ida, wdata->player_id);
> 
>  	/* prevent init_worker from being scheduled again */
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock)
>  		wdata->state.flags |= WIIPROTO_FLAG_EXITING;
> 
> -	cancel_work_sync(&wdata->init_worker);
> -	timer_shutdown_sync(&wdata->timer);
> +	if (wdata->init_state & WIIMOTE_PROBE_READY) {
> +		cancel_work_sync(&wdata->init_worker);
> +		timer_shutdown_sync(&wdata->timer);
> +	}
> 
> +	// safe, checks dev for NULL
>  	device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
>  	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
> 
> -	wiimote_mp_unload(wdata);
> -	wiimote_ext_unload(wdata);
> -	wiimote_modules_unload(wdata);
> +	if (wdata->init_state & WIIMOTE_MP_LOADED)
> +		wiimote_mp_unload(wdata);
> +	if (wdata->init_state & WIIMOTE_EXT_LOADED)
> +		wiimote_ext_unload(wdata);
> +	if (wdata->init_state & WIIMOTE_MODULES_LOADED)
> +		wiimote_modules_unload(wdata);
> +
>  	cancel_work_sync(&wdata->queue.worker);
> -	hid_hw_close(wdata->hdev);
> -	hid_hw_stop(wdata->hdev);
> +
> +	if (wdata->init_state & WIIMOTE_PROBE_HW_OPENED)
> +		hid_hw_close(wdata->hdev);
> +	if (wdata->init_state & WIIMOTE_PROBE_HW_STARTED)
> +		hid_hw_stop(wdata->hdev);
> 
>  	kfree(wdata);
>  }
> 
> +DEFINE_FREE(wiimote_probe_cleanup, struct wiimote_data *,
> +	wiimote_destroy(_T))
> +
>  static int wiimote_hid_probe(struct hid_device *hdev,
>  				const struct hid_device_id *id)
>  {
> -	struct wiimote_data *wdata;
>  	int ret;
> 
>  	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
> 
> -	wdata = wiimote_create(hdev);
> +	struct wiimote_data *wdata __free(wiimote_probe_cleanup) = 
> wiimote_create(hdev);
>  	if (!wdata) {
>  		hid_err(hdev, "Can't alloc device\n");
>  		return -ENOMEM;
> @@ -1792,41 +1815,43 @@ static int wiimote_hid_probe(struct hid_device 
> *hdev,
>  	ret = hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "HID parse failed\n");
> -		goto err;
> +		return ret;
>  	}
> 
>  	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>  	if (ret) {
>  		hid_err(hdev, "HW start failed\n");
> -		goto err;
> +		return ret;
>  	}
> +	wdata->init_state |= WIIMOTE_PROBE_HW_STARTED;
> 
>  	ret = hid_hw_open(hdev);
>  	if (ret) {
>  		hid_err(hdev, "cannot start hardware I/O\n");
> -		goto err_stop;
> +		return ret;
>  	}
> +	wdata->init_state |= WIIMOTE_PROBE_HW_OPENED;
> 
>  	ret = device_create_file(&hdev->dev, &dev_attr_extension);
>  	if (ret) {
>  		hid_err(hdev, "cannot create sysfs attribute\n");
> -		goto err_close;
> +		return ret;
>  	}
> 
>  	ret = device_create_file(&hdev->dev, &dev_attr_devtype);
>  	if (ret) {
>  		hid_err(hdev, "cannot create sysfs attribute\n");
> -		goto err_ext;
> +		return ret;
>  	}
> 
>  	ret = wiidebug_init(wdata);
>  	if (ret)
> -		goto err_free;
> +		return ret;
> 
>  	ret = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
>  	if (ret < 1) {
>  		hid_err(hdev, "cannot allocate controller id\n");
> -		goto err_free;
> +		return ret;
>  	}
> 
>  	wdata->player_id = ret;
> @@ -1834,24 +1859,10 @@ static int wiimote_hid_probe(struct hid_device *hdev,
> 
>  	/* schedule device detection */
>  	wiimote_schedule(wdata);
> +	wdata->init_state |= WIIMOTE_PROBE_READY;
> 
> +	retain_and_null_ptr(wdata);
>  	return 0;
> -
> -err_free:
> -	wiimote_destroy(wdata);
> -	return ret;
> -
> -err_ext:
> -	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
> -err_close:
> -	hid_hw_close(hdev);
> -err_stop:
> -	hid_hw_stop(hdev);
> -err:
> -	input_free_device(wdata->ir);
> -	input_free_device(wdata->accel);
> -	kfree(wdata);
> -	return ret;
>  }
> 
>  static void wiimote_hid_remove(struct hid_device *hdev)
> @@ -1902,3 +1913,4 @@ module_exit(wiimote_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
>  MODULE_DESCRIPTION("Driver for Nintendo Wii / Wii U peripherals");
> +
> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> index b8027bb23608..1353ab022acb 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -184,6 +184,9 @@ int wiidebug_init(struct wiimote_data *wdata)
>  	debugfs_create_u8("player_id", S_IRUSR,
>  		   dbg->wdata->hdev->debug_dir, &wdata->player_id);
> 
> +	debugfs_create_u8("init_state", S_IRUSR,
> +		   dbg->wdata->hdev->debug_dir, &wdata->init_state);
> +
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock)
>  		wdata->debug = dbg;
> 
> @@ -203,5 +206,6 @@ void wiidebug_deinit(struct wiimote_data *wdata)
>  	debugfs_remove(dbg->drm);
>  	debugfs_remove(dbg->eeprom);
>  	debugfs_lookup_and_remove("player_id", dbg->wdata->hdev->debug_dir);
> +	debugfs_lookup_and_remove("init_state", dbg->wdata->hdev->debug_dir);
>  	kfree(dbg);
>  }
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 8e5002f515e2..147751973702 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -154,6 +154,7 @@ struct wiimote_data {
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
>  	u8 player_id;
> +	u8 init_state;
> 
>  	union {
>  		struct input_dev *input;
> @@ -376,4 +377,12 @@ static inline int wiimote_cmd_wait_noint(struct 
> wiimote_data *wdata)
>  		return 0;
>  }
> 
> +/* controller initialization tracker bits */
> +#define WIIMOTE_PROBE_HW_STARTED  BIT(0)  // hid_hw_start succeeded
> +#define WIIMOTE_PROBE_HW_OPENED   BIT(1)  // hid_hw_open succeeded
> +#define WIIMOTE_PROBE_READY       BIT(2)  // wiimote_schedule succeeded
> +#define WIIMOTE_MP_LOADED         BIT(3)  // wiimote_mp_load succeeded
> +#define WIIMOTE_EXT_LOADED        BIT(4)  // wiimote_ext_load succeeded
> +#define WIIMOTE_MODULES_LOADED    BIT(5)  // wiimote_modules_load succeeded
> +
>  #endif
> -- 
> 2.55.0
