From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [PATCH 2/2] Input: add touchscreen support for TS-4800
Date: Sun, 13 Dec 2015 15:55:57 -0500
Message-ID: <20151213205557.GA4600@localhost>
References: <1449763872-572-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1449763872-572-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151213045858.GB22780@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:43914 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbbLMU4D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2015 15:56:03 -0500
Content-Disposition: inline
In-Reply-To: <20151213045858.GB22780@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, kernel@savoirfairelinux.com

Hi Dmitry

On Sat, Dec 12, 2015 at 08:58:58PM -0800, Dmitry Torokhov wrote:
> Hi Damien,
> 
> On Thu, Dec 10, 2015 at 11:11:12AM -0500, Damien Riegel wrote:
> > On this board, the touchscreen, an ads7843, is not handled directly by
> > Linux but by a companion FPGA. This FPGA is memory-mapped and the IP
> > design is very similar to the mk712.
> 
> ...
> 
> > +
> > +	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
> > +	if (!poll_dev)
> > +		return -ENOMEM;
> 
> I wonder how useful touchscreen implemented as polling device is. Isn't
> there an interrupt line for it?
 
There is an interrupt line between the touchscreen and the FGPA, but not
between the FPGA and the SoC. I agree it is a bit peculiar. Hopefully on
more recent boards, they changed their design to handle the touchscreen
directly with Linux.

Thanks,
Damien

> Thanks.
> 
> -- 
> Dmitry
