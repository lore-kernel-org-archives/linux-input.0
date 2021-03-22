Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2285BC433E3
	for <linux-input@archiver.kernel.org>; Mon, 22 Mar 2021 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A4E61931
	for <linux-input@archiver.kernel.org>; Mon, 22 Mar 2021 13:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhCVNSn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:18:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35787 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232357AbhCVNQ4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Mar 2021 09:16:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A8065C017C;
        Mon, 22 Mar 2021 09:16:55 -0400 (EDT)
Received: from imap8 ([10.202.2.58])
  by compute1.internal (MEProxy); Mon, 22 Mar 2021 09:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=+VpS8U9m6GjKkzm+jH5ORlCwtqda
        NL5i9E7zCyY7KkI=; b=CW8mYXPtQTFbSGKDgDvCldyaOoOoZM5btJaaC3kxxnjv
        KebB6X72V4Ds7CH5MZaDxCMP8L/aQXH5d82vuUUAv/cJOcWZyqA9W5uzIAqIONIN
        26A0jFEZAaG5TEkDvf2Hvo9+TQBOCOiTEOF/KSxbCppdsYuZERLtpKR3H7fGd5ua
        1X3B6Vc7yMvfAXXbVCsJZRQ5T/Qx6sXb6T+5r8u71s8asQSSC6r6r3Shc+MRph1L
        m8gTmP9tOTxecwldzuj1PLzbV9So64uB0yS8rV848+zAJHLz0uBm5PTb2IbaZc71
        K8jpmk8/iXTZ0GclASdkv4LumCm1uVAKI2OjzRBDsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+VpS8U
        9m6GjKkzm+jH5ORlCwtqdaNL5i9E7zCyY7KkI=; b=lsGk6BV+j39c2JEBKrRQvq
        h7DZ/Z/Ezr/vEAvycODFURBfXGqabCFwV5LAhsr0PUehOdrLEGyh277x0pLCjUIq
        Z+Oqyi6QNkAF/fempVT8gywY5ek/5kboAa2MAyPNHXhDlRQHzjWTi01sFeYUa4pu
        XvUpmuRMQ/7pHxXWhJelWgUx7yk87l2u78fUbbNA8cEGzZ/siu7GM6ri7O/U+u3B
        WaNlToOHA8ltBKbe/YzeObsjBsZhOGDNTB9ghgpfIQ7cQJSmJ7p6JLc4OPrEPM9O
        gsKhmb2eJeYfoHPO+jWvdkZ91Zd+wiG9R4VH7KUlmcaiumn0JzNpcGS9hbxJo5PA
        ==
X-ME-Sender: <xms:x5hYYKM_gy3rISQjHr1acGlRQPzRVZ2H2KmgVnGF8INZWqhnBY6pxw>
    <xme:x5hYYI-mSJgVRMho4_Tk2mePeZydh4sA0Qq1LvEkZWMQWKW7yj3g6HKj8wb1YDlNd
    MZJi-4kJzr2wLr0wpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeuffekveehjeeltdeuveeikeelkeejhfejheduhfdtgfdtgfejjeekvdev
    jeevueenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:x5hYYBS9x6ETdobByZ-ul6L2u1d3IYirJwWfds2oBoQOixp1TnvK-g>
    <xmx:x5hYYKvlPkGWOZK9URkNGj21YW4l7aDfwUArHmJQurIBtsBrs8GxAA>
    <xmx:x5hYYCcwB4pwa_DsYG2eQk5T-xWdvrD0u8jFCK-nub_oMSKhI2bFiw>
    <xmx:x5hYYEp8PxRxKCUncfAUjF9pc3PQeyeQLoYzN4tNKDxZWiCb5V_mjA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D8F33A0721; Mon, 22 Mar 2021 09:16:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-271-g88286cf463-fm-20210318.001-g88286cf4
Mime-Version: 1.0
Message-Id: <1adfc818-abf6-4fcd-82a9-19f5e7d0b994@www.fastmail.com>
In-Reply-To: <20210321220043.318239-1-dmitry.torokhov@gmail.com>
References: <20210321220043.318239-1-dmitry.torokhov@gmail.com>
Date:   Mon, 22 Mar 2021 09:13:15 -0400
From:   Alistair <alistair@alistair23.me>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Input: wacom_i2c - do not force interrupt trigger
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, Mar 21, 2021, at 6:00 PM, Dmitry Torokhov wrote:
> Instead of forcing interrupt trigger to "level low" rely on the
> platform to set it up according to how it is wired on the given
> board.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com <mailto:dmitry.torokhov%40gmail.com>>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> drivers/input/touchscreen/wacom_i2c.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
> index 1afc6bde2891..609ff84e7693 100644
> --- a/drivers/input/touchscreen/wacom_i2c.c
> +++ b/drivers/input/touchscreen/wacom_i2c.c
> @@ -195,8 +195,7 @@ static int wacom_i2c_probe(struct i2c_client *client,
> input_set_drvdata(input, wac_i2c);
>  
> error = request_threaded_irq(client->irq, NULL, wacom_i2c_irq,
> -      IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -      "wacom_i2c", wac_i2c);
> +      IRQF_ONESHOT, "wacom_i2c", wac_i2c);
> if (error) {
> dev_err(&client->dev,
> "Failed to enable IRQ, error: %d\n", error);
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
> 
