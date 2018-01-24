From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Dell docking station & Dell Embedded Controller & PS/2 devices
Date: Wed, 24 Jan 2018 11:41:21 +0100
Message-ID: <20180124104121.7g3zfay5smc5v2tc@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37150 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeAXKlY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 05:41:24 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry!

I'm observing a problem with internal touchpad (handled by psmouse.ko)
on Dell laptops connected to Dell E docking station. When I connect
external PS/2 keyboard to docking station then internal laptop touchpad
switch from multitouch absolute mode to relative bare PS/2 mode.

And because ALPS driver in psmouse.ko is capable to process interleaved
bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
trackstick data on some ALPS models), ALPS driver does not show any
message about this "downgrade" from multitouch to bare mode. And
continue working in bare mode.

When I rmmod psmouse and modprobe it again, then touchpad switch back to
multitouch mode.

Mario told me that Dell Embedded Controller, which handle internal
keyboard, internal touchpad and external PS/2 keyboard, automatically
send RESET command to *all* those devices when external PS/2 keyboard is
connected. Therefore this is reason why touchpad downgrade to to bare
mode. And according to Mario, host system should issue vendor specific
PS/2 commands to re-initialize all PS/2 devices when this situation
happen. Mario also told me that Windows is doing this action.

Every time when I connect external PS/2 keyboard to dock I see this
message in dmesg:

Spurious ACK... Some program might be trying to access hardware directly.

I see it also every time when I dock laptop into docking station (to
which is keyboard already connected). And it happens also when I connect
external PS/2 mouse to dock.

Dmitry, how to handle this situation to re-initialize psmouse.ko when
external PS/2 device is connected to Dell E docking station? According
to Mario, this is how Dell Embedded Controller is designed and suppose
how OS should work with it.

Manually rmmoding and modprobing for every docking/undocking laptop is
not ideal solution.

Could it be possible to use that Spurious ATKBD_RET_ACK from atkbd.c be
handled on Dell systems (probably via DMI) as an event to reset and
reinitialize all PS/2 devices?

-- 
Pali Rohár
pali.rohar@gmail.com
