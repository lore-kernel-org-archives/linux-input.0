From: Eric Paris <eparis@redhat.com>
Subject: Hang in mousedev_init
Date: Wed, 28 May 2008 11:49:42 -0400
Message-ID: <1211989782.3079.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbYE1Puf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 11:50:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, yoann.v@prelude-ids.com

I have a report of a person who is booting a 2.6.25 based fedora kernel
and hanging in mounsedev_init().  Moving to our old 2.6.24 based fedora
kernels he doesn't see any problems.

we know its mousedev_init since we added initcall_debug and
mousedev_init() is called but never returns...

Doesn't look like many patches between then and now

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3b04a61107dfe46dbfc1796298b59ca3c0a09cd9
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d182c10c842007984e12b3b816df2b10d997cc8e
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a7097ff89c3204737a07eecbc83f9ae6002cc534

About the only thing my clueless eye noticed was in
d182c10c842007984e12b3b816df2b10d997cc8e

--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -1032,7 +1032,7 @@ static const struct input_device_id mousedev_ids[] = {
                .flags = INPUT_DEVICE_ID_MATCH_EVBIT |
                        INPUT_DEVICE_ID_MATCH_KEYBIT |
                        INPUT_DEVICE_ID_MATCH_ABSBIT,
-               .evbit = { BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_SYN) },
+               .evbit = { BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) },
                .keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
                .absbit = { BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
        },      /* Mouse-like device with absolute X and Y but ordinary

You dropped the | BIT(EV_SYN)   does that matter?  What could have
changed to cause a hang?  Any clues?

