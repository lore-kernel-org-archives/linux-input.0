From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: i2c keyboard
Date: Mon, 23 Feb 2009 12:05:38 +0100
Message-ID: <200902231205.38255.marek.vasut@gmail.com>
References: <49A2636C.10502@kaa.org.ua>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:41920 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbZBWLFi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2009 06:05:38 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1149595mue.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2009 03:05:35 -0800 (PST)
In-Reply-To: <49A2636C.10502@kaa.org.ua>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleg Kravchenko <oleg@kaa.org.ua>
Cc: linux-input@vger.kernel.org

On Monday 23 of February 2009 09:50:52 Oleg Kravchenko wrote:
> Hello, everyone.
> We are porting the Linux kernel to our PDA, Asus P525/P535. This device
> has a pca9535 gpio extender. The keyboard is connected to it. The
> extender has only one irq. At the moment, the pca9535 is handled by
> pca953x gpio driver. We need to have the access to its registers from
> our keyboard driver (so as not to read 13 gpios, but decode the register
> containing gpio states). If i try to read each of these 13 gpios after
> the interrupt from the extender comes, the kernel crashes. Is there a
> solution to read i2c client addresses when there is a client registered
> already?
>
There was some discussion about implementing batch GPIO reads in 
linux-arm-kernel mailing list, that's probably what you want.

>
> http://www.kaa.org.ua/asus-p535/hardware.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


