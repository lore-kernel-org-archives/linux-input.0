From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: HID: Introduce hidpp, a module to handle Logitech hid++ devices
Date: Fri, 31 Oct 2014 12:15:09 +0300
Message-ID: <20141031091509.GB11252@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40348 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbaJaJPW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 05:15:22 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org

Hello Benjamin Tissoires,

The patch 2f31c5252910: "HID: Introduce hidpp, a module to handle
Logitech hid++ devices" from Sep 30, 2014, leads to the following
static checker warning:

	drivers/hid/hid-logitech-hidpp.c:359 hidpp_root_get_protocol_version()
	warn: should this return really be negated?

drivers/hid/hid-logitech-hidpp.c
   342  static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
   343  {
   344          struct hidpp_report response;
   345          int ret;
   346  
   347          ret = hidpp_send_fap_command_sync(hidpp,
   348                          HIDPP_PAGE_ROOT_IDX,
   349                          CMD_ROOT_GET_PROTOCOL_VERSION,
   350                          NULL, 0, &response);
   351  
   352          if (ret == 1) {
                    ^^^^^^^^
What does the "1" mean?  Magic numbers are bad, yada yada yada.

   353                  hidpp->protocol_major = 1;
   354                  hidpp->protocol_minor = 0;
   355                  return 0;
   356          }
   357  
   358          if (ret)
   359                  return -ret;
                        ^^^^^^^^^^^
This is wrong.  The real problem is that hidpp_send_fap_command_sync()
mixes normal and custom error codes.  The callers are inconsistent in
how they deal with it.

   360  
   361          hidpp->protocol_major = response.fap.params[0];
   362          hidpp->protocol_minor = response.fap.params[1];
   363  
   364          return ret;
   365  }

See also:

drivers/hid/hid-logitech-hidpp.c:398 hidpp_devicenametype_get_count() warn: should this return really be negated?
drivers/hid/hid-logitech-hidpp.c:417 hidpp_devicenametype_get_device_name() warn: should this return really be negated?
drivers/hid/hid-logitech-hidpp.c:524 hidpp_touchpad_get_raw_info() warn: should this return really be negated?

regards,
dan carpenter
