From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH] Input: ads7846 - correct the value get from SPI
Date: Thu, 23 Jul 2015 08:28:19 +0000
Message-ID: <BY1PR03MB138832C73F572E3F426F51E39A820@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1432278136-32457-1-git-send-email-haibo.chen@freescale.com>
 <55AE3290.60103@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0135.outbound.protection.outlook.com ([65.55.169.135]:6258
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751689AbbGWI2Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 04:28:24 -0400
In-Reply-To: <55AE3290.60103@compulab.co.il>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Igor,

The patch you attached is okay for me. But I suggest to explain this issue more clearly.
Actually it is not a no clear reason. i.MX6 platform SPI driver set MOSI and MISO in high 
level. You can refer to my patch log.

Best Regards
Haibo Chen


> -----Original Message-----
> From: Igor Grinberg [mailto:grinberg@compulab.co.il]
> Sent: Tuesday, July 21, 2015 7:53 PM
> To: Chen Haibo-B51421; dmitry.torokhov@gmail.com
> Cc: jg1.han@samsung.com; pramod.gurav@smartplayin.com; linux-
> input@vger.kernel.org
> Subject: Re: [PATCH] Input: ads7846 - correct the value get from SPI
> 
> Hi,
> 
> On 05/22/15 10:02, Haibo Chen wrote:
> > According to the touch controller SPEC, SPI return a 16 bit value,
> > only 12 bits are valid, they are bit[14-3].
> >
> > The value of MISO and MOSI can be configed when SPI in idle mode.
> > Currently this touch driver consider the SPI bus set the MOSI and MISO
> > in low level when SPI bus in idle mode. So the bit[15] of the value
> > get from SPI bus is always 0. But when SPI bus congfig the MOSI and
> > MISO in high level when SPI in idle mode, the bit[15] of the value get
> > from SPI is always 1, if not mask this bit[15], we may get the wrong
> > value.
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
> struct spi_message *m)
> >  		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
> >  		 * padding; built from two 8 bit values written msb-first.
> >  		 */
> > -		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
> > +		return (be16_to_cpup((__be16 *)t->rx_buf) & 0x7ff8) >> 3;
> 
> IIRC, 7845 is the same in regard to SPI bus, so may be we should also
> adjust the value in if statement, not just the else part.
> 
> We have the attached patch locally, so may you would like to consider it
> or a mixture of both...
> 
> 
> --
> Regards,
> Igor.
