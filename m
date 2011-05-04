From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: ads7846: ads7846_read12_ser is not DMA save
Date: Wed, 4 May 2011 15:17:18 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com>
References: <201105041602.03542.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:31290
	"EHLO CH1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752556Ab1EDOR2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 May 2011 10:17:28 -0400
Received: from mail20-ch1 (localhost.localdomain [127.0.0.1])	by
 mail20-ch1-R.bigfish.com (Postfix) with ESMTP id 2AC452F8200	for
 <linux-input@vger.kernel.org>; Wed,  4 May 2011 14:17:27 +0000 (UTC)
Received: from CH1EHSMHS011.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.244])	by mail20-ch1.bigfish.com (Postfix) with ESMTP id D62B8B3004C
	for <linux-input@vger.kernel.org>; Wed,  4 May 2011 14:17:26 +0000 (UTC)
In-Reply-To: <201105041602.03542.alexander.stein@systec-electronic.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Alexander Stein wrote on 2011-05-04:
> Hello,
>
> I just encountered a problem on my ARMv5 (AT91SAM9263 based) board
> while using
> ads7843 or ads7846 (I replaced it). I tried reading
> /sys/class/hwmon/hwmon0/device/in0_input and got 0 most of the time.
> Sometimes the correct voltage was shown.
> After digging a bit in the code I found out that sample (and command
> for Tx) from the following struct gets DMA mapped by the underlying
> atmel_spi driver for SPI Rx-Buffer.
>
> struct ser_req {
>       u8                      ref_on;
>       u8                      command;
>       u8                      ref_off;
>       u16                     scratch;
>       __be16                  sample;
>       struct spi_message      msg;
>       struct spi_transfer     xfer[6];
> };
>
> The atmel_spi driver does proper dma_{,un}map_signgle on the Rx and Tx
> buffers. Now when the cache line for scratch is cleared and
> invalidated and the spi subsystem access msg (and maybe xfer) the
> cache line gets filled again, rendering the cache clear and
> invalidation before as useless.
> As the ARMv5 core has 32Byte cache lines I added "char dummy[25];"
> after sample, so the spi structs are in a different cache line.
> But this seem only to be a workaround as the cache lines might differ
> across each CPU.
> Somebody an idea how to fix this in general?

Take a look at the AD7877 Touchscreen driver.
To work around the same issue we use ____cacheline_aligned

        /*
         * DMA (thus cache coherency maintenance) requires the
         * transfer buffers to live in their own cache lines.
         */
        u16 conversion_data[AD7877_NR_SENSE] ____cacheline_aligned;

Alternatively you can kmalloc the transfer buffers.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


