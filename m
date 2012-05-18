From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH RESEND v3 1/2] input: keyboard: Add keys driver for the
 LPC32xx SoC
Date: Fri, 18 May 2012 11:12:18 +0200
Message-ID: <4FB61272.5080700@antcom.de>
References: <1337199955-26441-1-git-send-email-stigge@antcom.de> <20120517173814.GA26948@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:53254 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967112Ab2ERJMV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 May 2012 05:12:21 -0400
In-Reply-To: <20120517173814.GA26948@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: axel.lin@gmail.com, riyer@nvidia.com, michael.hennerich@analog.com, grant.likely@secretlab.ca, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com

Hi Dmitry!

thanks for your suggestions, will include them into the next patch update.

On 05/17/2012 07:38 PM, Dmitry Torokhov wrote:
>> +	of_property_read_u32(np, "keypad,num-rows", &rows);
>> +	of_property_read_u32(np, "keypad,num-columns", &columns);
>> +	if (!rows || rows != columns) {
>> +		dev_err(dev, "rows and columns must be specified and be equal!\n");
> 
> Why?

The LPC32xx key scanner hardware is always configured with a square
matrix (rows == columns). So I had the choice to force "keypad,num-rows"
== "keypad,num-columns" (as done currently) to show potential error to
the DTS/DTB provider, or ignore problems here and use
max("keypad,num-rows", "keypad,num-columns") for actual hardware setup.

(You can and will leave out unconnected keys in the keymap anyway.)

So do you think we should change my current approach here?

Thanks in advance,

Roland
