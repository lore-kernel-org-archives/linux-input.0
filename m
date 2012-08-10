From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: eeti_ts: pass gpio value instead of IRQ
Date: Fri, 10 Aug 2012 15:25:25 +0300
Message-ID: <20120810122525.GA22941@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:51445 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab2HJMZk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Aug 2012 08:25:40 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: arnd@arndb.de
Cc: linux-input@vger.kernel.org

Hello Arnd Bergmann,

This is a semi-automatic email about new static checker warnings.

The patch 4eef6cbfcc03: "Input: eeti_ts: pass gpio value instead of 
IRQ" from Apr 30, 2012, leads to the following Smatch complaint:

drivers/input/touchscreen/eeti_ts.c:209 eeti_ts_probe()
	 warn: variable dereferenced before check 'pdata' (see line 202)

drivers/input/touchscreen/eeti_ts.c
   201		priv->input = input;
   202		priv->irq_gpio = pdata->irq_gpio;
                                 ^^^^^^^^^^^^^^^
   203		priv->irq = gpio_to_irq(pdata->irq_gpio);
                                        ^^^^^^^^^^^^^^^
   204	
   205		err = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
                                       ^^^^^^^^^^^^^^^
New dereferences.

   206		if (err < 0)
   207			goto err1;
   208	
   209		if (pdata)
                    ^^^^^
Old check.

   210			priv->irq_active_high = pdata->irq_active_high;
   211	

regards,
dan carpenter

