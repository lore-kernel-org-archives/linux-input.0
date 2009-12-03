From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH] input: Enable / disable methods
Date: Thu,  3 Dec 2009 12:58:18 +0200
Message-ID: <1259837900-10803-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23343 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbZLCK6f (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 05:58:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

First patch adds a generic way for userspace to enable and
disable an input device. Userspace interface is a sysfs entry.
Device is enabled by writing '1' to enable entry and disabled by
writing '0' to enabled entry. Current state can be read from the entry.
Actual disabling happens via callback functions. If the device driver doesn't
provide callback functions, write to sysfs entry returns an error code ENOSYS.

Purpose is to provide a generic way to force some input device to disabled
or enabled state regardless of the number of the users of that input device.
When disabling of the device happens in the driver level, it is possible
to turn off the corresponfing HW block to prevent unwanted activity.
For example system wide keypad locking feature can utilize this feature.
When several user space programs keep the input device open, one
user space program can set input device to disabled state. 

Second patch utilizes new feature and adds HW level disable / enable feature
to twl4030_keypad driver. Regardless of the number of users one control
program can temporarily disable all keypad interrupts from the twl4030 keypad
block. Keypad HW is also disabled during suspend mode.

Samu Onkalo (2):
  input: enable / disable methods with sysfs entry
  input: twl4030_keypad enable / disable feature

 drivers/input/input.c                   |   45 +++++++++
 drivers/input/keyboard/twl4030_keypad.c |  153 ++++++++++++++++++++++++++-----
 include/linux/input.h                   |    8 ++
 3 files changed, 183 insertions(+), 23 deletions(-)
