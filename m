From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: The way for disabling input device?
Date: Tue, 15 Mar 2011 18:06:26 +0900
Message-ID: <4D7F2C12.5020509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32100 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1COJSV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 05:18:21 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LI300LQQDAQTY40@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 15 Mar 2011 18:06:26 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LI300LW2DAQ50@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 15 Mar 2011 18:06:26 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi, all.

The many smartphones and embedded devices have LCD panel with
touchscreen. The LCD panel is turned off for power saving and
touchscreen also is disabled if there isn't user input for a while or if
user presses power key briefly. This state is such idle, not suspend.

The framebuffer device driver of kernel supplies sysfs interface to
control blanking level of framebuffer and  we can turn off LCD panel
using this sysfs at the above case.

Currently i know there isn't the generic way for disabling input device
via user interface, so i am looking for the way for disabling
input device on kernel side for above case.

The above case has a condition which the touchscreen is disabled if LCD
panel is turned off. The framebuffer framework of kernel has notifier
block to callback on events like hardware display blank change occured,
so the callback function disabling and enabling input device can be
called using notifier block of framebuffer. The callback function is
implemented in each touchscreen driver or can be implemented though
input core if this can be generic way for input device.

Actually i wonder whether this approach makes sense. I know this is a
specific case but certainly necessary function in the smartphone and
embedded devices.

Thanks.
