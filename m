From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 0/8] HID: Transport Driver Cleanup
Date: Mon, 15 Jul 2013 20:55:49 +0200
Message-ID: <CAN+gG=E0s_5sbmynx5hujMYqNneb0UH0tnG-_hT31f-Cd994pg@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:50686 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab3GOSzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 14:55:51 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so9739733lab.20
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 11:55:49 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

Hi David,

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> This series provides some cleanups for HID transport drivers:
>  Patch #1: Cleanup which can be picked up
>  Patch #2-#6: Provide generic hidinput_input_event() helpers
>  Patch #7-#8: Transport-driver Cleanup

First, thank you very much for this work. Especially the patch #7. I
did not read it entirely though, but it looks great.

I won't have the brain in a good state this evening to do an entire
review right now, but here are a few preliminary comments:

>
> Patch #7-#8 is an attempt to clean up the transport driver callbacks. Lets look
> at how the following hooks are currently implemented:
>  1) GET_REPORT: Issue a synchronous GET_REPORT via the ctrl-channel
>  2) SET_REPORT: Issue a synchronous SET_REPORT via the ctrl-channel

I am not 100% sure GET/SET_REPORT are synchronous. At least, they
ensure for the usbhid module some kind of PM negotiation which allows
communication.

>  3) OUTPUT: Issue an asynchronous OUTPUT report on the intr-channel
>
> USB-HID:
>  1) GET_REPORT can be issued via ->hid_get_raw_report() for all three report
>     types correctly.
>  2) SET_REPORT can only be issued for FEATURE reports via
>     ->hid_output_raw_report(). INPUT and OUTPUT reports on the same callback
>     cause an asynchronous report on the intr channel.
>  3) OUTPUT reports can be issued via ->hid_output_raw_report() as described
>     above in SET_REPORT.

I'm afraid no (for the 3 points). See dcd9006b1b053c7 in Linus' tree.
hid_hw_request uses usbhid_submit_report() which is very different
from ->hid_output_raw_report() or ->hid_get_raw_report() thanks to all
the glue around the USB communication.

>
> HIDP:
>  1) GET_REPORT: same as for USB-HID
>  2) SET_REPORT can only be issued for FEATURE reports via
>     ->hid_output_raw_report(). SET_REPORT for INPUT reports is forbidden (why?)
>     and SET_REPORT for OUTPUT reports is actually implemented as 3)
>  3) OUTPUT reports can be issued via ->hid_output_raw_report().
>
> I2C:
>  1) GET_REPORT implemented for INPUT and FEATURE via ->hid_get_raw_report().
>     Forbidden for OUTPUT reports (why?).

To me (I will double check later):
 - an INPUT report is read only, and send spontaneous events.
 - an OUTPUT report is write only.
 - a FEATURE is read/write but does not send spontaneous events

Then, the device firmware may allow you to do other things, but I
doubt there is any sense to write something on an INPUT report for
example.

>  2) SET_REPORT can be issued for OUTPUT and FEATURE reports via
>     ->hid_output_raw_report() but is forbidden for INPUT reports (why?).
>  3) OUTPUT reports cannot be issued at all.
>
> UHID:
>  1) GET_REPORT only supported for FEATURE via ->hid_get_raw_report()
>  2) SET_REPORT not supported at all
>  3) OUTPUT supported via ->hid_output_raw_report()
>
>
> As this is all very inconsistent, I added two new callbacks:
>  ->raw_request() is the same as ->request() but with a raw buffer. It should be
>  implemented by the transport drivers as SET/GET_REPORT calls in the
>  ctrl-channel.
>
>  ->output_report() is supposed to send an OUTPUT report on the intr-channel
>  (same channel asynchronous input reports are received from).
>
> Please see the hid-transport.txt for a description. The last patch tries to
> implement them. I have no idea how to implement it for i2c, it seems that i2c
> multiplexes ctrl and intr channels on a single i2c channel. I don't know how to
> send raw output reports at all.. Help welcome!

I can help. Actually, on I2C, there is no ctrl and intr channels. You
just send plain reports from both sides, and the device can notify the
host from an INPUT report thanks to an interrupt line (external to the
actual I2C communication). Anyway, I'll implement and test the I2C
stuffs if you need.

>
>
> If there is more interest in this work, I will clean it up, try to convert the
> other hid_ll_driver drivers and resend as a proper patchset.

Yes, I am very interested. Before cleaning it up, I think we already
have a lot to discuss (at least, I have some points :-P ).

Again, thanks for this work.

Cheers,
Benjamin

>
> Cheers
> David
>
> David Herrmann (8):
>   HID: usbhid: make usbhid_set_leds() static
>   HID: usbhid: update LED fields unlocked
>   HID: input: generic hidinput_input_event handler
>   HID: usbhid: use generic hidinput_input_event()
>   HID: i2c: use generic hidinput_input_event()
>   HID: uhid: use generic hidinput_input_event()
>   HID: add transport driver documentation
>   HID: implement new transport-driver callbacks
>
>  Documentation/hid/hid-transport.txt | 299 ++++++++++++++++++++++++++++++++++++
>  Documentation/hid/uhid.txt          |   4 +-
>  drivers/hid/hid-input.c             |  80 +++++++++-
>  drivers/hid/i2c-hid/i2c-hid.c       |  24 ---
>  drivers/hid/uhid.c                  |  52 ++++---
>  drivers/hid/usbhid/hid-core.c       | 144 +++++++++--------
>  drivers/hid/usbhid/usbhid.h         |   3 -
>  include/linux/hid.h                 |  10 +-
>  include/uapi/linux/uhid.h           |   4 +-
>  net/bluetooth/hidp/core.c           |  90 +++++++++++
>  10 files changed, 590 insertions(+), 120 deletions(-)
>  create mode 100644 Documentation/hid/hid-transport.txt
>
> --
> 1.8.3.2
>
