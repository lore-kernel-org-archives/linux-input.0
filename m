From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 0/10] Support for Win 8 digitizers
Date: Thu, 25 Oct 2012 16:09:39 +0200
Message-ID: <1351174189-24719-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi guys,

well, this is my first series as a Red Hat employee. I should be able to
communicate my email address soon (once I'm able to read it).

So, this is an update for supporting Win 8 multitouch devices in the kernel.
As I wanted to reliably forward the resolution, I noticed a bug in the
processing of the unit exponent in the hid core layer.
Thus the fixes for hid-core and hid-input.

The last patch removes the dependency for usbhid as now touchscreen may
be connected through i2c.

Cheers,
Benjamin
