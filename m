From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 14/15] Input: synaptics-rmi4 - ensure we have IRQs before
 reading status
Date: Tue, 4 Feb 2014 18:40:05 -0800
Message-ID: <20140205024004.GM1706@sonymobile.com>
References: <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
 <52F17379.6030306@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:14694 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754424AbaBECiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 21:38:21 -0500
Content-Disposition: inline
In-Reply-To: <52F17379.6030306@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linus.walleij@linaro.org

On Wed, Feb 05, 2014 at 12:10:49AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> > Cc: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > ---
> >   drivers/input/rmi4/rmi_f01.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> > index 22b57f2..06fc5bc 100644
> > --- a/drivers/input/rmi4/rmi_f01.c
> > +++ b/drivers/input/rmi4/rmi_f01.c
> > @@ -318,13 +318,15 @@ static int rmi_f01_initialize(struct rmi_function *fn)
> >   	ctrl_base_addr += sizeof(u8);
> >
> >   	data->interrupt_enable_addr = ctrl_base_addr;
> > -	error = rmi_read_block(rmi_dev, ctrl_base_addr,
> > -				data->device_control.interrupt_enable,
> > -				sizeof(u8) * (data->num_of_irq_regs));
> > -	if (error < 0) {
> > -		dev_err(&fn->dev,
> > -			"Failed to read F01 control interrupt enable register.\n");
> > -		goto error_exit;
> > +	if (data->num_of_irq_regs > 0) {
> > +		error = rmi_read_block(rmi_dev, ctrl_base_addr,
> > +					data->device_control.interrupt_enable,
> > +					sizeof(u8) * (data->num_of_irq_regs));
> > +		if (error < 0) {
> > +			dev_err(&fn->dev,
> > +				"Failed to read F01 control interrupt enable register.\n");
> > +			goto error_exit;
> > +		}
> 
> If we don't know the number of IRQ registers at this point, we're 
> basically screwed, as most of the control register positions will be 
> known correctly.  The previously submitted IRQ counting patch ensures 
> that number of IRQ registers is know by this point - if they aren't, 
> then we should probably fail entirely rather than just muddling along.
> 

Sounds good.  I just needed this to prevent random failure cases during
testing.  If your patch solves this problem, then it's probably a much
better way to address this.

> >   	}
> >
> >   	ctrl_base_addr += data->num_of_irq_regs;
> >
