Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249773E2AD6
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891957; cv=none; b=AF3FFHZiuAY/c0QffIUtXfvSTOsLWu3CwWmyieXc7nMI2BPN2UVYsZVmbJzj85vi6skPn4Cg+NqdAq4vgsyedl8zCJLXh37/+U8RKjibw9k7EB1OfBJwddijgDBpHOX20tLF5imK1cdIffq2IdJQNojJuLlVfOrWJf/W2jQvt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891957; c=relaxed/simple;
	bh=4cdC3MK2ZoEwFYWGx/fs7NzU7RdoncfU1sHM03ESm80=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=awjHbvC2AoznlXGMICZ8GxM/x4qODzd79paB1Q4h7GIF4yqlOSHJx7sSL7TC3jiNSGKYmnYBi0vvuuC09hwynjMPD4CWaxpj1jxeWj26vCproI3LvnhOyu1jqGYgtqwft5X/teuw+AFewq8PxTPR5hAAGEqZ4tcUUgz9WkSogR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=MnyGPDF4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PuWRp3Sk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="MnyGPDF4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PuWRp3Sk"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 59C361D00128;
	Sun, 20 Sep 2026 04:12:31 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 20 Sep 2026 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789891950;
	 x=1789978350; bh=PZYfzOcgFEwP/RRUICksR2Yk3ikEd29CS3BstvrM2fY=; b=
	MnyGPDF4BtKX0ro7kYCVQmUY/yyNGgoTL606n1RkI6/MYsNw6TVWvODEhbYORZie
	HHxrpLrvspVGvp7oH4RU9kJLAlx/xAVz86bGyKCB0IsqR+NURNt4qSxI9OT0eT77
	VlmfyvJUp4pfJ3C1OgpcStV4WfFDkMl5M2hCi1u66IRd4LKCWCp+iepandxw30uU
	BMYmCJ2Pyfb6EAK6pTYatyF3w5XrHRJQfmnAjTPm3zXSqifxodStjwPELKsZFNgq
	YDGTo2eEKLub7btWEmL18wvwX1M1PYMMcbJm2PpO/93JIwawtKAoQK401vdU52YZ
	xm8SdfoUaHDO7StjqsVnaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789891950; x=
	1789978350; bh=PZYfzOcgFEwP/RRUICksR2Yk3ikEd29CS3BstvrM2fY=; b=P
	uWRp3SkBpj8q7rFXFDdEPS3nwBmJxbydUk4wFUagTC6ZW9NI9ffUbIuzAQqBPkbh
	cfVbcvLI7yM3ermxwFroIymfoXg5uMux+K/N7VxxC1iX8vaMP3Bh/xa4KvPcr8Nx
	VAbA19pZFqRz++slgwFG1Y6fSngQ8vX2z9qN+GEj6dlZ4qFbLqCSpU41Bhv/ZGp8
	pmQNcZ7d7xn+/0R443KLhyS6V6l/vmbWsZVyATtzdl6H3cPa41fI/fhnVDTaFQ6A
	9g0WHNRPF+ZAYlo/4Ww0eYxrvfHkiAFY0wKBGxFs/q4/0DZMfxG0xI4C8CERkDt/
	qHgkN1bUILFd05psPXy4Q==
X-ME-Sender: <xms:bJWvaqcPt1rWt8NEnliK66LDj8l20LtDkGBl__EOCkHDgqY7IpRLyw>
    <xme:bJWvavCHhDNkkuZTjpoZ5dq3mnk3Hr4bl18P69jrzIXUt7_kP6jer8cd2Yqwhq_N5
    _evR3AIPtGDH2TI-tyg29_DZJis5Zhi1RBK_hOgLR6hSy2lltiKpbGF>
X-ME-Proxy-Cause: dmFkZTFEMQBmiWgoxT+ACPip6Z0w1zN3JDvz2cvuyesW8i/9QgbX58E7cVwZaIKKW78L+O
    YsexxYNlIy6IVp6Oj5sqs7DuHu+fsVNNwWH7efmNSRg7z0GvjbjCFr+oVoEElZc/+mF8sU
    5wpQozXy3KmoNN1mhes2vpjLE/wMgjh7enjh4/+rsJvTYPtItH0N5VBdDL9EC67la9Q3bW
    DKiB0i3jwFslsLyMB43vbI2nN9wP1vdeOBu8dEqs5k8bPKJE9SSLzOtxrT9BM91UTimyjY
    3SCjS35nWgTomV+7MzPNE6IwFMgLNiYwIXgQ3sMhMVSe9teFVGscRV2uGgeynP9JEnxoSw
    QP/aaYFGbakkHAsPw3esVAgIYr5Qw2Hms2S7e1l0cTIrsjlQ1ASDATFUY+66XsuRYkAzRl
    0gsq/35HxG2cza6PK6SZHve8Co8/q3h8KxEU7h9mSJZeH3m+NTMfSwgLGfevICmMbzJMlg
    isWYnv2l6PBJUyhc6OMrvZbMk4EpucLZJNCk42aLDjIaqmzmY2n4XWhbY4/i5BEfqTKEtN
    vhXZK4hyaqywibNElBBNnXlWoMF5zD6wHHNBkNOZl0fltcve05M5VTvjt5+U5HI1W/GQ4R
    Wua1nUzUHJHLDJPr0q81t+YZebIwpIKB7yTbtW3I674MeHsZegOKUOolKF7w
X-ME-Proxy: <xmx:bZWval0XFcQGMOohe5tEltH3tKuXn6Jb3hTff95sQ4bOcz9VDhLR6Q>
    <xmx:bZWvaszuYy7q1yNJkby_l1ocGVWwSpUYllDmY6rdjhWQrEpvIdZfEg>
    <xmx:bZWvakHJ3NyJaVb9m-T7lHp7pT6D-cTWNMo6N6G3RGvz5IWOl9X6yA>
    <xmx:bZWvanZ2C59xKryjCL9u7a1Vzujbhw2d9AjW5GA4eI7q8TDnV8fn2w>
    <xmx:bpWvauID6pOZhb4pc1i4EDsUaLRo3pw9Q5SxF8jT-9r2bnHRJ7y7Qlld>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3E76E32A0087; Sun, 20 Sep 2026 04:12:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8cqExJPKqV7
Date: Sun, 20 Sep 2026 10:12:07 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>,
 "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <95661df0-11cf-47dd-976b-3ccc895c0db5@app.fastmail.com>
In-Reply-To: <20260817213840.1053216-3-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-3-rafael@rcpassos.me>
Subject: Re: [PATCH v4 2/4] HID: wiimote: replace spinlock pairs with scoped_guard
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Mon, Aug 17, 2026, at 11:38 PM, Rafael Passos wrote:
> Cleanup code replacing manual lock/unlock with scoped guards.
> This does not change any behavior, but makes it safer to modify.
>
> The multi line spinlock blocks were replaced by braced scoped_guard,
> and one-liners by a scoped_guard without braces nor indentation.
>
> There are two cases left in this driver using lock/unlock, because
> guard would make the code more complex than current implementation.
>
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>

There is some whitespace/tab indentation mixup, otherwise:

Reviewed-by: David Rheinsberg <david@readahead.eu>

Thanks
David

> ---
>  drivers/hid/hid-wiimote-core.c    | 224 +++++++++++++-----------------
>  drivers/hid/hid-wiimote-debug.c   |  62 ++++-----
>  drivers/hid/hid-wiimote-modules.c |   7 +-
>  3 files changed, 127 insertions(+), 166 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index acf31d8b6991..05f8ddb7909b 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -7,6 +7,7 @@
>  /*
>   */
> 
> +#include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/hid.h>
> @@ -362,13 +363,12 @@ void wiiproto_req_rmem(struct wiimote_data 
> *wdata, bool eeprom, __u32 offset,
>  int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
>  						const __u8 *wmem, __u8 size)
>  {
> -	unsigned long flags;
>  	int ret;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
> -	wiiproto_req_wreg(wdata, offset, wmem, size);
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +	    wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
> +	    wiiproto_req_wreg(wdata, offset, wmem, size);
> +	}
> 
>  	ret = wiimote_cmd_wait(wdata);
>  	if (!ret && wdata->state.cmd_err)
> @@ -381,21 +381,19 @@ int wiimote_cmd_write(struct wiimote_data *wdata, 
> __u32 offset,
>  ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset, 
> __u8 *rmem,
>  								__u8 size)
>  {
> -	unsigned long flags;
>  	ssize_t ret;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.cmd_read_size = size;
> -	wdata->state.cmd_read_buf = rmem;
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, offset & 0xffff);
> -	wiiproto_req_rreg(wdata, offset, size);
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.cmd_read_size = size;
> +		wdata->state.cmd_read_buf = rmem;
> +		wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, offset & 0xffff);
> +		wiiproto_req_rreg(wdata, offset, size);
> +	}
> 
>  	ret = wiimote_cmd_wait(wdata);
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.cmd_read_buf = NULL;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.cmd_read_buf = NULL;
> 
>  	if (!ret) {
>  		if (wdata->state.cmd_read_size == 0)
> @@ -675,11 +673,8 @@ static void wiimote_modules_load(struct 
> wiimote_data *wdata,
>  			goto error;
>  	}
> 
> -	spin_lock_irq(&wdata->state.lock);
> -	wdata->state.devtype = devtype;
> -	spin_unlock_irq(&wdata->state.lock);
> -
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.devtype = devtype;
>  		/* after loading modules, set the Player ID LED cycling from 1 to 4*/
>  		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
>  	}
> @@ -703,13 +698,11 @@ static void wiimote_modules_unload(struct 
> wiimote_data *wdata)
>  {
>  	const __u8 *mods, *iter;
>  	const struct wiimod_ops *ops;
> -	unsigned long flags;
> 
>  	mods = wiimote_devtype_mods[wdata->state.devtype];
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.devtype = WIIMOTE_DEV_UNKNOWN;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.devtype = WIIMOTE_DEV_UNKNOWN;
> 
>  	/* find end of list */
>  	for (iter = mods; *iter != WIIMOD_NULL; ++iter)
> @@ -736,7 +729,6 @@ static void wiimote_modules_unload(struct 
> wiimote_data *wdata)
> 
>  static void wiimote_ext_load(struct wiimote_data *wdata, unsigned int ext)
>  {
> -	unsigned long flags;
>  	const struct wiimod_ops *ops;
>  	int ret;
> 
> @@ -748,22 +740,20 @@ static void wiimote_ext_load(struct wiimote_data 
> *wdata, unsigned int ext)
>  			ext = WIIMOTE_EXT_UNKNOWN;
>  	}
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.exttype = ext;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.exttype = ext;
>  }
> 
>  static void wiimote_ext_unload(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
>  	const struct wiimod_ops *ops;
> 
>  	ops = wiimod_ext_table[wdata->state.exttype];
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.exttype = WIIMOTE_EXT_UNKNOWN;
> -	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_USED;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.exttype = WIIMOTE_EXT_UNKNOWN;
> +		wdata->state.flags &= ~WIIPROTO_FLAG_EXT_USED;
> +	}
> 
>  	if (ops->remove)
>  		ops->remove(ops, wdata);
> @@ -771,7 +761,6 @@ static void wiimote_ext_unload(struct wiimote_data *wdata)
> 
>  static void wiimote_mp_load(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
>  	const struct wiimod_ops *ops;
>  	int ret;
>  	__u8 mode = 2;
> @@ -783,14 +772,12 @@ static void wiimote_mp_load(struct wiimote_data *wdata)
>  			mode = 1;
>  	}
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.mp = mode;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.mp = mode;
>  }
> 
>  static void wiimote_mp_unload(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
>  	const struct wiimod_ops *ops;
> 
>  	if (wdata->state.mp < 2)
> @@ -798,10 +785,10 @@ static void wiimote_mp_unload(struct wiimote_data *wdata)
> 
>  	ops = &wiimod_mp;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.mp = 0;
> -	wdata->state.flags &= ~WIIPROTO_FLAG_MP_USED;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.mp = 0;
> +		wdata->state.flags &= ~WIIPROTO_FLAG_MP_USED;
> +	}
> 
>  	if (ops->remove)
>  		ops->remove(ops, wdata);
> @@ -885,19 +872,19 @@ static void wiimote_init_detect(struct 
> wiimote_data *wdata)
> 
>  	wiimote_cmd_acquire_noint(wdata);
> 
> -	spin_lock_irq(&wdata->state.lock);
> -	wdata->state.devtype = WIIMOTE_DEV_UNKNOWN;
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
> -	wiiproto_req_status(wdata);
> -	spin_unlock_irq(&wdata->state.lock);
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> +		wdata->state.devtype = WIIMOTE_DEV_UNKNOWN;
> +		wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
> +		wiiproto_req_status(wdata);
> +	}
> +
> 
>  	ret = wiimote_cmd_wait_noint(wdata);
>  	if (ret)
>  		goto out_release;
> 
> -	spin_lock_irq(&wdata->state.lock);
> -	ext = wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED;
> -	spin_unlock_irq(&wdata->state.lock);
> +	scoped_guard(spinlock_irq, &wdata->state.lock)
> +		ext = wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED;
> 
>  	if (!ext)
>  		goto out_release;
> @@ -910,11 +897,11 @@ static void wiimote_init_detect(struct 
> wiimote_data *wdata)
>  	wiimote_init_set_type(wdata, exttype);
> 
>  	/* schedule MP timer */
> -	spin_lock_irq(&wdata->state.lock);
> -	if (!(wdata->state.flags & WIIPROTO_FLAG_BUILTIN_MP) &&
> -	    !(wdata->state.flags & WIIPROTO_FLAG_NO_MP))
> -		mod_timer(&wdata->timer, jiffies + HZ * 4);
> -	spin_unlock_irq(&wdata->state.lock);
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> +		if (!(wdata->state.flags & WIIPROTO_FLAG_BUILTIN_MP) &&
> +		!(wdata->state.flags & WIIPROTO_FLAG_NO_MP))
> +			mod_timer(&wdata->timer, jiffies + HZ * 4);
> +	}
>  }
> 
>  /*
> @@ -962,9 +949,8 @@ static bool wiimote_init_check(struct wiimote_data *wdata)
>  	__u8 type, data[6];
>  	bool ret, poll_mp;
> 
> -	spin_lock_irq(&wdata->state.lock);
> -	flags = wdata->state.flags;
> -	spin_unlock_irq(&wdata->state.lock);
> +	scoped_guard(spinlock_irq, &wdata->state.lock)
> +		flags = wdata->state.flags;
> 
>  	wiimote_cmd_acquire_noint(wdata);
> 
> @@ -980,11 +966,11 @@ static bool wiimote_init_check(struct wiimote_data *wdata)
>  		type = wiimote_cmd_read_mp_mapped(wdata);
>  		ret = type == WIIMOTE_MP_SINGLE;
> 
> -		spin_lock_irq(&wdata->state.lock);
> -		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> -		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED);
> -		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> -		spin_unlock_irq(&wdata->state.lock);
> +		scoped_guard(spinlock_irq, &wdata->state.lock) {
> +			ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> +			ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED);
> +			ret = ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> +		}
> 
>  		if (!ret)
>  			hid_dbg(wdata->hdev, "state left: !EXT && MP\n");
> @@ -1005,10 +991,10 @@ static bool wiimote_init_check(struct 
> wiimote_data *wdata)
>  		type = wiimote_cmd_read_ext(wdata, data);
>  		ret = type == wdata->state.exttype;
> 
> -		spin_lock_irq(&wdata->state.lock);
> -		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> -		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> -		spin_unlock_irq(&wdata->state.lock);
> +		scoped_guard(spinlock_irq, &wdata->state.lock) {
> +			ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> +			ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> +		}
> 
>  		if (!ret)
>  			hid_dbg(wdata->hdev, "state left: EXT && !MP\n");
> @@ -1031,11 +1017,11 @@ static bool wiimote_init_check(struct 
> wiimote_data *wdata)
>  		type = wiimote_cmd_read_ext(wdata, data);
>  		ret = type == wdata->state.exttype;
> 
> -		spin_lock_irq(&wdata->state.lock);
> -		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> -		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> -		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
> -		spin_unlock_irq(&wdata->state.lock);
> +		scoped_guard(spinlock_irq, &wdata->state.lock) {
> +			ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> +			ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> +			ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
> +		}
> 
>  		if (!ret)
>  			hid_dbg(wdata->hdev, "state left: !EXT && !MP\n");
> @@ -1061,11 +1047,11 @@ static bool wiimote_init_check(struct 
> wiimote_data *wdata)
>  		ret = ret && type != WIIMOTE_MP_UNKNOWN;
>  		ret = ret && type != WIIMOTE_MP_SINGLE;
> 
> -		spin_lock_irq(&wdata->state.lock);
> -		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
> -		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> -		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> -		spin_unlock_irq(&wdata->state.lock);
> +		scoped_guard(spinlock_irq, &wdata->state.lock) {
> +			ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
> +			ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
> +			ret = ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
> +		}
> 
>  		if (!ret)
>  			hid_dbg(wdata->hdev, "state left: EXT && MP\n");
> @@ -1120,16 +1106,15 @@ static void wiimote_init_hotplug(struct 
> wiimote_data *wdata)
> 
>  	wiimote_cmd_acquire_noint(wdata);
> 
> -	spin_lock_irq(&wdata->state.lock);
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> 
> -	/* get state snapshot that we will then work on */
> -	flags = wdata->state.flags;
> +	    /* get state snapshot that we will then work on */
> +	    flags = wdata->state.flags;
> 
> -	/* disable event forwarding temporarily */
> -	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_ACTIVE;
> -	wdata->state.flags &= ~WIIPROTO_FLAG_MP_ACTIVE;
> -
> -	spin_unlock_irq(&wdata->state.lock);
> +	    /* disable event forwarding temporarily */
> +	    wdata->state.flags &= ~WIIPROTO_FLAG_EXT_ACTIVE;
> +	    wdata->state.flags &= ~WIIPROTO_FLAG_MP_ACTIVE;
> +	}
> 
>  	/* init extension and MP (deactivates current extension or MP) */
>  	wiimote_cmd_init_ext(wdata);
> @@ -1152,9 +1137,8 @@ static void wiimote_init_hotplug(struct 
> wiimote_data *wdata)
>  			hid_info(wdata->hdev, "cannot detect extension; %6phC\n",
>  				 extdata);
>  		} else if (exttype == WIIMOTE_EXT_NONE) {
> -			spin_lock_irq(&wdata->state.lock);
> -			wdata->state.exttype = WIIMOTE_EXT_NONE;
> -			spin_unlock_irq(&wdata->state.lock);
> +			scoped_guard(spinlock_irq, &wdata->state.lock)
> +				wdata->state.exttype = WIIMOTE_EXT_NONE;
>  		} else {
>  			hid_info(wdata->hdev, "detected extension: %s\n",
>  				 wiimote_exttype_names[exttype]);
> @@ -1192,28 +1176,26 @@ static void wiimote_init_hotplug(struct 
> wiimote_data *wdata)
>  			mod_timer(&wdata->timer, jiffies + HZ * 4);
>  	}
> 
> -	spin_lock_irq(&wdata->state.lock);
> -
> -	/* enable data forwarding again and set expected hotplug state */
> -	if (mp) {
> -		wdata->state.flags |= WIIPROTO_FLAG_MP_ACTIVE;
> -		if (wdata->state.exttype == WIIMOTE_EXT_NONE) {
> -			wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
> -			wdata->state.flags &= ~WIIPROTO_FLAG_MP_PLUGGED;
> -		} else {
> -			wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
> -			wdata->state.flags |= WIIPROTO_FLAG_MP_PLUGGED;
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> +		/* enable data forwarding again and set expected hotplug state */
> +		if (mp) {
> +			wdata->state.flags |= WIIPROTO_FLAG_MP_ACTIVE;
> +			if (wdata->state.exttype == WIIMOTE_EXT_NONE) {
> +				wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
> +				wdata->state.flags &= ~WIIPROTO_FLAG_MP_PLUGGED;
> +			} else {
> +				wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
> +				wdata->state.flags |= WIIPROTO_FLAG_MP_PLUGGED;
> +				wdata->state.flags |= WIIPROTO_FLAG_EXT_ACTIVE;
> +			}
> +		} else if (wdata->state.exttype != WIIMOTE_EXT_NONE) {
>  			wdata->state.flags |= WIIPROTO_FLAG_EXT_ACTIVE;
>  		}
> -	} else if (wdata->state.exttype != WIIMOTE_EXT_NONE) {
> -		wdata->state.flags |= WIIPROTO_FLAG_EXT_ACTIVE;
> +
> +		/* request status report for hotplug state updates */
> +		wiiproto_req_status(wdata);
>  	}
> 
> -	/* request status report for hotplug state updates */
> -	wiiproto_req_status(wdata);
> -
> -	spin_unlock_irq(&wdata->state.lock);
> -
>  	hid_dbg(wdata->hdev, "detected extensions: MP: %d EXT: %d\n",
>  		wdata->state.mp, wdata->state.exttype);
>  }
> @@ -1244,11 +1226,8 @@ void __wiimote_schedule(struct wiimote_data *wdata)
> 
>  static void wiimote_schedule(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	__wiimote_schedule(wdata);
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		__wiimote_schedule(wdata);
>  }
> 
>  static void wiimote_init_timeout(struct timer_list *t)
> @@ -1638,7 +1617,6 @@ static int wiimote_hid_event(struct hid_device 
> *hdev, struct hid_report *report,
>  	struct wiimote_data *wdata = hid_get_drvdata(hdev);
>  	const struct wiiproto_handler *h;
>  	int i;
> -	unsigned long flags;
> 
>  	if (size < 1)
>  		return -EINVAL;
> @@ -1646,9 +1624,8 @@ static int wiimote_hid_event(struct hid_device 
> *hdev, struct hid_report *report,
>  	for (i = 0; handlers[i].id; ++i) {
>  		h = &handlers[i];
>  		if (h->id == raw_data[0] && h->size < size) {
> -			spin_lock_irqsave(&wdata->state.lock, flags);
> -			h->func(wdata, &raw_data[1]);
> -			spin_unlock_irqrestore(&wdata->state.lock, flags);
> +			scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +				h->func(wdata, &raw_data[1]);
>  			break;
>  		}
>  	}
> @@ -1666,11 +1643,9 @@ static ssize_t wiimote_ext_show(struct device 
> *dev,
>  {
>  	struct wiimote_data *wdata = dev_to_wii(dev);
>  	__u8 type;
> -	unsigned long flags;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	type = wdata->state.exttype;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		type = wdata->state.exttype;
> 
>  	switch (type) {
>  	case WIIMOTE_EXT_NONE:
> @@ -1719,11 +1694,9 @@ static ssize_t wiimote_dev_show(struct device *dev,
>  {
>  	struct wiimote_data *wdata = dev_to_wii(dev);
>  	__u8 type;
> -	unsigned long flags;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	type = wdata->state.devtype;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		type = wdata->state.devtype;
> 
>  	switch (type) {
>  	case WIIMOTE_DEV_GENERIC:
> @@ -1778,16 +1751,13 @@ static DEFINE_IDA(wiimote_ida);
> 
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
> -
>  	wiidebug_deinit(wdata);
> 
>  	ida_free(&wiimote_ida, wdata->player_id);
> 
>  	/* prevent init_worker from being scheduled again */
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.flags |= WIIPROTO_FLAG_EXITING;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.flags |= WIIPROTO_FLAG_EXITING;
> 
>  	cancel_work_sync(&wdata->init_worker);
>  	timer_shutdown_sync(&wdata->timer);
> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> index fc847c2a1c1f..b8027bb23608 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -7,12 +7,13 @@
>  /*
>   */
> 
> -#include <linux/debugfs.h>
> -#include <linux/module.h>
> -#include <linux/seq_file.h>
> -#include <linux/spinlock.h>
> -#include <linux/uaccess.h>
> -#include "hid-wiimote.h"
> + #include <linux/cleanup.h>
> + #include <linux/debugfs.h>
> + #include <linux/module.h>
> + #include <linux/seq_file.h>
> + #include <linux/spinlock.h>
> + #include <linux/uaccess.h>
> + #include "hid-wiimote.h"
> 
>  struct wiimote_debug {
>  	struct wiimote_data *wdata;
> @@ -25,7 +26,6 @@ static ssize_t wiidebug_eeprom_read(struct file *f, 
> char __user *u, size_t s,
>  {
>  	struct wiimote_debug *dbg = f->private_data;
>  	struct wiimote_data *wdata = dbg->wdata;
> -	unsigned long flags;
>  	ssize_t ret;
>  	char buf[16];
>  	__u16 size = 0;
> @@ -41,20 +41,19 @@ static ssize_t wiidebug_eeprom_read(struct file *f, 
> char __user *u, size_t s,
>  	if (ret)
>  		return ret;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.cmd_read_size = s;
> -	wdata->state.cmd_read_buf = buf;
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, *off & 0xffff);
> -	wiiproto_req_reeprom(wdata, *off, s);
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.cmd_read_size = s;
> +		wdata->state.cmd_read_buf = buf;
> +		wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, *off & 0xffff);
> +		wiiproto_req_reeprom(wdata, *off, s);
> +	}
> 
>  	ret = wiimote_cmd_wait(wdata);
>  	if (!ret)
>  		size = wdata->state.cmd_read_size;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.cmd_read_buf = NULL;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.cmd_read_buf = NULL;
> 
>  	wiimote_cmd_release(wdata);
> 
> @@ -99,12 +98,10 @@ static int wiidebug_drm_show(struct seq_file *f, void *p)
>  {
>  	struct wiimote_debug *dbg = f->private;
>  	const char *str = NULL;
> -	unsigned long flags;
>  	__u8 drm;
> 
> -	spin_lock_irqsave(&dbg->wdata->state.lock, flags);
> -	drm = dbg->wdata->state.drm;
> -	spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &dbg->wdata->state.lock)
> +		drm = dbg->wdata->state.drm;
> 
>  	if (drm < WIIPROTO_REQ_MAX)
>  		str = wiidebug_drmmap[drm];
> @@ -126,7 +123,6 @@ static ssize_t wiidebug_drm_write(struct file *f, 
> const char __user *u,
>  {
>  	struct seq_file *sf = f->private_data;
>  	struct wiimote_debug *dbg = sf->private;
> -	unsigned long flags;
>  	char buf[16];
>  	ssize_t len;
>  	int i;
> @@ -150,12 +146,12 @@ static ssize_t wiidebug_drm_write(struct file *f, 
> const char __user *u,
>  	if (i == WIIPROTO_REQ_MAX)
>  		i = simple_strtoul(buf, NULL, 16);
> 
> -	spin_lock_irqsave(&dbg->wdata->state.lock, flags);
> -	dbg->wdata->state.flags &= ~WIIPROTO_FLAG_DRM_LOCKED;
> -	wiiproto_req_drm(dbg->wdata, (__u8) i);
> -	if (i != WIIPROTO_REQ_NULL)
> -		dbg->wdata->state.flags |= WIIPROTO_FLAG_DRM_LOCKED;
> -	spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &dbg->wdata->state.lock) {
> +		dbg->wdata->state.flags &= ~WIIPROTO_FLAG_DRM_LOCKED;
> +		wiiproto_req_drm(dbg->wdata, (__u8) i);
> +		if (i != WIIPROTO_REQ_NULL)
> +			dbg->wdata->state.flags |= WIIPROTO_FLAG_DRM_LOCKED;
> +	}
> 
>  	return len;
>  }
> @@ -172,7 +168,6 @@ static const struct file_operations wiidebug_drm_fops = {
>  int wiidebug_init(struct wiimote_data *wdata)
>  {
>  	struct wiimote_debug *dbg;
> -	unsigned long flags;
> 
>  	dbg = kzalloc_obj(*dbg);
>  	if (!dbg)
> @@ -189,9 +184,8 @@ int wiidebug_init(struct wiimote_data *wdata)
>  	debugfs_create_u8("player_id", S_IRUSR,
>  		   dbg->wdata->hdev->debug_dir, &wdata->player_id);
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->debug = dbg;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->debug = dbg;
> 
>  	return 0;
>  }
> @@ -199,14 +193,12 @@ int wiidebug_init(struct wiimote_data *wdata)
>  void wiidebug_deinit(struct wiimote_data *wdata)
>  {
>  	struct wiimote_debug *dbg = wdata->debug;
> -	unsigned long flags;
> 
>  	if (!dbg)
>  		return;
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->debug = NULL;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->debug = NULL;
> 
>  	debugfs_remove(dbg->drm);
>  	debugfs_remove(dbg->eeprom);
> diff --git a/drivers/hid/hid-wiimote-modules.c 
> b/drivers/hid/hid-wiimote-modules.c
> index dccb78bb3afd..3cd614466740 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -30,6 +30,7 @@
>   * input devices.
>   */
> 
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/hid.h>
>  #include <linux/input.h>
> @@ -341,7 +342,6 @@ static int wiimod_led_probe(const struct wiimod_ops *ops,
>  	struct device *dev = &wdata->hdev->dev;
>  	size_t namesz = strlen(dev_name(dev)) + 9;
>  	struct led_classdev *led;
> -	unsigned long flags;
>  	char *name;
>  	int ret;
> 
> @@ -364,9 +364,8 @@ static int wiimod_led_probe(const struct wiimod_ops *ops,
> 
>  	/* enable LED1 to stop initial LED-blinking */
>  	if (ops->arg == 0) {
> -		spin_lock_irqsave(&wdata->state.lock, flags);
> -		wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
> -		spin_unlock_irqrestore(&wdata->state.lock, flags);
> +		scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +			wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
>  	}
> 
>  	return 0;
> -- 
> 2.55.0
