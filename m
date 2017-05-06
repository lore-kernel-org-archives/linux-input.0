From: Arek Burdach <arek.burdach@gmail.com>
Subject: Missing release event for Synaptics touchscreen
Date: Sat, 6 May 2017 21:28:46 +0200
Message-ID: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-874; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36754 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdEFT2u (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 6 May 2017 15:28:50 -0400
Received: by mail-lf0-f67.google.com with SMTP id h4so3042320lfj.3
        for <linux-input@vger.kernel.org>; Sat, 06 May 2017 12:28:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com, chatty@enac.fr, aduggan@synaptics.com
Cc: linux-input@vger.kernel.org

Hi,

A week ago I've reported a bug: 
https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there anybody that 
can help me with it?
I found out that some touchpads (and possible touchscreens?) are handled 
by both hid-multitouch and hid-rmi drivers. Is there a way to verify how 
the touchscreen would work on hid-rmi drivers? I've tested it with 
kernel 4.11.0-rc1 version where was this change:
279967a65b320d174a507498aea7d44db3fee7f4 HID: rmi: Handle all Synaptics 
touchpads using hid-rmi
which was reverted in later kernel's version. On this version, only my 
touchpad was handled by hid-rmi, touchscreen was still handled by 
hid-multitouch. Maybe I should change something in code or in 
compilation configuration to force hid-rmi?
Or it is a wrong way to go? I would be grateful for your help.

Regards,
Arek
