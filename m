From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] HID: wacom: Introduce new 'touch_input' device
Date: Wed, 12 Apr 2017 23:31:23 +0300
Message-ID: <20170412203123.GA3915@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17235 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755177AbdDLUbc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 16:31:32 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: killertofu@gmail.com
Cc: linux-input@vger.kernel.org

Hello Jason Gerecke,

This is a semi-automatic email about new static checker warnings.

The patch 2a6cdbdd4cc0: "HID: wacom: Introduce new 'touch_input' 
device" from Jun 15, 2015, leads to the following Smatch complaint:

drivers/hid/wacom_wac.c:1586 wacom_tpc_irq()
	 error: we previously assumed 'wacom->touch_input' could be null (see line 1577)

drivers/hid/wacom_wac.c
  1576				"%s: received report #%d\n", __func__, data[0]);
  1577		else if (wacom->touch_input)
                         ^^^^^^^^^^^^^^^^^^
Patch adds new check for NULL.

  1578			dev_dbg(wacom->touch_input->dev.parent,
  1579				"%s: received report #%d\n", __func__, data[0]);
  1580	
  1581		switch (len) {
  1582		case WACOM_PKGLEN_TPC1FG:
  1583			return wacom_tpc_single_touch(wacom, len);
  1584	
  1585		case WACOM_PKGLEN_TPC2FG:
  1586			return wacom_tpc_mt_touch(wacom);
                                                  ^^^^^
Not checked inside this function call.

  1587	
  1588		case WACOM_PKGLEN_PENABLED:

regards,
dan carpenter
