From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: Allow changing not-yet-mapped usages
Date: Wed, 15 Sep 2010 19:15:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009151914570.26813@pobox.suse.cz>
References: <20100915045822.GA21672@core.coreip.homeip.net> <alpine.LNX.2.00.1009151645360.26813@pobox.suse.cz> <20100915161647.GA8862@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59869 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab0IORPk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 13:15:40 -0400
In-Reply-To: <20100915161647.GA8862@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, jonno.conder+bugs@gmail.com

On Wed, 15 Sep 2010, Dmitry Torokhov wrote:

> Hi Jiri,
> 
> On Wed, Sep 15, 2010 at 04:48:42PM +0200, Jiri Kosina wrote:
> > > @@ -77,7 +77,10 @@ static bool match_scancode(struct hid_usage *usage,
> > >  static bool match_keycode(struct hid_usage *usage,
> > >  			  unsigned int cur_idx, unsigned int keycode)
> > >  {
> > > -	return usage->code == keycode;
> > > +	/*
> > > +	 * We should exclude unmapped usages when doing lookup by keycode.
> > > +	 */
> > > +	return usage->type == EV_KEY && usage->code == keycode;
> > 
> > This is for some reason hurting my eyes. It'd seem much more readable to 
> > me if the condition would be enclosed in brackets, purely for sake for 
> > readability. What do you think?
> > 
> 
> Like this:
> 
> 	return (usage->type == EV_KEY && usage->code == keycode);
> 
> ?
> 
> We normally do not enclose return expression in parenthesis but why
> not...

Yeah, that's what I usually do in my code. But I don't mind too much 
either way, that was just really a minor cosmetic thing.

> Alternatively we could code it as an "if" statement.
> 
> > >  }
> > >  
> > >  static bool match_index(struct hid_usage *usage,
> > > @@ -103,7 +106,7 @@ static struct hid_usage *hidinput_find_key(struct hid_device *hid,
> > >  			for (i = 0; i < report->maxfield; i++) {
> > >  				for (j = 0; j < report->field[i]->maxusage; j++) {
> > >  					usage = report->field[i]->usage + j;
> > > -					if (usage->type == EV_KEY) {
> > > +					if (usage->type == EV_KEY || usage->type == 0) {
> > >  						if (match(usage, cur_idx, value)) {
> > >  							if (usage_idx)
> > >  								*usage_idx = cur_idx;
> > > @@ -144,7 +147,8 @@ static int hidinput_getkeycode(struct input_dev *dev,
> > >  
> > >  	usage = hidinput_locate_usage(hid, ke, &index);
> > >  	if (usage) {
> > > -		ke->keycode = usage->code;
> > > +		ke->keycode = usage->type == EV_KEY ?
> > > +				usage->code : KEY_RESERVED;
> > >  		ke->index = index;
> > >  		scancode = usage->hid & (HID_USAGE_PAGE | HID_USAGE);
> > >  		ke->len = sizeof(scancode);
> > > @@ -164,7 +168,8 @@ static int hidinput_setkeycode(struct input_dev *dev,
> > >  
> > >  	usage = hidinput_locate_usage(hid, ke, NULL);
> > >  	if (usage) {
> > > -		*old_keycode = usage->code;
> > > +		*old_keycode = usage->type == EV_KEY ?
> > > +				usage->code : KEY_RESERVED;
> > >  		usage->code = ke->keycode;
> > >  
> > >  		clear_bit(*old_keycode, dev->keybit);
> > 
> > I guess you will be taking it through your tree together with all your 
> > keycode handling patches, right?
> 
> Yes, as long as you are OK with it.

Absolutely. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
