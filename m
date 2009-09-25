From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: keypad input method question
Date: Fri, 25 Sep 2009 15:01:37 +0200
Message-ID: <3ea34a000909250601n5127dd2bt6a84aab7a93c26ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:36677 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbZIYNBd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 09:01:33 -0400
Received: by ywh4 with SMTP id 4so2829956ywh.33
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2009 06:01:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi folks,

Recently, I ported Linux to a previously unsupported device (it uses
pxa270 processer, so most of the work was already done), and I had a
couple of issues that I hope you could help me with.

1) I wrote a new 'multi-function' driver for the STMPE2401 gpio
expander, which also has a keypad controller, 3 pwm channels, and a
rotator input, and I would appreciate it if a couple of people could
review it for me so that it could be submitted upstream. So far, only
the keypad function is implemented because my device doesn't use the
others. However, I've already coded in most of the structure for the
other device functions but they just return -ENOSYS on probe. I'm sure
that someone with sufficient experience could probably look at my
driver and give me a few tips on how to improve it before submission.
Which leads me to my next question...

2) currently the input is a bit complicated - there are a couple of
different modifier keys, and I'm not really sure where to start to
have userspace handle the scancode-keycode mapping. Right now it's
done in kernel mode in a small callback function. Can somebody point
me in the right direction? It would be nice if the keypad worked at
the console and also in X or other graphical environments. Currently
I'm trying to get it to work in Android, which just uses the typical
event interface for key-remapping.

I suppose one way to do it would be to have the kernel dynamically
switch based on if the event device is open... still it's a bit
confusing. Any tips?

Regards,

Chris
