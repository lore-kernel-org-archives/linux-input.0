From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 09/12] input: matrix-keypad: add binary column encoding
Date: Fri, 21 Jun 2013 15:58:14 -0600
Message-ID: <51C4CC76.70501@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-10-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36647 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946161Ab3FUV6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 17:58:18 -0400
In-Reply-To: <1371838198-7327-10-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> introduce support to optionally run a binary column address bit pattern
> on column GPIO pins in contrast to the formerly assumed one-out-of-N approach

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +The driver assumes that each row and column line of the keypad matrix is

Here, I would definitely:

s/The driver/This binding/.

> +connected to a specific GPIO pin.  Alternatively column addresses can get
> +encoded in binary form to reduce the number of GPIO pins involved, at the
> +cost of adding an external decoder which translates the binary pattern of N
> +GPIO coloumn pins into one of 2**N column lines of the matrix.  A mere

s/coloumn/column/

> +circuit of two inverting open collector drivers in series connected to one
> +output pin is a special case of this generic decoder approach.  Such a
> +decoder may be desirable since it's cheap and protects the SoC from damage
> +by unwanted interaction of signals when any combination of multiple keys
> +gets pressed, regardless of the software's operating the column GPIO pins.
> +The row GPIO pins won't interfere either since they all are inputs.

I'm not sure it's worth mentioning that; it presumably makes no semantic
difference to how SW interfaces to the HW this binding describes.

> +- col-gpios-binary:	boolean, switches from the 'one GPIO pin for each
> +			column' approach to the 'n GPIO pins to address
> +			2**n columns' approach (binary encoding of column
> +			addresses in contrast to a one-out-of-many pattern
> +			for the column GPIO pins)

Thinking about the keypad,num-rows/keypad,num-columns properties from
the previous patch, "num" might not be enough to describe all HW. "num"
assumes that the decoder outputs 0..num-1 are used and that num..N-1 are
not. What if the unused decoder outputs are 0..(N-num-1)? Instead, it
may be better to define a property col-values-mask, with one bit set for
each valid/useful integer value to be output on the column GPIOs?

BTW, I think some of the new properties in either/both these patches and
the original matrix-keypad binding doc are prefixed with "keypad," and
some not. It would be best to be consistent. Given these properties are
specific to this one binding, rather than some kind of generic
infra-structure, having the prefix on as many properties as possible
seems correct to me.
