From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] HID: sony: Fix uninitialized spinlocks
Date: Fri, 27 Feb 2015 19:23:43 +0100
Message-ID: <20150227182343.GB10971@amd>
References: <1424655766-2102-1-git-send-email-frank.praznik@oh.rr.com>
 <alpine.LNX.2.00.1502231302490.19920@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45976 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbbB0SXu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 13:23:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1502231302490.19920@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org

On Mon 2015-02-23 13:03:17, Jiri Kosina wrote:
> On Sun, 22 Feb 2015, Frank Praznik wrote:
> 
> > Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> > ---
> >  drivers/hid/hid-sony.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index 9e0987d..27f67e7 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -805,7 +805,7 @@ union sixaxis_output_report_01 {
> >  #define SIXAXIS_REPORT_0xF2_SIZE 17
> >  #define SIXAXIS_REPORT_0xF5_SIZE 8
> >  
> > -static spinlock_t sony_dev_list_lock;
> > +static DEFINE_SPINLOCK(sony_dev_list_lock);
> >  static LIST_HEAD(sony_device_list);
> >  static DEFINE_IDA(sony_device_id_allocator);
> 
> This hunk was already in my tree from earlier today.
> 
> >  
> > @@ -1965,6 +1965,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	spin_lock_init(&sc->lock);
> > +
> >  	sc->quirks = quirks;
> >  	hid_set_drvdata(hdev, sc);
> >  	sc->hdev = hdev;
> 
> I have applied this one from your patch. I have also added a bit of 
> changelog.

Acked-by: Pavel Machek <pavel@ucw.cz>

I should be able to test it on monday, but I guess that patch  is so simple
that it is not really required...?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
