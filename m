From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Thu, 6 Aug 2009 22:47:28 -0300
Message-ID: <200908062247.29254.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:35976 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZHGBro (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2009 21:47:44 -0400
Received: by gxk9 with SMTP id 9so1675422gxk.13
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2009 18:47:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

	Hi,

	As requested by Marcel Holtmann I am sending this e-mail to the linux-input 
mailing list so we can sort out one problem I have with my bluetooth mouse. 
Since kernel 2.6.28 my bluetooth mouse (0458:0058) makes Xorg cursor to get 
stucked at upper left corner of the screen. Even if I use the touchpad of my 
notebook (Acer Ferrari 4005) the cursor still gets trapped at upper left 
corner. One workaround I have found for this problem is change session type 
from hid to input in linux/net/bluetooth/hidp/core.c. Marcel does not like 
this idea so I need help to find a better way to solve this problem.

	One think I have discovered is that when using hid session the mouse send 
several 9-bytes frames with this content:  0x05 0xff 0x6e 0x6f 0x54 0xc6 0x10 
0x00 0x02 (or 0x03 instead of 0x02). If I filter those frames in 
hidp_recv_intr_frame (linux/net/bluetooth/hidp/core.c) before calling 
hid_input_report, the cursor does not get stucked but the overhead of doing 
that is too high, the cursor gets sluggish. Using input session instead of hid 
session gets muth better results and is not as uggly as filtering frames. Can 
someone help me to find a better solution?

-- 
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/
