From: Gregor Riepl <onitake@gmail.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Mon, 21 Mar 2016 01:51:42 +0100
Message-ID: <56EF459E.8000808@gmail.com>
References: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38847 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcCUAvp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Mar 2016 20:51:45 -0400
Received: by mail-wm0-f47.google.com with SMTP id l68so103917492wml.1
        for <linux-input@vger.kernel.org>; Sun, 20 Mar 2016 17:51:44 -0700 (PDT)
In-Reply-To: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>, linux-input@vger.kernel.org

> err = request_irq(icn85xx_ts->irq, icn85xx_ts_interrupt,
> IRQ_TYPE_EDGE_FALLING, "icn85xx_ts", icn85xx_ts);
>     if (err < 0){
>         icn85xx_error("icn85xx_ts_probe: request irq failed\n");
>         return err;
>     }
> 
> 1) Does this correct IRQ settings for TS? If not - what is procedure?
> What I have missed? H

I recommend using devm_request_threaded_irq instead.
The devm_* functions take care of deallocation automatically, and a threaded
IRQ handler is much better for slow operations like I2C access IMHO.

