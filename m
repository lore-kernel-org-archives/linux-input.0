From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH-V2 1/1] HID: Force feedback support for the Logitech
 G920
Date: Tue, 26 Jan 2016 12:03:57 -0700
Message-ID: <0db5d205435e01d8228b97a2d87ef42d.squirrel@mungewell.org>
References: <1452468315-8978-1-git-send-email-e.velds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:42831 "EHLO
	host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcAZTD7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2016 14:03:59 -0500
In-Reply-To: <1452468315-8978-1-git-send-email-e.velds@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?=22Michal_Mal=C3=BD=22?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Edwin Velds <e.velds@gmail.com>

On Sun, January 10, 2016 4:25 pm, Edwin Velds wrote:
> This patch implements force feedback support for the Logitech
> G920 Driving Force Racing Wheel. It is a generic implementation
> of feature 0x8123 of the Logitech HID++ protocol and should be usable for
> any future devices that implement this feature.

Apologies for being slow on this (something to do with changing jobs and
accomodation ;-).

Doesn't patch cleanly on Linus' HEAD due to:
--
commit d8ce9bf5551bfea431893bdd0a943f24a5170828
Author: Geliang Tang <geliangtang@163.com>
Date:   Sun Dec 27 17:25:20 2015 +0800

    HID: move to_hid_device() to hid.h
--

A couple of white space issues:
--
ERROR: trailing whitespace
#114: FILE: drivers/hid/hid-logitech-hidpp.c:867:
+static const u8 HIDPP_FF_CONDITION_CMDS[] = { $

ERROR: trailing whitespace
#121: FILE: drivers/hid/hid-logitech-hidpp.c:874:
+static const char *HIDPP_FF_CONDITION_NAMES[] = { $
--

Note: The wheel _DOES_NOT_ auto switch to Logitech/HID mode (it is stuck
in XBox since the xpad changes where not included). Michal has an
alternative approach documented here:
--
Create a file named "046d:c261" in "/etc/usb_modeswitch.d" with the
following content:

# Logitech G920 Racing Wheel
DefaultVendor=046d
DefaultProduct=c261
MessageEndpoint=01
ResponseEndpoint=01
TargetClass=0x03
MessageContent="0f00010142"

Then run "usb_modeswitch -c /etc/modeswitch.d/046d:c291" as root and
watch the magic happen:)
--

Apart from these few minor points, but seems to work OK - tested against
G920 with older firmware.

Tested-by: Simon Wood <simon@mungewell.org>


