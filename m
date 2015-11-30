From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Mon, 30 Nov 2015 11:40:17 -0800
Message-ID: <20151130194017.GA14889@dtor-ws>
References: <689469584.28015553.1448887007112.JavaMail.zimbra@redhat.com>
 <Pine.LNX.4.44L0.1511301046070.1938-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33350 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbK3TkV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 14:40:21 -0500
Received: by pabfh17 with SMTP id fh17so200001756pab.0
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 11:40:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1511301046070.1938-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Vladis Dronov <vdronov@redhat.com>, linux-input@vger.kernel.org

On Mon, Nov 30, 2015 at 11:06:30AM -0500, Alan Stern wrote:
> On Mon, 30 Nov 2015, Vladis Dronov wrote:
> 
> > Hello, Alan, all.
> 
> Hello.
> 
> > > > Yes for the normal USB device. This case is a weird USB device (with no
> > > > endpoints) specially designed to be weird. My point here is that even a
> > > > weird device probing should not crash a kernel by a NULL-deref.
> > > 
> > > True.  However, a weird device that didn't have any endpoint 0 would
> > > not crash the kernel, because the kernel wouldn't be able to
> > > communicate with it at all.
> > 
> > I'm afraid, I do not get you here. A device in question _does_ crash the kernel
> > (or driver only) as this call trace shows (see attached for the full call trace),
> > and that's why the patch is proposed:
> > 
> > [  622.444650] BUG: unable to handle kernel NULL pointer dereference at 0000000000000002
> > [  622.445019] IP: [<ffffffffa0395303>] aiptek_probe+0x463/0x658 [aiptek]
> > [  622.445019] RIP: 0010:[<ffffffffa0395303>] aiptek_probe+0x463/0x658 [aiptek]
> > [  622.445019] RAX: 0000000000000000 RBX: ffff88000bd67800 RCX: ffff88000bcd0800
> >                         ^^^ rax is NULL, it is being dereferenced
> 
> This is the result of a bug in the aiptek driver.  See below.
> 
> > Kernel does not communicates with the device,
> 
> Yes it does.  Otherwise how would the kernel know that the aiptek
> driver was the one which should be probed for this device?
> 
> >  but the driver tries to access
> > a kernel structure, which was not allocated (thus, a null-deref):
> > 
> > endpoint = &intf->altsetting[0].endpoint[0].desc; // the structure endpoint[0]
> >                                              // was not kzalloc()ed, thus NULL
> > usb_rcvintpipe(aiptek->usbdev, endpoint->bEndpointAddress) // NULL deref
> 
> Right.  That's the bug; aiptek should not try to access a data 
> structure that was never allocated.
> 
> > > Drivers do not have to check whether endpoint 0 exists; it always does.  
> > > But they do have to check any other endpoint they use.
> > 
> > As the above example shows, endpoint 0 does not always exists. A specially
> > crafted weird USB device can advertise absence of endpoint 0 and the kernel
> > will accept this:
> 
> The example above has nothing to do with endpoint 0.  The entries in
> the altsetting[n].endpoint array are not stored in numerical order;  
> entry 0 in this array does not refer to endpoint 0.  (See the comment
> for the endpoint field in the definition of struct usb_host_interface
> in include/linux/usb.h.)  In fact, endpoint 0 is treated specially and
> isn't part of this array at all.
> 
> > [drivers/usb/core/config.c]
> > num_ep = num_ep_orig = alt->desc.bNumEndpoints;  // weird device can have 0 here
> > alt->desc.bNumEndpoints = 0;
> > if (num_ep > 0) {
> >         /* Can't allocate 0 bytes */
> >         len = sizeof(struct usb_host_endpoint) * num_ep;
> >         alt->endpoint = kzalloc(len, GFP_KERNEL);
> > 
> > As far as I understand, this is a question we discuss here: whose responsibility
> > is to handle situations of endpoint 0 absence in an altconfig?
> 
> num_ep counts the number of endpoints _other_ than endpoint 0.  
> There's no point counting endpoint 0 because it is always present.  
> Not to mention that it doesn't get stored in this array, since endpoint
> 0 has no descriptor.
> 
> > - if it is driver's job, a driver much check this, as in the patch I propose
> > 
> > - if it is a kernel job not to allow devices with no endpoint 0 in one the
> > configurations, the current USB device detection implementation (in
> > drivers/usb/core/config.c) should be modified, as currently it allows such.
> > 
> > I do not have much expertise in the Linux USB stack, so I'm asking you and
> > the community for an advise on this.
> 
> My advice is to fix aiptek's probe routine.  It should check that 
> intf->altsetting[0].desc.bNumEndpoints > 0 before trying to accessing 
> the endpoint array.
> 
> > > > btw, indeed, this is not the only driver with this problem, I've met 2 more.
> > > 
> > > In fact, there's no way to check whether endpoint 0 exists.  Where 
> > > would you look to find out?  There isn't any endpoint descriptor for it.
> > 
> > I believe, there is a configuration descriptor for that, probably, I'm wrong:
> > 
> > if (intf->altsetting[0].desc.bNumEndpoints < 1) { ...
> 
> That value is the number of endpoints _other_ than endpoint 0.  This is 
> documented in the USB-2.0 specification, Table 9-12.

How about we do something like below?

Thanks.

-- 
Dmitry

usb: interface: allow drivers declare number of endpoints they need

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

USB interface drivers need to check number of endpoints before trying to
access/use them. Quite a few drivers only use the default setting
(altsetting 0), so let's allow them to declare number of endpoints in
altsetting 0 they require to operate and have USB core check it for us
instead of having every driver implement check manually.

For compatibility, if driver does not specify number of endpoints (i.e.
number of endpoints is left at 0) we bypass the check in USB core and
expect the driver perform necessary checks on its own.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/core/driver.c |    9 +++++++++
 include/linux/usb.h       |    7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 6b5063e..d9f680d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -306,6 +306,15 @@ static int usb_probe_interface(struct device *dev)
 
 	dev_dbg(dev, "%s - got id\n", __func__);
 
+	if (driver->num_endpoints &&
+	    intf->altsetting[0].desc.bNumEndpoints < driver->num_endpoints) {
+
+		dev_err(dev, "Not enough endpoints %d (want %d)\n",
+			intf->altsetting[0].desc.bNumEndpoints,
+			driver->num_endpoints);
+		return -EINVAL;
+	}
+
 	error = usb_autoresume_device(udev);
 	if (error)
 		return error;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 447fe29..93f8dfc 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1051,6 +1051,11 @@ struct usbdrv_wrap {
  * @id_table: USB drivers use ID table to support hotplugging.
  *	Export this with MODULE_DEVICE_TABLE(usb,...).  This must be set
  *	or your driver's probe function will never get called.
+ * @num_endpoints: Number of endpoints that should be present in default
+ *	setting (altsetting 0) the driver needs to operate properly.
+ *	The probe will be aborted if actual number of endpoints is less
+ *	than what the driver specified here. 0 means no check should be
+ *	performed.
  * @dynids: used internally to hold the list of dynamically added device
  *	ids for this driver.
  * @drvwrap: Driver-model core structure wrapper.
@@ -1099,6 +1104,8 @@ struct usb_driver {
 
 	const struct usb_device_id *id_table;
 
+	unsigned int num_endpoints;
+
 	struct usb_dynids dynids;
 	struct usbdrv_wrap drvwrap;
 	unsigned int no_dynamic_id:1;
