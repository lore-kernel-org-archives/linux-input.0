From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC] raw output buffering in HID layer
Date: Wed, 8 Jun 2011 17:28:21 +0200
Message-ID: <BANLkTim8_mPUWC+oMyAT7b0_zF1C12F6Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60483 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab1FHP2W (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 11:28:22 -0400
Received: by vws1 with SMTP id 1so432425vws.19
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2011 08:28:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>, jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Hi

I currently work on an HID driver for the Nintendo Wii Remote as Bluez GSoC
project. The Wii Remote (further wiimote) is a small wireless device
that communicates
with the host via bluetooth. It uses the HID ports but does not provide any
proper HID descriptor sets and doesn't really fit into the HID class so a
special driver is needed to control the device.
See [1], [2] and [3] for device details if required.

Since the wiimote protocol requires the host to send complex memory
read/write commands
to the wiimote, I need to use the raw hid interface. I use the
.raw_event callback
to get access to the raw input events, however, I also need to send
raw events to
the device.
The HIDRAW driver does exactly that. It uses:
  ret = dev->hid_output_raw_report(dev, buf, count, report_type);
However, this function may block and my HID driver, obviously, needs
to send commands
in atomic context. Therefore, I implemented a buffer which is sent to the device
in a workqueue via hid_output_raw_report.

No driver in the drivers/hid/ directory uses a workqueue, though, I
can't figure out any
other way to solve my problems here. I intend to submit the first
patchset to this list
to get this driver upstream but I want to go sure that using a
workqueue here is ok.

See [4] for my hid driver which is located at
drivers/hid/hid-wiimote.c. The related
patch that introduces the buffered out-queue is [5].

If there is any other way to send complex HID output reports to a
device other than the
hid_output_raw_report() function, I could rewrite this, but the
wiimote protocol really
requires this functionality and I couldn't find any other HID driver
that has similar
requirements.

Any comments are appreciated.
Kind regards

David


[1] General Device information: http://en.wikipedia.org/wiki/Wiimote
[2] Reverse-Engineered Protocol: http://wiibrew.org/wiki/Wiimote
[3] Bluetooth-Details:
https://github.com/dvdhrm/xwiimote/blob/master/doc/PROTOCOL
[4] My tree (based on jikos/master): https://github.com/dvdhrm/xwiimote_kernel
[5] Workqueue patch:
https://github.com/dvdhrm/xwiimote_kernel/commit/e8ac07bb2bff7e470a959d44db051d23dc5b0a60
[6] My userspace tools: https://github.com/dvdhrm/xwiimote
