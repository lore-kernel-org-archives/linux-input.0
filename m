From: Allan Crooks <allan@amcone.net>
Subject: Dell Latitude E7440 - ALPS touchpad keeps having state reset
Date: Mon, 27 Jan 2014 15:23:02 +0000
Message-ID: <CAPhwt3YC9zvdg6XrFvUt5giehrMHXft5p81UB6Z4rwBOTJ2ioA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:47282 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbaA0PXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 10:23:23 -0500
Received: by mail-bk0-f51.google.com with SMTP id w10so2936182bkz.10
        for <linux-input@vger.kernel.org>; Mon, 27 Jan 2014 07:23:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I've reported the problem I'm having in more detail here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1258837

In summary - I keep suffering from the mouse pointer jumping around
erratically, with the following messages output to syslog:
 psmouse serio1: DualPoint TouchPad at isa0060/serio1/input0 lost sync at byte 1
 psmouse serio1: DualPoint TouchPad at isa0060/serio1/input0 - driver resynced.

Other people have reported the same problem in that bug report.
Bisecting the kernel, the problem seems to have always been in place
as soon as the touchpad was correctly identified; according to xinput
- it's a "AlpsPS/2 ALPS DualPoint TouchPad". When it was being
identified as a generic PS/2 mouse, there's no problem (though of
course, there's also no touchpad functionality available either).

Is there anything I can do to help provide information to get this fixed?

Thanks,
Allan.
