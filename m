From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 00/13] Hid multitouch rewrite, support os system multi-axis devices, take 2
Date: Thu,  7 Jun 2018 09:54:35 +0200
Message-ID: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This is a new version of my previous series with few improvements.
I also merged the patches Dmitry sent out last year regarding the
MT_TOOL_PALM. Dmitry, I kept your SoB lines, feel free to yell if
there is something wrong.

Compared to the previous series some highlights:
- no more changes in input-core (behavior changes I mean)
- I split out the creation of MT_TOOL_DIAL
- I also fixed the location of MT_TOOL_* declaration in the uapi
- the Totem now has a hint that it will be reporting MT_TOOL_DIAL
  (setting the min/max to MT_TOOL_DIAL tells userspace that this is the
  only possible value)
- MT_TOOL_PALM changes from Dmitry are integrated.

Regarding the last item, we had a discussion whether or not quirking
the devices. After some brainstorming Peter and I came to a possible
explanation on why Dmitry was the only one detecting those issues.

I never had a report of a Win8 touchscreen that does palm rejection.
And if you think of it, when you use a touchscreen, you carefully
place your hand so it doesn't rest on the surface. Well, things are
different with dual sensors like Wacom devices. You can expect the
user to rest his/her palm on the surface while holding the pen (or
your writing gets all wobbly which kills the purpose).

So if Wacom or Pen+touch devices are the only ones having palm rejection,
in the libinput/Xorg world, the userspace tablet driver ends up doing palm
rejection for us if it's not already filtered out by the kernel.

I am not sure about how ChromeOS or Android handle such situations, but
there is a chance this is what the ChromeOS team was experiencing.
Given that assumption, I think we are safer to just keep the workaround
for all devices, knowing that it will only be triggered for a few devices.

Cheers,
Benjamin

Benjamin Tissoires (13):
  input: move MT_TOOL_* to input-event-codes.h
  input: add MT_TOOL_DIAL
  HID: multitouch: make sure the static list of class is not changed
  HID: multitouch: Store per collection multitouch data
  HID: multitouch: store a per application quirks value
  HID: multitouch: ditch mt_report_id
  HID: multitouch: remove one copy of values
  HID: input: enable Totem on the Dell Canvas 27
  HID: core: do not upper bound the collection stack
  HID: microsoft: support the Surface Dial
  HID: multitouch: report MT_TOOL_PALM for non-confident touches
  HID: multitouch: touchscreens also use confidence reports
  HID: multitouch: handle palm for touchscreens

 Documentation/input/multi-touch-protocol.rst |  12 +-
 drivers/hid/hid-core.c                       |  17 +-
 drivers/hid/hid-input.c                      |   3 +
 drivers/hid/hid-microsoft.c                  |  49 +-
 drivers/hid/hid-multitouch.c                 | 996 ++++++++++++++++-----------
 include/linux/hid.h                          |  15 +-
 include/uapi/linux/input-event-codes.h       |   9 +
 include/uapi/linux/input.h                   |   8 -
 8 files changed, 691 insertions(+), 418 deletions(-)

-- 
2.14.3
