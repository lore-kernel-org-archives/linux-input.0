From: Vladis Dronov <vdronov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Input: ati_remote2: fix crashes on detecting device with invalid descriptor
Date: Wed, 23 Mar 2016 16:53:07 +0100
Message-ID: <1458748387-17351-1-git-send-email-vdronov@redhat.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vladis Dronov <vdronov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The ati_remote2 driver expects at least two interfaces with one
endpoint each. If given malicious descriptor that specify one
interface or no endpoints, it will crash in the probe function.
Ensure there is at least two interfaces and one endpoint for each
interface before using it.

The full disclosure: http://seclists.org/bugtraq/2016/Mar/90

Reported-by: Ralf Spenneberg <ralf-bSzMNvQHHtybz89kn3q7ow@public.gmane.org>
Signed-off-by: Vladis Dronov <vdronov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
please, note: usb_driver_claim_interface() patch (0b818e3956) is
not sufficient to cover all cases when this can crash.

 drivers/input/misc/ati_remote2.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index cfd58e8..cf5d1e8 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -817,26 +817,49 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 
 	ar2->udev = udev;
 
+	/* Sanity check, first interface must have an endpoint */
+	if ((alt->desc.bNumEndpoints < 1) || !alt->endpoint) {
+		dev_err(&interface->dev,
+			"%s(): interface 0 must have an endpoint\n", __func__);
+		r = -ENODEV;
+		goto fail1;
+	}
 	ar2->intf[0] = interface;
 	ar2->ep[0] = &alt->endpoint[0].desc;
 
+	/* Sanity check, the device must have two interfaces */
 	ar2->intf[1] = usb_ifnum_to_if(udev, 1);
+	if ((udev->actconfig->desc.bNumInterfaces < 2) || !ar2->intf[1]) {
+		dev_err(&interface->dev, "%s(): need 2 interfaces, found %d\n",
+			__func__, udev->actconfig->desc.bNumInterfaces);
+		r = -ENODEV;
+		goto fail1;
+	}
+
 	r = usb_driver_claim_interface(&ati_remote2_driver, ar2->intf[1], ar2);
 	if (r)
 		goto fail1;
+
+	/* Sanity check, second interface must have an endpoint */
 	alt = ar2->intf[1]->cur_altsetting;
+	if ((alt->desc.bNumEndpoints < 1) || !alt->endpoint) {
+		dev_err(&interface->dev,
+			"%s(): interface 1 must have an endpoint\n", __func__);
+		r = -ENODEV;
+		goto fail2;
+	}
 	ar2->ep[1] = &alt->endpoint[0].desc;
 
 	r = ati_remote2_urb_init(ar2);
 	if (r)
-		goto fail2;
+		goto fail3;
 
 	ar2->channel_mask = channel_mask;
 	ar2->mode_mask = mode_mask;
 
 	r = ati_remote2_setup(ar2, ar2->channel_mask);
 	if (r)
-		goto fail2;
+		goto fail3;
 
 	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
 	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
@@ -845,11 +868,11 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 
 	r = sysfs_create_group(&udev->dev.kobj, &ati_remote2_attr_group);
 	if (r)
-		goto fail2;
+		goto fail3;
 
 	r = ati_remote2_input_init(ar2);
 	if (r)
-		goto fail3;
+		goto fail4;
 
 	usb_set_intfdata(interface, ar2);
 
@@ -857,10 +880,11 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 
 	return 0;
 
- fail3:
+ fail4:
 	sysfs_remove_group(&udev->dev.kobj, &ati_remote2_attr_group);
- fail2:
+ fail3:
 	ati_remote2_urb_cleanup(ar2);
+ fail2:
 	usb_driver_release_interface(&ati_remote2_driver, ar2->intf[1]);
  fail1:
 	kfree(ar2);
-- 
2.5.5
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
