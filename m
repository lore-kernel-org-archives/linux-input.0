From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 3 Sep 2010 09:20:56 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B181C768836@EXDCVYMBSTM006.EQ1STM.local>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
 <4C809F7B.2020807@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:51339 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753417Ab0ICHVU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Sep 2010 03:21:20 -0400
In-Reply-To: <4C809F7B.2020807@codeaurora.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi,

>-----Original Message-----
>From: Trilok Soni [mailto:tsoni@codeaurora.org]
>It is not must for this driver to go through, but what would be the behaviour of
>pwr-key on suspend and resume? Do you want power key to wakeup the system
>from sleep?
>OR don't want to make it as wakeup source?

This is from the AB8500 PMIC which is on always-on power source. All the AB8500 interrupts
to the system are by platform configuration wakeup source, which is handled separately by 
a PRCM unit on the DB8500 and hence no suspend/resume helpers or wakeup configuration 
for the Pon-Key.

Cheers!
Sundar
