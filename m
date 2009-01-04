From: Nick Warne <nick@ukfsn.org>
Subject: Re: [PATCH] Input: atkbd - broaden the Dell DMI signatures
Date: Sun, 4 Jan 2009 17:49:17 +0000
Message-ID: <20090104174917.4ef6fe9e@sauron.linicks.net>
References: <20081111074702.75e71055@sauron.linicks.net>
	<20081229113621.1a64caea@sauron.linicks.net>
	<20081229142902.GC31266@srcf.ucam.org>
	<200812292015.34296.dtor@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ukfsn.org ([77.75.108.10]:33725 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbZADRtV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 4 Jan 2009 12:49:21 -0500
In-Reply-To: <200812292015.34296.dtor@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org

Hi Matthew, Dmitry,

On Mon, 29 Dec 2008 20:15:33 -0800
Dmitry Torokhov <dtor@mail.ru> wrote:

> On Monday 29 December 2008 06:29:02 Matthew Garrett wrote:
> > Some Dells need the dell input quirk applied but have a different
> > vendor string in their DMI tables. Add an extra entry to cover
> > these machines as well.
> >
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> >
> > ---
> >
> > Dmitry, any chance of getting this queued for .29? Probably
> > suitable for -stable as well.
> 
> Yep, will send with the rest of stuff for .29. Thank you Matthew.

I am mailing off LKML here, as I don't know what to think, but somebody
has reported a new ID for these Dell laptops:




http://ubuntuforums.org/showpost.php?p=6488632&postcount=37
===
You say you're looking for people whose Vendor IDs don't say "Dell"?

Looks like you're looking for me.

261-BIOS Information
278: Vendor: Phoenix Technologies LTD
312- Version: A04
809- Manufacturer: Dell Inc.
834: Product Name: Inspiron 700m
869- Version: -1
--
1050- Manufacturer: DELL SYSTEM
1077: Product Name: 0D9593
1099- Version:
===


I dunno if this is a rogue post, but have no reason to assume otherwise.

Will this never end?

Nick
-- 
Free Software Foundation Associate Member 5508
http://linicks.net/
