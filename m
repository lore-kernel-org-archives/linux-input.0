From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Mon, 12 Apr 2010 08:56:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004120855230.8345@pobox.suse.cz>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr> <1270915489.3869.12.camel@lovely> <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr> <alpine.LNX.2.00.1004102116370.8345@pobox.suse.cz> <20100412031856.GD29292@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57966 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab0DLG4h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Apr 2010 02:56:37 -0400
In-Reply-To: <20100412031856.GD29292@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, linux@philmerk.de

On Sun, 11 Apr 2010, Dmitry Torokhov wrote:

> > > > > +static void egalax_remove(struct hid_device *hdev)
> > > > > +{
> > > > > +	hid_hw_stop(hdev);
> > > > > +	kfree(hid_get_drvdata(hdev));
> > > > > +	hid_set_drvdata(hdev, NULL);
> > > > > +}
> > > > 
> > > > Why not using hid_hw_stop() instead of hid_set_drvdata()?
> > > > 
> > > 
> > > Er, actually for a previous driver Dmitry suggested to add this line and 
> > > I did it without trying to understand :-)
> > 
> > Currently no code should be relying on this, but it's always nice/safe to 
> > do such initialization. 
> > 
> > Using 'if (!hdev)' to check whether hdev is valid/initialized or not 
> > should be always legitimate thing to do.
> 
> How can hdev be NULL? You did you mean hid_get_drvdata(hdev) != NULL?

Yup, sorry.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
