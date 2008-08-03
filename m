From: Chris Rankin <rankincj@yahoo.com>
Subject: [2.6.26.1] And one very confused mouse!
Date: Sun, 3 Aug 2008 04:57:46 -0700 (PDT)
Message-ID: <405580.49576.qm@web52909.mail.re2.yahoo.com>
Reply-To: rankincj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756728AbYHCL56@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

I have just cold-booted a machine into 2.6.26.1 for the very first time, and for a few seconds I had great difficulty using my PS/2 mouse. Here is what I found in the dmesg log afterwards:

input: PS/2 Generic Mouse as /class/input/input6
psmouse.c: Failed to enable mouse on isa0060/serio1
psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
psmouse.c: resync failed, issuing reconnect request
psmouse.c: Failed to enable mouse on isa0060/serio1
psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
psmouse.c: resync failed, issuing reconnect request
input: ImPS/2 Generic Wheel Mouse as /class/input/input7

It seems to have recovered now, but I have never seen this behaviour before and so thought that I should report it. I will monitor this...

Cheers,
Chris



      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
