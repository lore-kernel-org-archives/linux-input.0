From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Thu, 20 Mar 2014 11:12:08 +0100
Message-ID: <1395310330-3232-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbaCTMcM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2014 08:32:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

Hi All,

For firmware instantiated serio devices, such as devices instantiated
through ACPI, it may be useful for userspace to know the firmware-id
(pnp-id in case of ACPI) through which the device was instantiated.

One concrete example of this is the new ps/2 touchpads found in Lenovo
Thinkpad X240 T440 and T540 laptops, which not only have a special
bottom right click area to emulate right clicks, but also top middle
and top right areas to emulate middle and right clicks for the trackpoint.

Lenove has given these touchpads a unique LENxxxx pnp-id and we would like
to use this to automatically enable emulation of middle and right buttons
in the top area of the clickpad.

Matthew Garret wrote a patch to set the parent of the serio port to the
/sys/devices/pnp0/00:xx device so that we could get the necessary info that
way, but Dmitry rightfully pointed out that that would break suspend/resume
ordering, see:
https://lkml.org/lkml/2014/2/23/63
https://lkml.org/lkml/2014/3/7/428

So while discussing this with Peter Hutterer I made the plan to add a
/dev/devices/platform/i8042/serioX/firmware_parent symlink pointing to the
relevant /sys/devices/pnp0/00:xx device, and add a little udev-helper + rules
file to read this symlink and add an attribute to the udevdb with the
pnp-id this way.

This however is harder then it sounds, I spend a couple of hours on how
to do this in a race free manner and I could not come up with one. The
problem is that the sysfs_create_symlink call needs to be done after the
device_add call, at which point an add uevent has already been fired.
Causing a theoretical race where the udev-helper would not find the symlink,
this can be fixed with an extra change event after adding the symlink, but
then any higher userspace levels need to re-check on a change event as well.
So after spending too much time on this I decided to go for an alternative
solution.

Which in the end turns out to be much nicer too, since it gets rid of needing
a udev-helper too. After this much too long introduction I'll let the patches
speak for themselves.

With this patch-set one can now do:

[hans@shalem linux]$ udevadm info -p /devices/platform/i8042/serio1
P: /devices/platform/i8042/serio1
E: DEVPATH=/devices/platform/i8042/serio1
E: MODALIAS=serio:ty01pr00id00ex00
E: SERIO_EXTRA=00
E: SERIO_FIRMWARE_ID=PNP0f03 PNP0f13
E: SERIO_ID=00
E: SERIO_PROTO=00
E: SERIO_TYPE=01
E: SUBSYSTEM=serio

And the info we need is just there in the new SERIO_FIRMWARE_ID attribute,
for completeness the patch-set also adds:

[hans@shalem linux]$ cat /sys/devices/platform/i8042/serio1/firmware_id 
PNP0f03 PNP0f13

Regards,

Hans
