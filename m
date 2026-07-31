Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8F3537CE
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488935; cv=none; b=JwdoKn4MJXE1G1bFDpKBnrG7xQIdgji0bvRS6dDBy/p5blal7UZ0XEIilCcep2M6wxwygJIkp5z+5cC4K/qsmapLRimC8v77yXFog4nigx1FfkZHYnJZ5BUoN3P367h4OoOxCoLuBB8LHCMi3tTGkNPkGjzfuJ3rSUfw0Z2Klao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488935; c=relaxed/simple;
	bh=k3X6gshAurqhXcwDJS9vdXasoPrINDaQ8aZjRfFcI8w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MCcr+JxtPUKnneFYKkMyjOnsNzCoQqd0m03rFJq2rJaP+VYOr0QXnvlByWaaW0KQ/2jT6Io1aT2gU+O8IUQ8A+KzPCjY16DiOoNjxH+j7YxNrRAq8KGmnnaeS8jorHeZVPsBEj8QFekVVZDXmgSWI4SNt0lKxg2E3U791MevCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=BHhuoBSE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OzW/4KiE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="BHhuoBSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OzW/4KiE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4298E1D00170;
	Fri, 31 Jul 2026 05:08:50 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jul 2026 05:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785488930;
	 x=1785575330; bh=NCxzH38X4MXoJy/TeTSst9/FqMOYaCG238H2PXFF2FU=; b=
	BHhuoBSE1Co8ILI4XymcPf4XAn3D63R5AY/zXzQQtHiXNar9GxfBN+xW6747gQzr
	Gs3xjLjD2LkJHFOlVqdeSD+vkedPA7uHyfgNmwPw4RNhHW2kZ3R2oRaE2iXKQWa6
	zLf8vvJCjGmJThI12lAh7NM2Z7Lt0DMA/PCAMN4NOZ1TieOZ0lpiMAVtG9YoWMdl
	kTCoESwr/46xnLbqxmF9L5RWHbqFYsNNsEq5xf5f65SR5A/0WJycEBzx8gL5aBu2
	s5v4d8LTyFCv4YaDd/Y94zbu+PpHmVy0+A+X04xZVoRis9LYkaPtJ+04XR2RowOT
	0LH5q5IZKPsXbFHEEYsX/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785488930; x=
	1785575330; bh=NCxzH38X4MXoJy/TeTSst9/FqMOYaCG238H2PXFF2FU=; b=O
	zW/4KiEGV+qIoeM1VIQ6sScqtyzAROvH81t3erpF6XjgT1NuJ1Pzu6/07N1mE+VT
	CNfCA8NTGJgkJdn2zJVYmQo/hw33f+xFS28at/TUrAFdOBN2nvMttnh7YnrwvZsW
	5TX+7fcbNeVntoQsq2VUOXCRXFMQ2CRxBQKgczDDwN+dzDzkpfvYt2uIuHRbfxKv
	FdSlVwPE242N1AJIJD422tZXukUFFT+fnYhnlgSXVJ5OUeqpnWXXN8uKdjW9k/MC
	sEJAZk9CjtSdkbMpJv4zVbeoUEzrBKqBzrixYQTL+LMgPxKvydAWN+C83h3G6wUG
	tLhrD1JIvIgnkS3q1yZlQ==
X-ME-Sender: <xms:IWZsahH-oMjC7UKot5FRElIDIcT6LMsUtPhdE5qm9FmWI2S7Agqo0Q>
    <xme:IWZsahJHCuJaYbLhKUOVff428reu0JEt8bHzuLdST1Dl2ZZsGqqlLeYESgZPRMaHQ
    anKUhex-yWJQSmSPedE-FLoh3K2zYkpbhGNIN6x5yR9bKuilNz5gw>
X-ME-Proxy-Cause: dmFkZTE1bZz6rgqRHyOd6ky8YrHrm+2eNUwXNQLZPLiFrxFLhkCshpk+Gjrii900SKgdDB
    uVg7sHCx8y7+GuC+YzAuZxG7xDqYp74uTGdhYAlp1z+sFNYKpp+Rzi98sOP3exEiGdnzMu
    5ptR5lH3+uYFFuBVI3e1X4Qqisuvuj4cAnuVSK8NpyLSp8IgGqkX+x2lIZJ/Lu+gyCJmgm
    FTF+Y5akMFK68zqH+r6HJLAW1WfdOgJ/i4yQqBmviI0BqnDrezBJLNbTK4J8KTeqCoMEBg
    oygaByBnvt0g4dDtBEon00GO1Zl/M6t+uvsamXfsLrk6tOQiia+NQ4/OUM+B6eApmg+ioU
    nzJiVzDjcBK04GMj5kTeYpTt9uaglmYhWY/l0oTPQm0zqQDyydFvOxs+zjv3aCNyUD1jhB
    QPex5ZJlRjF3gAVvDIiH6GwTg1zAvTM2v5n7qXcPfkUf9yr3PVKB5VBUtI2+K1g3++cZHH
    JafNF0Sz0HmYCe1XBLX8l/3YpQZgDMa6zo3jAkrZ6xXJZ42EBLAJPznhvP77iXTYPgOxUH
    o86sf9o/z6BpQMNRdLV005RE7M6JIPQgOtLgVEztQnNrnxeHIc6XfXw34Un78l+SyqRFoV
    vm6SHl5spwTbzGkdmotDhrfWs2D1qpITCnhz8RfdV7GVU3TDAuAjF9ZopESQ
X-ME-Proxy: <xmx:IWZsarfgethnRjhEcI4rYsn-4VpGS8CX0ayLPza_wUmQyry9ypRzlg>
    <xmx:IWZsah6Gmfvaxk44cTmKTGoWZaSH7hGAt09D3QFUQw1ZhCcEJ3-xyg>
    <xmx:IWZsaivjOf7ZkjvIpA78uruY8Nwk0oIvr4FlR8LclYUf5dqq0t4IUA>
    <xmx:IWZsahi7r0g8w-6134vHXGd83oCE-Zm0q9xH_XK68vkhSUzPgpyxuw>
    <xmx:ImZsaoxsU6Kg5leiv0hEY8mK4ccGFADz5FweGiVQCHWFt-wTSzyP5LSw>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 930601EA006B; Fri, 31 Jul 2026 05:08:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXIsPOb7aHn3
Date: Fri, 31 Jul 2026 11:08:28 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <52967401-e1b0-4c47-a00d-b53d238641d0@app.fastmail.com>
In-Reply-To: <20260729164928.1138468-3-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-3-rafael@rcpassos.me>
Subject: Re: [PATCH v3 2/4] HID: wiimote: replace spinlock pairs with scoped_guard
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Wed, Jul 29, 2026, at 6:49 PM, Rafael Passos wrote:
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

Reviewed-by: David Rheinsberg <david@readahead.eu>

This looks good! Thanks a lot!
David

> ---
>  drivers/hid/hid-wiimote-core.c    | 224 +++++++++++++-----------------
>  drivers/hid/hid-wiimote-debug.c   |  50 +++----
>  drivers/hid/hid-wiimote-modules.c |   7 +-
>  3 files changed, 121 insertions(+), 160 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index 48830f2ffcb50..762b3c383194e 100644
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
> @@ -1774,14 +1747,11 @@ static struct wiimote_data 
> *wiimote_create(struct hid_device *hdev)
> 
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
> -
>  	wiidebug_deinit(wdata);
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
> index 5f74917781f28..df6f830ee791c 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -7,6 +7,7 @@
>  /*
>   */
> 
> +#include <linux/cleanup.h>
>  #include <linux/debugfs.h>
>  #include <linux/module.h>
>  #include <linux/seq_file.h>
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
> @@ -186,9 +181,8 @@ int wiidebug_init(struct wiimote_data *wdata)
>  	dbg->drm = debugfs_create_file("drm", S_IRUSR,
>  			dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
> 
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->debug = dbg;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->debug = dbg;
> 
>  	return 0;
> 
> @@ -197,14 +191,12 @@ int wiidebug_init(struct wiimote_data *wdata)
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
> index dccb78bb3afd6..3cd6144667404 100644
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
> 2.53.0
