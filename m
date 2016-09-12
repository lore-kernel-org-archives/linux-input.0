From: Egor Starkov <eastarkov@gmail.com>
Subject: [Asus K501UW] Focaltech touchpad detected as mouse
Date: Sun, 11 Sep 2016 21:18:26 -0500
Message-ID: <CAAm8XAZ4mX77jyQ3DVi8c3w=HJkqDfJYkrcmcOQjUgFJJn-+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35227 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbcILCS1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Sep 2016 22:18:27 -0400
Received: by mail-oi0-f51.google.com with SMTP id d191so65373297oih.2
        for <linux-input@vger.kernel.org>; Sun, 11 Sep 2016 19:18:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

The Focaltech touchpad on Asus K501UW laptop is detected as a mouse
(moving the cursor, tapping and pressing physical touchpad buttons
works, but touchpad-specific features like two-finger scrolling or
two-finger tap do not).

The touchpad is recognized in xinput-list as "FTE1001:00 0B05:0101".

Latest kernel version tested: "Linux version 4.8.0-040800rc5-generic
(kernel@tangerine) (gcc version 6.2.0 20160830 (Ubuntu
6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4 22:34:01 UTC 2016"

This bug at Launchpad:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1620811

Best,
Egor

[resending the letter since my first one contained html despite my
best efforts. Sorry for the repetition, if any.]
