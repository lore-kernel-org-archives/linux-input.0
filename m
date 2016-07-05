From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 00/27] HID: wacom: cleanup/EKR/LED
Date: Tue,  5 Jul 2016 16:38:56 +0200
Message-ID: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202AbcGEOj2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 10:39:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

Initially, I thought the series would have been short because it was driven
by 23/27 and 26/27. We wanted to have a common API for the LED in the kernel
and also let the kernel switches the LED for us so that libinput doesn't need
to have root access. The LED kernel API has kernel triggers which allows users
to enable/disable automatic LED switching.

Well, the plan did not go so well, and I ended up cleaning up the Wacom driver
one more time (Daft Punk's song complimentary). I finally made use of devres
management in this driver which allows to simplify the cleanups of the various
resources allocated here and there. I had to resort most of the time to devres
groups because of the 2 wireless receiver Wacom has. With these 2 receivers
(Intuos Pro/Bamboos and the EKR), input nodes can be created/destroyed at
will, without having the parent HID device removed.

The plan was also to provide a common API for the EKR and the rest of the
Intuos/Cintiqs. And working on this reminded me that we never finished providing
proper support of the Wacom ExpressKey Remote (one input node per remote,
one power_supply per remote).

So, here is the result of this past few weeks. I tested this on the following
devices: Intuos Pro, Bamboo 16 fg Pen/Touch, Bamboo Pad, Cintiq 13HD and
the EKR.
Peter tested an earlier series on the 21UX2 and I hope I fixed the bugs he
noted, but I would love the Wacom guys to test the series on the 21UX2 (again)
and the 24HD(T). I was only able to test those 2 devices through uhid, and
manually checked the raw commands were set properly, but an actual test would be
better.

Happy reviewing :)

Cheers,
Benjamin


Benjamin Tissoires (27):
  HID: wacom: actually report the battery level for wireless connected
  HID: wacom: store the type in wacom->shared for INTUOSHT and INTUOSHT2
  HID: wacom: remove cleanup of wacom->remote_dir from
    wacom_clean_inputs()
  HID: wacom: untie leds from inputs
  HID: wacom: use one work queue per task
  HID: wacom: switch battery to devres
  HID: wacom: switch inputs to devres
  HID: wacom: put the managed resources in a group
  HID: wacom: convert LEDs to devres
  HID: wacom: use devm_kasprintf for allocating the name of the remote
  HID: wacom: use devres to allocate driver data
  HID: wacom: devres manage the shared data too
  HID: wacom: leds: dynamically allocate LED groups
  HID: wacom: EKR: add a worker to add/remove resources on
    addition/removal
  HID: wacom: EKR: have the wacom resources dynamically allocated
  HID: wacom: rework fail path in probe() and parse_and_register()
  HID: wacom: EKR: have proper allocator and destructor
  HID: wacom: EKR: use devres groups to manage resources
  HID: wacom: EKR: have one array of struct remotes instead of many
    arrays
  HID: wacom: EKR: allocate one input node per remote
  HID: wacom: EKR: have one power_supply per remote
  HID: wacom: EKR: attach the power_supply on first connection
  HID: wacom: leds: use the ledclass instead of custom made sysfs files
  HID: wacom: leds: actually release the LEDs on disconnect
  HID: wacom: leds: fix ordering of LED banks
  HID: wacom: leds: handle the switch of the LEDs directly in the kernel
  HID: wacom: leds: handle Cintiq 24HD leds buttons

 Documentation/ABI/testing/sysfs-driver-wacom |    5 +
 drivers/hid/wacom.h                          |   98 ++-
 drivers/hid/wacom_sys.c                      | 1104 +++++++++++++++++++-------
 drivers/hid/wacom_wac.c                      |  238 ++++--
 drivers/hid/wacom_wac.h                      |   18 +-
 5 files changed, 1073 insertions(+), 390 deletions(-)

-- 
2.5.5

