From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: HID: hid-multitouch: Switch to device groups
Date: Wed, 8 Aug 2012 16:44:08 +0300
Message-ID: <20120808134408.GA25857@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:21446 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2HHNoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 09:44:21 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se
Cc: linux-input@vger.kernel.org

Hello Henrik Rydberg,

This is a semi-automatic email about new static checker warnings.

The patch 4fa3a5837b84: "HID: hid-multitouch: Switch to device 
groups" from May 1, 2012, leads to the following Smatch complaint:

drivers/hid/hid-multitouch.c:735 mt_probe()
	 error: we previously assumed 'id' could be null (see line 694)

drivers/hid/hid-multitouch.c
   693	
   694		if (id) {
                   ^^^^
Old check.

   695			for (i = 0; mt_classes[i].name ; i++) {
   696				if (id->driver_data == mt_classes[i].name) {
   697					mtclass = &(mt_classes[i]);
   698					break;
   699				}
   700			}
   701		}
   702	

[snip]

   733		mt_post_parse(td);
   734	
   735		if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
                    ^^^^^^^^^^
New dereference removed a check.

   736			mt_post_parse_default_settings(td);
   737	

regards,
dan carpenter

