From: <paul.chavent@fnac.net>
Subject: Re: input_polling_devices design question + adxl34x polling mode
 patch
Date: Tue, 12 Apr 2011 09:22:46 +0200 (CEST)
Message-ID: <21320964.95421302592966588.JavaMail.www@wsfrf1112>
Reply-To: <paul.chavent@fnac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaweb11.services.sfr.fr ([93.17.128.28]:19287 "EHLO
	smtp11.services.sfr.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756732Ab1DLHWr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 03:22:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: michael.hennerich@analog.com, device-driver-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

Hi Dimitry,

>Yes, just use the system workqueue

Ok. I won't use the polled input anymore.

>Note that I normally oppose supporting polling mode for devices that may be interrupt driven, since this normally increases power consumption.

Yes, but in my case i have no choice (the hardware don't allow to use interrupts). So The polled mode could be an option ?

Are you definitively opposed to this options ? 

Paul. 

