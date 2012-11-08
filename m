From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v4] Input: matrix-keypad - Add device tree support
Date: Thu, 8 Nov 2012 05:23:47 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA66B1F@DBDE01.ent.ti.com>
References: <1352280725-452-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6620F@DBDE01.ent.ti.com>
 <509A92E6.8020905@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56707 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2KHFYC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 00:24:02 -0500
In-Reply-To: <509A92E6.8020905@wwwdotorg.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Stephen Warren' <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Nov 07, 2012 at 22:27:10, Stephen Warren wrote:
> On 11/07/2012 02:38 AM, AnilKumar, Chimata wrote:
> > On Wed, Nov 07, 2012 at 15:02:05, AnilKumar, Chimata wrote:
> >> Add device tree support to matrix keypad driver and usage details
> >> are added to device tree documentation. Driver was tested on AM335x
> >> EVM.
> > 
> > +Stephen
> > 
> > ACK from the reviewers (Rob Herring and Stephen Warren) of earlier
> > versions will help to get this in.
> 
> I thought I already asked a question about the clustered IRQ properties,
> which don't make sense.

Hi Stephen,

In v4 I have added the details of clustered-irq properties

clustered-irq: have clustered irq number, that is needed if the irq
is a combined irq source for the whole matrix keypad. This is useful
if rows and columns of the keypad are connected to a GPIO expander.

clustered-irq-flags: clustered irq flags to specify the interrupt line
behavior among IRQF_TRIGGER_*.

These flags might vary depending on the hardware of the IO-expander
IRQ this flag is either IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING or
IRQF_TRIGGER_HIGH or IRQF_TRIGGER_LOW or combinations.

The current matrix_keypad.c driver uses these parameters in this way

        if (pdata->clustered_irq > 0) {
                err = request_irq(pdata->clustered_irq,
                                matrix_keypad_interrupt,
                                pdata->clustered_irq_flags,
                                "matrix-keypad", keypad);
                if (err) {
                        dev_err(&pdev->dev,
                                "Unable to acquire clustered interrupt\n");
                        goto err_free_rows;
                }
        }

In my v5 version I will remove these parameters and we can add if actual users
come into existence. My thought process was if somebody uses these, might affect.

Thanks
AnilKumar
