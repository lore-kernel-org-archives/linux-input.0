From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH] Input: add error handling for da9052_reg_write
Date: Tue, 12 Jun 2018 05:37:08 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AFADA@SW-EX-MBX02.diasemi.com>
References: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
 <20180611173017.GD251078@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611173017.GD251078@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 11 June 2018 18:30 wrote Dmitry Torokhov 

> Subject: Re: [PATCH] Input: add error handling for da9052_reg_write
> 
> Hi Zhouyang,
> 
> On Mon, Jun 11, 2018 at 01:23:39PM +0800, Zhouyang Jia wrote:
> > When da9052_reg_write fails, the lack of error-handling code may
> > cause unexpected results.
> >
> > This patch adds error-handling code after calling da9052_reg_write.
> >
> > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> > ---
> >  drivers/input/touchscreen/da9052_tsi.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/da9052_tsi.c
> b/drivers/input/touchscreen/da9052_tsi.c
> > index b5dfd594..60c82a0 100644
> > --- a/drivers/input/touchscreen/da9052_tsi.c
> > +++ b/drivers/input/touchscreen/da9052_tsi.c
> > @@ -319,8 +319,11 @@ static int da9052_ts_probe(struct platform_device *pdev)
> >  static int  da9052_ts_remove(struct platform_device *pdev)
> >  {
> >  	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
> > +	int error;
> >
> > -	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> > +	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> > +	if (error < 0)
> > +		return error;
> 
> No, this does not help anything. The remove() action must not fail
> (really, having it return an int and not void was an API mistake made
> long time ago), and thus returning early in and event of error failing
> to communicate with the device is a mistake. You really want to release
> the interrupts and memory and unregister input device before returning.
> 
> >
> >  	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
> >  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> > --
> > 2.7.4
> >

script?
https://patchwork.kernel.org/project/LKML/list/?submitter=181001
