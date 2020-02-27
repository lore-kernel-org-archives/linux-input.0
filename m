Return-Path: <SRS0=dHTn=4P=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8415C3F2C2
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 22:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8004424650
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 22:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="u1GqpQiG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eY5qbMHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgB0WgS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:36:18 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58859 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729808AbgB0WgR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Feb 2020 17:36:17 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B4476220BD;
        Thu, 27 Feb 2020 17:36:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 27 Feb 2020 17:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ov41UkSl41BMVyDa9tdCim+4xN3
        JMQqoafhLm9TNTqM=; b=u1GqpQiG9pgJ7V9jG/2MoW41kjRlgSIBAyqSUhwiB8W
        mDxTcYpOy9e/lklTy5qFKlcK2ahs6O3pW67hkFB98SdxTuFUh8sZGfS+zcQDVfEW
        04oGRFcWlcQJyphU9iiWDNgJb43AwFm6EDm6KF4cJTC/DApYplVx8ye1CtDpxYND
        7IW9nSDx9qBpKac8UOOh+jYllmjT75zmrJpTmDEoK4HF+QefpafuG9W924rwFkIc
        MPcmK2Eyr4/aX46G3M/S3Vu0QbnxV97UDe4VnZqKWukWeer1o5TB1OJ6jRWZ06eW
        oTTZfoYhhZhqbXFPJu0O6MMuxRECEZDxcPIPsSjXJKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ov41Uk
        Sl41BMVyDa9tdCim+4xN3JMQqoafhLm9TNTqM=; b=eY5qbMHbuj4CLg60BKVvCA
        dDsgP7NNqg4h5hPyaqE0T0sidKfmYV3DpTZvJDrMFPH/Ch6FyuQA4NwyKzoBgu+v
        TwDw+sJCY68Ed46GEVsH7i/astJahl6gglQJlYVTlI8blDabdtHWMsdgjJnkzQMS
        HPQWVrO/4Dl10qtSKSr7qnLAIQ+QjkAaRCT7yIZBGIM0reOGkuCWXohAHmT048PH
        rm5EkRlztTSwj3MUEpKvcuAwPOhs7raz+m0fBbHO6VRPiofN38FNIp59KNQKvozU
        DQIrIglMJNsU8wq6Ladd0qRDHl2BrxwlhNIQS44ZCPrNHwBJ3ZC3JbxEXxHfp3Ew
        ==
X-ME-Sender: <xms:X0RYXkBz_9d8Wxy7yzCP3VVaNLj6WAnSXDqQ0KhzD78bRSYCJltUyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvghtvghrucfjuhht
    thgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqnecukf
    hppeduudejrddvtddrjedurddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    ht
X-ME-Proxy: <xmx:X0RYXraFoDptMoV63fehTYhJtb6im-20GszuZNZfWeaHyFr66o5zIw>
    <xmx:X0RYXlKDbp5pqh601_W5UzYu3Pz8yaEjfZz_RwPxHK1bdDJ08AMRZA>
    <xmx:X0RYXs1lRPd7-6QTZabtXxduz6EjaDWw8KtGPGxsSOJxTp08eZFWZA>
    <xmx:YERYXgYjdmqekgXLlvrfzDe3C2Yoih4na2-TMO7yVZ4X9_16sd0_TA>
Received: from jelly (117-20-71-109.751447.bne.nbn.aussiebb.net [117.20.71.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4D173280064;
        Thu, 27 Feb 2020 17:36:12 -0500 (EST)
Date:   Fri, 28 Feb 2020 08:36:08 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Subject: Re: [PATCH] Input: elants_i2c - Report resolution information for
 touch major
Message-ID: <20200227223608.GB1087116@jelly>
References: <1582766000-23023-1-git-send-email-johnny.chuang.emc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582766000-23023-1-git-send-email-johnny.chuang.emc@gmail.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Feb 27, 2020 at 09:13:20AM +0800, Johnny Chuang wrote:
> From: Johnny Chuang <johnny.chuang@emc.com.tw>
> 
> This patch supports reporting resolution for ABS_MT_TOUCH_MAJOR event.
> This information is needed in showing pressure/width radius.
> 
> Signed-off-by: Johnny Chuang <johnny.chuang@emc.com.tw>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 4911799..14c577c 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -1309,6 +1309,7 @@ static int elants_i2c_probe(struct i2c_client *client,
>  	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
>  	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
>  	input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->y_res);
> +	input_abs_set_res(ts->input, ABS_MT_TOUCH_MAJOR, 1);

official resolution for absinfo is "units per mm", so a value of 3 would
mean 3mm, is that correct?

Not that it matters too much, since touch major is already all over the
place and needs userspace overrides for every device but it'd be nice to at
least make this useful out of the box on one device class.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

otherwise

Cheers,
   Peter

>  
>  	error = input_register_device(ts->input);
>  	if (error) {
> -- 
> 2.7.4
> 
