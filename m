From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: power_supply: Change ownership from driver to core
Date: Mon, 23 Mar 2015 17:54:33 +0300
Message-ID: <20150323145433.GA1609@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26157 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbCWOyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 10:54:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: k.kozlowski@samsung.com
Cc: linux-input@vger.kernel.org

Hello Krzysztof Kozlowski,

The patch 297d716f6260: "power_supply: Change ownership from driver
to core" from Mar 12, 2015, leads to the following static checker
warning:

	drivers/hid/hid-input.c:457 hidinput_setup_battery()
	error: potential NULL dereference 'dev->battery'.

drivers/hid/hid-input.c
   448          dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
   449          if (IS_ERR(dev->battery)) {
   450                  hid_warn(dev, "can't register power supply: %ld\n",
   451                                  PTR_ERR(dev->battery));
   452                  kfree(psy_desc->name);
   453                  kfree(psy_desc);
   454                  dev->battery = NULL;

Set to NULL.

   455          }
   456  
   457          power_supply_powers(dev->battery, &dev->dev);

Dereferenced inside function call.

   458  
   459  out:
   460          return true;
   461  }

regards,
dan carpenter
