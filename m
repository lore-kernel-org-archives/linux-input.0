From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v7] input: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Tue, 10 Apr 2012 21:23:35 +0200
Message-ID: <1334085815.6046.9.camel@flow>
References: <1333890051.55712.YahooMailClassic@web29020.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59631 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758740Ab2DJTXl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Apr 2012 15:23:41 -0400
Received: by bkcik5 with SMTP id ik5so109627bkc.19
        for <linux-input@vger.kernel.org>; Tue, 10 Apr 2012 12:23:40 -0700 (PDT)
In-Reply-To: <1333890051.55712.YahooMailClassic@web29020.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Am Sonntag, den 08.04.2012, 14:00 +0100 schrieb Paul Parsons:
> This driver adds support for the Synaptics NavPoint touchpad connected
> to a PXA27x SSP port in SPI slave mode. The driver implements a simple
> navigation pad. The four raised dots are mapped to UP/DOWN/LEFT/RIGHT
> buttons and the centre of the touchpad is mapped to the ENTER button.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> 
> V7:
> Separated arch/arm/mach-pxa/include/mach/mfp-pxa27x.h changes into a
> separate patch, to avoid crossing maintainer boundaries.
> This patch now submitted to linux-input instead of linux-arm-kernel.
> Improved dev_warn() messages.
> navpoint_hardint() now correctly returns IRQ_HANDLED in cases where
> reading SSDR does not return IRQ_WAKE_THREAD.
> Folded in "Input: navpoint: add clk_prepare/clk_unprepare calls" patch.
> Added calls to gpio_is_valid(), gpio_request(), gpio_direction_output().
> Rebased from linux-3.2 to linux-3.4-rc2.

Tested-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp


