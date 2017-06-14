From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] Proposal for making hid_have_special_driver obsolete
Date: Wed, 14 Jun 2017 10:24:38 +0200
Message-ID: <20170614082441.5270-1-benjamin.tissoires@redhat.com>
References: <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LSU.2.20.1706131134380.30709-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

As mentioned by Jiri, I found a way to have this horrible list a thing from
the past (to some extends).

The basic observation is that now, since v4.12, hid-generic should not be an
issue for any device, given that all it does is parsing the report descriptor
and starting the IRQs/URBs.

So it should not be an issue to have hid-generic handling all incoming devices
until the specialized driver comes in and replace it.

For users, that means that they will see an input node appearing and
disappearing as soon as hid-XXX.ko gets loaded.

I have tested this on the Logitech Unifying Receiver and some Wacom devices,
and all seem happy with the situation.

Patches 1 and 2 are HID cleanup and something I wanted to put in from a long
time.

Patch 3 is the one that does the magic and where I need input from the drivers
specialists.

To make things easier to handle, I deported the logic of unbinding hid-generic
into hid-generic itself. I would think a bus_notifier would be better than
instrumenting struct hid_driver for drivers (un)registering on the bus, but
we are missing those events in bus_notifiers.
Would such events (BUS_NOTIFY_ADD_DRIVER, BUS_NOTIFY_REMOVED_DRIVER) make sense
outside of this particular case?

The second question I have is whether or not I need locks around the unbinding
magic in hid-generic. After a lot of thinking I believe I don't, but I'd prefer
having a second pair of eyes on this.

Jiri, this series is on top of a merge of your for-next and your other
for-4.12/driver-matching-fix branch. I'll resubmit a proper patch that will
apply properly to for-next as soon as for-4.12/driver-matching-fix gets merged.

Cheers,
Benjamin

Benjamin Tissoires (3):
  HID: core: move the dynamic quirks handling in core
  HID: quirks: move the list of special devices into a quirk
  HID: core: remove the absolute need of hid_have_special_driver[]

 drivers/hid/Makefile            |    2 +-
 drivers/hid/hid-core.c          |  918 ++---------------------------
 drivers/hid/hid-generic.c       |   68 ++-
 drivers/hid/hid-quirks.c        | 1236 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/Makefile     |    2 +-
 drivers/hid/usbhid/hid-core.c   |   10 +-
 drivers/hid/usbhid/hid-quirks.c |  399 -------------
 include/linux/hid.h             |   19 +-
 net/bluetooth/hidp/core.c       |    2 +-
 9 files changed, 1380 insertions(+), 1276 deletions(-)
 create mode 100644 drivers/hid/hid-quirks.c
 delete mode 100644 drivers/hid/usbhid/hid-quirks.c

-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
