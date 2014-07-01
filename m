From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid-appleir: Fix kernel panic due to null pointer
Date: Tue, 1 Jul 2014 08:55:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407010852160.1655@pobox.suse.cz>
References: <1404180865-3681-1-git-send-email-xerofoify@gmail.com> <alpine.LNX.2.00.1407010837370.1655@pobox.suse.cz> <20140701065021.GA887@mguzik.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55813 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaGAGzQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Jul 2014 02:55:16 -0400
In-Reply-To: <20140701065021.GA887@mguzik.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mateusz Guzik <mguzik@redhat.com>
Cc: Nicholas Krause <xerofoify@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 1 Jul 2014, Mateusz Guzik wrote:

> > > Fixes a null pointer in appleir_input_configured due to reading
> > > into wrong size array. Changed the variable to input_dev->keycodemax.
> > 
> > This is a stale changelog from the previous buggy version.
> > 
> > > Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> > > ---
> > >  drivers/hid/hid-appleir.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
> > > index 0e6a42d..cc02df4 100644
> > > --- a/drivers/hid/hid-appleir.c
> > > +++ b/drivers/hid/hid-appleir.c
> > > @@ -272,7 +272,7 @@ static void appleir_input_configured(struct hid_device *hid,
> > >  	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
> > >  
> > >  	memcpy(appleir->keymap, appleir_key_table, sizeof(appleir->keymap));
> > > -	for (i = 0; i < ARRAY_SIZE(appleir_key_table); i++)
> > > +	for (i = 0; i < appleir->keymap; i++)
> > 
> > This is wrong. appleir->keymap is an array, and you want to count its 
> > elements.
> > 
> 
> But where the claim of 'null pointer' is coming from (or reading/writing
> past the array for that matter)?
> 
> Replacing appleir_key_table with appleir->keymap is a noop anyway
> because:
> unsigned short keymap[ARRAY_SIZE(appleir_key_table)];

It's not really equivalent. ARRAY_SIZE counts the number of short-sized 
elements, sizeof() counts the number of bytes that fit into the data 
structure (which is twice as much, as sizeof(unsigned short) == 2).

-- 
Jiri Kosina
SUSE Labs
