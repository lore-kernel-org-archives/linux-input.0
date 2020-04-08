Return-Path: <SRS0=LeEh=5Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E0C2D0F4
	for <linux-input@archiver.kernel.org>; Wed,  8 Apr 2020 21:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61202078E
	for <linux-input@archiver.kernel.org>; Wed,  8 Apr 2020 21:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgDHV4a (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:56:30 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50889 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgDHV43 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2020 17:56:29 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 267BCC0006;
        Wed,  8 Apr 2020 21:56:26 +0000 (UTC)
Date:   Wed, 8 Apr 2020 23:56:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] counter: Add atmel TCB capture counter
Message-ID: <20200408215625.GS3628@piout.net>
References: <20200406155320.1291701-1-kamel.bouhara@bootlin.com>
 <20200406155320.1291701-4-kamel.bouhara@bootlin.com>
 <20200408213013.GA30867@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408213013.GA30867@icarus>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi William,

On 08/04/2020 17:31:03-0400, William Breathitt Gray wrote:
> On Mon, Apr 06, 2020 at 05:53:20PM +0200, Kamel Bouhara wrote:
> > This drivers allows to use the capture mode of the Timer Counter Block
> > hardware block available in Atmel SoCs through the counter subsystem.
> > 
> > Two functions of the counter are supported for the moment: period
> > capture and quadrature decoder. The latter is only supported by the
> > SAMA5 series of SoCs.
> > 
> > For the period capture mode a basic setup has been chosen that will
> > reset the counter each time the period is actually reached. Of course
> > the device offers much more possibilities.
> > 
> > For quadrature mode, both channel 0 and 1 must be configured even if we
> > only capture the position (no revolution/rotation).
> > 
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Hi Kamel,
> 
> Thank you for submitting support for this driver. Since this is a new
> counter driver, make sure to create an entry for it in the top-level
> MAINTAINERS file so users know who to contact to report bugs and other
> issues.
> 

The file name already matches for the at91 maintainers so I think we are
good on this front.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
