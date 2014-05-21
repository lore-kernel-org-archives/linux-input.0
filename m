From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] input: pcap2: avoid calling mutex_lock() in irq handler
Date: Wed, 21 May 2014 11:17:50 +0200
Message-ID: <20140521111750.6e0fddfcc65522f9f3b70b66@ao2.it>
References: <1396731290-7062-1-git-send-email-khoroshilov@ispras.ru>
	<20140406202436.GA16739@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:6089 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbaEUJR5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 05:17:57 -0400
In-Reply-To: <20140406202436.GA16739@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Daniel Ribeiro <drwyrm@gmail.com>, Ilya Petrov <ilya.muromec@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>

On Sun, 6 Apr 2014 13:24:36 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Sun, Apr 06, 2014 at 12:54:50AM +0400, Alexey Khoroshilov wrote:
> > pcap_keys_handler() calls ezx_pcap_read() that calls mutex_lock().
> > pcap_keys_handler() is registered as nonthreaded irq handler,
> > that means sleeping function is called in irq handler.
> > 
> > The patch makes a switch to threaded irq handling.
> > Compile tested only.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > ---
> >  drivers/input/misc/pcap_keys.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/misc/pcap_keys.c b/drivers/input/misc/pcap_keys.c
> > index cd230365166e..2a10f3a30969 100644
> > --- a/drivers/input/misc/pcap_keys.c
> > +++ b/drivers/input/misc/pcap_keys.c
> > @@ -79,13 +79,15 @@ static int pcap_keys_probe(struct platform_device *pdev)
> >  	if (err)
> >  		goto fail_allocate;
> >  
> > -	err = request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_ONOFF),
> > -			pcap_keys_handler, 0, "Power key", pcap_keys);
> > +	err = request_threaded_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_ONOFF),
> > +				   NULL, pcap_keys_handler, 0,
> > +				   "Power key", pcap_keys);
> >  	if (err)
> >  		goto fail_register;
> >  
> > -	err = request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_MIC),
> > -			pcap_keys_handler, 0, "Headphone button", pcap_keys);
> > +	err = request_threaded_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_MIC),
> > +				   NULL, pcap_keys_handler, 0,
> > +				   "Headphone button", pcap_keys);
> 
> So I guess we do need threaded IRQ here, but I do not see the pcap's
> irqchip specifying IRQCHIP_ONESHOT_SAFE so I do not think
> request_threaded_irq() without IRQF_ONESHOT would succeed.
> 
> Can someone test the change to be sure?
>

Tested-by: Antonio Ospite <ao2@ao2.it>

I confirm the keys still work fine with the patch applied on a 3.2
kernel. I cannot test on a newer version for now.

Sorry for the delay.

Ciao ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
