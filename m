From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 V3] mfd: add STMPE811 core support
Date: Tue, 15 Jun 2010 15:59:29 +0100
Message-ID: <20100615145929.GI14510@rakim.wolfsonmicro.main>
References: <1276511558-27121-1-git-send-email-l.fu@pengutronix.de>
 <1276592446-26909-2-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34522 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753481Ab0FOO7c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 10:59:32 -0400
Content-Disposition: inline
In-Reply-To: <1276592446-26909-2-git-send-email-l.fu@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luotao Fu <l.fu@pengutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 15, 2010 at 11:00:44AM +0200, Luotao Fu wrote:
> STMPE811 is a multifunction device, which contains a GPIO controller, a
> Touchscreen controller, an ADC and a temperature sensor. This patch adds a core
> driver for this device. The driver provides core functionalities like accessing
> the registers and management of subdevices. The device supports communication
> through SPI and I2C interface. Currently we only support I2C.
> 
> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
> Acked-by: Jonathan Cameron<jic23@cam.ac.uk>

Looks good.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
