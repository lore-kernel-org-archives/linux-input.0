From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 15 Jan 2015 22:51:43 +0200
Message-ID: <16733840.6Wupp0rKhe@avalon>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdW7ETcFGSPiE9BWA2dAE93477fzoyF-+_EaiPSDT9WMWA@mail.gmail.com> <20150115174333.GC6342@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150115174333.GC6342@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Wolfram,

On Thursday 15 January 2015 18:43:33 Wolfram Sang wrote:
> On Thu, Jan 15, 2015 at 06:32:31PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Jan 15, 2015 at 6:02 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> >>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> >>> @@ -18,8 +18,7 @@ adi,adt7475         +/-1C TDM Extended Temp Range I.C
> >>> 
> >>>  adi,adt7476          +/-1C TDM Extended Temp Range I.C
> >>>  adi,adt7490          +/-1C TDM Extended Temp Range I.C
> >>>  adi,adxl345          Three-Axis Digital Accelerometer
> >>> 
> >>> -adi,adxl346          Three-Axis Digital Accelerometer
> >>> -adi,adxl34x          Three-Axis Digital Accelerometer
> >>> +adi,adxl346          Three-Axis Digital Accelerometer
> >>> (backward-compatibility value "adi,adxl345" must be listed too)
> >>
> >> I'd rather drop 346 because there is no compatible for that one
> >> anywhere. No need to resend, I can fix it here...
> > 
> > If you drop adi,adxl346, checkpatch will start complaining if it
> > encounters it in a .dts.
> 
> Boah, this is annoying. That means we need an 346 entry even if it is
> not different from 345 (which is fine by me).
> 
> If checkpatch does it this way, that means the rule of thumb is to
> *always* have a dedicated compatible entry? Can someone confirm this?

I believe we should register a new compatible entry for a device when the 
device isn't identical, from a compatibility point of view, to an already 
registered device. In this specific case the adxl346 offers addition features 
compared to the adxl345. It thus qualify for its own compatible string. Its DT 
nodes should list both the adi,adxl346 and adi,adxl345 compatible strings in 
that order, as the chip is compatible with the adxl345. On the driver side, 
given that we don't need to differentiate between the devices based on the 
compatible string (as runtime model detection is possible) we don't need to 
add a match entry for adi,adxl346.

> Why did we discuss then? Now, I am confused as well...

-- 
Regards,

Laurent Pinchart

