From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date: Tue, 28 Aug 2018 11:02:20 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1808281101500.25787@cbobk.fhfr.pm>
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-2-hcutts@chromium.org> <20180823185722.GA24777@bombadil.infradead.org> <20180823190124.GB53155@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823190124.GB53155@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Harry Cutts <hcutts@chromium.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jiri.kosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

On Thu, 23 Aug 2018, Dmitry Torokhov wrote:

> > > +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> > > +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> > > +    distance travelled by the user's finger, in 256ths of a millimeter.
> > 
> > Is it too late to change this to an actual unit like micrometres?
> 
> No love for imperial roots? Sure, micrometers would work too I think.

I don't really care strongly :) Is either of you going to update the 
patch? Otherwise I'll just apply as-is.

Thanks,

-- 
Jiri Kosina
SUSE Labs
