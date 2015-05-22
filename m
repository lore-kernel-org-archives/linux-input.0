From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix OF match for adxl34x driver
Date: Fri, 22 May 2015 16:32:45 -0700
Message-ID: <20150522233245.GB20687@dtor-ws>
References: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35287 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429AbbEVXct (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 19:32:49 -0400
Content-Disposition: inline
In-Reply-To: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, May 21, 2015 at 01:42:24PM +0200, Geert Uytterhoeven wrote:
> 	Hi Dmitry,
> 
> This is a resent of a series by Laurent Pinchart to fix OF matching for
> the adxl34x driver.
> 
> According to the discussion in response to that series, we were under
> the impression this was going in through the input tree
> (http://www.spinics.net/lists/linux-i2c/msg18293.html).
> 
> In input patchwork, the series is still marked "Awaiting Upstream"
> (https://patchwork.ozlabs.org/project/linux-i2c/list/?state=*&q=adxl),
> but actually we are waiting for you, as we can't update the affected DTS
> before the driver fix has gone in ;-)
> 
> From Laurent's submission:
> 
>     This patch set fixes OF matching for the adxl34x driver when the DT
>     node lists a device-specific "adi,adxl345" or "adi,adxl346"
>     compatible value first.
> 
>     The first version (see
>     http://www.spinics.net/lists/linux-i2c/msg18107.html) added an OF
>     match entry for the "adi,adxl34x" compatible string. The discussion
>     that followed concluded that that compatible string should be
>     deprecated and that the driver should match the device-specific
>     strings instead.
> 
>     The first patch thus deprecates the "adi,adxl34x" compatible string
>     by removing it the DT trivial devices list, and the second patch
>     then adds an OF match table to the adxl34x driver.
> 
> Thanks for applying!

Applied and sorry for the delay.

-- 
Dmitry
