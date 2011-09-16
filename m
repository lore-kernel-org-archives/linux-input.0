From: Jaikumar Ganesh <jaikumarg@gmail.com>
Subject: hid-magicmouse driver race condition (second try)
Date: Thu, 15 Sep 2011 17:28:32 -0700
Message-ID: <CACMz=xj=85kVEvu7RS5Zbaj2tE5ihu-owgUVDnq9u+0nPuC2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42]:64107 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1IPA2w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Sep 2011 20:28:52 -0400
Received: by qwi4 with SMTP id 4so166132qwi.1
        for <linux-input@vger.kernel.org>; Thu, 15 Sep 2011 17:28:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Poole <mdpoole@troilus.org>

Resending as the first email bounced.
--------
Folks,
   There is a race condition in hid-magicmouse driver that I am
encountering. In the probe function, we call magicmouse_setup_input
after hid_hw_start which calls
hidinput_connect.

So if a userspace thread scans "/dev" to see if there is a new input
device and on seeing the new magicmouse device added, makes the ioctl
call EVCIOGBIT for EV_ABS or EV_KEY or any other type it will get
wrong values as magicmouse_setup_input has not been called yet.

So these keybits will change under the hood for the userspace program
on an open file descriptor.

I am able to reproduce this race condition easily. To verify the
above, as a hack, I called magicmouse_setup_input just before calling
input_register_device in hidp_connect and things were fine.

We were not using hidp-input parser but in the following commit we
moved to it which introduced the race condition:

commit 64eb105d7f92fa48798106ac0d8bf17668eb2524
Author: Michael Poole <mdpoole@troilus.org>
Date:   Fri Sep 24 13:58:18 2010 +0200

    HID: magicmouse: Use hid-input parsing rather than bypassing it

Any pointers for a clean fix ? Do we want to add a new field to
hid_driver structure so that we can use it to call from hid-input to
indicate parsing is done before the input device is registered ?

Thanks
