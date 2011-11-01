From: Jonathan Nieder <jrnieder@gmail.com>
Subject: psmouse: "bad data from KBD - bad parity" every 2ms with synaptics
 touchpad
Date: Tue, 1 Nov 2011 03:02:11 -0500
Message-ID: <20111101080210.GB4566@elie.hsd1.il.comcast.net>
References: <20111030195253.3248.82914.reportbug@debian>
 <20111030203044.GB18681@elie.hsd1.il.comcast.net>
 <CAAyXcGAC5W5md17=V5rx-kaL7PTmBig4a-4ZhRvAVLVZ7wWzSg@mail.gmail.com>
 <20111031092748.GB24978@elie.hsd1.il.comcast.net>
 <CAAyXcGCz0Z8xkEin5DVhTa8p6Jc8oOtgghH2EWoSaLrRqCzWdg@mail.gmail.com>
 <CAAyXcGDOsmp+PVhHZx3JFjApF2_UbE8dr8jnHKJNDEm5=bWrzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42796 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab1KAICQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 04:02:16 -0400
Received: by gyb13 with SMTP id 13so6776864gyb.19
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2011 01:02:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAyXcGDOsmp+PVhHZx3JFjApF2_UbE8dr8jnHKJNDEm5=bWrzA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Arvind K <arvindkhadri@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Damjan Jovanovic <damjan.jov@gmail.com>

(cc-ing some people in case they have clues)
Hi Dmitry et al,

Arvind K explains at [1]:

He owns a Synaptics touchpad and has been using it for a while.  Every
once in a while it stops responding.  Running "modprobe -r psmouse &&
modprobe psmouse" gets it working again.

On investigation, we learn that the message

	psmouse.c: bad data from KBC - bad parity

appears in dmesg approximately every 2 milliseconds when this happens.

The touchpad worked without trouble since this system was installed,
in February.  The bug only surfaced recently, when he changed the X
configuration somehow.

Userland is Debian 6.0.x (squeeze).

The problem is reproducible with:

 - Debian's 2.6.32-38 (which is based on v2.6.32.43)
 - 2.6.39-3~bpo60+1 (based on v2.6.39.2)
 - 3.1.0~rc7-1~experimental.1 (very close to v3.1-rc7)

Hardware:

	Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04731/0xa40000/0xa0000

More details are in the original report at [1].  Any ideas for
tracking this down?

Thanks for keeping the input subsystem in good shape.
Jonathan

[1] http://bugs.debian.org/647136
