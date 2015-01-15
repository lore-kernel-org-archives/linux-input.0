From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 16:19:19 +0200
Message-ID: <2054159.e1XeKNyynp@avalon>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1492007.8cQN1myWLD@avalon> <20150115125321.GD2549@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150115125321.GD2549@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>
List-Id: linux-input@vger.kernel.org

Hi Wolfram,

On Thursday 15 January 2015 13:53:22 Wolfram Sang wrote:
> On Thu, Dec 18, 2014 at 02:49:28PM +0200, Laurent Pinchart wrote:
> > On Thursday 18 December 2014 09:21:51 Wolfram Sang wrote:
> >> On Thu, Dec 18, 2014 at 04:15:23AM +0200, Laurent Pinchart wrote:
> >>> The I2C subsystem can match devices without explicit OF support based
> >>> on the part of their compatible property after the comma. However,
> >>> this mechanism uses the first compatible value only. For adxl34x OF
> >>> device nodes the compatible property should list the more specific
> >>> "adi,adxl345" or "adi,adxl346" value first and the "adi,adxl34x"
> >>> fallback value second. This prevents the device node from being
> >>> matched with the adxl34x driver.
> >>> 
> >>> Fix this by adding an OF match table with an "adi,adxl34x" compatible
> >>> entry.
> >>> 
> >>> Signed-off-by: Laurent Pinchart
> >>> <laurent.pinchart+renesas@ideasonboard.com>
> >>> ---
> >>> 
> >>>  drivers/input/misc/adxl34x-i2c.c | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>> 
> >>> Another option would have been to add "adxl325" and "adxl326" entries
> >>> to the adxl34x_id I2C match table, but it would have had the drawback
> >>> of requiring a driver update for every new device.
> >> 
> >> AFAIK this is even required for compatible entries, to be as specific as
> >> possible. I think this makes sense. With platform_ids, we already had
> >> the problem that pca954x was too generic and was used for both GPIO
> >> extenders and I2C muxers (IIRC).
> > 
> > There are three compatible strings defined for the ADXL345 and ADXL346 in
> > Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345",
> > "adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for
> > the first two I don't see a need to add the specific compatible strings to
> > the driver for now. If a new totally incompatible chip named ADXL347 comes
> > out we will need a new driver which won't be allowed to use the
> > "adi,adxl34x" compatible string.
> 
> Been there, got bitten. We only found out too late, because one driver
> was in i2c and the other in GPIO (or LED even?), both using "953x" :(

That seems like a development, review and/or merge process failure to me, I 
wouldn't avoid generic compatible strings for that reason only.

> > An option would be to remove "adi,adxl34x" from
> > Documentation/devicetree/bindings/i2c/trivial-devices.txt, in which case
> > the driver should match explicitly on "adi,adxl345" and "adi,adxl346".
> > That might clash with the DT ABI stability requirements though.
> 
> I do prefer this:
> 
> 1) add specific compatible values to the driver. We do those updates for
> new devices all the time

Do you mean OF compatible values, or I2C match table entries ? I assume OF 
compatible values.

As the ADXL346 is backward-compatible with the ADXL345, and as the driver 
doesn't support the ADXL346-specific features, how about adding only the 
adxl345 for now, and using compatible = "adi,adxl346", "adi,adxl345"; for the 
ADXL346 ?

> 2) also add "34x" as a compatible but mark it as deprecateed
> 3) delete "34x" from trivial devices

OK.

> Everyone OK with that?

-- 
Regards,

Laurent Pinchart

