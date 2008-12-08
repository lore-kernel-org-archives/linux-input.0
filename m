From: Jean Delvare <khali@linux-fr.org>
Subject: Re: + input-add-tsc2007-based-touchscreen-driver.patch added to -mm
 tree
Date: Mon, 8 Dec 2008 09:46:01 +0100
Message-ID: <20081208094601.272dfb8f@hyperion.delvare>
References: <200812070027.mB70R361001860@imap1.linux-foundation.org>
	<483a38b80812072135iefd5390q82ce022359401451@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:12863 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbYLHIqP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2008 03:46:15 -0500
In-Reply-To: <483a38b80812072135iefd5390q82ce022359401451@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, mm-commits@vger.kernel.org, dtor@mail.ru, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Trilok Soni <soni.trilok@gmail.com>

On Mon, 8 Dec 2008 14:35:59 +0900, Kwangwoo Lee wrote:
> From d5258e21e38e38e4128112844f24621ffb1c1e86 Mon Sep 17 00:00:00 2001
> From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> Date: Mon, 8 Dec 2008 13:42:14 +0900
> Subject: [PATCH] Add tsc2007 based touchscreen driver.
> 
> corrected some parts following in helpful comments:
> Remove unnecessary headers and variables.
> Use i2c_smbus_read_word_data() to prevent race condition.
> Fix i2c_check_functionality() argument correctly.
> 
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>

Looks much better, thanks. Just one thing:

> +static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
> +{
> +	s32 data;
> +	u16 val;
> +
> +	data = i2c_smbus_read_word_data(tsc->client, cmd);
> +	if (data < 0) {
> +		dev_err(&tsc->client->dev, "i2c io error: %d\n", data);
> +		return data;
> +	}
> +
> +	/* The protocol and raw data format from i2c interface:
> +	 * S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA P
> +	 * Where DataLow has [D11-D4], DataHigh has [D3-D0 << 4 | Dummy 4bit].
> +	 */
> +
> +	val = (u16) (data & 0xFFFF);

These masking and cast are unnecessary. i2c_smbus_read_word_data()
returns a 16-bit value already.

> +	val = be16_to_cpu(val) >> 4;

I don't think this is correct. The SMBus read word protocol says that
the LSB goes first on the wire. If your chip sends the MSB first (and
in fast almost all I2C/SMBus chips I know, do that) then you need to
swap the bytes in the driver, but this must be done independently of
the CPU endianness! This means that you should use swab16() rather than
be16_to_cpu().

So I believe that what you really want is:

#include <linux/swab.h>

	val = swab16(data) >> 4;

> +
> +	dev_dbg(&tsc->client->dev, "data: 0x%x, val: 0x%x\n", data, val);
> +
> +	return val;
> +}

The rest looks OK.

-- 
Jean Delvare
