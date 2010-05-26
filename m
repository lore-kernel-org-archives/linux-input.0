From: Chase Douglas <chase.douglas@canonical.com>
Subject: New multitouch touchscreen over serial support
Date: Wed, 26 May 2010 18:29:25 -0400
Message-ID: <1274912965.4128.43.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57606 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423Ab0EZW33 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 18:29:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pingc@wacom.com
Cc: linux-input@vger.kernel.org

Ping,

I've got one of the new HP Mini 5102 touchscreen netbooks, which has a
wacom multitouch touchscreen over serial. I haven't found any support
for this device in the kernel, it seems X reads from it directly using
xf86-input-wacom. IMHO, the best support for this driver would be as a
kernel module that could use the input subsystem to send multitouch
events up through the evdev interface.

Do you have any information on this device? Would it be possible to
write a driver?

Thanks,

-- Chase

