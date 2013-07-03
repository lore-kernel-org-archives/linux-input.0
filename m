From: Ferruh Yigit <fery@cypress.com>
Subject: Re: Input: cyttsp4 - SPI driver for Cypress TMA4XX touchscreen devices
Date: Wed, 3 Jul 2013 16:24:18 +0300
Message-ID: <51D42602.5030001@cypress.com>
References: <20130702214731.GD1598@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay-s04-hub002.domainlocalhost.com ([74.115.207.101]:15413
	"EHLO relay-S04-HUB002.domainlocalhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301Ab3GCNYZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jul 2013 09:24:25 -0400
In-Reply-To: <20130702214731.GD1598@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

On 07/03/2013 12:47 AM, Dan Carpenter wrote:
> Hello Ferruh Yigit,
>
> The patch 67bf12ca50d5: "Input: cyttsp4 - SPI driver for Cypress
> TMA4XX touchscreen devices" from Jun 30, 2013, leads to the following
> Smatch warning:
> "drivers/input/touchscreen/cyttsp4_spi.c:66 cyttsp_spi_xfer()
>        warn: impossible condition '(reg > 255) => (0-255 > 255)'"
>
> drivers/input/touchscreen/cyttsp4_spi.c
>      66          if (reg > 255)
>                      ^^^^^^^^^
> "reg" is unsigned char so 255 is the max it can be.
>      67                  wr_buf[0] = op + CY_SPI_A8_BIT;
>      68          else
>      69                  wr_buf[0] = op;
>
> regards,
> dan carpenter
>
Hi Dan,

Shortly, check is correct and address should be 16 bit, parameter size
is wrong.

In TSG4, register map is 512bytes long and to access all of it, one bit
from address byte is used (which bit to use differs for I2C and SPI),
the code you marked is doing that check.

Since common code used TSG3 and TSG4 for I2C, this parameter wrongly
used as u8. TSG3 does not access beyond 255 bytes but TSG4 may.

I have a patch for this, but should I create it against previous patch I
have sent or against latest next tree?

--

Thanks,
ferruh

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
