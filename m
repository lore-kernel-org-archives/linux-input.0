Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39993EB81D
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496764; cv=none; b=SGWX/utlvPDXomlPpgmofVoiOd1Oup0tRBG5TAcO5Q9NV2bG7m2UMty593RUNiDiU7kXk6XZZRjjZl1w8hf/w0RNCBJvHQ6ZW/59mEIuQ2HehrMe3m737DMRX7p0Zs/AU8Gb7mfeeJlAxtHvBU4wBJqfX3GYk6UQeR+JWIaXLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496764; c=relaxed/simple;
	bh=0/5jZ6QcOVX9U1CCgxf+T3U91DdTpNUCQsmQyTkomrM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ITH5F/QwGgOdv96RJNlYHcLi6/IaNYiOyyDcm5VCFgp5G1hO+gkxOrjCSpma/H1npfemD+EffbrLCFl9hxIWu0oU2aj38PCMm+uekSF1dU3XzqndFQdGXvPc/FnaGSixnOiNYoVsgVSMKi4exmWFbivBRHObLqVGToGgFlcqICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=P1Eqyz+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxXaA5t0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="P1Eqyz+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxXaA5t0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CECB21D00137;
	Fri, 31 Jul 2026 07:19:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jul 2026 07:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785496760;
	 x=1785583160; bh=s7NARfyBbwDYgjOlIBdn4wD//rGHJOB4bicBtMbePhk=; b=
	P1Eqyz+YpZ4/0oT063grUXCvo7G8/JTTzj1uqnHP1TaoqZPnqawZKuPn+fndXWiE
	a+Mng1x8TwxY1rAf3MYrJXi4bFMd8aOni8/AEzpuQCho4cM/AngXp/ueUOPpF5WF
	o2oLbXFPOD22OWQRP1DsZmm0jRPwlle55feP3tn2xHCrn+cf2ZMyIQ02TXiuidrA
	dP+0Cy1o5YrIOLSSyOys908bcvyOZf16l5PfUSol6YtDs+pLhBY+vCwR8EzzPma9
	DgzoeErxMxmyP/Jsmd+KY/C2gWDcunIvg/C+JtEdoU/FCtrUYy087p/qVtrdNRWg
	z/RqqPPTK6iI/OIsoJ+d8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785496760; x=
	1785583160; bh=s7NARfyBbwDYgjOlIBdn4wD//rGHJOB4bicBtMbePhk=; b=T
	xXaA5t0MeyIh6yuolIGa5a/zFmb8vCLgLzTjD9xJwI0JPfWRqDrU/vKnV4eNG2mX
	OgLTqqeeY1raM/O4sQTspvounuy6z4cdsM96ttPcR8+VywFE06Ki8xRGztNlE6f8
	WBrZqkGouKi4losC5//fRDemssFXF7SJ2Qvl4VVesmRRZoef2ac2e3X27jB+fcUu
	CVkDlPEP0ZXLLfr0ZxEvXXP322z8IcGOYvRk/EWrjqRMdP6Dd8Os8M10jPmTXd01
	J53usFtQN0qadOKmh6qeErHx+aEQQWZWw2fRuG+qAjktEOtmnzauGoqk/RaVdsY5
	TrivCmhHJt4NrlIwDsY7Q==
X-ME-Sender: <xms:uIRsaqO9DXQnyEnLUxSlPGVpAC1o4KEhuKNVKafaodHs3JxaOeqVLg>
    <xme:uIRsajwEDcoXEPnkEU37E3gEo37DdtuviWb3wnkqGZ_DWfVAErc_IAkl9McGTYeEm
    RlWr2-Eq_is2pEOVkuv-HlefuHQJcCYv_bS-rT0d3cOz9P2Qol8iA>
X-ME-Proxy-Cause: dmFkZTFxF4lUlUJBuRLZgIc88aNJLprpetElOsgju8dkVm7ACM1I7kIOOyBfUg2d4Jl74t
    tFSSQnjUgyOS4IUZ4P2fLsCu5VDHkq6wYdKYC8R2xbr3zQmkybSkRsPQbrHihs2R3NUep3
    Q6mWyMMm8TLu0kmwc9RUmTrAe1WjpER6umEMlhyUTFXvC6BsEFFInjRlFubTuqvqZ5HwoW
    Vpc4pROD2SBSrifqNYtpvP2a8eeMHkNjPFVrYryLTkxMMQaz3/9gdZUBCXLECcoUrd/JVn
    tYeM4DzlCJRz8aPk+nlqvn72ljTrS8nlRTt0VK1fQ0phLBknIJNPlvZoasgVgXeiI/45gu
    21e2qryHbxTw1jzAFQZm3jBRDyh8mNrvwgPIo8eDcImEKULyiRxTj/EQ/0zqE4qAOZvo7s
    Qr5zicSkG6ZueX1tJuMvq/rsGHaR7zSwV65PNkT/0KxLqTXP/VmDzZ5khwcOornkmZ/Y5s
    bNaNmztqwgIyJfomLbb4dLIFzKub/rduT0MOmfYM3if96kLJRs3SrtQtj+nJfW0QpzMxqr
    4UrsLsSojhripjhTHIlQTb7d7JrzZOjhWMTpdOHhZgFeQDBbvyGGecWJAsr26Ms3G8KUzQ
    03+IdEzlFvc91SaCVpgG1Juj9VoPPeAPv37dF8ruhPAs/dvZvMC4AzuwKVMw
X-ME-Proxy: <xmx:uIRsavnaEZ3he8TDarysMux1CodUtpTV8v8aUOn9N5se2dnG510xmQ>
    <xmx:uIRsajhgkUX-mnkcuUeaB0b55YindqXQ7OdAZq493DocCHxXsEn4-Q>
    <xmx:uIRsaj0crcbQ1Hs8UJQRIt8IZ8wjb2lmLPcuMjQX8TWpn_6zpBT2-g>
    <xmx:uIRsasIznV8wrSlQ0lcJeuIVVv8tSuuizmoAtvBgWqn9WQZsxpzhrA>
    <xmx:uIRsal4_ZgKUCgYmfQTg2zpYCUa9LyU_jelyfiiK-7FOYB2M8w0rs4zZ>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2B56E1EA006B; Fri, 31 Jul 2026 07:19:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFRbf3cIW8tN
Date: Fri, 31 Jul 2026 13:18:57 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <42b2b3bf-a165-4caf-a746-0c37bfa925a2@app.fastmail.com>
In-Reply-To: <20260729164928.1138468-4-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-4-rafael@rcpassos.me>
Subject: Re: [PATCH v3 3/4] HID: wiimote: use scoped cleanup in wiimote and led probes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Wed, Jul 29, 2026, at 6:49 PM, Rafael Passos wrote:
> Cleanup code in wiimote/led probe function, using the scoped cleanup.
> This prevents mistakes in future changes to this function.
>
> In wiimote_probe_clenaup, a few functions are safe to call without
> checking. For the hid_hw calls, a new bit mask was introduced to track
> probing state.

Is this patch worth it? the led-probe looks ok, but the wiimote_probe() change looks convoluted. If you really want to go that route I would prefer if you reuse wiimote_destroy() and ensure it checks for the right conditions, rather than adding __wiimote_probe_cleanup().

Thanks
David

> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>  drivers/hid/hid-wiimote-core.c    | 68 ++++++++++++++++++-------------
>  drivers/hid/hid-wiimote-modules.c | 17 ++++----
>  drivers/hid/hid-wiimote.h         |  1 +
>  3 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index 762b3c383194e..31ee86affc553 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -1772,16 +1772,40 @@ static void wiimote_destroy(struct wiimote_data *wdata)
>  /* Global id allocator for wii remotes */
>  static DEFINE_IDA(wiimote_ida);
> 
> +#define WIIMOTE_PROBE_HW_STARTED  BIT(0)  // hid_hw_start succeeded
> +#define WIIMOTE_PROBE_HW_OPENED   BIT(1)  // hid_hw_open succeeded
> +
> +static void __wiimote_probe_cleanup(struct wiimote_data *wdata)
> +{
> +	if (!wdata)
> +		return;
> +
> +	if (wdata->player_id)
> +		ida_free(&wiimote_ida, wdata->player_id);
> +
> +	// safe, debugfs checks IS_ERR_OR_NULL
> +	wiidebug_deinit(wdata);
> +	// safe, checks dev for NULL
> +	device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
> +	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
> +	if (wdata->probe_state & WIIMOTE_PROBE_HW_OPENED)
> +		hid_hw_close(wdata->hdev);
> +	if (wdata->probe_state & WIIMOTE_PROBE_HW_STARTED)
> +		hid_hw_stop(wdata->hdev);
> +	kfree(wdata);
> +}
> +
> +DEFINE_FREE(wiimote_probe_cleanup, struct wiimote_data *,
> +	__wiimote_probe_cleanup(_T))
> +
>  static int wiimote_hid_probe(struct hid_device *hdev,
>  				const struct hid_device_id *id)
>  {
> -	struct wiimote_data *wdata;
>  	int ret;
> -	int player_id;
> 
>  	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
> 
> -	wdata = wiimote_create(hdev);
> +	struct wiimote_data *wdata __free(wiimote_probe_cleanup) = 
> wiimote_create(hdev);
>  	if (!wdata) {
>  		hid_err(hdev, "Can't alloc device\n");
>  		return -ENOMEM;
> @@ -1790,68 +1814,54 @@ static int wiimote_hid_probe(struct hid_device 
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
> +	wdata->probe_state |= WIIMOTE_PROBE_HW_STARTED;
> 
>  	ret = hid_hw_open(hdev);
>  	if (ret) {
>  		hid_err(hdev, "cannot start hardware I/O\n");
> -		goto err_stop;
> +		return ret;
>  	}
> +	wdata->probe_state |= WIIMOTE_PROBE_HW_OPENED;
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
> -	player_id = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
> +	int player_id = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
>  	if (player_id < 1) {
>  		hid_err(hdev, "cannot allocate controller id\n");
>  		ret = player_id;
> -		goto err_free;
> +		return ret;
>  	}
> -
>  	wdata->player_id = player_id;
> 
> +
>  	hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);
> 
>  	/* schedule device detection */
>  	wiimote_schedule(wdata);
> -
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
> diff --git a/drivers/hid/hid-wiimote-modules.c 
> b/drivers/hid/hid-wiimote-modules.c
> index 3cd6144667404..47fa6a8ecdaef 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -341,11 +341,11 @@ static int wiimod_led_probe(const struct 
> wiimod_ops *ops,
>  {
>  	struct device *dev = &wdata->hdev->dev;
>  	size_t namesz = strlen(dev_name(dev)) + 9;
> -	struct led_classdev *led;
>  	char *name;
>  	int ret;
> 
> -	led = kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
> +	struct led_classdev *led __free(kfree) =
> +		kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
>  	if (!led)
>  		return -ENOMEM;
> 
> @@ -359,8 +359,12 @@ static int wiimod_led_probe(const struct wiimod_ops *ops,
> 
>  	wdata->leds[ops->arg] = led;
>  	ret = led_classdev_register(dev, led);
> -	if (ret)
> -		goto err_free;
> +	if (ret) {
> +		wdata->leds[ops->arg] = NULL;
> +		return ret;
> +	}
> +
> +	retain_and_null_ptr(led);
> 
>  	/* enable LED1 to stop initial LED-blinking */
>  	if (ops->arg == 0) {
> @@ -369,11 +373,6 @@ static int wiimod_led_probe(const struct wiimod_ops *ops,
>  	}
> 
>  	return 0;
> -
> -err_free:
> -	wdata->leds[ops->arg] = NULL;
> -	kfree(led);
> -	return ret;
>  }
> 
>  static void wiimod_led_remove(const struct wiimod_ops *ops,
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index a53f72d5077ef..6812efa589c93 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -154,6 +154,7 @@ struct wiimote_data {
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
>  	__u8 player_id;
> +	__u8 probe_state;
> 
>  	union {
>  		struct input_dev *input;
> -- 
> 2.53.0
