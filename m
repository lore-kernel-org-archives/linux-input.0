From: Kirill Churin <reflexing@reflexing.ru>
Subject: Microsoft Sculpt Mobile bluetooth keyboard support
Date: Thu, 11 Apr 2013 16:32:30 +0600
Message-ID: <CAOzeqF=2a82=NzYvryMpqqGoGQDEBWrooSaPRnzoQ_e+dWV+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:47226 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab3DKKcw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Apr 2013 06:32:52 -0400
Received: by mail-la0-f48.google.com with SMTP id fq12so1316001lab.35
        for <linux-input@vger.kernel.org>; Thu, 11 Apr 2013 03:32:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, I have a problem with subject keyboard.

By default it's F1..F12 keys mapped to multimedia functions, and to
type actual F keys one should press Fn. And it doesn't have Fn-lock
key to change such behavior.

I tried to remap scancodes of those keys, and it works for F1..F4, but
F5..F12 keys produces three keypresses (like Control_L + Super_L +
Tab) so I can't remap it.

I think some quirks and it's IDs should be added to hid_microsoft for
this keyboard. Currently it is handled by hid_generic driver.

I'm not a kernel hackers so can't fix it myself, so I looking for
someone (hid_microsoft maintainers?) to add proper fixes for this
keyboard.

I can send any needed debug information. Thanks.

--
Kirill Churin
Jabber: reflexing@reflexing.ru
