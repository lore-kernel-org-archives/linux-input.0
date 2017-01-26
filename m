From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/8] HID: wacom: Support second generation Intuos Pro
Date: Thu, 26 Jan 2017 21:48:29 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701262148180.25515@cbobk.fhfr.pm>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42739 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753728AbdAZUsj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 15:48:39 -0500
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com

On Wed, 25 Jan 2017, Aaron Armstrong Skomra wrote:

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
> 
>  drivers/hid/wacom.h     |   3 +
>  drivers/hid/wacom_sys.c | 111 +++++++++++++++----
>  drivers/hid/wacom_wac.c | 279 +++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/hid/wacom_wac.h |  37 ++++++-
>  4 files changed, 389 insertions(+), 41 deletions(-)

Applied to hid.git#for-4.11/wacom, thanks.

-- 
Jiri Kosina
SUSE Labs

