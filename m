From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: RFC: User-space interface to read/write touchscreen controller registers
 (atmel_mxt_ts.c)
Date: Fri, 22 Jul 2011 15:11:25 +0300
Message-ID: <4E2968ED.4030708@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:64429 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1GVML1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 08:11:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello,

we have a need to access the configuration registers/register blocks of the touchscreen controller from the user space. There are several reasons for this, and while some of them are related to debugging, some can be valuable in normal use cases. For example, a configuration parameter might need to be semi-permanently changed to improve performance, or some parameter could even be updated for different usage modes of the device. This interface would make it very easy. Currently, a change in the board file and kernel recompile is needed to change the settings. 

My question is, what kind of approach would be recommended, and what would be acceptable to include in the mainline version? Currently there exists a patch which adds a character device and few IOCTLs (very similar to maXTouch driver here: http://gitorious.org/maxtouch), but my understanding is that is not the best way to do this. Would a sysfs-based system be better suited? Are there any good examples in the mainline drivers how something like this should be implemented?

Best Regards,

-- 
Iiro Valkonen
