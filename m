From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: disconnect in ati_remote2
Date: Wed, 2 Jul 2008 23:31:43 +0200
Message-ID: <200807022331.44288.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

this doesn't look quite right. Somebody might use sysfs or usbfs to
disconnect only one interface. In that case you should give up the other
interface, not depending on the first interface being disconnected.

	Regards
		Oliver

static void ati_remote2_disconnect(struct usb_interface *interface)
{
	struct ati_remote2 *ar2;
	struct usb_host_interface *alt = interface->cur_altsetting;

	if (alt->desc.bInterfaceNumber)
		return;

	ar2 = usb_get_intfdata(interface);
	usb_set_intfdata(interface, NULL);

	input_unregister_device(ar2->idev);

	ati_remote2_urb_cleanup(ar2);

	usb_driver_release_interface(&ati_remote2_driver, ar2->intf[1]);

	kfree(ar2);
}
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
