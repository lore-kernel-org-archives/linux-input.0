From: Daniel Drake <dsd@laptop.org>
Subject: Communicating tablet mode status to userspace
Date: Tue, 2 Oct 2012 16:27:07 -0600
Message-ID: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:55558 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab2JBW1H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Oct 2012 18:27:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org
Cc: hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>

Hi,

For the upcoming OLPC touchscreen laptop we're trying to solve the
following problem: we want the on-screen keyboard to only activate
itself when the laptop is "folded over" into tablet mode where the
keyboard is physically obscured.

We already have an ebook mode switch which detects this, and the
driver is upstream. Its an input device that exposes this information
via the SW_TABLET_MODE switch.

The on-screen keyboard runs in the user environment, which means that
its not root - it can't access /dev/input/event nodes directly. X
doesn't treat switches as input devices, so this info is not available
through X.

I'm wondering if anyone has suggestions on the best way to solve this
problem. The most attractive option I have found would be to do
something similar to the accelerometer:
http://git.kernel.org/?p=linux/hotplug/udev.git;a=blob;f=src/accelerometer/accelerometer.c

Modify the kernel input driver to generate a uevent (in addition to
the evdev event) every time the switch state is changed, then write a
udev program to expose this info in a udev property.

The change event would (presumably) trigger libudev's udev_monitor,
which would be used by the on-screen keyboard software (maliit) to
change its behaviour according to the property value.

Does this sound like a sensible plan, would these udev and kernel
changes be acceptable? Or is there a better option that I'm missing?

Thanks
Daniel
