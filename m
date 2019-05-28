From: Dave Hansen <dave.hansen@intel.com>
Subject: hid-related 5.2-rc1 boot hang
Date: Tue, 28 May 2019 09:43:59 -0700
Message-ID: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

I have a system that works fine on 5.1.  When updating to 5.2-rc1, it
hangs at boot waiting on an instance of systemd-udevd.  The kernel
backtrace (https://photos.app.goo.gl/EV8rf7FofWouvdeE8) looks like it's
doing an finit_module() that dives into the hid code and is waiting on a
request_module().

This hang only occurs if I have a particular USB device inserted:

> Bus 001 Device 007: ID 046d:c52b Logitech, Inc. Unifying Receiver

Bisecting the issue points at this (unlikely to be the culprit) commit:

> [161f62cd07fde123fd52bf6d5b6fd6513cca968e] HID: macally: Add support for Macally ikey keyboard

This bisect result is probably just a bisect artifact.  The first real,
bad commit is a merge commit: 63b6f0b827d.  This commit merges a bunch
of stuff, but includes changes to the hid request_module() code and to
the logitech-hidpp which is the driver for the above device.

I also have a picture of the hang which includes __request_module()
dumping out the string it is passed:

	https://photos.app.goo.gl/tUETiCBZHJfKqWPu8

This is easy enough to work around, and the system works fine if I just
unplug the Logitech device and plug it in after boot.  But, it would be
nice to figure out what's going wrong.  I guess it could easily be some
interaction between systemd, the driver and the request_module() ordering.
