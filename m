From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: I2C Touchscreen OMAP OOPS
Date: Tue, 4 Jan 2011 18:44:43 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1101041842590.18898@esdhcp041196.research.nokia.com>
References: <1294124183.6822.335.camel@t-dhlii>  <BF127B05DE84486CBC072C314CD0178B@wipblrx0099946> <1294157084.6822.387.camel@t-dhlii>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:32867 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab1ADQpZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Jan 2011 11:45:25 -0500
In-Reply-To: <1294157084.6822.387.camel@t-dhlii>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "David Lynch Jr." <dhlii@dlasys.net>
Cc: Hemanth V <hemanthv@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On Tue, 4 Jan 2011, David Lynch Jr. wrote:
>        For reference the mcs5000 driver as well as an st1232 driver that was
> in the linux input patch stream perform I2C xfers in an interrupt
> context.

They are using threaded IRQ handlers, which might be the solution you
are looking for.

A.
