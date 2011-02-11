From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: adxl34x - Fix references to adx134x
Date: Fri, 11 Feb 2011 08:55:02 -0800
Message-ID: <20110211165502.GA17932@core.coreip.homeip.net>
References: <1297438422-25838-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1297438422-25838-3-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4D55563E.4050309@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51702 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab1BKQzK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 11:55:10 -0500
Received: by pxi15 with SMTP id 15so459718pxi.19
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 08:55:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D55563E.4050309@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On Fri, Feb 11, 2011 at 04:31:10PM +0100, Michael Hennerich wrote:
> On 02/11/2011 04:33 PM, Mark Brown wrote:
> > The adxl34x SPI driver has what appears to be a typo referring to the
> > device as adx134x with the numeral 1 rather than letter l. This appears
> > to be an error so convert.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >   
> Thought I fixed that before...
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> 

One must have slipped through... Anyway, applied the whole lot.

Thanks.

-- 
Dmitry
