From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Input: ad7879 - consolidate PM methods
Date: Tue, 15 Nov 2011 11:41:15 +0000
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E77CA17B@LIMKCMBX1.ad.analog.com>
References: <1321258891-10398-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:50714
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755103Ab1KOLlY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 06:41:24 -0500
In-Reply-To: <1321258891-10398-1-git-send-email-dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

Dmitry Torokhov wrote on 2011-11-14:
> The PM methods are basically the same for SPI and I2C busses, so let's
> use the same dev_pm_ops for both of them.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879-i2c.c |   26 +-----------------------

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


