From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Mon, 15 Aug 2011 10:49:44 +0100 (BST)
Message-ID: <1313401784.93192.YahooMailClassic@web29015.mail.ird.yahoo.com>
References: <CAMPhdO8WOsnbCvqGGYqnCMiw71esp-OqXryXAS4Xeb0id2DG2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm12.bullet.mail.ird.yahoo.com ([77.238.189.65]:29228 "HELO
	nm12.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751406Ab1HOJtp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 05:49:45 -0400
In-Reply-To: <CAMPhdO8WOsnbCvqGGYqnCMiw71esp-OqXryXAS4Xeb0id2DG2g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, philipp.zabel@gmail.com, mad_soft@inbox.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--- On Mon, 15/8/11, Eric Miao <eric.y.miao@gmail.com> wrote:
> > MFP_CFG_OUT(GPIO102, ...) had already moved from the
> patch v1 platform file to patch v2 mfp-pxa27x.h because it
> was suggested that MFP macros should not be used directly.
> > Changing the direction in the platform file would
> surely require using the MFP macros again, so how to keep
> everyone happy? Maybe I should just define a more generic
> name such as GPIO102_GPIO_OUT?
> 
> I guess we need a new definition for this config, looks
> like SCLK here
> is different from a normal configuration because the pxa27x
> is used
> as a SPI slave here?
> 
> And checked a bit with the pxa27x developer manual, there
> is no SCLK
> for this GPIO102????

GPIO102 is apparently a navpoint power enable; the old linux-2.6.21-hh20 kernel from handhelds.org defines it thus:

#define GPIO_NR_HX4700_SYNAPTICS_POWER_ON        102

I verified that it does need to be asserted before the navpoint will work. I don't possess any hx4700 developer documentation; perhaps Philipp can shed some light on GPIO102.
