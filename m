From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 15 Jan 2015 09:27:00 -0800
Message-ID: <20150115172700.GA33214@dtor-ws>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20150115170209.GA6342@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51994 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbbAOR1E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 12:27:04 -0500
Content-Disposition: inline
In-Reply-To: <20150115170209.GA6342@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>

On Thu, Jan 15, 2015 at 06:02:09PM +0100, Wolfram Sang wrote:
> On Thu, Jan 15, 2015 at 04:54:14PM +0200, Laurent Pinchart wrote:
> > DT nodes should use the more specific adi,adxl345 and adi,adxl346
> > compatible values instead. As the ADXL346 is backward-compatible with
> > the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
> > in that order.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index 9f41d05be3be..757e42510517 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -18,8 +18,7 @@ adi,adt7475		+/-1C TDM Extended Temp Range I.C
> >  adi,adt7476		+/-1C TDM Extended Temp Range I.C
> >  adi,adt7490		+/-1C TDM Extended Temp Range I.C
> >  adi,adxl345		Three-Axis Digital Accelerometer
> > -adi,adxl346		Three-Axis Digital Accelerometer
> > -adi,adxl34x		Three-Axis Digital Accelerometer
> > +adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
> 
> I'd rather drop 346 because there is no compatible for that one anywhere.
> No need to resend, I can fix it here...

So color me confused now. We deprecated adi,adxl34x because it is
generic, but then we adding "specific" adi,adxl345 that covers again
both devices? Why do we do this exactly? What is broken at the moment?

Thanks.

-- 
Dmitry
