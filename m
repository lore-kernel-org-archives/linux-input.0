From: Joey Oravec <joravec@drewtech.com>
Subject: shutdown callback needed in serio?
Date: Mon, 19 Sep 2011 15:18:45 -0400
Message-ID: <4E779595.1070205@drewtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from drewtech.com ([66.36.241.150]:37320 "EHLO server.drewtech.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756511Ab1ISTSr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 15:18:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Howdy,

I'm writing a serio-based kernel driver for a uart-based chip that my 
company makes. This chip is used on embedded systems and implements 
several features: gpio, rtc, interrupt controller, etc.

One of the features is a power/reset controller. We support one family 
of ARM chips that cannot even reboot themselves. This family has a 
single reset request line that gets asserted for several reasons: 
writing to the shutdown register, low-power suspend, hardware watchdog, 
etc. For normal cases the host should send a serial message to setup the 
desired action (reboot, powerdown) then write to the shutdown register.

Normally shutdown or suspend callbacks are available, but serio does not 
expose these. Should I try to register a child platform_device with 
these callbacks? How is this going to work during reboot and shutdown 
since inputattach must be running in userspace to keep the line 
discipline alive? Will serio disconnect before any the kernel sends 
shutdown notifications?

-joey
