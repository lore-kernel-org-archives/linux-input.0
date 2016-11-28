From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Change msleep to usleep_range for small msecs
Date: Sun, 27 Nov 2016 20:48:57 -0800
Message-ID: <20161128044857.GD2821@dtor-ws>
References: <1480015479-3640-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35853 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbcK1EtB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 27 Nov 2016 23:49:01 -0500
Content-Disposition: inline
In-Reply-To: <1480015479-3640-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com

Hi Aniroop,

On Fri, Nov 25, 2016 at 12:54:39AM +0530, Aniroop Mathur wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, data reading time, etc.
> Thus, change msleep to usleep_range for precise wakeups.
> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/gameport/ns558.c              |  4 ++--
>  drivers/input/joystick/adi.c                |  4 ++--
>  drivers/input/joystick/analog.c             | 12 ++++++------
>  drivers/input/joystick/gf2k.c               |  8 ++++----
>  drivers/input/joystick/sidewinder.c         | 24 ++++++++++++------------
>  drivers/input/keyboard/lm8323.c             |  2 +-
>  drivers/input/mouse/navpoint.c              |  2 +-
>  drivers/input/mouse/pxa930_trkball.c        |  2 +-
>  drivers/input/mouse/synaptics_i2c.c         |  6 +++---
>  drivers/input/touchscreen/ads7846.c         |  4 ++--
>  drivers/input/touchscreen/edt-ft5x06.c      |  4 ++--
>  drivers/input/touchscreen/w90p910_ts.c      |  4 ++--
>  drivers/input/touchscreen/zylonite-wm97xx.c |  4 ++--

This does make sense and probably even needed for the joystick drivers,
but I would like to make sure this is tested. Can you please split the
patch by driver and try to find people with the hardware to test this?

Thanks!

>  13 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
> index 7c21784..046cb28 100644
> --- a/drivers/input/gameport/ns558.c
> +++ b/drivers/input/gameport/ns558.c
> @@ -98,7 +98,7 @@ static int ns558_isa_probe(int io)
>  		release_region(io, 1);
>  		return -ENODEV;
>  	}
> -	msleep(3);
> +	usleep_range(3000, 3100);
>  /*
>   * After some time (4ms) the axes shouldn't change anymore.
>   */
> @@ -124,7 +124,7 @@ static int ns558_isa_probe(int io)
>  		outb(0xff, io & (-1 << i));
>  		for (j = b = 0; j < 1000; j++)
>  			if (inb(io & (-1 << i)) != inb((io & (-1 << i)) + (1 << i) - 1)) b++;
> -		msleep(3);
> +		usleep_range(3000, 3100);
>  
>  		if (b > 300) {				/* We allow 30% difference */
>  			release_region(io & (-1 << i), (1 << i));
> diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
> index d09cefa..f1955bf 100644
> --- a/drivers/input/joystick/adi.c
> +++ b/drivers/input/joystick/adi.c
> @@ -48,7 +48,7 @@ MODULE_LICENSE("GPL");
>  #define ADI_MAX_START		200	/* Trigger to packet timeout [200us] */
>  #define ADI_MAX_STROBE		40	/* Single bit timeout [40us] */
>  #define ADI_INIT_DELAY		10	/* Delay after init packet [10ms] */
> -#define ADI_DATA_DELAY		4	/* Delay after data packet [4ms] */
> +#define ADI_DATA_DELAY		4000	/* Delay after data packet [4000us] */
>  
>  #define ADI_MAX_LENGTH		256
>  #define ADI_MIN_LENGTH		8
> @@ -514,7 +514,7 @@ static int adi_connect(struct gameport *gameport, struct gameport_driver *drv)
>  
>  	msleep(ADI_INIT_DELAY);
>  	if (adi_read(port)) {
> -		msleep(ADI_DATA_DELAY);
> +		usleep_range(ADI_DATA_DELAY, ADI_DATA_DELAY + 100);
>  		adi_read(port);
>  	}
>  
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index 3d8ff09..2891704 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -88,7 +88,7 @@ MODULE_PARM_DESC(map, "Describes analog joysticks type/capabilities");
>  #define ANALOG_EXTENSIONS	0x7ff00
>  #define ANALOG_GAMEPAD		0x80000
>  
> -#define ANALOG_MAX_TIME		3	/* 3 ms */
> +#define ANALOG_MAX_TIME		3000	/* 3000 us */
>  #define ANALOG_LOOP_TIME	2000	/* 2 * loop */
>  #define ANALOG_SAITEK_DELAY	200	/* 200 us */
>  #define ANALOG_SAITEK_TIME	2000	/* 2000 us */
> @@ -257,7 +257,7 @@ static int analog_cooked_read(struct analog_port *port)
>  	int i, j;
>  
>  	loopout = (ANALOG_LOOP_TIME * port->loop) / 1000;
> -	timeout = ANALOG_MAX_TIME * port->speed;
> +	timeout = (ANALOG_MAX_TIME / 1000) * port->speed;
>  
>  	local_irq_save(flags);
>  	gameport_trigger(gameport);
> @@ -625,20 +625,20 @@ static int analog_init_port(struct gameport *gameport, struct gameport_driver *d
>  
>  		gameport_trigger(gameport);
>  		t = gameport_read(gameport);
> -		msleep(ANALOG_MAX_TIME);
> +		usleep_range(ANALOG_MAX_TIME, ANALOG_MAX_TIME + 100);
>  		port->mask = (gameport_read(gameport) ^ t) & t & 0xf;
>  		port->fuzz = (port->speed * ANALOG_FUZZ_MAGIC) / port->loop / 1000 + ANALOG_FUZZ_BITS;
>  
>  		for (i = 0; i < ANALOG_INIT_RETRIES; i++) {
>  			if (!analog_cooked_read(port))
>  				break;
> -			msleep(ANALOG_MAX_TIME);
> +			usleep_range(ANALOG_MAX_TIME, ANALOG_MAX_TIME + 100);
>  		}
>  
>  		u = v = 0;
>  
> -		msleep(ANALOG_MAX_TIME);
> -		t = gameport_time(gameport, ANALOG_MAX_TIME * 1000);
> +		usleep_range(ANALOG_MAX_TIME, ANALOG_MAX_TIME + 100);
> +		t = gameport_time(gameport, ANALOG_MAX_TIME);
>  		gameport_trigger(gameport);
>  		while ((gameport_read(port->gameport) & port->mask) && (u < t))
>  			u++;
> diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
> index 0f519db..e9d5095 100644
> --- a/drivers/input/joystick/gf2k.c
> +++ b/drivers/input/joystick/gf2k.c
> @@ -42,7 +42,7 @@ MODULE_LICENSE("GPL");
>  
>  #define GF2K_START		400	/* The time we wait for the first bit [400 us] */
>  #define GF2K_STROBE		40	/* The time we wait for the first bit [40 us] */
> -#define GF2K_TIMEOUT		4	/* Wait for everything to settle [4 ms] */
> +#define GF2K_TIMEOUT		4000	/* Wait for everything to settle [4000 us] */
>  #define GF2K_LENGTH		80	/* Max number of triplets in a packet */
>  
>  /*
> @@ -138,7 +138,7 @@ static void gf2k_trigger_seq(struct gameport *gameport, short *seq)
>  	i = 0;
>          do {
>  		gameport_trigger(gameport);
> -		t = gameport_time(gameport, GF2K_TIMEOUT * 1000);
> +		t = gameport_time(gameport, GF2K_TIMEOUT);
>  		while ((gameport_read(gameport) & 1) && t) t--;
>                  udelay(seq[i]);
>          } while (seq[++i]);
> @@ -259,11 +259,11 @@ static int gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
>  
>  	gf2k_trigger_seq(gameport, gf2k_seq_reset);
>  
> -	msleep(GF2K_TIMEOUT);
> +	usleep_range(GF2K_TIMEOUT, GF2K_TIMEOUT + 100);
>  
>  	gf2k_trigger_seq(gameport, gf2k_seq_digital);
>  
> -	msleep(GF2K_TIMEOUT);
> +	usleep_range(GF2K_TIMEOUT, GF2K_TIMEOUT + 100);
>  
>  	if (gf2k_read_packet(gameport, GF2K_LENGTH, data) < 12) {
>  		err = -ENODEV;
> diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
> index 4a95b22..e5a1292 100644
> --- a/drivers/input/joystick/sidewinder.c
> +++ b/drivers/input/joystick/sidewinder.c
> @@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
>  
>  #define SW_START	600	/* The time we wait for the first bit [600 us] */
>  #define SW_STROBE	60	/* Max time per bit [60 us] */
> -#define SW_TIMEOUT	6	/* Wait for everything to settle [6 ms] */
> +#define SW_TIMEOUT	6000	/* Wait for everything to settle [6000 us] */
>  #define SW_KICK		45	/* Wait after A0 fall till kick [45 us] */
>  #define SW_END		8	/* Number of bits before end of packet to kick */
>  #define SW_FAIL		16	/* Number of packet read errors to fail and reinitialize */
> @@ -139,7 +139,7 @@ static int sw_read_packet(struct gameport *gameport, unsigned char *buf, int len
>  	unsigned char pending, u, v;
>  
>  	i = -id;						/* Don't care about data, only want ID */
> -	timeout = id ? gameport_time(gameport, SW_TIMEOUT * 1000) : 0; /* Set up global timeout for ID packet */
> +	timeout = id ? gameport_time(gameport, SW_TIMEOUT) : 0; /* Set up global timeout for ID packet */
>  	kick = id ? gameport_time(gameport, SW_KICK) : 0;	/* Set up kick timeout for ID packet */
>  	start = gameport_time(gameport, SW_START);
>  	strobe = gameport_time(gameport, SW_STROBE);
> @@ -248,7 +248,7 @@ static void sw_init_digital(struct gameport *gameport)
>  	i = 0;
>          do {
>                  gameport_trigger(gameport);			/* Trigger */
> -		t = gameport_time(gameport, SW_TIMEOUT * 1000);
> +		t = gameport_time(gameport, SW_TIMEOUT);
>  		while ((gameport_read(gameport) & 1) && t) t--;	/* Wait for axis to fall back to 0 */
>                  udelay(seq[i]);					/* Delay magic time */
>          } while (seq[++i]);
> @@ -483,13 +483,13 @@ static int sw_read(struct sw *sw)
>  		" - reinitializing joystick.\n", sw->gameport->phys);
>  
>  	if (!i && sw->type == SW_ID_3DP) {					/* 3D Pro can be in analog mode */
> -		mdelay(3 * SW_TIMEOUT);
> +		mdelay(3 * (SW_TIMEOUT / 1000));
>  		sw_init_digital(sw->gameport);
>  	}
>  
> -	mdelay(SW_TIMEOUT);
> +	mdelay(SW_TIMEOUT / 1000);
>  	i = sw_read_packet(sw->gameport, buf, SW_LENGTH, 0);			/* Read normal data packet */
> -	mdelay(SW_TIMEOUT);
> +	mdelay(SW_TIMEOUT / 1000);
>  	sw_read_packet(sw->gameport, buf, SW_LENGTH, i);			/* Read ID packet, this initializes the stick */
>  
>  	sw->fail = SW_FAIL;
> @@ -616,14 +616,14 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  		gameport->phys, gameport->io, gameport->speed);
>  
>  	i = sw_read_packet(gameport, buf, SW_LENGTH, 0);		/* Read normal packet */
> -	msleep(SW_TIMEOUT);
> +	usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
>  	dbg("Init 1: Mode %d. Length %d.", m , i);
>  
>  	if (!i) {							/* No data. 3d Pro analog mode? */
>  		sw_init_digital(gameport);				/* Switch to digital */
> -		msleep(SW_TIMEOUT);
> +		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
>  		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Retry reading packet */
> -		msleep(SW_TIMEOUT);
> +		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
>  		dbg("Init 1b: Length %d.", i);
>  		if (!i) {						/* No data -> FAIL */
>  			err = -ENODEV;
> @@ -636,7 +636,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  	dbg("Init 2: Mode %d. ID Length %d.", m, j);
>  
>  	if (j <= 0) {							/* Read ID failed. Happens in 1-bit mode on PP */
> -		msleep(SW_TIMEOUT);
> +		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
>  		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Retry reading packet */
>  		m |= sw_guess_mode(buf, i);
>  		dbg("Init 2b: Mode %d. Length %d.", m, i);
> @@ -644,7 +644,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  			err = -ENODEV;
>  			goto fail2;
>  		}
> -		msleep(SW_TIMEOUT);
> +		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
>  		j = sw_read_packet(gameport, idbuf, SW_LENGTH, i);	/* Retry reading ID */
>  		dbg("Init 2c: ID Length %d.", j);
>  	}
> @@ -655,7 +655,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  
>  	do {
>  		k--;
> -		msleep(SW_TIMEOUT);
> +		usleep_range(SW_TIMEOUT, SW_TIMEOUT + 100);
>  		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Read data packet */
>  		dbg("Init 3: Mode %d. Length %d. Last %d. Tries %d.", m, i, l, k);
>  
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index 21bea52..14679e9 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -689,7 +689,7 @@ static int lm8323_probe(struct i2c_client *client,
>  			break;
>  		}
>  
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  
>  	lm8323_configure(lm);
> diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
> index d6e8f58..2ede00b 100644
> --- a/drivers/input/mouse/navpoint.c
> +++ b/drivers/input/mouse/navpoint.c
> @@ -166,7 +166,7 @@ static void navpoint_up(struct navpoint *navpoint)
>  	for (timeout = 100; timeout != 0; --timeout) {
>  		if (!(pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS))
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  
>  	if (timeout == 0)
> diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
> index 9b4d9a5..d8ac9f9 100644
> --- a/drivers/input/mouse/pxa930_trkball.c
> +++ b/drivers/input/mouse/pxa930_trkball.c
> @@ -85,7 +85,7 @@ static int write_tbcr(struct pxa930_trkball *trkball, int v)
>  	while (--i) {
>  		if (__raw_readl(trkball->mmio_base + TBCR) == v)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  
>  	if (i == 0) {
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index aa7c5da..826ac65 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -29,9 +29,9 @@
>   * after soft reset, we should wait for 1 ms
>   * before the device becomes operational
>   */
> -#define SOFT_RESET_DELAY_MS	3
> +#define SOFT_RESET_DELAY_US	3000
>  /* and after hard reset, we should wait for max 500ms */
> -#define HARD_RESET_DELAY_MS	500
> +#define HARD_RESET_DELAY_US	500000
>  
>  /* Registers by SMBus address */
>  #define PAGE_SEL_REG		0xff
> @@ -311,7 +311,7 @@ static int synaptics_i2c_reset_config(struct i2c_client *client)
>  	if (ret) {
>  		dev_err(&client->dev, "Unable to reset device\n");
>  	} else {
> -		msleep(SOFT_RESET_DELAY_MS);
> +		usleep_range(SOFT_RESET_DELAY_US, SOFT_RESET_DELAY_US + 100);
>  		ret = synaptics_i2c_config(client);
>  		if (ret)
>  			dev_err(&client->dev, "Unable to config device\n");
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 1ce3ecb..b1a5a6c 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -58,7 +58,7 @@
>   * files.
>   */
>  
> -#define TS_POLL_DELAY	1	/* ms delay before the first sample */
> +#define TS_POLL_DELAY	1000	/* us delay before the first sample */
>  #define TS_POLL_PERIOD	5	/* ms delay between samples */
>  
>  /* this driver doesn't aim at the peak continuous sample rate */
> @@ -857,7 +857,7 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
>  	struct ads7846 *ts = handle;
>  
>  	/* Start with a small delay before checking pendown state */
> -	msleep(TS_POLL_DELAY);
> +	usleep_range(TS_POLL_DELAY, TS_POLL_DELAY + 100);
>  
>  	while (!ts->stopped && get_pendown_state(ts)) {
>  
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 703e295..379dd31 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -67,7 +67,7 @@
>  #define EDT_SWITCH_MODE_RETRIES		10
>  #define EDT_SWITCH_MODE_DELAY		5 /* msec */
>  #define EDT_RAW_DATA_RETRIES		100
> -#define EDT_RAW_DATA_DELAY		1 /* msec */
> +#define EDT_RAW_DATA_DELAY		1000 /* usec */
>  
>  enum edt_ver {
>  	M06,
> @@ -664,7 +664,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
>  	}
>  
>  	do {
> -		msleep(EDT_RAW_DATA_DELAY);
> +		usleep_range(EDT_RAW_DATA_DELAY, EDT_RAW_DATA_DELAY + 100);
>  		val = edt_ft5x06_register_read(tsdata, 0x08);
>  		if (val < 1)
>  			break;
> diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
> index da6004e..3f14b5a 100644
> --- a/drivers/input/touchscreen/w90p910_ts.c
> +++ b/drivers/input/touchscreen/w90p910_ts.c
> @@ -171,9 +171,9 @@ static int w90p910_open(struct input_dev *dev)
>  	clk_enable(w90p910_ts->clk);
>  
>  	__raw_writel(ADC_RST1, w90p910_ts->ts_reg);
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  	__raw_writel(ADC_RST0, w90p910_ts->ts_reg);
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  
>  	/* set delay and screen type */
>  	val = __raw_readl(w90p910_ts->ts_reg + 0x04);
> diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
> index e2ccd68..cebd3a8 100644
> --- a/drivers/input/touchscreen/zylonite-wm97xx.c
> +++ b/drivers/input/touchscreen/zylonite-wm97xx.c
> @@ -81,7 +81,7 @@ static void wm97xx_acc_pen_up(struct wm97xx *wm)
>  {
>  	int i;
>  
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  
>  	for (i = 0; i < 16; i++)
>  		MODR;
> @@ -98,7 +98,7 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
>  	 * for samples.  The controller can't have a suitably low
>  	 * threshold set to use the notifications it gives.
>  	 */
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  
>  	if (tries > 5) {
>  		tries = 0;
> -- 
> 2.6.2
> 

-- 
Dmitry
