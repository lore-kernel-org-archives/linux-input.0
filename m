From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: cyttsp4 - SPI driver for Cypress TMA4XX touchscreen
 devices
Date: Wed, 3 Jul 2013 00:47:31 +0300
Message-ID: <20130702214731.GD1598@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33709 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab3GBVra (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jul 2013 17:47:30 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: fery@cypress.com
Cc: linux-input@vger.kernel.org

Hello Ferruh Yigit,

The patch 67bf12ca50d5: "Input: cyttsp4 - SPI driver for Cypress
TMA4XX touchscreen devices" from Jun 30, 2013, leads to the following
Smatch warning:
"drivers/input/touchscreen/cyttsp4_spi.c:66 cyttsp_spi_xfer()
	 warn: impossible condition '(reg > 255) => (0-255 > 255)'"

drivers/input/touchscreen/cyttsp4_spi.c
    66          if (reg > 255)
                    ^^^^^^^^^
"reg" is unsigned char so 255 is the max it can be.
    67                  wr_buf[0] = op + CY_SPI_A8_BIT;
    68          else
    69                  wr_buf[0] = op;

regards,
dan carpenter

