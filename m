From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] [RFC] ads7846: force driver to work with ads7845
Date: Tue, 19 May 2015 14:49:22 +0200
Message-ID: <20150519144922.20768521@crub>
References: <20150518125500.GA22524@fifteen>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35640 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbESMtg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 08:49:36 -0400
In-Reply-To: <20150518125500.GA22524@fifteen>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Dmitry Torokhov <dtor@mail.ru>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, 18 May 2015 15:55:00 +0300
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> CC me please, I'm not subscribed to any linux-kernel list.
> 
> Hi,
> recently I have ads7845 device connected to my beagleboard,
> and I try to use ads7846 to work with it.
> But it fails, it show completely wrong x/y.
> 
> But, after I disabled almost all code that related to ads7845 ("== 7845"),
> except determination of amount of pressure force,
> all start works as expected,
> I found such commit:
> 
> >commit 3eac5c7e44f35eb07f0ecb28ce60f15b2dda1932
> >Author: Anatolij Gustschin <agust@denx.de>
> >...
> >ADS7845 is a controller for 5-wire touch screens and somewhat
> >different from 7846. It requires three serial communications to
> >accomplish one complete conversion.
> >...
> 
> But according to datasheets:
> http://www.ti.com/lit/ds/symlink/ads7846.pdf
> http://www.ti.com/lit/ds/symlink/ads7845.pdf
> 
> ads7845(page 8) and ads7846 (page 12) have
> identical digital interfaces, I attach quotes
> from them in text from to this email.
> 
> So why spi negotiation for ads7845 require special code,
> except
> >Z1-/Z2- position measurement
> 
> Was this commit tested? May be you test
> in some special mode, like 15 vs 16 bits?

this was tested, but if I remember correctly, on some ppc board were
multi-segment SPI transfers didn't work (SPI chip-select disabled by
controller after first SPI command byte). I do not know any more if it
was the only reason for this ads7845 specific handling in my commit
and unfortunately I do not have this board to check it again.

> Here is working for me patch (it against 3.16,
> but applied to Linus's git master also).
> 
> ads7846: fix to force ads7846 driver works with ads7845
>  device

Then can you please first revert my patch and then add the only
code that is needed to work with ads7845 ? After this you can
squash both parts to a single commit and submit a clean patch.

Thanks,

Anatolij

> Signed-off-by: Evgneiy A. Dushistov <dushistov@mail.ru>
> ---
>  drivers/input/touchscreen/ads7846.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index da201b8..27f4796 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -17,6 +17,9 @@
>   *  it under the terms of the GNU General Public License version 2 as
>   *  published by the Free Software Foundation.
>   */
> +#define VERBOSE_DEBUG
> +#define DEBUG
> +
>  #include <linux/types.h>
>  #include <linux/hwmon.h>
>  #include <linux/err.h>
> @@ -671,14 +674,14 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
>  	struct spi_transfer *t =
>  		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
>  
> -	if (ts->model == 7845) {
> +	if (0/*ts->model == 7845*/) {
>  		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
>  	} else {
>  		/*
>  		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
>  		 * padding; built from two 8 bit values written msb-first.
>  		 */
> -		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
> +		return (be16_to_cpup((__be16 *)t->rx_buf) & 0x7fff) >> 3;
>  	}
>  }
>  
> @@ -755,14 +758,12 @@ static void ads7846_report_state(struct ads7846 *ts)
>  	 * from on-the-wire format as part of debouncing to get stable
>  	 * readings.
>  	 */
> +	x = packet->tc.x;
> +	y = packet->tc.y;
>  	if (ts->model == 7845) {
> -		x = *(u16 *)packet->tc.x_buf;
> -		y = *(u16 *)packet->tc.y_buf;
>  		z1 = 0;
>  		z2 = 0;
>  	} else {
> -		x = packet->tc.x;
> -		y = packet->tc.y;
>  		z1 = packet->tc.z1;
>  		z2 = packet->tc.z2;
>  	}
> @@ -995,7 +996,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
>  	spi_message_init(m);
>  	m->context = ts;
>  
> -	if (ts->model == 7845) {
> +	if (0/*ts->model == 7845*/) {
>  		packet->read_y_cmd[0] = READ_Y(vref);
>  		packet->read_y_cmd[1] = 0;
>  		packet->read_y_cmd[2] = 0;
> @@ -1040,7 +1041,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
>  	spi_message_init(m);
>  	m->context = ts;
>  
> -	if (ts->model == 7845) {
> +	if (0/*ts->model == 7845*/) {
>  		x++;
>  		packet->read_x_cmd[0] = READ_X(vref);
>  		packet->read_x_cmd[1] = 0;
> @@ -1149,7 +1150,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
>  	spi_message_init(m);
>  	m->context = ts;
>  
> -	if (ts->model == 7845) {
> +	if (0/*ts->model == 7845*/) {
>  		x++;
>  		packet->pwrdown_cmd[0] = PWRDOWN;
>  		packet->pwrdown_cmd[1] = 0;
> @@ -1408,7 +1409,7 @@ static int ads7846_probe(struct spi_device *spi)
>  	 * Take a first sample, leaving nPENIRQ active and vREF off; avoid
>  	 * the touchscreen, in case it's not connected.
>  	 */
> -	if (ts->model == 7845)
> +	if (0/*ts->model == 7845*/)
>  		ads7845_read12_ser(&spi->dev, PWRDOWN);
>  	else
>  		(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
