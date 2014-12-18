From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 18 Dec 2014 14:49:28 +0200
Message-ID: <1492007.8cQN1myWLD@avalon>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20141218082151.GA1038@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:50911 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaLRMt0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Dec 2014 07:49:26 -0500
In-Reply-To: <20141218082151.GA1038@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-input@vger.kernel.org, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>

Hi Wolfram,

On Thursday 18 December 2014 09:21:51 Wolfram Sang wrote:
> On Thu, Dec 18, 2014 at 04:15:23AM +0200, Laurent Pinchart wrote:
> > The I2C subsystem can match devices without explicit OF support based on
> > the part of their compatible property after the comma. However, this
> > mechanism uses the first compatible value only. For adxl34x OF device
> > nodes the compatible property should list the more specific
> > "adi,adxl345" or "adi,adxl346" value first and the "adi,adxl34x"
> > fallback value second. This prevents the device node from being matched
> > with the adxl34x driver.
> > 
> > Fix this by adding an OF match table with an "adi,adxl34x" compatible
> > entry.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/input/misc/adxl34x-i2c.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > Another option would have been to add "adxl325" and "adxl326" entries to
> > the adxl34x_id I2C match table, but it would have had the drawback of
> > requiring a driver update for every new device.
> 
> AFAIK this is even required for compatible entries, to be as specific as
> possible. I think this makes sense. With platform_ids, we already had
> the problem that pca954x was too generic and was used for both GPIO
> extenders and I2C muxers (IIRC).

There are three compatible strings defined for the ADXL345 and ADXL346 in 
Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345", 
"adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for the 
first two I don't see a need to add the specific compatible strings to the 
driver for now. If a new totally incompatible chip named ADXL347 comes out we 
will need a new driver which won't be allowed to use the "adi,adxl34x" 
compatible string.

An option would be to remove "adi,adxl34x" from 
Documentation/devicetree/bindings/i2c/trivial-devices.txt, in which case the 
driver should match explicitly on "adi,adxl345" and "adi,adxl346". That might 
clash with the DT ABI stability requirements though.

-- 
Regards,

Laurent Pinchart

