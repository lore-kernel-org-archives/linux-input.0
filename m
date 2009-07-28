From: Alan Stern <stern@rowland.harvard.edu>
Subject: No way to turn avoid building HID drivers
Date: Tue, 28 Jul 2009 10:59:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907281049560.5214-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41641 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753141AbZG1O7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2009 10:59:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Jiri:

The current Kconfig settings for many of the special HID drivers don't
offer any way to avoid building them unless CONFIG_EMBEDDED is on.  
For example:

config HID_A4TECH
	tristate "A4 tech" if EMBEDDED
	depends on USB_HID
	default !EMBEDDED
	---help---
	Support for A4 tech X5 and WOP-35 / Trust 450L mice.

Without CONFIG_EMBEDDED, the tristate doesn't take effect.  Hence the 
symbol isn't controllable by the user and Kbuild initializes it to the 
!EMBEDDED setting.

Should the tristate line say "if !EMBEDDED"?  Or was it your intention 
that all these drivers should always be built whenever CONFIG_USB_HID 
is on?

Alan Stern

