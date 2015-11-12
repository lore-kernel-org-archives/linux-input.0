From: Simon Wood <simon@mungewell.org>
Subject: [Patch-V2 0/6] HID: Support for the Logitech G920 Wheel
Date: Thu, 12 Nov 2015 09:25:29 -0700
Message-ID: <1447345535-2912-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Patch-V2 tweaked as per Benjamin's requests.

This series of patches provide input support for the Logitech G920 gaming wheel.

This wheel is internally different from the other Logitech wheels; when first 
connected it is in X-Box mode and can instructed to switch to HID with a 'magic 
command' (1st patch). Once the wheel reconnects in HID mode it can communicate 
with the HID++ protocol, but using a 'very long' packet size (2nd patch).

Basic input operation is possible with adustment of the 'range' (the amount that 
the wheel turns) controlled via the '/sys' interface, same concept as the G25/G27/etc.

We also discovered that wheel uses some vendor specific pages, which confuse the 
HID system resulting in lots of additional axis reported. This is prevented by 
ignoring these pages (5th patch, thank you Elias).

Note: These patches are applied to Jiri's 'for-next' tree to work with the other 
HID++ changes already queued for 4.4.

The future... as the internals of the wheel are considerably more 'capable' we 
are working on implementing Force Feedback using the forth-coming KLGD system.

[Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech G920
[Patch-V2 2/6] HID: hid-logitech-hidpp: Add support for very long
[Patch-V2 3/6] HID: hid-logitech-hidpp: Add basic support for
[Patch-V2 4/6] HID: hid-logitech-hidpp: Add range sysfs for Logitech
[Patch-V2 5/6] HID: Add vendor specific usage pages for Logitech G920
[Patch-V2 6/6] HID: hid-logitech-hidpp: G920 remove deadzones
