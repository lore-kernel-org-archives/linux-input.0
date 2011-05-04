From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: ads7846: ads7846_read12_ser is not DMA save
Date: Wed, 4 May 2011 16:02:03 +0200
Message-ID: <201105041602.03542.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:51748 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab1EDOCG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 10:02:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello,

I just encountered a problem on my ARMv5 (AT91SAM9263 based) board while using 
ads7843 or ads7846 (I replaced it). I tried reading 
/sys/class/hwmon/hwmon0/device/in0_input and got 0 most of the time. Sometimes 
the correct voltage was shown.
After digging a bit in the code I found out that sample (and command for Tx) 
from the following struct gets DMA mapped by the underlying atmel_spi driver 
for SPI Rx-Buffer.

struct ser_req {
	u8			ref_on;
	u8			command;
	u8			ref_off;
	u16			scratch;
	__be16			sample;
	struct spi_message	msg;
	struct spi_transfer	xfer[6];
};

The atmel_spi driver does proper dma_{,un}map_signgle on the Rx and Tx 
buffers. Now when the cache line for scratch is cleared and invalidated and 
the spi subsystem access msg (and maybe xfer) the cache line gets filled 
again, rendering the cache clear and invalidation before as useless.
As the ARMv5 core has 32Byte cache lines I added "char dummy[25];" after 
sample, so the spi structs are in a different cache line.
But this seem only to be a workaround as the cache lines might differ across 
each CPU.
Somebody an idea how to fix this in general?

Regards,
Alexander
