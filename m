From: Jaikumar Ganesh <jaikumarg@gmail.com>
Subject: Magic trackpad issues on 3.0
Date: Mon, 15 Aug 2011 13:18:29 -0700
Message-ID: <CACMz=xjmL=voNMk4usxT+Y6z1D_nncvJ34Y_w1PuqBNAE-4phg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62701 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab1HOUSt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 16:18:49 -0400
Received: by gwaa12 with SMTP id a12so3393195gwa.19
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 13:18:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

Folks,
   This is with regard to the issue:

http://www.spinics.net/lists/linux-input/msg15334.html

As mentioned in that thread we were ignoring the EIO return value earlier.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=c3a4924565e2eecf2539871abd123d35be6d76d5

reverted the commit back, because

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7f4f0572df6c8eaa6a587bc212b0806ff37380dd
fixed the issue with the Bluetooth stack with 1.1 Bluetooth devices.

However, I am seeing the same problem with an Apple Trackpad which is
2.0 Bluetooth device. It worked fine before because we were ignoring
the EIO.

The Error code is the same as mentioned in the thread above: Invalid
Report ID while calling the Set Feature Report call.

So to the driver authors:

In magicmouse_probe function, the report id is set to d7. __u8
feature[] = { 0xd7, 0x01 };

Is it guaranteed that all Apple devices will have 0xd7 as the report
Id. Why are we not reading the report ID from the report descriptor
since its an optional feature ?

I am going to sniff the traffic to check if the report ID for this
device is different.

Is anyone else aware of the issue ?

Thanks
