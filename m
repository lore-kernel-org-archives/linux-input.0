From: Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [RFC v2 0/4] uhid LED input events handling
Date: Mon, 17 Dec 2012 10:28:22 -0300
Message-ID: <CACJA=fUYX0Wehd--Ay0bwSS+9visC5By=SCWaoVkvKjVsJySKQ@mail.gmail.com>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41954 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2LQN2Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Dec 2012 08:28:24 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4007409pbc.19
        for <linux-input@vger.kernel.org>; Mon, 17 Dec 2012 05:28:23 -0800 (PST)
In-Reply-To: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

Ping.

On Sat, Dec 1, 2012 at 4:07 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
> Hi all,
>
> This patchset implements the support for handling LED input events in uhid
> driver.
>
> As requested in the previous RFC, it was introduced a new helper in hid-input.c
> to carry out a generic LED input events handling (hidinput_led_output_report).
> The helper is used by uhid driver.
>
> The helper can also be used in i2c-hid driver since it does a very simply
> handling of LED events too. I have no i2c device to test the i2c-hid patch,
> so it requires some testing before applying it.
>
> As long as the helper relies on device's .hid_output_raw_report() and
> hid-logitech-dj driver doesn't properly implement this callback, the helper is
> not used in hid-logitech-dj driver.
>
> Also, this helper is not used in usbhid driver as long as it does a more
> sophisticated handling than what hidinput_led_output_report helper does. For
> further information about usbhid LEDs handling see comments in the patchset [1].
>
> This patchset is rebased on Jiri's for-next branch.
>
> Best regards,
>
> Andre Guedes
>
> [1] - http://marc.info/?l=linux-usb&m=132013970108623&w=2
>
>
> Andre Guedes (4):
>   HID: Add generic handler for LED input events
>   HID: uhid: Handle LED input events
>   HID: uhid: Use GFP_ATOMIC in uhid_hid_output_raw
>   HID: i2c-hid: LED input events handling
>
>  drivers/hid/hid-input.c       | 51 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/i2c-hid/i2c-hid.c | 11 +---------
>  drivers/hid/uhid.c            | 34 +++++++++++++++++++----------
>  include/linux/hid.h           |  2 ++
>  4 files changed, 76 insertions(+), 22 deletions(-)
>
> --
> 1.8.0.1
>
