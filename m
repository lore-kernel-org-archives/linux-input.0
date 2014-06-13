From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v2 2/2] Add support for Compact (Bluetooth|USB) keyboard
 with Trackpoint
Date: Fri, 13 Jun 2014 23:45:38 +0200
Message-ID: <20140613234538.c960b52757f554699f2dbd1f@ao2.it>
References: <1402439094-25464-1-git-send-email-jm@lentin.co.uk>
	<1402439094-25464-3-git-send-email-jm@lentin.co.uk>
	<20140611103616.79b40e7b0bbf3447837921fc@ao2.it>
	<alpine.DEB.2.02.1406112253440.4059@marmot.wormnet.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:64750 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbaFMVp5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jun 2014 17:45:57 -0400
In-Reply-To: <alpine.DEB.2.02.1406112253440.4059@marmot.wormnet.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 12 Jun 2014 09:56:41 +0100 (BST)
Jamie Lentin <jm@lentin.co.uk> wrote:

> On Wed, 11 Jun 2014, Antonio Ospite wrote:
> 

[...]

> >> +static int tpcompactkbd_input_mapping(struct hid_device *hdev,
> >
> > Maybe name these functions like tpkbd_input_mapping_compact()?
> >
> > This way the namespace is more consistent, and follows the logic of
> > patch 1/2 more closely.
> >
> > Use this scheme at least for functions which have a _tp() counterpart.
> 
> Previously the tpkbd driver had various functions marked "_tp" to indicate 
> that it's for the "mouse" half of the keyboard as the kernel sees it, 
> however it does nothing special with the keyboard half. I was intending 
> (somewhat sloppily) to repurpose this into having versions of each 
> function for each keyboard, and a common function to switch between them. 
> Should make it fairly easy to add extra keyboards in the future.
> 
> The problem, as ever, is choosing decent names for them. It should 
> probably be either:-
> 
> * tpkbd_input_mapping_usbkbd
> * tpkbd_input_mapping_compactkbd
> ...and tpkbd_input_mapping switches between them
> 
> or rename the driver to hid-lenovo and do:-
> 

I am OK with a rename. Most files in drivers/hid are per-vendor after
all. Jiri?

> * lenovo_input_mapping_tpkbd
> * lenovo_input_mapping_compacttp

I think you meant lenovo_input_mapping_compactkbd ? :)

> ...and lenovo_input_mapping switches between them
> 
> The latter seems a bit too invasive, but I'm not sure how obvious with the 
> former that it'd be that the "Compact USB keyboard" is in-fact a 
> compactkbd not a usbkbd. The former is probably what I'll go for unless 
> you have any thoughts.
> 
[...]

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
