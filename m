From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some
 keyboards
Date: Wed, 10 Sep 2014 10:26:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com> <CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35314 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbaIJI0i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 04:26:38 -0400
In-Reply-To: <CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 9 Sep 2014, Fredrik Hallenberg wrote:

> Hi, time for a bump on this one.
> 
> On Sun, Aug 10, 2014 at 11:56 AM, Fredrik Hallenberg
> <megahallon@gmail.com> wrote:
> > Here is my attempt on a fix for bug 70181, please review it. It is
> > tested on my nordic Corsair K70, if this solution is deemed acceptable
> > I can ask some people with other problematic keyboards to test it.
> >
> > Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
> > ---
> >  drivers/hid/hid-input.c | 14 ++++++++++++++
> >  include/linux/hid.h     |  1 +
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 2619f7f..56429c0 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1085,6 +1085,20 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
> >                 return;
> >         }
> >
> > +       /*
> > +        * Some keyboards will report both HID keys 0x31 (\ and |) and
> > +        * 0x32 (Non-US # and ~) which are both mapped to
> > +        * KEY_BACKSLASH. This will cause spurious events causing

Hmm, makes me wonder if this mapping in hid_keyboard[] is even correct. 
The footnote in HUT 1.12 specifies very different mappings for different 
national keyboards.

-- 
Jiri Kosina
SUSE Labs
