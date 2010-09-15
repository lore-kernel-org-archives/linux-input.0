From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HID: Allow changing not-yet-mapped usages
Date: Wed, 15 Sep 2010 09:16:47 -0700
Message-ID: <20100915161647.GA8862@core.coreip.homeip.net>
References: <20100915045822.GA21672@core.coreip.homeip.net>
 <alpine.LNX.2.00.1009151645360.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46536 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0IOQQ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 12:16:58 -0400
Received: by pvg2 with SMTP id 2so107121pvg.19
        for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 09:16:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009151645360.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Input <linux-input@vger.kernel.org>, jonno.conder+bugs@gmail.com

Hi Jiri,

On Wed, Sep 15, 2010 at 04:48:42PM +0200, Jiri Kosina wrote:
> > @@ -77,7 +77,10 @@ static bool match_scancode(struct hid_usage *usage,
> >  static bool match_keycode(struct hid_usage *usage,
> >  			  unsigned int cur_idx, unsigned int keycode)
> >  {
> > -	return usage->code == keycode;
> > +	/*
> > +	 * We should exclude unmapped usages when doing lookup by keycode.
> > +	 */
> > +	return usage->type == EV_KEY && usage->code == keycode;
> 
> This is for some reason hurting my eyes. It'd seem much more readable to 
> me if the condition would be enclosed in brackets, purely for sake for 
> readability. What do you think?
> 

Like this:

	return (usage->type == EV_KEY && usage->code == keycode);

?

We normally do not enclose return expression in parenthesis but why
not...

Alternatively we could code it as an "if" statement.

> >  }
> >  
> >  static bool match_index(struct hid_usage *usage,
> > @@ -103,7 +106,7 @@ static struct hid_usage *hidinput_find_key(struct hid_device *hid,
> >  			for (i = 0; i < report->maxfield; i++) {
> >  				for (j = 0; j < report->field[i]->maxusage; j++) {
> >  					usage = report->field[i]->usage + j;
> > -					if (usage->type == EV_KEY) {
> > +					if (usage->type == EV_KEY || usage->type == 0) {
> >  						if (match(usage, cur_idx, value)) {
> >  							if (usage_idx)
> >  								*usage_idx = cur_idx;
> > @@ -144,7 +147,8 @@ static int hidinput_getkeycode(struct input_dev *dev,
> >  
> >  	usage = hidinput_locate_usage(hid, ke, &index);
> >  	if (usage) {
> > -		ke->keycode = usage->code;
> > +		ke->keycode = usage->type == EV_KEY ?
> > +				usage->code : KEY_RESERVED;
> >  		ke->index = index;
> >  		scancode = usage->hid & (HID_USAGE_PAGE | HID_USAGE);
> >  		ke->len = sizeof(scancode);
> > @@ -164,7 +168,8 @@ static int hidinput_setkeycode(struct input_dev *dev,
> >  
> >  	usage = hidinput_locate_usage(hid, ke, NULL);
> >  	if (usage) {
> > -		*old_keycode = usage->code;
> > +		*old_keycode = usage->type == EV_KEY ?
> > +				usage->code : KEY_RESERVED;
> >  		usage->code = ke->keycode;
> >  
> >  		clear_bit(*old_keycode, dev->keybit);
> 
> I guess you will be taking it through your tree together with all your 
> keycode handling patches, right?
> 

Yes, as long as you are OK with it.

Thanks.

-- 
Dmitry
