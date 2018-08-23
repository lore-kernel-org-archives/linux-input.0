From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date: Thu, 23 Aug 2018 12:01:24 -0700
Message-ID: <20180823190124.GB53155@dtor-ws>
References: <20180823183057.247630-1-hcutts@chromium.org>
 <20180823183057.247630-2-hcutts@chromium.org>
 <20180823185722.GA24777@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180823185722.GA24777@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Harry Cutts <hcutts@chromium.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jiri.kosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 23, 2018 at 11:57:22AM -0700, Matthew Wilcox wrote:
> On Thu, Aug 23, 2018 at 11:30:55AM -0700, Harry Cutts wrote:
> > +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> > +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> > +    distance travelled by the user's finger, in 256ths of a millimeter.
> 
> Is it too late to change this to an actual unit like micrometres?

No love for imperial roots? Sure, micrometers would work too I think.

-- 
Dmitry
