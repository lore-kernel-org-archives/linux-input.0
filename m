From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: touchscreen: ad7879: fix default x/y axis
 assignment
Date: Wed, 27 Jan 2016 15:40:22 -0800
Message-ID: <20160127234022.GE28687@dtor-ws>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
 <1453777477-29706-2-git-send-email-stefan@agner.ch>
 <56A72734.9000303@analog.com>
 <53cf5cb2a96a236925bb2901e3c417f8@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34947 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934577AbcA0Xk0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:40:26 -0500
Content-Disposition: inline
In-Reply-To: <53cf5cb2a96a236925bb2901e3c417f8@agner.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: michael.hennerich@analog.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 26, 2016 at 09:04:20AM -0800, Stefan Agner wrote:
> On 2016-01-25 23:58, Michael Hennerich wrote:
> > On 01/26/2016 04:04 AM, Stefan Agner wrote:
> >> The measurements read from the controller which are temporary stored
> >> in conversion_data, are interpreted wrong. The first measurement X+
> >> contains the Y position, and the second measurement Y+ the X position
> >> (see also Table 11 Register Table in the data sheet).
> >>
> >> The problem is already known and a swap option has been introduced:
> >> commit 6680884a4420 ("Input: ad7879 - add option to correct xy axis")
> >>
> >> However, with that the meaning of the new boolean is inverted since
> >> the underlying values are already swapped. With this change, a true
> >> in swap_xy actually swaps the two axis.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> Hi Michael,
> >>
> >> It seems that swap_xy is not used in any board which is in mainline,
> >> hence swap_xy is always false. Therefore, up until now all boards
> >> actually used swapped axis. However, I doubt that the blackfin boards
> >> really have those axis swapped, it is probably more likely that the
> >> userspace calibration took care of it.
> >>
> >> However, if they are really swapped, we should set the swap_xy flag
> >> to 1 for those board...
> >>
> >> Do you happen to now what is the case with those boards?
> >>
> > 
> > 
> > Hi Stefan,
> > 
> > I would be hesitant to invert the default behaviour of the driver.
> > Too many people in the field already using it as it is.
> 
> Afaik, we should be able to change in-kernel API's (especially if they
> are wrong) since we do not guarantee any API...
> 
> > 
> > A XY swap can have multiple reasons.
> > 
> > Lot's of small VGA/QVGA TFTs have the option to switch the scan
> > direction from Landscape to Portrait. In addition you can also rotate
> > and flip or mirror using VDMA options. So it really depends on the use
> > case, how the touch panel is mounted to the screen or how it is wired.
> 
> Ok, I see the reason for that functionality.
> 
> I am mainly concerned about the new DT bindings. The touchscreen binding
> documents specify touchscreen-swapped-x-y, see:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> I would like to make sure that this property is really swapping axis
> (and not necessary if the hardware is implemented according to the
> datasheet...)
> 
> We could also implement a workaround to keep the platform data behavior
> as is (invert the swap_xy flag)...

That is probably the best option.

Thanks.

-- 
Dmitry
