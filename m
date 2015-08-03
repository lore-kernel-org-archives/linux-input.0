From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Subject: Re: [PATCHv v2] Input: zforce - make the interrupt GPIO optional
Date: Mon, 03 Aug 2015 09:54:49 +0200
Message-ID: <1763405.uXNYd4iq17@diego>
References: <1438583646-14022-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:56417 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbHCHyw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Aug 2015 03:54:52 -0400
In-Reply-To: <1438583646-14022-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Dirk,

Am Montag, 3. August 2015, 08:34:06 schrieb Dirk Behme:
> Add support for hardware which uses an I2C Serializer / Deserializer
> (SerDes) to communicate with the zFroce touch driver. In this case the
> SerDes will be configured as an interrupt controller and the zForce driver
> will have no access to poll the GPIO line.
> 
> To support this, we add two dedicated new GPIOs in the device tree:
> reset-gpio and irq-gpio. With the irq-gpio being optional, then.
> 
> To not break the existing device trees, the index based 'gpios' entries
> are still supported, but marked as deprecated.
> 
> With this, if the interrupt GPIO is available, either via the old or new
> device tree style, the while loop will read and handle the packets as long
> as the GPIO indicates that the interrupt is asserted (existing, unchanged
> driver behavior).
> 
> If the interrupt GPIO isn't available, i.e. not configured via the new
> device tree style, we are falling back to one read per ISR invocation
> (new behavior to support the SerDes).
> 
> Note that the gpiod functions help to handle the optional GPIO:
> devm_gpiod_get_index_optional() will return NULL in case the interrupt
> GPIO isn't available. And gpiod_get_value_cansleep() does cover this, too,
> by returning 0 in this case.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

looks nice now in v2, thanks :-)

Reviewed-by: Heiko Stuebner <heiko.stuebner@bq.com>

