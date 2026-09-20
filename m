Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99983E51C6
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892262; cv=none; b=YiBmhm1igAkAszzZCpDP4cWLPVC9c6NVblKmlGf3BFPlSMYaEMHZC31VXmPCyI2bS0OERvHBXxAHrkocdm2RkK984j4qLlr1k+nCVY2mSFwVTUuCsGsp7SMeS5W8AWMnLfZKIK+U3k4IYxUyIDm+BCWLcc6rMB/Mf1ELvcJXfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892262; c=relaxed/simple;
	bh=24nPwVXbdkyGDa5nE3rBVWER+qEE2CNjT2bHNDpxBvo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Mrh+VUggyGGaBRaRvB6nbIvShp+nh3OC3gJi78OTHQ1W0cgBvfSEE6ox4j+ROnZhj3p40blA2a3SDt/7rHiTxWKp/RzjEQmvfFjk+yI4Sw0wRRpWcqsGLEQ9qG26sugkbGAjqqyAxZfMgIOZXvVYnXQmGff8qImoSfJOHwoU4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=By0rkr7P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnonHF4V; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="By0rkr7P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnonHF4V"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 384E91D00137;
	Sun, 20 Sep 2026 04:17:36 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789892255;
	 x=1789978655; bh=CfP7m4y2JwjnF+JX7zAPCb9xfFzxU+khZCD1pKf8DdQ=; b=
	By0rkr7PgBv2pXnmLyvtFn9M5ZnQ4fjnojmcHa8iPB46tDcAXAzJiVeZmTSgVE6c
	hjc22dMEpyJTa6ii7jrfq7GKrNd4a3qtA3o6Dfb6ZO2wgT7xC9hBfqEmV0uqjnKj
	D0IhcWqS7w0QMS7ikrcJbKThs2C4iIc6aQJ+7GbaVOaNEyIretGW3oFLpT0eUseB
	SCUGnJzGINtmYovf0yX42DrlTSMXEJehmiowQiDS94elvm2UGvCXQpNgb95yc7NL
	spohbf4Do5WXBy0UzRjgma9dBF0QJOZxknB0D5BPqL5wz8MP/ZMEqGrHXEMOsnEy
	Ccq2i6M2oRKvmlw7CDKgYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789892255; x=
	1789978655; bh=CfP7m4y2JwjnF+JX7zAPCb9xfFzxU+khZCD1pKf8DdQ=; b=T
	nonHF4VAVVCoO+4DUjClIOxRM0qbtknYiCUA0SRqqP5sMaD/uwd1Nl95uBGHCNfw
	L5jccrke2uMpUkZyFSqHF6KSkK+XHQG8tPM7G5H+pnzmVl9kXoXPesUGKHQyhXZO
	lgk74Qfu0IxmLzVfV4DWcaK4sSRs1ug4a2eTyrv9rbsJCt9n4Z5S/CdIajXcNXNY
	XMR2bDOvI6LOwi3WAAfTAc/hYYnx03btaICZv+gf8z4Tn1SAKm1a1RwJeJonY+cF
	W96VT39hu/11ZY8LNYGZ66o8XAwkJAag1Xj71wjUaGVuzBy7Phv3/bduJE+9IsfY
	4bzXj+7Hb5Pu6g2Cjdznw==
X-ME-Sender: <xms:nJavamjGd-nsjX9i0963P2O8gp3p19lcNMq5xIuzKl_w_O4vP4cmkg>
    <xme:nJavah2-r_fYmW4cqRWuDCs3z9oronAUSzjJq6j8JjeJGUVvcrGi2o4zSjUjsLX-7
    _Byr9a6TNZIFp1XR6yvw1uRr--LOn2rsLnv1J8ANZNYjEmyM-jfTr01>
X-ME-Proxy-Cause: dmFkZTG3dDIxyV0gfOmw+Tx+G1rRONJM66y2m+Rg+mSPdGPP+YE8+0VOCt2re3xIbDrYYP
    n/S9D2BI5/5ei6NBUdzNPayLaAIh+/CViqG17fFpdj/5e+REQUaRLzvRIZgjs+wei0ooM5
    FKhgqFW1utumdSYffm4c8oQiSjSJIDD6U9shp9/WQcELBF/lcx2DyMUfTM1i9t/o4B0CZT
    WIaOJwcP73ZmIJvW+3xRFanZ6x9BwtuYBYbgxfsYLy2G9GOWPyZkufXT9coHhcpRUDBIOd
    fqhOMSzsIZ+7MgRrWvAoNxIGQY6cDScLPHpvau8SBKyXZvjTtEbXw1p70zradL44Kzh5kx
    7ezty7fbFz0fckbI4qUWdRPM6KQ8MUXxWnlgTm6IB2GKbb3jCV+VQaTlJNc8RG5Eqlar2x
    odNuJeIEVaBP8kGcZCYHNk1+W+AaAD5pCp+Nw2Qu6p5yPv3mEuP22fF269vTo7w00ITzCP
    uO3TTDnaxVj2ArhaSCdzlAJ5FNy9a1Ix6xAlqZ3W7SlkcjmCiTgPDDOTtj/xRG/NUuCQ93
    T6WftsSu8o//IvGIxNDUy+ZxWxMScCk2FKLdMiy9jGq+ZswWMNNkmrWn7DjTZe5tUoPLlR
    1kNoI1suNQbhMAwZ040iHmi0Zojw7bdNJ2oqH0o8g/gLIVYs+GVzQDaohfNA
X-ME-Proxy: <xmx:nZavarYeZnHvqD-Y9V7XdNp3T7FIg9qhcJTZD06yh3mBxCBAt824Ww>
    <xmx:nZavarEFiroV_4nq7NLWO9wTZiH4E9b8_lnc6IfwuLWLL0ZU05BNhg>
    <xmx:nZavasJGwnJPlOf8tL8haawBzZniI-bMa0ifhv-s2hlsGzAfdiU4gg>
    <xmx:nZavamPMbzGom3xm6MGmIf20iF5slvDaHXAoARcRY0I9dRt8ofUL8g>
    <xmx:n5avakO_aSLZCVjohFiwr6ELW4r519pEuw222dniyMXorVrgJ2ImZ1hE>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 26C1632A0087; Sun, 20 Sep 2026 04:17:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApQcrHuoOch-
Date: Sun, 20 Sep 2026 10:17:11 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>,
 "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <4fa49d62-ce93-46e6-a0be-9b2750bee9c7@app.fastmail.com>
In-Reply-To: <20260817213840.1053216-4-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-4-rafael@rcpassos.me>
Subject: Re: [PATCH v4 3/4] HID: wiimote: led_probe with scoped cleanup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Mon, Aug 17, 2026, at 11:38 PM, Rafael Passos wrote:
> Cleanup code in led probe function, using the modern scoped cleanup.
> This prevents mistakes in future changes to this function.
>
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>  drivers/hid/hid-wiimote-modules.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-modules.c 
> b/drivers/hid/hid-wiimote-modules.c
> index 3cd614466740..47fa6a8ecdae 100644
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

We usually do not allow mixed declarations and code. So the variable declaration including the `__free(kfree)` should be moved to the top.

Otherwise, this looks good:

Reviewed-by: David Rheinsberg <david@readahead.eu>

Thanks!

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
> -- 
> 2.55.0
