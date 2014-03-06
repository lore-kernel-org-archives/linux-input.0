From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 0/8] HID: sony: More Sony controller fixes and improvements.
Date: Thu,  6 Mar 2014 17:32:48 -0500
Message-ID: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:4607 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750919AbaCFWdF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Mar 2014 17:33:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

v2 rebases the previous set of patches against Benjamin Tissoires' latest patch
set and adds some additional changes:

- Adds a patch setting the new HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP for the
  Sixaxis and DualShock 4 when they are connected via Bluetooth.  This adds
  support for sending output reports via hidraw.
  
- A patch with a new union/struct is introduced for the Sixaxis output report.
  This improves readability, particularly in the later blink support patch.
  
- Adds an IDA id allocator and uses it to assign the number at the end of the
  battery string and set the default LED values relative to other Sony
  controllers.

- Drops the LED trigger patch as it probably doesn't belong in kernel space.
  
- Addresses various issues raised during code review of the previous patch set.
