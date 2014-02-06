From: Vasily Titskiy <qehgt0@gmail.com>
Subject: PROBLEM: [Dell LATITUDE E7440] ALPS touchpad events are not routed
 into /dev/input/mice and /dev/input/mouseX
Date: Thu, 6 Feb 2014 12:37:10 -0500
Message-ID: <CABSveYj4gwNpY0Lv_ip051FUPyURhjQiEepqN-=n9_3U0nSZdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:33889 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbaBFRhb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 12:37:31 -0500
Received: by mail-ea0-f178.google.com with SMTP id a15so1060994eae.23
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 09:37:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

The issues occurs on every kernel after
1302bac33d9e88cd43e482191a806998f3ed43cc commit. Before the commit,
this touchpad device was detected as PS/2 mouse and "cat
/dev/input/mice" shows data when the touchpad is used.
After the commit, there are no events from the touchpad in
/dev/input/mice or /dev/input/mouseX files anymore.

According to drivers/input/mouse/alps.c source file, all devices with
signatures "ec[0] == 0x88 && ec[1] == 0x08" are treated as "Rushmore
touchpads". This touchpad has E7 signature of "73-03-0A" and EC
signature of "88-08-22", and it looks like that V5 protocol (not
"Rushmore") should be used here. If V5 protocol is forced to use for
this device then everything works fine.

The patch is trivial, but I'm not sure how to properly separate
"Rushmore" and "V5" devices. Are there any datasheets or experts to
help me with it?

Thanks.
--
  Vasily Titskiy
