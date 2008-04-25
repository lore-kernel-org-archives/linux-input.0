From: "Andrew Victor" <avictor.za@gmail.com>
Subject: Re: [PATCH 2/2] atmel_tsadcc: Add board specific information for touchscreen driver
Date: Sat, 26 Apr 2008 00:29:09 +0200
Message-ID: <cd73a99e0804251529g68e88165x3863c4257618ee00@mail.gmail.com>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
	 <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
	 <1209149798-20418-3-git-send-email-justin.waters@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:9560 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbYDYW3L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 18:29:11 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3331226wxd.4
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 15:29:09 -0700 (PDT)
In-Reply-To: <1209149798-20418-3-git-send-email-justin.waters@timesys.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Waters <justin.waters@timesys.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, dmitry.torokhov@gmail.com, linux@maxim.org.za

hi Justin,

>  +static u64 atmel_tsadcc_dmamask = 0xffffffffUL;

Rather use DMA_BIT_MASK(32).

>  +       /* These values work with a 100 MHz Master Clock for the ADC */
>  +       .prescaler      = 0xC, /* 3.846 MHz Clock */
>  +       .debounce       = 0xE, /* 4.2 ms debounce */
>  +       .tsshtim        = 0x3, /* 1.04 us Sample Hold time */
>  +       .startup        = 0x13, /* 41 us Startup Time */

What is the impact of a different Master Clock rate?  This devices.c
file is intended to be board-independent.
Wouldn't it be better for the driver to call clk_get_rate() and
calculate "good" values for these?


>  +                               .coherent_dma_mask      = 0xffffffff,

Similarly, DMA_BIT_MASK(32).


Regards,
  Andrew Victor
