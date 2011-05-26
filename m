From: Jeffrey Brown <jeffbrown@android.com>
Subject: Input: evdev - only signal polls on full packets
Date: Thu, 26 May 2011 00:37:22 -0700
Message-ID: <BANLkTikUByGxerUPwXTN1E3g8E_cCvyaXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53082 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab1EZHiD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2011 03:38:03 -0400
Received: by iyb14 with SMTP id 14so404834iyb.19
        for <linux-input@vger.kernel.org>; Thu, 26 May 2011 00:38:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,
I was just reviewing the final patch for the EV_SYN wake-up
optimization.  I'm glad to see it made it in.  It'll let me strip out
some unsightly hacks elsewhere.  :)

Anyways, my original patch contained this proposed change to
evdev_event, which seems to have been accidentally omitted:

-       wake_up_interruptible(&evdev->wait);
+       if (full_sync)
+               wake_up_interruptible(&evdev->wait);
 }

The idea was that we should only wake waiters on the event device when
we actually post an EV_SYN / SYN_REPORT to the queue.  Otherwise we
end up making waiting threads runnable again only for them to go right
back to sleep because the device still isn't readable.

So I think we want something like this in evdev_event:

if (type == EV_SYN && code == SYN_REPORT)
   wake_up_interruptible(&evdev->wait);

What do you think?

Context: http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=blobdiff;f=drivers/input/evdev.c;h=75c4e86830331dbedd933a07b13cc723135df517;hp=88d8e4cb419a1d0d6cc17828894dc4d3b67e0201;hb=cdda911c34006f1089f3c87b1a1f31ab3a4722f2;hpb=03351ff4d897098a590cb247b6eebc470b8ecb5a

Thanks!
Jeff.
