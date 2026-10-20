Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517955;
	b=JTkw2GCO9A3sh+Kry8YGFkfb8uacUhrLKusknKqa5x5Ld2RuI0BLQkhw9/8I9hd9blWe
	 3eh4vaaZkG1Rl+BfSGFGtNKtYYXs4dm18DqCQgcEaQjgywUAn9jC3NZuRI90Yt5lVQ6i5
	 yDtRDh9JCpWM1UY6YjgGYl7h8jBDIlz7UURJpsyOcMhkQwM3bb9Mf4LVgAPs1tL3gJibd
	 Gb0mw32hnWGEjlHRJITofnT9BwV8YLd0hj+LMdawDwqka6bm4+O2Mqapymq0X+2P8QsKb
	 EAi/rxk1VoF2FZJSAPjwHNVg0hiWOq33/qn3AGN8lntMWeTJpj4PzUBTDzSjeoPjrOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517955;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ejnXPpAefmwKQuaZISzEiXIEf4jvZdKKJ6wwjfA1jmE=;
	b=uZ0oS76JbUhyuOIzUsGE/AjkESVibaAS/YR9PCvjof0FzqOPYN8pBb8H9wpyJSxigO9X
	 XjJr1Fo44HIFceD70FUMYyfJeHiJNuIuGNsPwRYke2sBQEFhGDp/II5hD/Vvij7GtlxKO
	 9XAeARYWrCOdD/Qdy6UabB+53iUQ7FNuGFauUFIAi0x6eyWG9IT26RzL+JtD/2MgZuv+s
	 3BtsQ+fLbO5ymr0SHpXCzr9KE8li1BmqNEGCkp+GhsViE/c2ArAABwlJQrfbj/sWZ5rXx
	 nUm3JLN5xTUsOILxn0RAznOXinM7Xrg23XeZOWOyjQHIhSera654jC2dC8jC56l2NlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GIIL0DGP;
	arc=none smtp.remote-ip=95.215.58.44
Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12089606A31B
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12089606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GIIL0DGP
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J93Fn08gXYX73zzQt4Psiim3AWUrAfxgKY2VikdZQGc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792517953; v=1; x=1793122753;
 b=GIIL0DGPIlC4PaY7ZV9s0PHMeAzJelUYoMjcKVMqAiIhjziedNZW1ML9b/7sN2c/2o0TpHTx
 cGbF7PvjV647ncvSo9XPntZBwIpem8RQ0AyEhFb2z6P4RU/l4EVGqlr+U7MKs2I5ks/tuJ5wqp4
 QQoDAllijQ0bOp/4doRCKUnU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ed11797560c934b;
	Tue, 20 Oct 2026 17:39:13 +0000
X-Mizu-Trace-ID: 4ed11797560c934b
X-Migadu-Flow: FLOW_OUT
Message-ID: <fa5487dc-571d-42f1-8cc6-b838cc4040ed@linux.dev>
Date: Tue, 20 Oct 2026 19:39:11 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] HID: asus: Force hid-input to bind to the Zenbook
 Duo hotkey interface
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261020092423.36380-1-p.pisati@gmail.com>
 <20261020092423.36380-4-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261020092423.36380-4-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/20/26 11:24, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
>
> The Zenbook Duo USB keyboard reports its hotkeys on a dedicated
> interface, separate from the keyboard and consumer control ones, that
> only contains ASUS vendor usage collections. hid-input does not
> consider those an input application and never binds to the interface,
> so the hotkeys are never mapped.
>
> Pass HID_CONNECT_HIDINPUT_FORCE for the interface of Zenbook Duo
> keyboards that carries the ASUS vendor collection, which skips that
> check, so the vendor usages go through asus_input_mapping() like on
> any other ASUS keyboard. The other interfaces either have a proper
> input application or nothing worth an input device.

Reviewed-by: Denis Benato <denis.benato@linux.dev>

> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: use HID_CONNECT_HIDINPUT_FORCE on the vendor interface instead
>  of injecting a fake keyboard collection into its report descriptor]
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
> Reviewed-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 54f4d68eecc7..68211ebe1290 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1514,6 +1514,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	struct asus_drvdata *drvdata;
>  	struct hid_report *rep;
>  	bool is_vendor = false;
> +	unsigned int connect_mask;
>  	int ret;
>  
>  	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> @@ -1609,7 +1610,15 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  	}
>  
> -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	/*
> +	 * The Zenbook Duo hotkey interface only has vendor collections, which
> +	 * hid-input does not bind to on its own.
> +	 */
> +	connect_mask = HID_CONNECT_DEFAULT;
> +	if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) && is_vendor)
> +		connect_mask |= HID_CONNECT_HIDINPUT_FORCE;
> +
> +	ret = hid_hw_start(hdev, connect_mask);
>  	if (ret) {
>  		asus_worker_stop(drvdata->worker);
>  		hid_err(hdev, "Asus hw start failed: %d\n", ret);
