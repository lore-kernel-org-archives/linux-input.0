From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 01/20] Input: Break out MT data
Date: Thu, 13 Sep 2012 19:58:15 +0200
Message-ID: <20120913175815.GA3125@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-2-git-send-email-rydberg@euromail.se>
 <20120913051528.GC17105@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120913051528.GC17105@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 12, 2012 at 10:15:28PM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 01, 2012 at 09:46:56PM +0200, Henrik Rydberg wrote:
> > Move all MT-related things to a separate place. This saves some
> > bytes for non-mt input devices, and prepares for new MT features.
> > 
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ...
> > @@ -1287,10 +1284,8 @@ struct input_dev {
> >  
> >  	int rep[REP_CNT];
> >  
> > -	struct input_mt_slot *mt;
> > -	int mtsize;
> > +	struct input_mt *mt;
> >  	int slot;
> > -	int trkid;
> >  
> >  	struct input_absinfo *absinfo;
> 
> Shouldn't 'slot' go into struct input_mt as well?

I wanted to remove it all together, but it turned out hairier than I
envisioned, so I left it for now. Once/if MT drivers are converted to
pass input_value arrays instead, 'slot' will disappear cleanly.

Henrik
