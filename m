From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: zforce_ts: add DT support for reset GPIO polarity
Date: Mon, 29 Jun 2015 17:08:58 -0700
Message-ID: <20150630000858.GA35823@dtor-ws>
References: <1434347665-24396-1-git-send-email-dirk.behme@de.bosch.com>
 <20150616235755.GE17610@dtor-ws>
 <558A3DAE.8090203@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36286 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbbF3AJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 20:09:03 -0400
Received: by iecvh10 with SMTP id vh10so1628953iec.3
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2015 17:09:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <558A3DAE.8090203@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On Wed, Jun 24, 2015 at 07:18:38AM +0200, Dirk Behme wrote:
> On 17.06.2015 01:57, Dmitry Torokhov wrote:
> >On Mon, Jun 15, 2015 at 07:54:25AM +0200, Dirk Behme wrote:
> >>From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> >>
> >>According to
> >>
> >>Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> >>
> >>the RST GPIO is supposed to provide a polarity flag parameter
> >>
> >>gpios = <&GPIO_BANK GPIO_NUMBER GPIO_POLARITY>
> >>
> >>with GPIO_POLARITY
> >>
> >>reset active low  = 1 (GPIO_ACTIVE_LOW)
> >>reset active high = 0 (GPIO_ACTIVE_HIGH)
> >>
> >>Example for GPIO_ACTIVE_LOW (1) reset GPIO:
> >>
> >>	zforce_ts@50 { /* Neonode zForce I2C */
> >>		compatible = "neonode,zforce-ts";
> >>		...
> >>		gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>, /* INT */
> >>			<&gpio1 29 GPIO_ACTIVE_LOW>; /* RST */
> >>		...
> >>	};
> >>
> >>Add the missing polarity flag evaluation to the driver.
> >>
> >>Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> >>Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> >>Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> >>---
> >>  drivers/input/touchscreen/zforce_ts.c   | 27 +++++++++++++++++++++++----
> >>  include/linux/platform_data/zforce_ts.h |  3 +++
> >>  2 files changed, 26 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> >>index 19880c7..125311d 100644
> >>--- a/drivers/input/touchscreen/zforce_ts.c
> >>+++ b/drivers/input/touchscreen/zforce_ts.c
> >>@@ -162,6 +162,20 @@ static int zforce_command(struct zforce_ts *ts, u8 cmd)
> >>  	return 0;
> >>  }
> >>
> >>+static void zforce_reset_assert(struct zforce_ts *ts)
> >>+{
> >>+	const struct zforce_ts_platdata *pdata = ts->pdata;
> >>+
> >>+	gpio_set_value(pdata->gpio_rst, pdata->reset_active_low ? 0 : 1);
> >
> >Instead of doing this I'd rather we converted the driver to use gpiod
> >that handles polarity automatically.
> 
> 
> Thanks, we'll look into that.
> 
> Just to understand correctly: Converting this driver to gpiod will
> be an additional patch on top of this patch as it doesn't change any
> functionality provided by this patch, but does some clean up.
> Correct?

No, gpiod understands annotations on gpio descriptions and converts the
logical "active"/"inactive" value into appropriate output depending on
the polarity specified for gpio. So zforce_reset_assert() woudl only
need to do

	gpiod_set_value[_cansleep](ts->gpio_rst, 1);


Thanks.

-- 
Dmitry
