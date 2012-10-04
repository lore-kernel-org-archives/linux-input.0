From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: 3.6 kernel regression: annoying keyboard autosuspend
Date: Thu, 4 Oct 2012 00:40:13 -0300
Message-ID: <k4j0es$6el$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38510 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755671Ab2JEB0n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Oct 2012 21:26:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1TJweq-0008D1-Fe
	for linux-input@vger.kernel.org; Fri, 05 Oct 2012 03:24:53 +0200
Received: from 187.37.57.115 ([187.37.57.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 05 Oct 2012 03:24:52 +0200
Received: from fragabr by 187.37.57.115 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 05 Oct 2012 03:24:52 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

	I upgraded from kernel 3.5.1 to kernel 3.6 and my keyboard
(Logitech Access keyboard 600 USB) was suspending everytime.

	So I did the following as a workaround:

echo -1 > /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/power/autosuspend

	***

	This didn't happen with kernel 3.5, so something has changed in hid_generic.

	Any hints?

-- 
Linux 3.6.0: Terrified Chipmunk
http://www.youtube.com/DanielFragaBR


