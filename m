From: Alan Stern <stern@rowland.harvard.edu>
Subject: Annoying touchpad behavior
Date: Fri, 11 Nov 2011 23:10:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1111112303590.306-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44373 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753312Ab1KLEKr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Nov 2011 23:10:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry:

My laptop has a Synaptics touchpad:

[    2.528474] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04731/0xa40000/0xa0000
[    2.566383] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input4

Under circumstances which I can't pin down (they generally involve my
thumb brushing over the trackpad, which happens fairly often as I
type), the touchpad reports a right-click.  This causes gnome-terminal
to pop up its menu, which is very annoying.

Why does the trackpad report a right-click instead of a normal 
left-click?  How can I fix this?

Thanks,

Alan Stern

