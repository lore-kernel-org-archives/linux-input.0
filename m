From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] HID: input: do not increment usages when a
 duplicate is found
Date: Mon, 16 Apr 2018 16:51:56 -0700
Message-ID: <20180416235156.GE77055@dtor-ws>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
 <20171208142818.15156-3-benjamin.tissoires@redhat.com>
 <20171210222926.GB11027@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171210222926.GB11027@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 11, 2017 at 08:29:26AM +1000, Peter Hutterer wrote:
> On Fri, Dec 08, 2017 at 03:28:18PM +0100, Benjamin Tissoires wrote:
> > This is something that bothered us from a long time. When hid-input
> > doesn't know how to map a usage, it uses *_MISC. But there is something
> > else which increments the usage if the evdev code is already used.
> > 
> > This leads to few issues:
> > - some devices may have their ABS_X mapped to ABS_Y if they export a bad
> >   set of usages (see the DragonRise joysticks IIRC -> fixed in a specific
> >   HID driver)
> > - *_MISC + N might (will) conflict with other defined axes (my Logitech
> >   H800 exports some multitouch axes because of that)
> > - this prevents to freely add some new evdev usages, because "hey, my
> >   headset will now report ABS_COFFEE, and it's not coffee capable".
> > 
> > So let's try to kill this nonsense, and hope we won't break too many
> > devices.
> > 
> > I my headset case, the ABS_MISC axes are created because of some
> > proprietary usages, so we might not break that many devices.
> > 
> > For backward compatibility, a quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE
> > is created and can be applied to any device that needs this behavior.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

So what is happening with this series? I think we should get it them
in; there is really no reason for bumping ABS_MISC till it gets into
ABS_MT_* range on some devices that are out there.

FWIW

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
