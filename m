From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] Input: touchscreen-iproc: Add Broadcom iProc touchscreen
 driver
Date: Thu, 12 Mar 2015 15:44:19 -0700
Message-ID: <550216C3.8090807@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>  <1426182312-6081-1-git-send-email-jonathar@broadcom.com>  <1426182312-6081-2-git-send-email-jonathar@broadcom.com> <1426183169.2742.10.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426183169.2742.10.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 15-03-12 10:59 AM, Joe Perches wrote:
> On Thu, 2015-03-12 at 10:45 -0700, Jonathan Richardson wrote:
>> Add initial version of the Broadcom touchscreen driver.
> 
> style trivia:
> (any of which could be fixed/improved/ignored later)
> 
>> diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
> []
>> +static void ts_reg_dump(struct iproc_ts_priv *priv)
>> +{
>> +	struct device *dev = &priv->pdev->dev;
>> +
>> +	dev_dbg(dev, "regCtl1             = 0x%08x\n",
>> +				readl(priv->regs + REGCTL1));
> 
> The output case here generally isn't very important so
> sometimes it's better to use a macro like:
> 
> #define dbg_reg(dev, priv, reg)						\
> 	dev_dbg(dev, "%20s= 0x%08x\n", #reg, readl((priv)->regs + reg))
> 
>> +	dev_dbg(dev, "regCtl2             = 0x%08x\n",
>> +				readl(priv->regs + REGCTL2));
> 
> so these become
> 	dbg_reg(dev, priv, INTERRUPT_THRES);
> 	dbg_reg(dev, priv, INTERRUPT_MASK);
> 
> etc...
> 
> This style can reduce typo and copy/paste defects.
> 
>> +	dev_dbg(dev, "interrupt_Thres     = 0x%08x\n",
>> +				readl(priv->regs + INTERRUPT_THRES));
>> +	dev_dbg(dev, "interrupt_Mask      = 0x%08x\n",
>> +				readl(priv->regs + INTERRUPT_MASK));
>> +	dev_dbg(dev, "interrupt_Status    = 0x%08x\n",
>> +				readl(priv->regs + INTERRUPT_STATUS));
>> +	dev_dbg(dev, "controller_Status   = 0x%08x\n",
>> +				readl(priv->regs + CONTROLLER_STATUS));
>> +	dev_dbg(dev, "FIFO_Data           = 0x%08x\n",
>> +				readl(priv->regs + FIFO_DATA));
>> +	dev_dbg(dev, "analog_Control      = 0x%08x\n",
>> +				readl(priv->regs + ANALOG_CONTROL));
>> +	dev_dbg(dev, "aux_Data            = 0x%08x\n",
>> +				readl(priv->regs + AUX_DATA));
>> +	dev_dbg(dev, "debounce_Cntr_Stat  = 0x%08x\n",
>> +				readl(priv->regs + DEBOUNCE_CNTR_STAT));
>> +	dev_dbg(dev, "scan_Cntr_Stat      = 0x%08x\n",
>> +				readl(priv->regs + SCAN_CNTR_STAT));
>> +	dev_dbg(dev, "rem_Cntr_Stat       = 0x%08x\n",
>> +				readl(priv->regs + REM_CNTR_STAT));
>> +	dev_dbg(dev, "settling_Timer_Stat = 0x%08x\n",
>> +				readl(priv->regs + SETTLING_TIMER_STAT));
>> +	dev_dbg(dev, "spare_Reg           = 0x%08x\n",
>> +				readl(priv->regs + SPARE_REG));
>> +	dev_dbg(dev, "soft_Bypass_Control = 0x%08x\n",
>> +				readl(priv->regs + SOFT_BYPASS_CONTROL));
>> +	dev_dbg(dev, "soft_Bypass_Data    = 0x%08x\n",
>> +				readl(priv->regs + SOFT_BYPASS_DATA));
>> +}
> 
> []
> 
>> +static int get_tsc_config(struct device_node *np, struct iproc_ts_priv *priv)
>> +{
>> +	u32 val;
> []
>> +	if (of_property_read_u32(np, "debounce_timeout", &val) >= 0) {
>> +		if (val < 0 || val > 255) {
> 
> testing u32 < 0 isn't necessary.
> 
> Maybe it'd be better to emit the out of range value too
> 
>> +			dev_err(dev, "debounce_timeout must be [0-255]\n");
> 
> 			dev_err(dev, "debounce_timeout (%u) must be [0-255]\n", val);
> 
> 

Thanks. I'll make the suggested changes and send out a new patch.

Jon



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
