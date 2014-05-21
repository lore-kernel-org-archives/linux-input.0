From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: atmel_mxt_ts - read and report bootloader version
Date: Wed, 21 May 2014 15:26:24 +0300
Message-ID: <20140521122624.GB23396@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18532 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbaEUM0c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 08:26:32 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nick.dyer@itdev.co.uk
Cc: linux-input@vger.kernel.org

Hello Nick Dyer,

The patch e57a66aa8534: "Input: atmel_mxt_ts - read and report
bootloader version" from May 18, 2014, leads to the following static
checker warning:

	drivers/input/touchscreen/atmel_mxt_ts.c:437 mxt_get_bootloader_version()
	warn: signedness bug returning '(-5)'

drivers/input/touchscreen/atmel_mxt_ts.c
   429  static u8 mxt_get_bootloader_version(struct mxt_data *data, u8 val)
   430  {
   431          struct device *dev = &data->client->dev;
   432          u8 buf[3];
   433  
   434          if (val & MXT_BOOT_EXTENDED_ID) {
   435                  if (mxt_bootloader_read(data, &buf[0], 3) != 0) {
   436                          dev_err(dev, "%s: i2c failure\n", __func__);
   437                          return -EIO;
                                       ^^^^
This gets truncated into a number from 0-255 and anyway the caller
doesn't check for errors.

   438                  }
   439  
   440                  dev_dbg(dev, "Bootloader ID:%d Version:%d\n", buf[1], buf[2]);
   441  
   442                  return buf[0];
   443          } else {
   444                  dev_dbg(dev, "Bootloader ID:%d\n", val & MXT_BOOT_ID_MASK);
   445  
   446                  return val;
   447          }
   448  }

regards,
dan carpenter
