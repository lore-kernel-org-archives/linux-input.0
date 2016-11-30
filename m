From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: imx6ul_tsc: convert int to u32
Date: Wed, 30 Nov 2016 10:28:35 -0800
Message-ID: <20161130182835.GB31934@dtor-ws>
References: <1480423249-2933-1-git-send-email-guy.shapiro@mobi-wize.com>
 <AM4PR0401MB2324906F15C93517C6081569908C0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33684 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757534AbcK3S2i (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 13:28:38 -0500
Received: by mail-pf0-f196.google.com with SMTP id 144so10574255pfv.0
        for <linux-input@vger.kernel.org>; Wed, 30 Nov 2016 10:28:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AM4PR0401MB2324906F15C93517C6081569908C0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "bjorn.forsman@gmail.com" <bjorn.forsman@gmail.com>

On Wed, Nov 30, 2016 at 02:10:46AM +0000, Bough Chen wrote:
> [...]
> 
> > -----Original Message-----
> > From: Guy Shapiro [mailto:guy.shapiro@mobi-wize.com]
> > Sent: Tuesday, November 29, 2016 8:41 PM
> > To: dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
> > Cc: Bough Chen <haibo.chen@nxp.com>; Fabio Estevam
> > <fabio.estevam@nxp.com>; bjorn.forsman@gmail.com; Guy Shapiro
> > <guy.shapiro@mobi-wize.com>
> > Subject: [PATCH] input: touchscreen: imx6ul_tsc: convert int to u32
> > 
> > The code uses of_property_read_u32 and expects positive values.
> > However, the values are stored in signed int variables.
> > Additionally, the registers values are also stored in signed variables without a
> > good reason (readl/writel expect u32).
> > 
> > The only time this caused a real bug was in the new average-samples property,
> > in which the property is numerically compared and implicitly expected to be
> > positive.
> > I believe it's better to change all the properties and registers to u32, for
> > consistency and warnings reduction.
> > 
> > Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> > Reported-by: Bjørn Forsman <bjorn.forsman@gmail.com>
> > ---
> >  drivers/input/touchscreen/imx6ul_tsc.c | 38 +++++++++++++++++--------------
> > ---
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/imx6ul_tsc.c
> > b/drivers/input/touchscreen/imx6ul_tsc.c
> > index 31724d9..71ea2d8 100644
> > --- a/drivers/input/touchscreen/imx6ul_tsc.c
> > +++ b/drivers/input/touchscreen/imx6ul_tsc.c
> > @@ -86,9 +86,9 @@ struct imx6ul_tsc {
> >  	struct clk *adc_clk;
> >  	struct gpio_desc *xnur_gpio;
> > 
> > -	int measure_delay_time;
> > -	int pre_charge_time;
> > -	int average_samples;
> > +	u32 measure_delay_time;
> > +	u32 pre_charge_time;
> > +	u32 average_samples;
> > 
> >  	struct completion completion;
> >  };
> > @@ -99,10 +99,10 @@ struct imx6ul_tsc {
> >   */
> >  static int imx6ul_adc_init(struct imx6ul_tsc *tsc)  {
> > -	int adc_hc = 0;
> > -	int adc_gc;
> > -	int adc_gs;
> > -	int adc_cfg;
> > +	u32 adc_hc = 0;
> > +	u32 adc_gc;
> > +	u32 adc_gs;
> > +	u32 adc_cfg;
> >  	int timeout;
> 
> Here, *timeout* should be also change to unsigned long.
> 
> > 
> >  	reinit_completion(&tsc->completion);
> > @@ -155,7 +155,7 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
> >   */
> >  static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)  {
> > -	int adc_hc0, adc_hc1, adc_hc2, adc_hc3, adc_hc4;
> > +	u32 adc_hc0, adc_hc1, adc_hc2, adc_hc3, adc_hc4;
> > 
> >  	adc_hc0 = DISABLE_CONVERSION_INT;
> >  	writel(adc_hc0, tsc->adc_regs + REG_ADC_HC0); @@ -180,8 +180,8
> > @@ static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
> >   */
> >  static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)  {
> > -	int basic_setting = 0;
> > -	int start;
> > +	u32 basic_setting = 0;
> > +	u32 start;
> > 
> >  	basic_setting |= tsc->measure_delay_time << 8;
> >  	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE; @@ -
> > 216,8 +216,8 @@ static int imx6ul_tsc_init(struct imx6ul_tsc *tsc)
> > 
> >  static void imx6ul_tsc_disable(struct imx6ul_tsc *tsc)  {
> > -	int tsc_flow;
> > -	int adc_cfg;
> > +	u32 tsc_flow;
> > +	u32 adc_cfg;
> > 
> >  	/* TSC controller enters to idle status */
> >  	tsc_flow = readl(tsc->tsc_regs + REG_TSC_FLOW_CONTROL); @@ -
> > 234,8 +234,8 @@ static void imx6ul_tsc_disable(struct imx6ul_tsc *tsc)  static
> > bool tsc_wait_detect_mode(struct imx6ul_tsc *tsc)  {
> >  	unsigned long timeout = jiffies + msecs_to_jiffies(2);
> > -	int state_machine;
> > -	int debug_mode2;
> > +	u32 state_machine;
> > +	u32 debug_mode2;
> > 
> >  	do {
> >  		if (time_after(jiffies, timeout))
> > @@ -253,10 +253,10 @@ static bool tsc_wait_detect_mode(struct imx6ul_tsc
> > *tsc)  static irqreturn_t tsc_irq_fn(int irq, void *dev_id)  {
> >  	struct imx6ul_tsc *tsc = dev_id;
> > -	int status;
> > -	int value;
> > +	u32 status;
> > +	u32 value;
> >  	int x, y;
> 
> *x,y* also need to change to u32.

I made changes recommended by Bough and applied.

Thanks.
 
-- 
Dmitry
