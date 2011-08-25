From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Question: I2C touchscreen controller
Date: Thu, 25 Aug 2011 09:23:24 +0200
Message-ID: <20110825072324.GA4065@polaris.bitmath.org>
References: <ADE657CA350FB648AAC2C43247A983F001F3885759E3@AUSP01VMBX24.collaborationhost.net>
 <20110824195436.GA13228@core.coreip.homeip.net>
 <ADE657CA350FB648AAC2C43247A983F001F388575A7F@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:50311 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1HYHVZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 03:21:25 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 133D3D5ED
	for <linux-input@vger.kernel.org>; Thu, 25 Aug 2011 09:21:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F388575A7F@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> It looks like these are the current I2C touchscreen drivers in mainline:
> 
> CONFIG_TOUCHSCREEN_88PM860X		pmic mfd device? probably not standalone
> CONFIG_TOUCHSCREEN_AD7879_I2C		datasheet looks simple enough
> CONFIG_TOUCHSCREEN_ATMEL_MXT		needs firmware? probably complicated
> CONFIG_TOUCHSCREEN_BU21013		can't find a datasheet
> CONFIG_TOUCHSCREEN_CY8CTMG110		looks like the chip may be obsolete
> CONFIG_TOUCHSCREEN_MAX11801		Maxim usually has long lead times
> CONFIG_TOUCHSCREEN_MCS5000		can't find a datasheet
> CONFIG_TOUCHSCREEN_STMPE		datasheet looks simple enough
> CONFIG_TOUCHSCREEN_TSC2007		datasheet looks simple enough
> 
> Based on that I'm considering the Analog Devices, STMicro, and TI parts.
> 
> Do you know if any of these work better than the others?

Out of those, bu21013 (and st1232 not on your list) are dual touch,
and atmel_mxt is true multitouch. The rest are single touch.

Cheers,
Henrik
