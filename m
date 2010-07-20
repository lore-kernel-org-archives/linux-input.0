From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 - Support gpio function on
 unused pin
Date: Tue, 20 Jul 2010 11:40:03 -0700
Message-ID: <20100720184003.GA14222@core.coreip.homeip.net>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60161 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761404Ab0GTSkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jul 2010 14:40:15 -0400
Received: by pwi5 with SMTP id 5so2274341pwi.19
        for <linux-input@vger.kernel.org>; Tue, 20 Jul 2010 11:40:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolong Chen <xiaolong.chen@gmail.com>
Cc: Michael <Michael.Hennerich@analog.com>, david-b@pacbell.net, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>, Xiaolong CHEN <a21785@motorola.com>

Hi Xiaolong,

On Tue, Jul 20, 2010 at 08:49:36PM +0800, Xiaolong Chen wrote:
> Hi Dmitry,
> 
> There is still some issue on my company mail system, so change to this mail to submit the patch.
> 
> Looks like this time haven't the line wrapped issue, any further comments and suggestion, please let me know.
> 

I think we need to protect the code you are adding with #ifdef
CONFIG_GPIOLIBi and provide the stubs in case gpiolib is not
available. This will also force splitting the gpio hanlding code
into separate functions so that it is easier to read. Please see
how it is done in ad7879 driver.

Also if would be great if you generated the patch against the
version of the driver that is ither in linux-next or in the 'next'
branch of my tree as there a few changes clashing with yours.

Thanks.

-- 
Dmitry
