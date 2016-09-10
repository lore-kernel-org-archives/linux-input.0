From: Brad Baker <bbaker6212@gmail.com>
Subject: Goodix touchscreen works intermittently, fails reading config info.
Date: Sat, 10 Sep 2016 18:21:07 -0300
Message-ID: <CAG=1usatOHQ3sq5NTanbRQZ088gD53Xu3APVxe4p6Lf4mf5ahQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35793 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbcIJVVJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Sep 2016 17:21:09 -0400
Received: by mail-qt0-f170.google.com with SMTP id 93so56955357qtg.2
        for <linux-input@vger.kernel.org>; Sat, 10 Sep 2016 14:21:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bastien nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

Summary: Goodix touchscreen works intermittently, fails reading config info.
 https://bugzilla.kernel.org/show_bug.cgi?id=156511

Description:  Chuwi Hi12 tablet with Intel cherry-trail Atom Z8300,
the touchscreen does work after bootup most of the time, but sometimes
it does not work without running modprobe.  When it fails the dmesg
log shows the error "Invalid config, using defaults" and when it works
this error is not present.

Module: goodix, goodix_backport
Linux version 4.8.0-040800rc5-generic (kernel@tangerine) (gcc version
6.2.0 20160830 (Ubuntu 6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4
22:34:01 UTC 2016

dmesg log when it's failing:
[ 10.012314] Goodix-TS i2c-GDIX1001:00: ID 9111, version: 1060
[ 10.017711] Goodix-TS i2c-GDIX1001:00: Invalid config, using defaults
[ 10.018021] input: Goodix Capacitive TouchScreen as
/devices/pci0000:00/808622C1:05/i2c-13/i2c-GDIX1001:00/input/input6

details given in bugzilla #156511
