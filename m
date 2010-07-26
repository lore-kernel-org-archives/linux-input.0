From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 - Support gpio function on
 unused pin
Date: Mon, 26 Jul 2010 10:38:44 -0700
Message-ID: <20100726173844.GC14609@core.coreip.homeip.net>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
 <4C4DADA7.9000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63812 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0GZRiv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 13:38:51 -0400
Received: by pwi5 with SMTP id 5so164011pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 10:38:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C4DADA7.9000201@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolong Chen <xiaolong.chen@gmail.com>
Cc: Michael <Michael.Hennerich@analog.com>, david-b@pacbell.net, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>, Xiaolong CHEN <a21785@motorola.com>

Hi Xiaolong,

On Mon, Jul 26, 2010 at 11:45:43PM +0800, Xiaolong Chen wrote:
>  Hi, Dmitry
> 
> Following your comments, add the CONFIG_GPIOLIB and update the
> patch based on the linux-next. If there is any comments and
> suggestion, please feel free let me know.
> 
> I think we need to protect the code you are adding with #ifdef
> CONFIG_GPIOLIBi and provide the stubs in case gpiolib is not
> available. This will also force splitting the gpio hanlding code
> into separate functions so that it is easier to read. Please see
> how it is done in ad7879 driver.
> Done.
> 
> Also if would be great if you generated the patch against the
> version of the driver that is ither in linux-next or in the 'next'
> branch of my tree as there a few changes clashing with yours.
> Done.
> 

I have applied the patch with minor changes to my 'next' branch on
kernel.org. Would you mind taking a look there to make sure it is all in
order?

Thanks.

-- 
Dmitry
