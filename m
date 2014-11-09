From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 0/2] HID: lenovo: Small fixups for compact keyboards
Date: Sun,  9 Nov 2014 07:54:28 +0000
Message-ID: <1415519670-24449-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>
List-Id: linux-input@vger.kernel.org

Some small problems that have since been picked up since my patchset that
introduced support for the Thinkpad Compact Keyboards[0]. Both have been tested
on 3.18-rc1.

There are other outstanding problems that will require less trivial patches:

* The USB keyboard needs a patch to the HID descriptor table for the horizontal
scroll wheel events to be recognised.

* There is potentially a sensitivity control to expose via. sysfs, but needs
more investigation.

* The bluetooth keyboard mouse buttons still autorepeat. Since they are part of
the same input device as the keys I'm not sure this is currently solvable.

The first 2 I will sort out once enough free time appears, if you would prefer
a single large patchset, feel free to ignore this and wait for a bigger
patchset.

Many thanks,

[0] https://lkml.org/lkml/2014/7/23/702

Jamie Lentin (2):
  HID: lenovo: Move USB KEY_FILE to 0x00f9 to prevent scancode clash
  HID: lenovo: Don't set EV_REP to avoid repeating mice buttons

 drivers/hid/hid-lenovo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.1.0
