From: Will Roberts <wildwilhelm@gmail.com>
Subject: Elantech touchpad very slow and laggy with high CPU usage
Date: Fri, 19 Jan 2018 20:15:05 +0100
Message-ID: <CADHR4-+FXgBT058w1eqcZExezd9fPugAbSm+19DpnJevXt=Q4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:39481 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755985AbeASTPH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:15:07 -0500
Received: by mail-wr0-f174.google.com with SMTP id z48so2494285wrz.6
        for <linux-input@vger.kernel.org>; Fri, 19 Jan 2018 11:15:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I'm having an issue with an Elantech 1200 touchpad behaving poorly on
an asus laptop.  I think I can show that recording the touchpad with
hid-recorder delivers a clean event stream, but recording with
evemu-record produces the funky behaviour.

If anybody on here gets a chance, can you take a quick look at the bug
report I opened:
https://bugzilla.kernel.org/show_bug.cgi?id=198473

I would be very grateful for any tips on how to diagnose this further,
or any guesses as to what the problem could be.  Thanks in advance!

Best wishes,
Will Roberts
