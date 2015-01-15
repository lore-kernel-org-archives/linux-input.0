From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 16:38:16 +0200
Message-ID: <1546932.HT3eEIWcNh@avalon>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2445803.jDZCe1u2Wf@avalon> <20150115143637.GA5057@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:51501 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbbAOOht (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 09:37:49 -0500
In-Reply-To: <20150115143637.GA5057@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>

On Thursday 15 January 2015 15:36:37 Wolfram Sang wrote:
> >>> Been there, got bitten. We only found out too late, because one driver
> >>> was in i2c and the other in GPIO (or LED even?), both using "953x" :(
> >> 
> >> That seems like a development, review and/or merge process failure to
> >> me, I wouldn't avoid generic compatible strings for that reason only.
> 
> Well, I think different here, but let's skip this discussion as it is
> not really needed right now...
> 
> >> As the ADXL346 is backward-compatible with the ADXL345, and as the
> >> driver doesn't support the ADXL346-specific features, how about adding
> >> only the adxl345 for now, and using compatible = "adi,adxl346",
> >> "adi,adxl345"; for the ADXL346 ?
> > 
> > I spoke too fast. The driver supports ADXL346-specific features, but does
> > so by detecting the device model at runtime.
> > 
> > I still believe it would make sense to list both the 346 and 345 models in
> > DT for 346 devices, as they're compatible with the 345.
> 
> I agree.
> 
> >>> 2) also add "34x" as a compatible but mark it as deprecateed
> >>> 3) delete "34x" from trivial devices
> >> 
> >> OK.
> 
> Yay :)

I'll submit patches very soon.

-- 
Regards,

Laurent Pinchart

