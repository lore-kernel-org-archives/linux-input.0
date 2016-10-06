From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 00/19] HID: wacom: Add support for MobileStudio Pro
Date: Thu,  6 Oct 2016 14:22:12 -0700
Message-ID: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36100 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935071AbcJFVWk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:40 -0400
Received: by mail-qt0-f172.google.com with SMTP id m5so13621557qtb.3
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Wacom announced two new "MobileStudio Pro" tablets yesterday, a third
iteration of the Cintiq Companion line of mobile PCs which can double
as external pen displays.

Unlike Wacom's prior professional-grade devices, the HID descriptor for
the MobileStudio Pro includes a rudimentary (but standard!) "Digitizer"
application collection that is usable by the existing HID_GENERIC codepath.
Additionally, a second vendor-defined application collection exists which
fully defines reports that enable full tablet functionality. The numerous
vendor-defined usages are planned to be used in future professional devices
as well, allowing us to finally gain some of the same forward compatibility
benefits we've had for ISDv4 devices since 3.17.

 * Patches 1-3 perform some basic cleanups.

 * Patches 4-6 work on the operation of the driver for all HID_GENERIC
   devices, correcting minor issues and adding some missing features.

 * Patches 7-19 implement support for the vendor defined usages that
   are used in the MobileStudio Pro, and which are planned to be used
   in future professional devices as well.


Jiri: Could you let me know whether it would be possible to schedule
these for the currently-open 4.9 merge window?


Jason Gerecke (19):
  HID: wacom: Update vendor-defined usage names to better match
    standards
  HID: wacom: Have WACOM_PEN_FIELD and WACOM_FINGER_FIELD recgonize more
    fields
  HID: wacom: Refactor button-to-key translation into function
  HID: wacom: Detect and correct descriptors missing
    HID_DG_BARRELSWITCH2
  HID: wacom: generic: Strip off excessive name prefixing
  HID: wacom: generic: Add support for height, tilt, and twist usages
  HID: wacom: generic: Support and use 'Custom HID' mode and usages
  HID: wacom: generic: Add support for vendor-defined "Distance" usage
  HID: wacom: generic: Add support for vendor-defined "Fingerwheel"
    usage
  HID: wacom: generic: Add support for vendor-defined "Sense" usage
  HID: wacom: Read and internally use corrected Intuos tool IDs
  HID: wacom: generic: Support tool ID and additional tool types
  HID: wacom: generic: Pass 'hdev' to 'wacom_map_usage'
  HID: wacom: Fix sensor outbounds and redefine as offsets from each
    edge
  HID: wacom: generic: Add support for sensor offsets
  HID: wacom: generic: Introduce pad support
  HID: wacom: generic: Add support for battery status on pen and pad
    interfaces
  HID: wacom: generic: Extend pad support
  HID: input: Recognize ABS_WHEEL in hidinput_calc_abs_res

 drivers/hid/hid-input.c |   1 +
 drivers/hid/wacom_sys.c |  92 ++++++--
 drivers/hid/wacom_wac.c | 544 +++++++++++++++++++++++++++++++++++++++---------
 drivers/hid/wacom_wac.h |  73 ++++++-
 include/linux/hid.h     |   4 +
 5 files changed, 595 insertions(+), 119 deletions(-)

-- 
2.10.0

