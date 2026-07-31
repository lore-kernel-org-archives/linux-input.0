Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB11DF75B
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488551; cv=none; b=VMjTxtACxEt9iqWMMvgdFQIWY4ewJTsPPa6lb4CIz0BhAFz2wHag8AuCqkqLfFcBFp+vQ986KbAJ8w9pGHIyxp7Zv5dyzvRoz3frmzaN2Yk9mdPXL2nmYuJqn8OuRT5bZsL49BgW7DPilEOmOSnvTR2aum/cD0rSTfxSLnDeZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488551; c=relaxed/simple;
	bh=VC4165L+siZIia2Ie69QUfBXRoz37yzOJE7VNJRs4Kw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TJa8j58RFOqn07gTvui2PjUo0Hg5UMvTMMpLdAuOC4FxFKpPLzU4w+zQOen4BSr1SGkrXvOhA2Yry1FszkZSsWkK7Jk+w6nczBsB8DBbGYhk4Mz6hiEOyJFtxb/T7rs+ulBx5JFafjO5O6Bqd/0Y/6aubKrgNuAaFX2s8ne2jYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=ZgZRKbkj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+0p0GG+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="ZgZRKbkj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+0p0GG+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D2AA7A0138;
	Fri, 31 Jul 2026 05:02:26 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jul 2026 05:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785488546;
	 x=1785574946; bh=7QXLGz4Zv0w46l+IaJ0064nYpfyvutpzgaTRmTJACm4=; b=
	ZgZRKbkjP0Acx9y3cVP0bt5jCQ4oxTvEbwx+aTk2v4YZlauWqOw+JFgWXtODESDM
	co6pz3r5kH38qdX/hBfXLbotPjZIE6l+CLp2FxVHo0mcQOEhGQnv9l++sgdqcY6E
	/2PizkeDCw3IHuBKSd4IeLa7TJA9nvxZh1hxldowZarfW2vkWcjJ6QG2VUZgAZVT
	WVuRpSvZnJ/F9RXeqwb0B/ylORgTg/RuUJzRP1/tNTrw2sjFm9xaPQWFLAvKuD0l
	liIVNk+AFkaS1Jf+GCZUM5K3otASqr2b/LAdMARmNT0KWM9/XCeBXBpa9G08tvO7
	3F95gNY6lpPXnx+pFd/kuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785488546; x=
	1785574946; bh=7QXLGz4Zv0w46l+IaJ0064nYpfyvutpzgaTRmTJACm4=; b=D
	+0p0GG+MDnl+iHa7oeou5IWmg8m+Nd3sDwDzhF3EE462MZNK1+q5zslYXeIvPVyD
	TjtyIzSUV2OuvaG14LFba3MjyZ2t8wIJSYv8oeKIKKHJkp8m9VZb44H9My2ze6mR
	deetcfkBDaFNYnz6F3EOAzr3bO+AjU8FQPu/FOIqUmK4wG7Tk3WiLBMtkHhamNPn
	+gGDMpyj8H3oTynP7n37IY2w2ZEEja4CTaLQrtx8/neoMMpOb6343ohkyW8F+1Ds
	XoLuScNJiDQG0AaNGQp3qThrsaBXKian+63eh4uFQdp3Q69KL/gqpVrhMINH/umC
	ppUz+xRo8BM2/q6F5efVg==
X-ME-Sender: <xms:oWRsarZhwJ3YiVkDOSHKFCh4Qz5LZJ-1cavZkr0DK_IryCl2J2_8VA>
    <xme:oWRsalPyCcaoe6jvHrW8hnvhd32N-8zglSbT5pS5Gb8SeBVlOM-1tcCI_GGuipdK4
    8cESc77ldePsFElHPgGj7gvbzioLLe4cImiY9H-L80MrWxlvmVO_Dk>
X-ME-Proxy-Cause: dmFkZTEArNf3nNNpeXwUnatP+8nZQdTOAOTgP4j7vGZDXRi+c1Wbo7MaR+aa+F0CbbndLX
    CceuieSrYZ7oZunUfQPIRglc86WYNRM6SsYbKOfuG+NfSxJQv/5CMTvEK4xc2q/Mvg5fWZ
    06HtckmuORtDml4K4CMIJR3W41bHwO2WWCemZw3y47w04YxsDbSJ2r9jXqkc8Y0cPP2xtb
    6IN0xPDiR4sjI0Af1ynl8lgi7EZM5Uc6KVuvjTNWTcg9ydXuvBaVr//Jkc7tqEM3J0VFbp
    f0MCvqDspvHE1ULn8B6Ek9AjJSx7kGzx7uTN/A1XqU4lu0Vbx0qW0CMz2SxOyAHki8YpeO
    vgU8VmTyGV6CPfPp4Gn0IaB9S2hIj6vqN3BFSVURSmiz64U587jtogDshH1HQBjScFS3n2
    kr6OT8RBr/iTlUwGQa+lL2RJPvnTAd5jvX43NmXsiEKdJL2HK/mC+ujzg+8Bhc+8OAPc4N
    uqu0IQCT18FXBOP5xLeAeFHCheSym4ljl2YVoS/wsXbETJT2DoYoU68HcAxhqMGhloLLdO
    Vs5xjljmt13Ylq/YTtJyGt1m0coB7LEXZFxbdUurxsH8sCUsHgVYzp3HPAbh0UGPDivgJ/
    HxoBZMX0JHh8WNnbs/hpWbWGvoj8tDY2xjrNVsJSQYgl4UVMyZDGbhRcoQuA
X-ME-Proxy: <xmx:oWRsalS0QqIfI7MXUi9MlEdwnywCndfqhxKjHMkD3las9IXWZjRRWw>
    <xmx:oWRsavetiajvvis9lSlDFcjIm1dvykB4zs7_vieYDOZ9IXQ4sFMGGA>
    <xmx:oWRsapDQU07mcIOWl7oKf0yNW_zRqugswZsAT-swX6KdWUqS4N-HaQ>
    <xmx:oWRsahmNHh53RieEvimfRmQlzyW8yitOgo6rbVTbE5afV9q_4JbYVw>
    <xmx:omRsalGTbxMoTnBfUWzt7_HJLnhxdXjQLxDwm-Rv_L5BURGp4rJ5wn1n>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AEBA61EA006B; Fri, 31 Jul 2026 05:02:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_FoBlbN4D9R
Date: Fri, 31 Jul 2026 11:02:03 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <6ffe2879-5d76-42b3-bd65-2180967d1498@app.fastmail.com>
In-Reply-To: <20260729164928.1138468-2-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-2-rafael@rcpassos.me>
Subject: Re: [PATCH v3 1/4] HID: wiimote: turn on the LEDs indicating the controller id
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Wed, Jul 29, 2026, at 6:49 PM, Rafael Passos wrote:
> The behavior in a Wii/Wii U console is to have each controller turn on
> a different LED indicating the controller id.
> This commit implements the same behavior using the ida struct.
> Unlike switch controllers, each ID only turns one LED (from 1 to 4).
>
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>  drivers/hid/hid-wiimote-core.c | 54 ++++++++++++++++++++++++++++++----
>  drivers/hid/hid-wiimote.h      |  1 +
>  2 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c 
> b/drivers/hid/hid-wiimote-core.c
> index 63c4fa8fbb9b6..48830f2ffcb50 100644
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
> @@ -1786,11 +1799,15 @@ static void wiimote_destroy(struct wiimote_data *wdata)
>  	kfree(wdata);
>  }
> 
> +/* Global id allocator for wii remotes */
> +static DEFINE_IDA(wiimote_ida);
> +
>  static int wiimote_hid_probe(struct hid_device *hdev,
>  				const struct hid_device_id *id)
>  {
>  	struct wiimote_data *wdata;
>  	int ret;
> +	int player_id;
> 
>  	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
> 
> @@ -1834,7 +1851,16 @@ static int wiimote_hid_probe(struct hid_device *hdev,
>  	if (ret)
>  		goto err_free;
> 
> -	hid_info(hdev, "New device registered\n");
> +	player_id = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
> +	if (player_id < 1) {
> +		hid_err(hdev, "cannot allocate controller id\n");
> +		ret = player_id;
> +		goto err_free;
> +	}
> +
> +	wdata->player_id = player_id;
> +
> +	hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);

`wiimote_create()` should initialize `wdata->player_id` to -1, so `ida_free()` is a no-op in the `err_free` path. Right now it is implicitly initialized to 0, and thus ida_free() will warn about an unallocated ID.

Also: Why not just use IDs starting from 0?

Lastly, this initialization can be simplified to:

ret = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
if (ret < 1) {
	hid_err(hdev, "cannot allocate controller id\n");
	goto err_free;
}

wdata->player_id = ret;

> 
>  	/* schedule device detection */
>  	wiimote_schedule(wdata);
> @@ -1862,6 +1888,8 @@ static void wiimote_hid_remove(struct hid_device *hdev)
>  {
>  	struct wiimote_data *wdata = hid_get_drvdata(hdev);
> 
> +	ida_free(&wiimote_ida, wdata->player_id);
> +
>  	hid_info(hdev, "Device removed\n");
>  	wiimote_destroy(wdata);
>  }
> @@ -1887,7 +1915,21 @@ static struct hid_driver wiimote_hid_driver = {
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
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 9c12f63f6dd2d..a53f72d5077ef 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -153,6 +153,7 @@ struct wiimote_data {
>  	struct input_dev *mp;
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
> +	__u8 player_id;

You can use `u8`. Double underscore is only needed for uapi headers.

Otherwise looks good!

David

> 
>  	union {
>  		struct input_dev *input;
> -- 
> 2.53.0
