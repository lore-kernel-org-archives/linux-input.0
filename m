From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: add Cypress TTSP capacitive multi-touch screen support
Date: Wed, 1 Feb 2012 12:40:39 +0300
Message-ID: <20120201094039.GA20690@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:61511 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322Ab2BAJku (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2012 04:40:50 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier@dowhile0.org
Cc: linux-input@vger.kernel.org

Hello Javier Martinez Canillas,

This is a semi-automatic email about new static checker warnings.

The patch 4065d1e7b216: "Input: add Cypress TTSP capacitive 
multi-touch screen support" from Jan 31, 2012, leads to the following 
Smatch complaint:

drivers/input/touchscreen/cyttsp_core.c +526 cyttsp_probe()
	 warn: variable dereferenced before check 'dev' (see line 521)

drivers/input/touchscreen/cyttsp_core.c
   520	{
   521		const struct cyttsp_platform_data *pdata = dev->platform_data;
                                                           ^^^^^
dereference.

   522		struct cyttsp *ts;
   523		struct input_dev *input_dev;
   524		int error;
   525	
   526		if (!dev || !bus_ops || !pdata || !pdata->name || irq <= 0) {
                    ^^^^
check.

   527			error = -EINVAL;
   528			goto err_out;

"dev" is never NULL here so the check can be removed probably.

regards,
dan carpenter
