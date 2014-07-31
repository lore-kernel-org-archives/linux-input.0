From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: HID: huion: Switch to generating report descriptor
Date: Thu, 31 Jul 2014 12:40:12 +0300
Message-ID: <20140731094012.GH30276@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18812 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJlB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 05:41:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: spbnick@gmail.com
Cc: linux-input@vger.kernel.org

Hello Nikolai Kondrashov,

The patch f8dd5cb2c6d0: "HID: huion: Switch to generating report
descriptor" from Jul 23, 2014, leads to the following static checker
warning:

	drivers/hid/hid-huion.c:126 huion_tablet_enable()
	error: doing dma on the stack (buf)

drivers/hid/hid-huion.c
   113  static int huion_tablet_enable(struct hid_device *hdev)
   114  {
   115          int rc;
   116          struct usb_device *usb_dev = hid_to_usb_dev(hdev);
   117          struct huion_drvdata *drvdata = hid_get_drvdata(hdev);
   118          __le16 buf[6];
   119  
   120          /*
   121           * Read string descriptor containing tablet parameters. The specific
   122           * string descriptor and data were discovered by sniffing the Windows
   123           * driver traffic.
   124           * NOTE: This enables fully-functional tablet mode.
   125           */
   126          rc = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
   127                                  USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
   128                                  (USB_DT_STRING << 8) + 0x64,
   129                                  0x0409, buf, sizeof(buf),
                                                ^^^
   130                                  USB_CTRL_GET_TIMEOUT);

regards,
dan carpenter
