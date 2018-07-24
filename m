From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH v1 07/10] Input: atmel_mxt_ts - zero terminate config
 firmware file
Date: Tue, 24 Jul 2018 21:43:57 +0100
Message-ID: <20180724204357.GA5025@hairyalien>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-7-nick@shmanahar.org>
 <20180723223534.GK100814@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723223534.GK100814@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 23, 2018 at 03:35:34PM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 20, 2018 at 10:51:19PM +0100, Nick Dyer wrote:
> > From: Nick Dyer <nick.dyer@itdev.co.uk>
> > 
> > We use sscanf to parse the configuration file, so it's necessary to zero
> > terminate the configuration otherwise a truncated file can cause the
> > parser to run off into uninitialised memory.
> > 
> > Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 36 +++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 0ce126e918f1..2d1fddafb7f9 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -279,7 +279,7 @@ enum mxt_suspend_mode {
> >  
> >  /* Config update context */
> >  struct mxt_cfg {
> > -	const u8 *raw;
> > +	u8 *raw;
> >  	size_t raw_size;
> >  	off_t raw_pos;
> >  
> > @@ -1451,14 +1451,21 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
> >  	u32 info_crc, config_crc, calculated_crc;
> >  	u16 crc_start = 0;
> >  
> > -	cfg.raw = fw->data;
> > +	/* Make zero terminated copy of the OBP_RAW file */
> > +	cfg.raw = kzalloc(fw->size + 1, GFP_KERNEL);
> 
> kmemdup_nul()? I guess config it not that big to be concerned with
> kmalloc() vs vmalloc() and allocation failures...

Yes, that looks like it should work. There's a limit on the size of the
data due to the I2C address space, so we should be fine.

Nick
