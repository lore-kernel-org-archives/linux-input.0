From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] HTC Shift Touchscreen Driver
Date: Tue, 27 May 2008 10:55:06 -0400
Message-ID: <20080527105118.ZZRA012@mailhub.coreip.homeip.net>
References: <20080527144603.GA18796@s0.pofhq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756541AbYE0Ozc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080527144603.GA18796@s0.pofhq.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pau Oliva Fora (pof)" <pau@eslack.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Pau,

I have couple more comments...

On Tue, May 27, 2008 at 04:46:03PM +0200, Pau Oliva Fora (pof) wrote:
> +
> +static void htcpen_close(struct input_dev *dev)
> +{
> +	free_irq(HTCPEN_IRQ, dev);

No, free_irq() should go into htcpen_remove(). Otherwise if we don't
unload the driver and open the device again we will not have IRQ
handler installed.

> +	outb_p(DEVICE_DISABLE, HTCPEN_PORT_INIT);
> +}
> +
> +static int __devinit htcpen_isa_probe(struct device *dev, unsigned int id)
> +{
> +	int err;
> +	struct input_dev *htcpen_dev;
> +
> +	inb_p(HTCPEN_PORT_IRQ_CLEAR);

You should not touch the ports until you resetved them with request
region.

-- 
Dmitry
