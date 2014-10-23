From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: add driver for Elan I2C/SMbus touchpad
Date: Thu, 23 Oct 2014 15:02:30 -0700
Message-ID: <20141023220230.GA9463@dtor-ws>
References: <20141023145813.GA20197@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:37490 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbaJWWCf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 18:02:35 -0400
Received: by mail-pd0-f175.google.com with SMTP id y13so240346pdi.20
        for <linux-input@vger.kernel.org>; Thu, 23 Oct 2014 15:02:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141023145813.GA20197@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: dusonlin@emc.com.tw, linux-input@vger.kernel.org

Hi Dan,

On Thu, Oct 23, 2014 at 05:58:13PM +0300, Dan Carpenter wrote:
> Hello Duson Lin,
> 
> The patch 29fbd64b0fd2: "Input: add driver for Elan I2C/SMbus
> touchpad" from Oct 3, 2014, leads to the following static checker
> warning:

Can you copy committer on such reports as well please?

> 
> 	drivers/input/mouse/elan_i2c_smbus.c:372 elan_smbus_prepare_fw_update()
> 	warn: sizeof(NUMBER)?
> 
> drivers/input/mouse/elan_i2c_smbus.c
>    365                  /*
>    366                   * Read back password to make sure we enabled flash
>    367                   * successfully.
>    368                   */
>    369                  len = i2c_smbus_read_block_data(client,
>    370                                                  ETP_SMBUS_IAP_PASSWORD_READ,
>    371                                                  val);
>    372                  if (len != sizeof(ETP_SMBUS_IAP_PASSWORD)) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> sizeof(int) is 4.
> val is a 3 byte array.
> If we read 4 bytes then we are writing beyond the end of the val[]
> array.

We should be checking sizeof(u16) here, I'll fix it up.

Thanks.

-- 
Dmitry
