From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Method to power off HID device from driver?
Date: Thu, 1 Dec 2016 18:05:07 -0800
Message-ID: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34199 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcLBCFJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2016 21:05:09 -0500
Received: by mail-ua0-f173.google.com with SMTP id 51so267798437uai.1
        for <linux-input@vger.kernel.org>; Thu, 01 Dec 2016 18:05:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

Some of the devices I'm dealing with have methods to disconnect the
device through HID reports. This is mostly useful for wireless devices
to save battery and power them off e.g. when no activity in a wihle or
user wants to turn device off (some devices don't have a power off
button).

I was trying to figure out if it there is some generic way without
inventing a driver specific method. So far I haven't found anything on
the HID side. The use case is not that common often a user would
unplug a cable, but for some devices there is no real other way.

The closest thing I found was 'poweroff' as supported by device power
management spec:
https://www.kernel.org/doc/Documentation/power/devices.txt. The HID
drivers only support a subset of this so far.

Does anyone have a good suggestion for handling this?

Thanks,
Roderick
