From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 00/04] input: RMI4 Synaptics RMI4 Touchscreen Driver
Date: Wed, 13 Nov 2013 15:39:28 -0800
Message-ID: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16061 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3KMXjp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 18:39:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

This patchset implements changes to the synaptics-rmi4 branch of
Dmitry's input tree.  The base for the patchset is Dmitry's commit
4a695a01fba9bf467b3b52e124ccee6cef73b323 from 2013-01-31.



Overall this patchset implements the following changes with respect to
the Dmitry's 2013-01-31 commit:

* Refactors the transport layer (rmi_i2c) to be named appropriately.

* Eliminates packed struct bitfields, replacing them with masks
and shifts.  This should make the various register definitions
endian-independent.

* Removed most or all of the sysfs and debugfs support from the driver core
and function drivers.  These features are still critical during platform 
development, particularly on embedded systems, so there are hooks that allow 
custom modules that support these control and debug capabilities.  One result 
of this is that several .c files have a corresponding .h file (for example, 
rmi_f01.c has a corresponding rmi_f01.h).  Also, a rmi_control.h file is
added to provide general definitions for control/debug modules.

* Fixes a number of bugs in the baseline commit.

* Trivial - added an rmi_version.h file, which lets the version be easily
tweaked using a script.


We've broken this patch into 6 parts, as follows:
    01 - core sensor and bus implementation
    02 - I2C physical layer driver
    03..04 - drivers for individual RMI functions


Hopefully this is the last time we'll have wide-ranging structural changes in
the driver code, and future patchsets can be much smaller and confined to
one or two areas of interest. (yeah, I've said that before...)


Comments and other feedback on this driver are welcomed.

Christopher Heiny and the Synaptics RMI4 driver team

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joerie de Gram <j.de.gram@gmail.com>

---
