From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH] input: Add Atmel maXTouch touchscreen driver
Date: Wed, 17 Nov 2010 12:41:40 +0200
Message-ID: <4CE3B164.9070607@atmel.com>
References: <4CDD4BBA.5070301@atmel.com> <20101112201001.GE1299@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:14219 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229Ab0KQLGk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 06:06:40 -0500
Received: from bagnes.atmel.com (bagnes.atmel.com [10.175.100.4])
	by sjogate2.atmel.com (8.13.6/8.13.6) with ESMTP id oAHB4ECx022574
	for <linux-input@vger.kernel.org>; Wed, 17 Nov 2010 03:04:14 -0800 (PST)
In-Reply-To: <20101112201001.GE1299@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kyungmin.park@samsung.com, jy0922.shim@samsung.com, linux-input@vger.kernel.org

On 11/12/2010 10:10 PM, Dmitry Torokhov wrote:
> Hi Iiro,
> 
> I believe there is already a driver for this hardware in the tree
> (qt602240.c). Could you tell me what additional features your driver
> implements and why can't they be added to the existing driver.
> 

Hi Dmitry,

the current driver is written for one maXTouch chip, mXT224. The driver that I submitted will support all current maXTouch chips, and it is built to be future-proof so it should work with yet to be released chips too, with minor or no changes. This shows in the naming too, part name "qt602240" is deprecated and it shouldn't be used. As the driver should work with all chips in the maXTouch family, a more generic naming convention in the driver name itself and all the code inside the driver would be more appropriate. 

Atmel would like to be the maintainer of this driver, and it would be easiest if we could use the code I submitted. Of course we would be happy to implement any improvements like the threaded IRQs.

Best Regards,
-- 
Iiro Valkonen
Application Engineer / Atmel Corporation
Tel: +358(9)45208250 / Mobile: +358(40)5820012
iiro.valkonen@atmel.com / www.atmel.com
