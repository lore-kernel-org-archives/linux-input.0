From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/7] Input: document meanings of KEY_SCREEN and KEY_ZOOM
Date: Wed, 23 Jan 2019 14:07:35 -0800
Message-ID: <20190123220735.GE179701@dtor-ws>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
 <nycvar.YFH.7.76.1901211110190.6626@cbobk.fhfr.pm>
 <CAO-hwJLMKyOeuFyCyaR+zO9BNTDA1pXe35yRF_4nK7ZpOY=3GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJLMKyOeuFyCyaR+zO9BNTDA1pXe35yRF_4nK7ZpOY=3GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 21, 2019 at 11:41:32AM +0100, Benjamin Tissoires wrote:
> On Mon, Jan 21, 2019 at 11:11 AM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Fri, 18 Jan 2019, Dmitry Torokhov wrote:
> >
> > > It is hard to say what KEY_SCREEN and KEY_ZOOM mean, but historically DVB
> > > folks have used them to indicate switch to full screen mode. Later, they
> > > converged on using KEY_ZOOM to switch into full screen mode and KEY)SCREEN
> > > to control aspect ratio (see Documentation/media/uapi/rc/rc-tables.rst).
> > >
> > > Let's commit to these uses, and define:
> > >
> > > - KEY_FULL_SCREEN (and make KEY_ZOOM its alias)
> > > - KEY_ASPECT_RATIO (and make KEY_SCREEN its alias)
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >
> > > Please let me know how we want merge this. Some of patches can be applied
> > > independently and I tried marking them as such, but some require new key
> > > names from input.h
> >
> > Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Mauro, any objections on pushing the media doc patch through my tree?

Thanks.

-- 
Dmitry
