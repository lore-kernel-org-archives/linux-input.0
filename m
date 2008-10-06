From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc6] ads7846: work better
	with DMA
Date: Mon, 6 Oct 2008 16:57:24 -0700
Message-ID: <200810061657.24382.david-b@pacbell.net>
References: <200809151632.17505.david-b@pacbell.net>
	<20080916192156.GE9252@amd.corenet.prb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080916192156.GE9252-ydVhwsVbLhBa2NCMCyH88g@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 16 September 2008, Dmitry Torokhov wrote:
> On Mon, Sep 15, 2008 at 04:32:17PM -0700, David Brownell wrote:
> > From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > 
> > We had a report a while back that the ads7846 driver had some issues
> > when used with DMA-based SPI controllers (like atmel_spi) on systems
> > where main memory is not DMA-coherent (most non-x86 boards) ... but no
> > mergeable patch addressed it.  Pending any more comprehensive fix,
> > just push the relevant data into cache lines that won't be shared,
> > preventing those issues (but not in a very pretty way).
> > 
> 
> How about this one? Because the change is purely mechanical I feel
> pretty safe about it...

Looks OK to me ... sorry for the delayed response.

Nicolas:  this may be useful on the at91sam926[03] EK boards.


> 
> -- 
> Dmitry
> 
> 
> Input: ads7846 - fix cache line sharing issue
> 
> We had a report a while back that the ads7846 driver had some issues
> when used with DMA-based SPI controllers (like atmel_spi) on systems
> where main memory is not DMA-coherent (most non-x86 boards). Allocate
> memory potentially used for DMA separately to avoid cache line issues.
> 
> Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
> ---
> 
>  drivers/input/touchscreen/ads7846.c |   87 +++++++++++++++++++++--------------
>  1 files changed, 51 insertions(+), 36 deletions(-)
> 
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 6020a7d..b9b7fc6 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -69,6 +69,17 @@ struct ts_event {
>  	int	ignore;
>  };
>  
> +/*
> + * We allocate this separately to avoid cache line sharing issues when
> + * driver is used with DMA-based SPI controllers (like atmel_spi) on
> + * systems where main memory is not DMA-coherent (most non-x86 boards).
> + */
> +struct ads7846_packet {
> +	u8			read_x, read_y, read_z1, read_z2, pwrdown;
> +	u16			dummy;		/* for the pwrdown read */
> +	struct ts_event		tc;
> +};
> +
>  struct ads7846 {
>  	struct input_dev	*input;
>  	char			phys[32];
> @@ -86,9 +97,7 @@ struct ads7846 {
>  	u16			x_plate_ohms;
>  	u16			pressure_max;
>  
> -	u8			read_x, read_y, read_z1, read_z2, pwrdown;
> -	u16			dummy;		/* for the pwrdown read */
> -	struct ts_event		tc;
> +	struct ads7846_packet	*packet;
>  
>  	struct spi_transfer	xfer[18];
>  	struct spi_message	msg[5];
> @@ -513,16 +522,17 @@ static int get_pendown_state(struct ads7846 *ts)
>  static void ads7846_rx(void *ads)
>  {
>  	struct ads7846		*ts = ads;
> +	struct ads7846_packet	*packet = ts->packet;
>  	unsigned		Rt;
>  	u16			x, y, z1, z2;
>  
>  	/* ads7846_rx_val() did in-place conversion (including byteswap) from
>  	 * on-the-wire format as part of debouncing to get stable readings.
>  	 */
> -	x = ts->tc.x;
> -	y = ts->tc.y;
> -	z1 = ts->tc.z1;
> -	z2 = ts->tc.z2;
> +	x = packet->tc.x;
> +	y = packet->tc.y;
> +	z1 = packet->tc.z1;
> +	z2 = packet->tc.z2;
>  
>  	/* range filtering */
>  	if (x == MAX_12BIT)
> @@ -546,10 +556,10 @@ static void ads7846_rx(void *ads)
>  	 * the maximum. Don't report it to user space, repeat at least
>  	 * once more the measurement
>  	 */
> -	if (ts->tc.ignore || Rt > ts->pressure_max) {
> +	if (packet->tc.ignore || Rt > ts->pressure_max) {
>  #ifdef VERBOSE
>  		pr_debug("%s: ignored %d pressure %d\n",
> -			ts->spi->dev.bus_id, ts->tc.ignore, Rt);
> +			ts->spi->dev.bus_id, packet->tc.ignore, Rt);
>  #endif
>  		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
>  			      HRTIMER_MODE_REL);
> @@ -642,6 +652,7 @@ static int ads7846_no_filter(void *ads, int data_idx, int *val)
>  static void ads7846_rx_val(void *ads)
>  {
>  	struct ads7846 *ts = ads;
> +	struct ads7846_packet *packet = ts->packet;
>  	struct spi_message *m;
>  	struct spi_transfer *t;
>  	int val;
> @@ -661,7 +672,7 @@ static void ads7846_rx_val(void *ads)
>  	case ADS7846_FILTER_REPEAT:
>  		break;
>  	case ADS7846_FILTER_IGNORE:
> -		ts->tc.ignore = 1;
> +		packet->tc.ignore = 1;
>  		/* Last message will contain ads7846_rx() as the
>  		 * completion function.
>  		 */
> @@ -669,7 +680,7 @@ static void ads7846_rx_val(void *ads)
>  		break;
>  	case ADS7846_FILTER_OK:
>  		*(u16 *)t->rx_buf = val;
> -		ts->tc.ignore = 0;
> +		packet->tc.ignore = 0;
>  		m = &ts->msg[++ts->msg_idx];
>  		break;
>  	default:
> @@ -774,7 +785,6 @@ static void ads7846_disable(struct ads7846 *ts)
>  	/* we know the chip's in lowpower mode since we always
>  	 * leave it that way after every request
>  	 */
> -
>  }
>  
>  /* Must be called with ts->lock held */
> @@ -850,6 +860,7 @@ static int __devinit setup_pendown(struct spi_device *spi, struct ads7846 *ts)
>  static int __devinit ads7846_probe(struct spi_device *spi)
>  {
>  	struct ads7846			*ts;
> +	struct ads7846_packet		*packet;
>  	struct input_dev		*input_dev;
>  	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
>  	struct spi_message		*m;
> @@ -885,14 +896,16 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  		return err;
>  
>  	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
> +	packet = kzalloc(sizeof(struct ads7846_packet), GFP_KERNEL);
>  	input_dev = input_allocate_device();
> -	if (!ts || !input_dev) {
> +	if (!ts || !packet || !input_dev) {
>  		err = -ENOMEM;
>  		goto err_free_mem;
>  	}
>  
>  	dev_set_drvdata(&spi->dev, ts);
>  
> +	ts->packet = packet;
>  	ts->spi = spi;
>  	ts->input = input_dev;
>  	ts->vref_mv = pdata->vref_mv;
> @@ -964,13 +977,13 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  	spi_message_init(m);
>  
>  	/* y- still on; turn on only y+ (and ADC) */
> -	ts->read_y = READ_Y(vref);
> -	x->tx_buf = &ts->read_y;
> +	packet->read_y = READ_Y(vref);
> +	x->tx_buf = &packet->read_y;
>  	x->len = 1;
>  	spi_message_add_tail(x, m);
>  
>  	x++;
> -	x->rx_buf = &ts->tc.y;
> +	x->rx_buf = &packet->tc.y;
>  	x->len = 2;
>  	spi_message_add_tail(x, m);
>  
> @@ -982,12 +995,12 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  		x->delay_usecs = pdata->settle_delay_usecs;
>  
>  		x++;
> -		x->tx_buf = &ts->read_y;
> +		x->tx_buf = &packet->read_y;
>  		x->len = 1;
>  		spi_message_add_tail(x, m);
>  
>  		x++;
> -		x->rx_buf = &ts->tc.y;
> +		x->rx_buf = &packet->tc.y;
>  		x->len = 2;
>  		spi_message_add_tail(x, m);
>  	}
> @@ -1000,13 +1013,13 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  
>  	/* turn y- off, x+ on, then leave in lowpower */
>  	x++;
> -	ts->read_x = READ_X(vref);
> -	x->tx_buf = &ts->read_x;
> +	packet->read_x = READ_X(vref);
> +	x->tx_buf = &packet->read_x;
>  	x->len = 1;
>  	spi_message_add_tail(x, m);
>  
>  	x++;
> -	x->rx_buf = &ts->tc.x;
> +	x->rx_buf = &packet->tc.x;
>  	x->len = 2;
>  	spi_message_add_tail(x, m);
>  
> @@ -1015,12 +1028,12 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  		x->delay_usecs = pdata->settle_delay_usecs;
>  
>  		x++;
> -		x->tx_buf = &ts->read_x;
> +		x->tx_buf = &packet->read_x;
>  		x->len = 1;
>  		spi_message_add_tail(x, m);
>  
>  		x++;
> -		x->rx_buf = &ts->tc.x;
> +		x->rx_buf = &packet->tc.x;
>  		x->len = 2;
>  		spi_message_add_tail(x, m);
>  	}
> @@ -1034,13 +1047,13 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  		spi_message_init(m);
>  
>  		x++;
> -		ts->read_z1 = READ_Z1(vref);
> -		x->tx_buf = &ts->read_z1;
> +		packet->read_z1 = READ_Z1(vref);
> +		x->tx_buf = &packet->read_z1;
>  		x->len = 1;
>  		spi_message_add_tail(x, m);
>  
>  		x++;
> -		x->rx_buf = &ts->tc.z1;
> +		x->rx_buf = &packet->tc.z1;
>  		x->len = 2;
>  		spi_message_add_tail(x, m);
>  
> @@ -1049,12 +1062,12 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  			x->delay_usecs = pdata->settle_delay_usecs;
>  
>  			x++;
> -			x->tx_buf = &ts->read_z1;
> +			x->tx_buf = &packet->read_z1;
>  			x->len = 1;
>  			spi_message_add_tail(x, m);
>  
>  			x++;
> -			x->rx_buf = &ts->tc.z1;
> +			x->rx_buf = &packet->tc.z1;
>  			x->len = 2;
>  			spi_message_add_tail(x, m);
>  		}
> @@ -1066,13 +1079,13 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  		spi_message_init(m);
>  
>  		x++;
> -		ts->read_z2 = READ_Z2(vref);
> -		x->tx_buf = &ts->read_z2;
> +		packet->read_z2 = READ_Z2(vref);
> +		x->tx_buf = &packet->read_z2;
>  		x->len = 1;
>  		spi_message_add_tail(x, m);
>  
>  		x++;
> -		x->rx_buf = &ts->tc.z2;
> +		x->rx_buf = &packet->tc.z2;
>  		x->len = 2;
>  		spi_message_add_tail(x, m);
>  
> @@ -1081,12 +1094,12 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  			x->delay_usecs = pdata->settle_delay_usecs;
>  
>  			x++;
> -			x->tx_buf = &ts->read_z2;
> +			x->tx_buf = &packet->read_z2;
>  			x->len = 1;
>  			spi_message_add_tail(x, m);
>  
>  			x++;
> -			x->rx_buf = &ts->tc.z2;
> +			x->rx_buf = &packet->tc.z2;
>  			x->len = 2;
>  			spi_message_add_tail(x, m);
>  		}
> @@ -1100,13 +1113,13 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  	spi_message_init(m);
>  
>  	x++;
> -	ts->pwrdown = PWRDOWN;
> -	x->tx_buf = &ts->pwrdown;
> +	packet->pwrdown = PWRDOWN;
> +	x->tx_buf = &packet->pwrdown;
>  	x->len = 1;
>  	spi_message_add_tail(x, m);
>  
>  	x++;
> -	x->rx_buf = &ts->dummy;
> +	x->rx_buf = &packet->dummy;
>  	x->len = 2;
>  	CS_CHANGE(*x);
>  	spi_message_add_tail(x, m);
> @@ -1159,6 +1172,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>  		ts->filter_cleanup(ts->filter_data);
>   err_free_mem:
>  	input_free_device(input_dev);
> +	kfree(packet);
>  	kfree(ts);
>  	return err;
>  }
> @@ -1184,6 +1198,7 @@ static int __devexit ads7846_remove(struct spi_device *spi)
>  	if (ts->filter_cleanup)
>  		ts->filter_cleanup(ts->filter_data);
>  
> +	kfree(ts->packet);
>  	kfree(ts);
>  
>  	dev_dbg(&spi->dev, "unregistered touchscreen\n");
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
