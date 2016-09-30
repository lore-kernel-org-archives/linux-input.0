From: William Linna <william.linna@gmail.com>
Subject: Elantech touchpad doesn't work on Fujitsu E556 laptop
Date: Fri, 30 Sep 2016 10:57:12 +0300
Message-ID: <e511d6de-1db4-5560-a56c-06846fb3bcfb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33506 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbcI3H5Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Sep 2016 03:57:16 -0400
Received: by mail-lf0-f42.google.com with SMTP id t81so31565164lfe.0
        for <linux-input@vger.kernel.org>; Fri, 30 Sep 2016 00:57:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, tiwai@suse.de

Hi,

Elantech touchpad doesn't work on Fujitsu E556 laptop.

Touchpad doesn't move the cursor at all, and it seems to disturb 
keyboard too. If I accidentally hit the touchpad while typing, the key 
gets "stuck" (it keeps repeating until I press something else).

Fortunately, the touchpad works fine when I force crc_enabled on with:
echo 1 > /sys/devices/platform/i8042/serio2/crc_enabled

or by applying the following patch, but replacing the U745 with E556:
https://patchwork.kernel.org/patch/7570531/

See also:
https://bugzilla.opensuse.org/show_bug.cgi?id=982131

Best regards,
William

