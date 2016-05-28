From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH v2] Support for Alps SS5 touchpad
Date: Sat, 28 May 2016 14:00:58 +0200
Message-ID: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56285 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcE1MBL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 08:01:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>


Here is a patchset adding support for the Alps SS5 touchpad hardware shipped
with the Dell Latitude E7470. The protocol is similar to that used by the SS4
v2 devices, but with additional support for a touchstick.

The touchpad exhibits slightly inconsistent behavior when single-finger
contacts are released while a button is being held. This leads to extremely
unpleasant jumps in pointer position, especially during drag-and-drop
operations. This is resolved by patch 2/4.

One minor outstanding issue is the high speed of the touchstick. Previous
touchstick drivers have taken the extremely unfortunate approach of scaling the
input device space to work-around this (often sacrificing device resolution in
the process). I've started another thread on linux-input (see "Should
touchsticks really be relative input devices?") to discuss options for
resolving this.

Cheers,

- Ben


Changes:

v1:
 * Initial revision

v2:
 * Rework device detection
 * Fix contact release behavior of 1F events
 * Expose pressure of touchstick
