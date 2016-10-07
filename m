From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 00/19] HID: wacom: Add support for MobileStudio Pro
Date: Fri, 7 Oct 2016 17:41:20 +0200
Message-ID: <20161007154120.GA30411@mail.corp.redhat.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938860AbcJGPl0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 11:41:26 -0400
Content-Disposition: inline
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Oct 06 2016 or thereabouts, Jason Gerecke wrote:
> Wacom announced two new "MobileStudio Pro" tablets yesterday, a third
> iteration of the Cintiq Companion line of mobile PCs which can double
> as external pen displays.
> 
> Unlike Wacom's prior professional-grade devices, the HID descriptor for
> the MobileStudio Pro includes a rudimentary (but standard!) "Digitizer"
> application collection that is usable by the existing HID_GENERIC codepath.
> Additionally, a second vendor-defined application collection exists which
> fully defines reports that enable full tablet functionality. The numerous
> vendor-defined usages are planned to be used in future professional devices
> as well, allowing us to finally gain some of the same forward compatibility
> benefits we've had for ISDv4 devices since 3.17.
> 
>  * Patches 1-3 perform some basic cleanups.
> 
>  * Patches 4-6 work on the operation of the driver for all HID_GENERIC
>    devices, correcting minor issues and adding some missing features.
> 
>  * Patches 7-19 implement support for the vendor defined usages that
>    are used in the MobileStudio Pro, and which are planned to be used
>    in future professional devices as well.
> 
> 
> Jiri: Could you let me know whether it would be possible to schedule
> these for the currently-open 4.9 merge window?

Jiri, FYI, I have already made 2 (or 3) internal reviews of this series.
I just have one/two nitpicks here and there (I noticed few if statements
with braces while only one statement was done after), but nothing
preventing from pulling the series IMO.

I have been staring the series for too long now, and I can't find
anything useful (besides in patch 13, but not a biggy).

>From what I can tell, the series has little impact on existing devices
(patches 1, 3, 11, 14), and I assume Jason and the other Wacom engineers
made extensive tests for these patches.

Patch 19 for hid-input should also be safe :)

The series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
> 
> Jason Gerecke (19):
>   HID: wacom: Update vendor-defined usage names to better match
>     standards
>   HID: wacom: Have WACOM_PEN_FIELD and WACOM_FINGER_FIELD recgonize more
>     fields
>   HID: wacom: Refactor button-to-key translation into function
>   HID: wacom: Detect and correct descriptors missing
>     HID_DG_BARRELSWITCH2
>   HID: wacom: generic: Strip off excessive name prefixing
>   HID: wacom: generic: Add support for height, tilt, and twist usages
>   HID: wacom: generic: Support and use 'Custom HID' mode and usages
>   HID: wacom: generic: Add support for vendor-defined "Distance" usage
>   HID: wacom: generic: Add support for vendor-defined "Fingerwheel"
>     usage
>   HID: wacom: generic: Add support for vendor-defined "Sense" usage
>   HID: wacom: Read and internally use corrected Intuos tool IDs
>   HID: wacom: generic: Support tool ID and additional tool types
>   HID: wacom: generic: Pass 'hdev' to 'wacom_map_usage'
>   HID: wacom: Fix sensor outbounds and redefine as offsets from each
>     edge
>   HID: wacom: generic: Add support for sensor offsets
>   HID: wacom: generic: Introduce pad support
>   HID: wacom: generic: Add support for battery status on pen and pad
>     interfaces
>   HID: wacom: generic: Extend pad support
>   HID: input: Recognize ABS_WHEEL in hidinput_calc_abs_res
> 
>  drivers/hid/hid-input.c |   1 +
>  drivers/hid/wacom_sys.c |  92 ++++++--
>  drivers/hid/wacom_wac.c | 544 +++++++++++++++++++++++++++++++++++++++---------
>  drivers/hid/wacom_wac.h |  73 ++++++-
>  include/linux/hid.h     |   4 +
>  5 files changed, 595 insertions(+), 119 deletions(-)
> 
> -- 
> 2.10.0
> 
