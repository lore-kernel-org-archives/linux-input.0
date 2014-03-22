From: Robert Kraus <robert.bob.kraus@gmail.com>
Subject: Elan touchscreen report (HP Pavilion 10-e010nr)
Date: Fri, 21 Mar 2014 23:53:20 -0400
Message-ID: <CAMsr0sLqRj+pi20GrncOYjNSxaMLwPZbi10HX8ATa97SNtn0Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:33774 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaCVDxV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2014 23:53:21 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so3456773veb.17
        for <linux-input@vger.kernel.org>; Fri, 21 Mar 2014 20:53:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm sending this to you as per the directions at
https://wiki.archlinux.org/index.php/Multitouch_Displays

Hardware: HP Pavilion 10-e010nr touchscreen laptop
OS: xubuntu 12.04 LTS, kernel 3.2.0-60-generic
Module: hid-multitouch, vendor class
MT_CLS_GENERALTOUCH_PWT_TENFINGERS 0x0109 (decimal 265)
lsusb output: (note, the device # kept incrementing due to mtp-probe
thinking it's an MTP device)
Bus 003 Device 119: ID 04f3:0268 Elan Microelectronics Corp.

It may already be known to you guys as the touchscreen worked without
configuration in Steam OS, in which case feel free to trash this
message.

Regards,
-Bob
