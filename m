From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH v3] input: keyboard: snvs_pwrkey: Send key events for
 i.MX6 S, DL and Q
Date: Mon, 16 Sep 2019 07:45:37 +0000
Message-ID: <VE1PR04MB663896B94C68B5EF9AE0BE36898C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190904062329.97520-1-robin@protonic.nl>
 <20190912201300.GA636@penguin> <803592d161b9ca75d6ac1c2c54e891a1@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <803592d161b9ca75d6ac1c2c54e891a1@protonic.nl>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robin <robin@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, "linux-input @ vger . kernel . org" <linux-input@vger.kernel.org>, Adam Ford <aford173@gmail.com>, "linux-arm-kernel @ lists . infradead . org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On 2019/9/13 15:31 robin <robin@protonic.nl> wrote:> 
> Hi Dmitry,
> 
> On 2019-09-12 22:13, Dmitry Torokhov wrote:
> > Hi Robin,
> >
> > On Wed, Sep 04, 2019 at 06:23:29AM +0000, Robin van der Gracht wrote:
> >> The first generation i.MX6 processors does not send an interrupt when
> >> the power key is pressed. It sends a power down request interrupt if
> >> the key is released before a hard shutdown (5 second press). This
> >> should allow software to bring down the SoC safely.
> >>
> >> For this driver to work as a regular power key with the older SoCs,
> >> we need to send a keypress AND release when we get the power down
> >> request irq.
> >>
> >> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> >> ---
> >> @@ -67,13 +83,17 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int
> >> irq, void *dev_id)  {
> >>  	struct platform_device *pdev = dev_id;
> >>  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> >> +	unsigned long expire = jiffies;
> >>  	u32 lp_status;
> >>
> >>  	pm_wakeup_event(pdata->input->dev.parent, 0);
> >>
> >>  	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
> >> -	if (lp_status & SNVS_LPSR_SPO)
> >> -		mod_timer(&pdata->check_timer, jiffies +
> >> msecs_to_jiffies(DEBOUNCE_TIME));
> >> +	if (lp_status & SNVS_LPSR_SPO) {
> >> +		if (pdata->minor_rev > 0)
> >> +			expire = jiffies + msecs_to_jiffies(DEBOUNCE_TIME);
> >> +		mod_timer(&pdata->check_timer, expire);
> >
> > Why do we even need to fire the timer in case of the first generation
> > hardware? Just send press and release events directly from the ISR.
That timer looks like a software debounce to prevent unexpected and
meaningless interrupt/event caused by quick press/release.   
> 
> Robin Gong proposed to move the code to imx_imx_snvs_check_for_events()
> to improve readability and unload the ISR.
> 
> But since I, eventually, couldn't use the existing handling in
> imx_imx_snvs_check_for_events(), I do see why you're asking.
> 
> I'll move the code to the ISR and submit a new patch.
> 
> Robin van der Gracht
