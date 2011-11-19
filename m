From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Supporting Battery Strength from my Bluetooth Mouse
Date: Fri, 18 Nov 2011 22:52:20 -0800
Message-ID: <4EC75224.7070207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:52623 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab1KSGwW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Nov 2011 01:52:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz

My Bluetooth mouse (HP branded, but some generic Taiwanese innards)
supports reporting its battery level.

The data appears in its HID descriptor as:

  INPUT(3)[INPUT]
    Field(0)
      Usage(1)
        0006.0020
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )

which is consistent with the USB HID Usage Tables 1.12 spec, which lists
Usage Page 6 as Generic Device Controls and Usage ID 0x20 as Battery
Strength.  I'm assuming that this is commonplace on battery-powered
mice, but I only have one to check.

I've written an (untested) patch to display this correctly in debugfs.
(below)

My real question is how to get this out to somewhere useful, where
(ultimately) some GUI could show the battery information if its available?

Is the next step to define a new ABS_BATTERY_STRENGTH type for it (and
likewise for the other values, though I have no idea what the Security
stuff is about)?  Then at least it will appear in evdev in a useful way,
and becomes usermode's problem to deal with it.

(Hm, and I wonder what makes the mouse actually report the battery
level; I guess I'll only ever see a report if it actually changes.)

Any guidance?

Thanks,
    J

Subject: [PATCH] hid: decode Generic Device Controls Usage Page

The USB HID Usage Tables spec defines page 6 for Generic Device
Controls, the most useful of which (to me) is Battery Strength.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index ee80d73..01dd9a7 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -114,6 +114,14 @@ static const struct hid_usage_entry hid_usage_table[] = {
       {0, 0xbd, "FlareRelease"},
       {0, 0xbe, "LandingGear"},
       {0, 0xbf, "ToeBrake"},
+  {  6, 0, "GenericDeviceControls" },
+      {0, 0x20, "BatteryStrength" },
+      {0, 0x21, "WirelessChannel" },
+      {0, 0x22, "WirelessID" },
+      {0, 0x23, "DiscoverWirelessControl" },
+      {0, 0x24, "SecurityCodeCharacterEntered" },
+      {0, 0x25, "SecurityCodeCharactedErased" },
+      {0, 0x26, "SecurityCodeCleared" },
   {  7, 0, "Keyboard" },
   {  8, 0, "LED" },
       {0, 0x01, "NumLock"},


