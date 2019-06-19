From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/20] Input: iforce - remove "being used" silliness
Date: Tue, 18 Jun 2019 17:24:48 -0700
Message-ID: <20190619002448.GC62571@dtor-ws>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
 <0541f46d-1f4f-05f4-8e93-6663f6c13bd9@gmx.de>
 <20180919171039.GA116719@dtor-ws>
 <3505434a-f5ec-de50-5f94-7347c6926f40@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3505434a-f5ec-de50-5f94-7347c6926f40@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 12, 2019 at 04:44:00PM +0200, Tim Schumacher wrote:
> On 19.09.18 19:10, Dmitry Torokhov wrote:
> > On Wed, Sep 19, 2018 at 04:51:26PM +0200, Tim Schumacher wrote:
> >> On 18.09.18 02:47, Dmitry Torokhov wrote:
> >>> The kernel is supposed to handle multiple devices, static flags
> >>> in packet handling code will never work.
> >>>
> >>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> ---
> >>>
> >>> This is a random assortment of iforce patches that I made a few weeks back.
> >>>
> >>> Tim, I do not have hardware, so I was bound to screw it up, but if you
> >>> have some time I'd appreciate if you try them out (and if I indeed broke
> >>> things if you could identify issues that would be even more awesome).
> >>>
> >>> Thanks!
> >>>
> >> Hello Dmitry,
> >>
> >> I tested those patches and I didn't find any obvious issues. The basic functions
> >> do work (i.e. buttons and axes, don't have a HAT so I can't test that), force
> >> feedback seems to work to the extent it was before (I only have fftest though,
> >> no games that support force feedback). I'll go through a few more applications
> >> and see if anything not obvious is broken.
> >>
> >
> > Thank you for taking a look.
> >
> >> Unfortunately, I only have that one wheel and I can only test USB connections
> >> at the moment (unless I find a proper serial adaptor, but I'm not sure if that
> >> would even work).
> >>
> >> Are those patches planned to go into 4.19 or are they intended to be merged in
> >> the next development cycle?
> >
> > Definitely not 4.19. Could be 4.20 or 4.21...
> >
> > Thanks.
> >
> 
> Hello Dmitry,
> 
> as a followup to the last E-Mail I sent about this topic, the complete chain
> of patches has been in my personal tree since September of 2018 and there
> have been no issues so far as well. I tested a few more games and utilities,
> and I was able to test with multiple wheels simultaneously as well.
> 
> In the end it's still your decision, but imo those patches should be fine

Thank you Tim, I'll put your name down as Tested-by then.

-- 
Dmitry
