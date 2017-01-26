From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/8] HID: wacom: Support second generation Intuos Pro
Date: Thu, 26 Jan 2017 12:39:11 -0800
Message-ID: <CAF8JNhJaGfGL4k0cpwefvd2J9h-P8Zh7yXqcZtV-Ds94-G4a2w@mail.gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36682 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbdAZUjc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 15:39:32 -0500
Received: by mail-oi0-f44.google.com with SMTP id u143so145376379oif.3
        for <linux-input@vger.kernel.org>; Thu, 26 Jan 2017 12:39:32 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>

On Wed, Jan 25, 2017 at 12:08 PM, Aaron Armstrong Skomra
<skomra@gmail.com> wrote:
>
> Patches 1-3 add Bluetooth support for the 2nd-gen Intuos Pro. Its
> Bluetooth report lacks a proper report descriptor so we must add
> explicit support for the device here.
>
> Patches 4-8 add USB support for this device via the Wacom driver's
> generic code path.
>
> Best,
> Aaron
>
> Aaron Armstrong Skomra (5):
>   HID: wacom: generic: remove input_event_flag
>   HID: wacom: generic: add support for touchring
>   HID: wacom: generic: add vendor defined touch
>   HID: wacom: generic: support generic touch switch
>   HID: wacom: generic: support LEDs
>
> Jason Gerecke (3):
>   HID: wacom: Enable HID_GENERIC codepath for Bluetooth devices
>   HID: wacom: Move WAC_CMD_* into wacom_wac.h
>   HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface

This whole set is reviewed-by: Ping Cheng <pingc@wacom.com>

Thank you Aaron and Jason for your effort.

Cheers,
Ping

>
>  drivers/hid/wacom.h     |   3 +
>  drivers/hid/wacom_sys.c | 111 +++++++++++++++----
>  drivers/hid/wacom_wac.c | 279 +++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/hid/wacom_wac.h |  37 ++++++-
>  4 files changed, 389 insertions(+), 41 deletions(-)
>
> --
> 2.7.4
>
