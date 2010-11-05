From: Ping Cheng <pinglinux@gmail.com>
Subject: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Fri, 5 Nov 2010 11:47:28 -0700
Message-ID: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57879 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab0KESr3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Nov 2010 14:47:29 -0400
Received: by ewy7 with SMTP id 7so1969106ewy.19
        for <linux-input@vger.kernel.org>; Fri, 05 Nov 2010 11:47:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "X.Org Devel List" <xorg-devel@lists.freedesktop.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

Recent changes and discussion about MT support at LKML, UDS, and
xorg-devel encouraged me to migrate Wacom MT devices to the slot-based
MT protocol (introduced in kernel 2.6.36). Since Wacom supports both
digitizer and touch devices, I need to decide how to report touch data
when the pen is in proximity.

My goal is to understand how X server would like the MT data to be
reported from the kernel. I hope to keep kernel and X server driver MT
support in sync so we can avoid unnecessary confusion or extra work in
the userland.

The existing solution for single touch events is to arbitrate touch
when pen is in prox. This is based on the assumption that we do not
want to have two cursors competing on the screen.

With the introduction of MT, the touch data are most likely translated
into something other than pointer events. So, reporting both pen and
touch data makes sense now. However, I want to assure a smooth
tansition from single touch to MT for end users so they still get the
single touch behavior as they used to be. I gathered the following
approaches:

1.     Arbitrate all touch data in the kernel.

This is the simplest solution for device driver developers. But I do
not feel it is end user and userland client friendly.

2.     Report first finger touch as ABS_X/Y events when pen is not in
prox.  Arbitrating single touch data when pen is in prox. Pen data is
reported as ABS_X/Y events. Both ABS_X/Y for pen or the first finger
and ABS_MT_* for MT data are reported.

This approach reduces the overhead in dealing with two cursors in userland.

3.    Report first finger touch as ABS_X/Y events when pen is not in prox;
       Report pen data as ABS_X/Y events when there is no finger touch;
       Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_PEN
events when both pen and touch data are received. No ABS_X/Y are
reported when pen and tocuh or multi-touch data are received.

I feel this one makes sense to userland since pen can be considered as
another touch.

4.    Report first finger touch as ABS_X/Y events when pen is not in prox;
       Report pen data as ABS_X/Y events when there is no finger touch;
       Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_PEN
events when both pen and touch data are received. ABS_X/Y are also
reported for pen when both pen and tocuh data are received.

This one makes sense to userland too. It eases the backward
compatibility support for those clients that don't support MT at all.

Which approach do you like? Or do you have other suggestions share?

Ping
