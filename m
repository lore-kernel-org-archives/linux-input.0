From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: atmel_mxt_ts - initialise IRQ before probing
Date: Fri, 25 Jul 2014 15:20:21 +0300
Message-ID: <20140725122021.GA528@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35454 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760134AbaGYMUo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2014 08:20:44 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Hello Nick Dyer,

The patch dd24dcf566d0: "Input: atmel_mxt_ts - initialise IRQ before
probing" from Jul 23, 2014, leads to the following static checker
warning:

drivers/input/touchscreen/atmel_mxt_ts.c:1701 mxt_initialize()
	 warn: we tested 'error' before and it was 'false'

drivers/input/touchscreen/atmel_mxt_ts.c
  1693          /* Get object table information */
  1694          error = mxt_get_object_table(data);
  1695          if (error) {
  1696                  dev_err(&client->dev, "Error %d reading object table\n", error);
  1697                  return error;
  1698          }
  1699  
  1700          mxt_acquire_irq(data);

Probably error = mxt_acquire_irq(data) was intended here?

  1701          if (error)
  1702                  goto err_free_object_table;
  1703  
  1704          request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
  1705                                  &data->client->dev, GFP_KERNEL, data,
  1706                                  mxt_config_cb);
  1707  
  1708          return 0;
  1709  
  1710  err_free_object_table:
  1711          mxt_free_object_table(data);
  1712          return error;
  1713  }

regards,
dan carpenter
