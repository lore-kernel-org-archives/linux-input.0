From: Cedric Sodhi <manday@gmx.net>
Subject: Sensors of a EEE Slate PC
Date: Sat, 14 Jan 2012 20:07:37 +0100
Message-ID: <20120114190737.GA12250@slate.Speedport_W_723V_Typ_A>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:36747 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755831Ab2ANTIL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Jan 2012 14:08:11 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I'd like to use the WMI-kind of buttons on the EEE Slate PC. the
eeepc-wmi module creates an input/event node on which pressing the
buttons results in activity.

However, three of the buttons, one of which is a two-state-slider type
of button, result in messages "Unknown key f3/f5/f6 pressed" and, if X
with evdev is running "Can't emulate rawmode for keycode 240" in dmesg
for each of the buttons respectively.

Two of the buttons, those which are intended for Volume Control,
actually work all right, though.

If someone could point me to the right tools and/or source files to
debug the issue or has otherwise useful hints for me...

Thank you.
