From: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [BUG] hid-multitouch ignores all event after recent patch in 3.17-rc1
 to input_mt_sync_frame()
Date: Wed, 27 Aug 2014 00:45:17 -0500
Message-ID: <CA+BWVURnxeQUJnDDhO=q=67sCK2NGq7_W=8wAN5qDjTKk14yAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:57936 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbaH0Fpi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 01:45:38 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so5230923wib.2
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2014 22:45:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, bleung@chromium.org, dmitry.torokhov@gmail.com, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hello Henrik Rydberg,

I noticed a recent patch to input-mt.c breaks hid-multitouch on my MS Surface:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/input-mt.c?id=f8ec894945e7d205ce62be59e55e72c4304e4739

This device uses a special quirk in the hid-multitouch driver to
ignore duplicate input events. This quirk uses the inline function
input_mt_is_used() to determine if an input frame is a duplicate. In
the patch you remove the line, mt->frame++, from the function
input_mt_sync_frame(). This causes the is_used function to return true
as the frame number never increases.

What would be the best way to solve this, is it ok to simply re add that line?

Thank You,
Reyad Attiyat
