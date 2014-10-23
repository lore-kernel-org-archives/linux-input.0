From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: add driver for Elan I2C/SMbus touchpad
Date: Thu, 23 Oct 2014 17:58:13 +0300
Message-ID: <20141023145813.GA20197@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24222 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbaJWO6l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 10:58:41 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dusonlin@emc.com.tw
Cc: linux-input@vger.kernel.org

Hello Duson Lin,

The patch 29fbd64b0fd2: "Input: add driver for Elan I2C/SMbus
touchpad" from Oct 3, 2014, leads to the following static checker
warning:

	drivers/input/mouse/elan_i2c_smbus.c:372 elan_smbus_prepare_fw_update()
	warn: sizeof(NUMBER)?

drivers/input/mouse/elan_i2c_smbus.c
   365                  /*
   366                   * Read back password to make sure we enabled flash
   367                   * successfully.
   368                   */
   369                  len = i2c_smbus_read_block_data(client,
   370                                                  ETP_SMBUS_IAP_PASSWORD_READ,
   371                                                  val);
   372                  if (len != sizeof(ETP_SMBUS_IAP_PASSWORD)) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
sizeof(int) is 4.
val is a 3 byte array.
If we read 4 bytes then we are writing beyond the end of the val[]
array.

   373                          error = len < 0 ? len : -EIO;
   374                          dev_err(dev, "failed to read iap password: %d\n",
   375                                  error);
   376                          return error;
   377                  }
   378  
   379                  password = be16_to_cpup((__be16 *)val);
   380                  if (password != ETP_SMBUS_IAP_PASSWORD) {
   381                          dev_err(dev, "wrong iap password = 0x%X\n", password);
   382                          return -EIO;
   383                  }

regards,
dan carpenter
