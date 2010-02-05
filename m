From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Fri, 5 Feb 2010 11:39:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002051138170.15395@pobox.suse.cz>
References: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu> <20100205055302.GA17121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42561 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab0BEKjM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2010 05:39:12 -0500
In-Reply-To: <20100205055302.GA17121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, chatty@enac.fr, evilynux@gmail.com

On Thu, 4 Feb 2010, Dmitry Torokhov wrote:

>  +
> > +		if (matched < nd->contact_count) {
> > +			for (i = 0; i < nd->contact_count; i++) {
> > +				if (nd->contacts[i].logical_id < 0) {
> > +					for (j = 0; j < nd->prev_contact_count;
> > +					     j++) {
> > +						if (nd->
> > +						    prev_contacts[j].confidence
> > +						    &&
> > +						    (contact_map
> > +						     [nd->
> > +						      prev_contacts
> > +						      [j].logical_id] < 0)
> > +						    &&
> > +						    (abs
> > +						     (nd->contacts[i].x -
> > +						      nd->prev_contacts[j].x) <
> > +						     nd->max_width)
> > +						    &&
> > +						    (abs
> > +						     (nd->contacts[i].y -
> > +						      nd->prev_contacts[j].y) <
> > +						     nd->max_height)) {
> > +							nd->contacts
> > +							    [i].logical_id =
> > +							    nd->prev_contacts
> > +							    [j].logical_id;
> > +							contact_map
> > +							    [nd->prev_contacts
> > +							     [j].logical_id]
> > +							    = i;
> > +							matched++;
> 
> OK, this kind code just makes me want to poke my eyes with a fork... 5
> times...
> 
> Seriously, either factor it out into a nice function, or say "screw it"
> to the 80 columt limit, or maybe both. Anything but this.

I absolutely agree with Dmitry here.

Plus, even if formatted/factored-out properky, the condition seems to be 
very unintuitivie. Maybe a line of two of comments, explaining what is the 
actual condition testing, might be very helpful.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
