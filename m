From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: roccat: Fix "cannot create duplicate filename"
 problems
Date: Mon, 30 Sep 2013 10:52:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309301051430.28935@pobox.suse.cz>
References: <1380340666.2451.4.camel@neuromancer.tessier-ashpool> <20130928040257.GA21630@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130928040257.GA21630@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 27 Sep 2013, Greg KH wrote:

> > Fixing some wrong macro stringification/concatenation.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> > ---
> >  drivers/hid/hid-roccat-kone.c     |    2 +-
> >  drivers/hid/hid-roccat-koneplus.c |    4 ++--
> >  drivers/hid/hid-roccat-kovaplus.c |    4 ++--
> >  drivers/hid/hid-roccat-pyra.c     |    4 ++--
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> > index 602c188..6101816 100644
> > --- a/drivers/hid/hid-roccat-kone.c
> > +++ b/drivers/hid/hid-roccat-kone.c
> > @@ -382,7 +382,7 @@ static ssize_t kone_sysfs_write_profilex(struct file *fp,
> >  }
> >  #define PROFILE_ATTR(number)					\
> >  static struct bin_attribute bin_attr_profile##number = {	\
> > -	.attr = { .name = "profile##number", .mode = 0660 },	\
> > +	.attr = { .name = "profile" #number, .mode = 0660 },	\
> 
> Ugh, very sorry about that, I hate macros in C at times :)
> 
> Jiri, can you take this through your tree, or I can if you want, it
> needs to go in for 3.12-final.
> 
> If yours, feel free to add:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Stefan, thanks for fixing my bugs, it's much appreciated.

Thanks, queued, will go to Linus for 3.12 still.

-- 
Jiri Kosina
SUSE Labs
