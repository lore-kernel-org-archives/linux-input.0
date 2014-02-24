From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
Date: Mon, 24 Feb 2014 17:47:17 +0300
Message-ID: <20140224144717.GP26776@mwanda>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de>
 <20140224133316.GI26722@mwanda>
 <201402241538.26530.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <201402241538.26530.jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, jic23@cam.ac.uk, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 24, 2014 at 03:38:26PM +0100, Juergen Beisert wrote:
> Hi Dan,
> 
> On Monday 24 February 2014 14:33:16 Dan Carpenter wrote:
> > On Mon, Feb 24, 2014 at 02:16:24PM +0100, Juergen Beisert wrote:
> > > > While I don't have much experience with the TS part of the code but I
> > > > can investigate if you don't have any idea.
> > >
> > > can you please test the following patch?
> > > After releasing the touchscreen the internal state machine was left in a
> > > wrong state.
> > >
> > > diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> > > index e2dd783..558a76c 100644
> > > --- a/drivers/staging/iio/adc/mxs-lradc.c  
> > > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > > @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct
> > > mxs_lradc *lradc, bool valid) }
> > >
> > >         /* if it is released, wait for the next touch via IRQ */
> > > +       lradc->cur_plate = LRADC_TOUCH;
> > >         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
> > >         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
> > >         } 
> >
> > I am confused.  Why don't you send this like a normal patch?
> 
> For testing fist. But you are right, patch will follow.
> 

Never mind, I suck at reading.

regards,
dan carpenter
