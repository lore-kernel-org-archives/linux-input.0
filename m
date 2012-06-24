From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH RESEND v4] input: keyboard: Add keys driver for the LPC32xx
 SoC
Date: Sun, 24 Jun 2012 16:42:28 +0200
Message-ID: <4FE72754.2000706@antcom.de>
References: <1339443891-15197-1-git-send-email-stigge@antcom.de> <20120621085623.GF2193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:53006 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab2FXOmc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jun 2012 10:42:32 -0400
In-Reply-To: <20120621085623.GF2193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: axel.lin@gmail.com, riyer@nvidia.com, michael.hennerich@analog.com, grant.likely@secretlab.ca, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com

On 21/06/12 10:56, Dmitry Torokhov wrote:
> On Mon, Jun 11, 2012 at 09:44:51PM +0200, Roland Stigge wrote:
>> This patch adds a driver for the key scan interface of the LPC32xx SoC
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>> For the DT binding: Acked-by: Rob Herring <rob.herring@calxeda.con>
> 
> Not a real review, just a quick question - if th driver is DT-only now
> do we need to have the platform data or it would make more sense to read
> DT-bindings and fill the main device structure directly?

And:

>> +
>> +	matrix_keypad_build_keymap(NULL, NULL, kscandat->kscancfg->matrix_sz,
>> +				   kscandat->kscancfg->matrix_sz,
>> +				   kscandat->kscancfg->keymap, kscandat->input);
> 
> This function may fail now.

I'm addressing both issues in a updated patch.

Thanks for the feedback,

Roland
