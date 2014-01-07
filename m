From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Tue, 07 Jan 2014 09:35:45 +0900
Message-ID: <000f01cf0b40$670c3720$3524a560$%han@samsung.com>
References: <20140104090147.GA16680@core.coreip.homeip.net>
 <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
 <20140106180705.GB2754@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31584 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbaAGAfw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jan 2014 19:35:52 -0500
In-reply-to: <20140106180705.GB2754@core.coreip.homeip.net>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Sebastian Reichel' <sre@debian.org>, linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, January 07, 2014 3:07 AM, Dmitry Torokhov wrote:
> On Mon, Jan 06, 2014 at 11:25:54AM +0900, Jingoo Han wrote:
> > On Saturday, January 04, 2014 6:02 PM, Dmitry Torokhov wrote:
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >
> > > Compile-tested only.
> > >
> > >
> > >  drivers/input/keyboard/twl4030_keypad.c | 70 +++++++++++----------------------
> > >  1 file changed, 22 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> > > index f663c19..71eb041 100644
> > > --- a/drivers/input/keyboard/twl4030_keypad.c
> > > +++ b/drivers/input/keyboard/twl4030_keypad.c
> >
> > [.....]
> >
> > > -static int twl4030_kp_remove(struct platform_device *pdev)
> > > -{
> > > -	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
> > > -
> > > -	free_irq(kp->irq, kp);
> > > -	input_unregister_device(kp->input);
> >
> > Hi Dmitry Torokhov,
> >
> > IMHO, input_unregister_device() seems to be necessary,
> > because input_register_device() is still used.
> > If I am wrong, please let me know kindly.
> 
> No, input_unregister_device() is not needed (although it can be used)
> with managed input devices (ones that are allocated with
> devm_input_allocate_device()) because input_register_device() will
> automatically insert devres entry for such devices. So for managed input
> devices that were registered with input subsystem there are 2 separate
> devres entries: one for unregistering the device and another is to
> finally release all resources. If you had a sequence:
> 
> 	devm_kzalloc(...);
> 	devm_input_allocate_device(...);
> 	devm_devm_ioremap_resource(...);
> 	devm_request_irq(...);
> 	input_register_device(...);
> 
> then unwind sequence will be:
> 
> 	unregister input device (but input device structure is still
> 		present in memory and input_event() can be called, but
> 		events won't be delivered anywhere - that is done so
> 		that we can survive releasing IRQs after unregistering
> 		managed input device)
> 	free IRQ
> 	release resources
> 	free input device structure
> 	free kzalloc memory
> 
> Hope this helps.

Oh, I really appreciate your detailed and kind comments. :-)

I checked the following. As you said, input_register_device()
automatically inserts devres entry.

./drivers/input/input.c
int input_register_device(struct input_dev *dev)
{
        struct input_devres *devres = NULL;
        struct input_handler *handler;
        unsigned int packet_size;
        const char *path;
        int error;

        if (dev->devres_managed) {
                devres = devres_alloc(devm_input_device_unregister,
                                      sizeof(struct input_devres), GFP_KERNEL);

Thank you so much.

Best regards,
Jingoo Han

