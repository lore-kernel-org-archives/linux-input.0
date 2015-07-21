From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH] Input: ads7846 - correct the value get from SPI
Date: Tue, 21 Jul 2015 02:31:56 +0000
Message-ID: <BY1PR03MB13880D14EA7A3AC696B544EF9A840@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1432278136-32457-1-git-send-email-haibo.chen@freescale.com>
 <BY1PR03MB13885FCFCE49AC75240EC4569ABD0@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0143.outbound.protection.outlook.com ([207.46.100.143]:5484
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751580AbbGUDFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 23:05:30 -0400
In-Reply-To: <BY1PR03MB13885FCFCE49AC75240EC4569ABD0@BY1PR03MB1388.namprd03.prod.outlook.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi


> -----Original Message-----
> From: Chen Haibo-B51421
> Sent: Wednesday, June 10, 2015 4:54 PM
> To: Chen Haibo-B51421; dmitry.torokhov@gmail.com
> Cc: jg1.han@samsung.com; pramod.gurav@smartplayin.com; linux-
> input@vger.kernel.org
> Subject: RE: [PATCH] Input: ads7846 - correct the value get from SPI
> 
> Ping...
> 
> 
> > -----Original Message-----
> > From: Haibo Chen [mailto:haibo.chen@freescale.com]
> > Sent: Friday, May 22, 2015 3:02 PM
> > To: dmitry.torokhov@gmail.com
> > Cc: jg1.han@samsung.com; pramod.gurav@smartplayin.com; linux-
> > input@vger.kernel.org; Chen Haibo-B51421
> > Subject: [PATCH] Input: ads7846 - correct the value get from SPI
> >
> > According to the touch controller SPEC, SPI return a 16 bit value,
> > only
> > 12 bits are valid, they are bit[14-3].
> >
> > The value of MISO and MOSI can be configed when SPI in idle mode.
> > Currently this touch driver consider the SPI bus set the MOSI and MISO
> > in low level when SPI bus in idle mode. So the bit[15] of the value
> > get from SPI bus is always 0. But when SPI bus congfig the MOSI and
> > MISO in high level when SPI in idle mode, the bit[15] of the value get
> > from SPI is always 1, if not mask this bit[15], we may get the wrong
> value.
> >
> > This patch mask the invalid bit, and make sure to return the correct
> > value nomatter how SPI bus configed.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  drivers/input/touchscreen/ads7846.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/ads7846.c
> > b/drivers/input/touchscreen/ads7846.c
> > index e4eb8a6..91b335f 100644
> > --- a/drivers/input/touchscreen/ads7846.c
> > +++ b/drivers/input/touchscreen/ads7846.c
> > @@ -678,7 +678,7 @@ static int ads7846_get_value(struct ads7846 *ts,
> > struct spi_message *m)
> >  		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
> >  		 * padding; built from two 8 bit values written msb-first.
> >  		 */
> > -		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
> > +		return (be16_to_cpup((__be16 *)t->rx_buf) & 0x7ff8) >> 3;
> >  	}
> >  }
> >
> > --
> > 1.9.1

Will this patch be merged? Since more than 5 weeks passed, I did not see any comments about this patch. 
