From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] xen/input: add multi-touch support
Date: Wed, 7 Jun 2017 09:56:30 -0700
Message-ID: <20170607165630.GA13116@dtor-ws>
References: <1492083484-31786-1-git-send-email-andr2000@gmail.com>
 <1492083484-31786-3-git-send-email-andr2000@gmail.com>
 <20170421021018.GB23279@dtor-ws>
 <bd6b6680-6023-765f-d80f-b00e2b6dd597@gmail.com>
 <20170530055150.GA38163@dtor-ws>
 <8092dd49-20e0-3e8d-977d-2f570142a37d@gmail.com>
 <20170530163708.GA12922@dtor-ws>
 <c355258d-f207-aa5e-a170-e52438102a37@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35807 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdFGQ4e (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 12:56:34 -0400
Content-Disposition: inline
In-Reply-To: <c355258d-f207-aa5e-a170-e52438102a37@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, joculator@gmail.com, al1img@gmail.com, vlad.babchuk@gmail.com, andrii.anisov@gmail.com, olekstysh@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

On Wed, May 31, 2017 at 12:06:56PM +0300, Oleksandr Andrushchenko wrote:
> Hi, Dmitry!
> 
> On 05/30/2017 07:37 PM, Dmitry Torokhov wrote:
> >On Tue, May 30, 2017 at 03:50:20PM +0300, Oleksandr Andrushchenko wrote:
> >>Hi, Dmitry!
> >>
> >>On 05/30/2017 08:51 AM, Dmitry Torokhov wrote:
> >>>On Fri, Apr 21, 2017 at 09:40:36AM +0300, Oleksandr Andrushchenko wrote:
> >>>>Hi, Dmitry!
> >>>>
> >>>>On 04/21/2017 05:10 AM, Dmitry Torokhov wrote:
> >>>>>Hi Oleksandr,
> >>>>>
> >>>>>On Thu, Apr 13, 2017 at 02:38:04PM +0300, Oleksandr Andrushchenko wrote:
> >>>>>>From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >>>>>>
> >>>>>>Extend xen_kbdfront to provide multi-touch support
> >>>>>>to unprivileged domains.
> >>>>>>
> >>>>>>Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >>>>>>---
> >>>>>>  drivers/input/misc/xen-kbdfront.c | 142 +++++++++++++++++++++++++++++++++++++-
> >>>>>>  1 file changed, 140 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>>diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> >>>>>>index 01c27b4c3288..e5d064aaa237 100644
> >>>>>>--- a/drivers/input/misc/xen-kbdfront.c
> >>>>>>+++ b/drivers/input/misc/xen-kbdfront.c
> >>>>>>@@ -17,6 +17,7 @@
> >>>>>>  #include <linux/errno.h>
> >>>>>>  #include <linux/module.h>
> >>>>>>  #include <linux/input.h>
> >>>>>>+#include <linux/input/mt.h>
> >>>>>>  #include <linux/slab.h>
> >>>>>>  #include <asm/xen/hypervisor.h>
> >>>>>>@@ -34,11 +35,14 @@
> >>>>>>  struct xenkbd_info {
> >>>>>>  	struct input_dev *kbd;
> >>>>>>  	struct input_dev *ptr;
> >>>>>>+	struct input_dev *mtouch;
> >>>>>>  	struct xenkbd_page *page;
> >>>>>>  	int gref;
> >>>>>>  	int irq;
> >>>>>>  	struct xenbus_device *xbdev;
> >>>>>>  	char phys[32];
> >>>>>>+	/* current MT slot/contact ID we are injecting events in */
> >>>>>>+	int mtouch_cur_contact_id;
> >>>>>>  };
> >>>>>>  enum { KPARAM_X, KPARAM_Y, KPARAM_CNT };
> >>>>>>@@ -47,6 +51,12 @@ module_param_array(ptr_size, int, NULL, 0444);
> >>>>>>  MODULE_PARM_DESC(ptr_size,
> >>>>>>  	"Pointing device width, height in pixels (default 800,600)");
> >>>>>>+enum { KPARAM_MT_X, KPARAM_MT_Y, KPARAM_MT_CNT };
> >>>>>>+static int mtouch_size[KPARAM_MT_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
> >>>>>>+module_param_array(mtouch_size, int, NULL, 0444);
> >>>>>>+MODULE_PARM_DESC(ptr_size,
> >>>>>>+	"Multi-touch device width, height in pixels (default 800,600)");
> >>>>>>+
> >>>>>Why do you need separate module parameters for multi-touch device?
> >>>>please see below
> >>>>>>  static int xenkbd_remove(struct xenbus_device *);
> >>>>>>  static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
> >>>>>>  static void xenkbd_disconnect_backend(struct xenkbd_info *);
> >>>>>>@@ -100,6 +110,60 @@ static irqreturn_t input_handler(int rq, void *dev_id)
> >>>>>>  				input_report_rel(dev, REL_WHEEL,
> >>>>>>  						 -event->pos.rel_z);
> >>>>>>  			break;
> >>>>>>+		case XENKBD_TYPE_MTOUCH:
> >>>>>>+			dev = info->mtouch;
> >>>>>>+			if (unlikely(!dev))
> >>>>>>+				break;
> >>>>>>+			if (unlikely(event->mtouch.contact_id !=
> >>>>>>+					info->mtouch_cur_contact_id)) {
> >>>>>Why is this unlikely? Does contact ID changes once in 1000 packets or
> >>>>>even less?
> >>>>Mu assumption was that regardless of the fact that we are multi-touch
> >>>>device still single touches will come in more frequently
> >>>>But I can remove *unlikely* if my assumption is not correct
> >>>I think the normal expectation is that "unlikely" is supposed for
> >>>something that happens once in a blue moon, so I'd rather remove it.
> >>>
> >>agree, removed "unlikely"
> >>>>>>+				info->mtouch_cur_contact_id =
> >>>>>>+					event->mtouch.contact_id;
> >>>>>>+				input_mt_slot(dev, event->mtouch.contact_id);
> >>>>>>+			}
> >>>>>>+			switch (event->mtouch.event_type) {
> >>>>>>+			case XENKBD_MT_EV_DOWN:
> >>>>>>+				input_mt_report_slot_state(dev, MT_TOOL_FINGER,
> >>>>>>+							   true);
> >>>Should we establish tool event? We have MT_TOOL_PEN, etc.
> >>I think that for multi-touch MT_TOOL_FINGER is enough
> >>any reason we would also want MT_TOOL_PEN here?
> >Why would not you? Let's say you have a drawing application running in
> >guest that can make use of tool types. Why would not you want to tell it
> >that the tool user is currently using is in fact a pen and not finger?
> But it is a finger :) we are multi-touch, not multi pen

So for tablets that support both touch and stylus you would export them
as 2 separate devices?

> 
> Besides, that, if I am about to implement pen support
> (which I still not convinced we really need), how will I
> do that?

I do not know what you have on the backend side, but roughly speaking if
you detect a pen/stylus you let your guest know that the contact is not
a finger, but pen. How you plumb it through is up to you.

> My understanding is that I need 2 different slots to report
> the same coordinates for finger and pen. This is because
> input_mt_report_slot_state has a check that if tool has
> changed for the current slot then a new tracking ID is set.
> Do I also need to allocate twice more slots, so I can
> report 2 * num_contacts events simultaneously (one for finger
> and another for pen)?
> That said, I believe we can start with multi-touch support
> and if need be then add pen support as a separate change,
> does that make sense for you?
> >
> >>(I guess MT_TOOL_PALM is not appropriate anyways)
> >Depends on if you do straight pass-through from the host side or not. If
> >you stack does palm rejection before passing the data through then you
> >would not see MT_TOOL_PALM in guest.
> the protocol used between guest and host is a generic one,
> not using Linux types/constants/events.

It does not have to use Linux types to support the concept of different
tools.

> So, no PALM/TOOL support is in place

OK, that is fair. The pen support is definitely not a hard requirement.
I was just wondering if you considered or have plans for adding that. Or
if you want to review the protocol so it can be easily added in the
future. For example you could have tool type to be part of
XENKBD_MT_EV_DOWN event.

> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_POSITION_X,
> >>>>>>+					    event->mtouch.u.pos.abs_x);
> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_POSITION_Y,
> >>>>>>+					    event->mtouch.u.pos.abs_y);
> >>>>>>+				input_event(dev, EV_ABS, ABS_X,
> >>>>>>+					    event->mtouch.u.pos.abs_x);
> >>>>>>+				input_event(dev, EV_ABS, ABS_Y,
> >>>>>>+					    event->mtouch.u.pos.abs_y);
> >>>>>>+				break;
> >>>>>>+			case XENKBD_MT_EV_UP:
> >>>>>>+				input_mt_report_slot_state(dev, MT_TOOL_FINGER,
> >>>>>>+							   false);
> >>>>>>+				break;
> >>>>>>+			case XENKBD_MT_EV_MOTION:
> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_POSITION_X,
> >>>>>>+					    event->mtouch.u.pos.abs_x);
> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_POSITION_Y,
> >>>>>>+					    event->mtouch.u.pos.abs_y);
> >>>>>>+				input_event(dev, EV_ABS, ABS_X,
> >>>>>>+					    event->mtouch.u.pos.abs_x);
> >>>>>>+				input_event(dev, EV_ABS, ABS_Y,
> >>>>>>+					    event->mtouch.u.pos.abs_y);
> >>>>>>+				break;
> >>>>>>+			case XENKBD_MT_EV_SYN:
> >>>>>>+				input_mt_sync_frame(dev);
> >>>>>>+				break;
> >>>>>>+			case XENKBD_MT_EV_SHAPE:
> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_TOUCH_MAJOR,
> >>>>>>+					    event->mtouch.u.shape.major);
> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_TOUCH_MINOR,
> >>>>>>+					    event->mtouch.u.shape.minor);
> >>>>>>+				break;
> >>>>>>+			case XENKBD_MT_EV_ORIENT:
> >>>>>>+				input_event(dev, EV_ABS, ABS_MT_ORIENTATION,
> >>>>>>+					    event->mtouch.u.orientation);
> >>>>>>+				break;
> >>>>>>+			}
> >>>>>>+			/* only report syn when requested */
> >>>>>>+			if (event->mtouch.event_type != XENKBD_MT_EV_SYN)
> >>>>>>+				dev = NULL;
> >>>>>>  		}
> >>>>>>  		if (dev)
> >>>>>>  			input_sync(dev);
> >>>>>>@@ -115,9 +179,9 @@ static int xenkbd_probe(struct xenbus_device *dev,
> >>>>>>  				  const struct xenbus_device_id *id)
> >>>>>>  {
> >>>>>>  	int ret, i;
> >>>>>>-	unsigned int abs;
> >>>>>>+	unsigned int abs, touch;
> >>>>>>  	struct xenkbd_info *info;
> >>>>>>-	struct input_dev *kbd, *ptr;
> >>>>>>+	struct input_dev *kbd, *ptr, *mtouch;
> >>>>>>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
> >>>>>>  	if (!info) {
> >>>>>>@@ -152,6 +216,17 @@ static int xenkbd_probe(struct xenbus_device *dev,
> >>>>>>  		}
> >>>>>>  	}
> >>>>>>+	touch = xenbus_read_unsigned(dev->nodename,
> >>>>>>+				     XENKBD_FIELD_FEAT_MTOUCH, 0);
> >>>>>>+	if (touch) {
> >>>>>>+		ret = xenbus_write(XBT_NIL, dev->nodename,
> >>>>>>+				   XENKBD_FIELD_REQ_MTOUCH, "1");
> >>>>>>+		if (ret) {
> >>>>>>+			pr_warning("xenkbd: can't request multi-touch");
> >>>>>>+			touch = 0;
> >>>>>>+		}
> >>>>>>+	}
> >>>>>>+
> >>>>>>  	/* keyboard */
> >>>>>>  	kbd = input_allocate_device();
> >>>>>>  	if (!kbd)
> >>>>>>@@ -208,6 +283,67 @@ static int xenkbd_probe(struct xenbus_device *dev,
> >>>>>>  	}
> >>>>>>  	info->ptr = ptr;
> >>>>>>+	/* multi-touch device */
> >>>>>>+	if (touch) {
> >>>>>>+		int num_cont, width, height;
> >>>>>>+
> >>>>>>+		mtouch = input_allocate_device();
> >>>>>>+		if (!mtouch)
> >>>>>>+			goto error_nomem;
> >>>>>>+
> >>>>>>+		num_cont = xenbus_read_unsigned(info->xbdev->nodename,
> >>>>>>+						XENKBD_FIELD_MT_NUM_CONTACTS,
> >>>>>>+						1);
> >>>Should we refuse MT devices with number of contacts less than 2?
> >>we can, but I see no harm in 1. what is more, this may
> >>allow guests to emulate more pointing devices
> >>but, if you insist, then I will add appropriate code to
> >>reject if number of contacts is less then 2

The question is if you are planning to keep the single-touch interface
or you will migrate everything to multi-touch.

> >>>>>>+		width = xenbus_read_unsigned(info->xbdev->nodename,
> >>>>>>+					     XENKBD_FIELD_MT_WIDTH,
> >>>>>>+					     XENFB_WIDTH);
> >>>>>>+		height = xenbus_read_unsigned(info->xbdev->nodename,
> >>>>>>+					      XENKBD_FIELD_MT_HEIGHT,
> >>>>>>+					      XENFB_HEIGHT);
> >>>>>Curious why you need separate parameters here too...
> >>>>This is because mt parameters are different from ptr
> >>>>in a way that they are configurable per front driver's
> >>>>instance rather than per backend, e.g. in XenStore:
> >>>>
> >>>>/local/domain/0/backend/vkbd/1/0/width = "1920"
> >>>>/local/domain/0/backend/vkbd/1/0/height = "1080"
> >>>>
> >>>>/local/domain/1/device/vkbd/0/multi-touch-width = "1920"
> >>>>/local/domain/1/device/vkbd/0/multi-touch-height = "1080"
> >>>>/local/domain/1/device/vkbd/0/multi-touch-num-contacts = "10"
> >>>>
> >>>>/local/domain/1/device/vkbd/1/multi-touch-width = "800"
> >>>>/local/domain/1/device/vkbd/1/multi-touch-height = "600"
> >>>>/local/domain/1/device/vkbd/1/multi-touch-num-contacts = "3"
> >>>>
> >>>>The main reason for such configuration is that you can
> >>>>configure multiple mt input devices even for the same guest
> >>>>with different resolutions which may not match those
> >>>>configured for ptr.
> >>>>(In my use-case I use new displif protocol [1] in conjunction
> >>>>with mt input devices and the corresponding backend is not
> >>>>QEMU's xenfb)
> >>>I see.
> >>>
> >>>>As to module parameters, I added those to be consistent with
> >>>>ptr device. Do you think we can live without them and
> >>>>do you want me to remove them?
> >>>Yes, I think we better. I am also confused by the way you are handling
> >>>the module parameters. It looks to me you update them with data passed
> >>>from the backend, but never use the data...
> >>I have removed module parameters (the only use of those
> >>was to be able to see configured width and height on
> >>guest side, but this is minor)
> >evtest would show it to you. Or you can query input device yourself
> >(EVIOCGABS iotcl).
> yes, if embedded system (which is my target) has evtest
> but it definitely does have ioctl though
> >>>>>>+
> >>>>>>+		mtouch->name = "Xen Virtual Multi-touch";
> >>>>>>+		mtouch->phys = info->phys;
> >>>>>>+		mtouch->id.bustype = BUS_PCI;
> >>>>>>+		mtouch->id.vendor = 0x5853;
> >>>>>>+		mtouch->id.product = 0xfffd;
> >>>>>>+
> >>>>>>+		__set_bit(EV_ABS, mtouch->evbit);
> >>>>>>+		__set_bit(EV_KEY, mtouch->evbit);
> >>>>>>+		__set_bit(BTN_TOUCH, mtouch->keybit);
> >Please make it
> >		input_set_capability(mtouch, EV_KEY, BTN_TOUCH);
> >
> >and drop all __set_bit()s.
> done, thank you
> >>>>>>+
> >>>>>>+		input_set_abs_params(mtouch, ABS_X,
> >>>>>>+				     0, width, 0, 0);
> >>>>>>+		input_set_abs_params(mtouch, ABS_Y,
> >>>>>>+				     0, height, 0, 0);
> >>>>>>+		input_set_abs_params(mtouch, ABS_PRESSURE,
> >>>>>>+				     0, 255, 0, 0);
> >>>>>>+
> >>>>>>+		input_set_abs_params(mtouch, ABS_MT_TOUCH_MAJOR,
> >>>>>>+				     0, 255, 0, 0);
> >>>>>>+		input_set_abs_params(mtouch, ABS_MT_POSITION_X,
> >>>>>>+				     0, width, 0, 0);
> >>>>>>+		input_set_abs_params(mtouch, ABS_MT_POSITION_Y,
> >>>>>>+				     0, height, 0, 0);
> >>>>>>+		input_set_abs_params(mtouch, ABS_MT_PRESSURE,
> >>>>>>+				     0, 255, 0, 0);
> >>>>>>+
> >>>>>>+		input_mt_init_slots(mtouch, num_cont, 0);
> >>>We need error handling here.
> >>done
> >>>  Also, it would be nice if we set INPUT_MT_*
> >>>flags here, so that userspace had better chance of figuring how to
> >>>handle the device.
> >>done, I will use INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED
> >Does that mean that your backend does not reliably report release of
> >contacts?
> there is a ring buffer between host and guest,
> so there is always a possibility (rather small I believe)
> that the buffer overruns. Do you think I need INPUT_MT_DROP_UNUSED or
> we can live without it?

Again, it depends on your backend behavior. Do you report all slots
repeatedly for every packet or you report only changed slots?

Thanks.

> >
> >Thanks.
> >
> >>>>>>+
> >>>>>>+		mtouch_size[KPARAM_MT_X] = width;
> >>>>>>+		mtouch_size[KPARAM_MT_Y] = height;
> >>>>>>+		info->mtouch_cur_contact_id = -1;
> >>>>>>+
> >>>>>>+		ret = input_register_device(mtouch);
> >>>>>>+		if (ret) {
> >>>>>>+			input_free_device(mtouch);
> >>>>>>+			xenbus_dev_fatal(info->xbdev, ret,
> >>>>>>+					 "input_register_device(mtouch)");
> >>>>>>+			goto error;
> >>>>>>+		}
> >>>>>>+		info->mtouch_cur_contact_id = -1;
> >>>>>>+		info->mtouch = mtouch;
> >>>>>>+	}
> >>>>>>+
> >>>>>>  	ret = xenkbd_connect_backend(dev, info);
> >>>>>>  	if (ret < 0)
> >>>>>>  		goto error;
> >>>>>>@@ -240,6 +376,8 @@ static int xenkbd_remove(struct xenbus_device *dev)
> >>>>>>  		input_unregister_device(info->kbd);
> >>>>>>  	if (info->ptr)
> >>>>>>  		input_unregister_device(info->ptr);
> >>>>>>+	if (info->mtouch)
> >>>>>>+		input_unregister_device(info->mtouch);
> >>>>>>  	free_page((unsigned long)info->page);
> >>>>>>  	kfree(info);
> >>>>>>  	return 0;
> >>>>>>-- 
> >>>>>>2.7.4
> >>>>>>
> >>>Thanks.
> >>>
> >>For your convenience I am attaching the changes I am about
> >>to put into v1 of the series:
> >>  - remove unlikely
> >>  - remove module parameters
> >>  - error handling for input_mt_init_slots
> >>  - let userspace better chance of figuring how to handle the device
> >>
> >>Thank you,
> >>Oleksandr
> >> From e76506c55846e2bb4ccbafa430642e368643e51d Mon Sep 17 00:00:00 2001
> >>From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >>Date: Tue, 30 May 2017 14:49:58 +0300
> >>Subject: [PATCH] Fix: remove unlikely Fix: remove module paramters Fix: error
> >>  handling for input_mt_init_slots Fix: let userspace better chance of figuring
> >>  how to handle the device
> >>
> >>Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >>---
> >>  drivers/input/misc/xen-kbdfront.c | 21 ++++++++++-----------
> >>  1 file changed, 10 insertions(+), 11 deletions(-)
> >>
> >>diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> >>index 8266ef948a06..273d786a19cd 100644
> >>--- a/drivers/input/misc/xen-kbdfront.c
> >>+++ b/drivers/input/misc/xen-kbdfront.c
> >>@@ -51,12 +51,6 @@ module_param_array(ptr_size, int, NULL, 0444);
> >>  MODULE_PARM_DESC(ptr_size,
> >>  	"Pointing device width, height in pixels (default 800,600)");
> >>-enum { KPARAM_MT_X, KPARAM_MT_Y, KPARAM_MT_CNT };
> >>-static int mtouch_size[KPARAM_MT_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
> >>-module_param_array(mtouch_size, int, NULL, 0444);
> >>-MODULE_PARM_DESC(ptr_size,
> >>-	"Multi-touch device width, height in pixels (default 800,600)");
> >>-
> >>  static int xenkbd_remove(struct xenbus_device *);
> >>  static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
> >>  static void xenkbd_disconnect_backend(struct xenkbd_info *);
> >>@@ -114,8 +108,8 @@ static irqreturn_t input_handler(int rq, void *dev_id)
> >>  			dev = info->mtouch;
> >>  			if (unlikely(!dev))
> >>  				break;
> >>-			if (unlikely(event->mtouch.contact_id !=
> >>-					info->mtouch_cur_contact_id)) {
> >>+			if (event->mtouch.contact_id !=
> >>+					info->mtouch_cur_contact_id) {
> >>  				info->mtouch_cur_contact_id =
> >>  					event->mtouch.contact_id;
> >>  				input_mt_slot(dev, event->mtouch.contact_id);
> >>@@ -327,10 +321,15 @@ static int xenkbd_probe(struct xenbus_device *dev,
> >>  		input_set_abs_params(mtouch, ABS_MT_PRESSURE,
> >>  				     0, 255, 0, 0);
> >>-		input_mt_init_slots(mtouch, num_cont, 0);
> >>+		ret = input_mt_init_slots(mtouch, num_cont,
> >>+				INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> >>+		if (ret) {
> >>+			input_free_device(mtouch);
> >>+			xenbus_dev_fatal(info->xbdev, ret,
> >>+					 "input_mt_init_slots");
> >>+			goto error;
> >>+		}
> >>-		mtouch_size[KPARAM_MT_X] = width;
> >>-		mtouch_size[KPARAM_MT_Y] = height;
> >>  		info->mtouch_cur_contact_id = -1;
> >>  		ret = input_register_device(mtouch);
> >>-- 
> >>2.7.4
> >>
> >
> Thank you,
> Oleksandr

-- 
Dmitry
