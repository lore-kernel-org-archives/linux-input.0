From: Alexandra Chin <alexandra.chin@tw.synaptics.com>
Subject: RE: [PATCH] Input: Add new driver into Input Subsystem for
 Synaptics DS4 touchscreen I2C devices
Date: Fri, 5 Oct 2012 09:44:55 +0000
Message-ID: <CC51EC7B5B7F984AA566DC102237848896F59949@hkdcw-mail1.synaptics-inc.local>
References: <CC51EC7B5B7F984AA566DC102237848896F590C0@hkdcw-mail1.synaptics-inc.local>
 <20121003180121.GA4198@polaris.bitmath.org>
 <CC51EC7B5B7F984AA566DC102237848896F593FA@hkdcw-mail1.synaptics-inc.local>
 <20121004065137.GA14217@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tw-mx2.synaptics.com.tw ([203.163.83.68]:18472 "EHLO
	tw-mx2.synaptics.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab2JEJpE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Oct 2012 05:45:04 -0400
In-Reply-To: <20121004065137.GA14217@core.coreip.homeip.net>
Content-Language: zh-HK
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Mahesh Srinivasan <msrinivasan@synaptics.com>, Alex Chang <alex.chang@tw.synaptics.com>, Scott Lin <scott.lin@tw.synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>

Hi Dmitry/Henrik,


From: Dmitry Torokhov
Sent: Thursday, October 04, 2012 2:52 PM
> Given that the other group at Synaptics works on general version of RMI4
> driver what is the benefit of having separate driver for DS4 line? I can
> understand keeping one copy of older driver in staging so that some
> customers coudl still use hardware while universal implementation is
> being developed, but I do not see why we would want to have 3 separate
> drivers.


Thank you for your suggestions and comments!

We agree with your opinion. We will submit the driver as a patch on top 
of STE's driver since it is in the staging.

And we would like to state our purpose clearly why we are doing this 
including the following:
- We have customers that require a Touch Controller platform specific
 driver, that is protocol specific, following a single source file structure.
- There is also a requirement that the platform specific driver has to be 
 adopted and included into the Linux kernel.

As you are aware, Chris' team is working on general version of RMI4. 
However customers still require a platform specific driver for Touch 
Controller platform. We really hope both drivers (general RMI4 driver 
and STE's driver) being adopted into the kernel. This will allow us to 
provide the best flexibility possible to customers.

Your opinion will be greatly appreciated.

Alexandra Chin
