From: Jason Gerecke <killertofu@gmail.com>
Subject: Proper representation of button touch (as opposed to button press)
Date: Fri, 2 Mar 2012 10:36:22 -0800
Message-ID: <CANRwn3QLhpH=W8r1fJ=xB4Dc46kdfaG+5_x0oFbEJYWjTyYyZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47719 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab2CBSgY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Mar 2012 13:36:24 -0500
Received: by wejx9 with SMTP id x9so1227571wej.19
        for <linux-input@vger.kernel.org>; Fri, 02 Mar 2012 10:36:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The Intuos5 was just announced, and I'm working on adding support for
it to the wacom kernel module. One feature new to the Intuos5 is the
addition of capacitive sensors embedded in the buttons. Each
ExpressKey (button) has two bits of state: one for the capacitive
switch and one for the mechanical switch. These bits are synthesized
into three cases: released, touched, and pressed (the 4th case of
"pressed with a non-capacitive object" isn't particularly
interesting). My initial thought was to call input_event() with a
unique value for the 'touched' case. However, the documentation only
defines three values for EV_KEY: 0 (released), 1 (pressed), and 2
(autorepeat).

Is 'touched' a case we would want to allow for EV_KEY, or should I be
representing things differently?

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
