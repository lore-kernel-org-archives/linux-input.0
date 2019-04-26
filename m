From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] HID: input: add mapping for KEY_KBD_LAYOUT_NEXT
Date: Fri, 26 Apr 2019 16:33:39 -0700
Message-ID: <20190426233339.GA42369@dtor-ws>
References: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
 <20190425163846.51730-2-dmitry.torokhov@gmail.com>
 <CAO-hwJ+=n0Nh7XbcWRLeO5ay43YVwWK6vmMB=A5H23JKCWCUtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+=n0Nh7XbcWRLeO5ay43YVwWK6vmMB=A5H23JKCWCUtg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, gwink@chromium.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 26, 2019 at 08:38:29AM +0200, Benjamin Tissoires wrote:
> On Thu, Apr 25, 2019 at 6:38 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > HUTRR56 defined a new usage code on consumer page to cycle through
> > set of keyboard layouts, let's add this mapping.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I don't think this will collide with the HID tree, so IMO, you can
> take this through yours if you want.

OK, I will do that, thanks!

-- 
Dmitry
