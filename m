From: Oliver Neukum <oliver@neukum.org>
Subject: How to learn a device is open
Date: Wed, 25 Nov 2009 17:57:16 +0100
Message-ID: <200911251757.17009.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:50925 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758858AbZKYQ5M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 11:57:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,

I need a way to determine whether an input device has been opened.
A private flag seems wasteful. Is this an acceptable method?

	Regards
		Oliver

+static int usbtouch_resume(struct usb_interface *intf)
+{
+       struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+       struct input_dev *input = usbtouch->input;
+       int result = 0;
+
+       mutex_lock(&input->mutex);
+       if (input->users)
+               result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+       mutex_unlock(&input->mutex);
+       return result;
+}
