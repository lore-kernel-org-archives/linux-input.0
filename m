From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Wed, 11 Oct 2017 15:53:24 +0200
Message-ID: <20171011135324.GI865@mail.corp.redhat.com>
References: <20171010041631.22093-1-wnhuang@google.com>
 <20171010065740.GA22909@mars.bitmath.org>
 <CAE_wzQ_jPP54_1GgEuPZWHjs57=owTTP35ygO6dafYmxgDZYPQ@mail.gmail.com>
 <20171011085451.GG865@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1710111529360.14384@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1710111529360.14384@jbgna.fhfr.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, Henrik Rydberg <rydberg@bitmath.org>, Wei-Ning Huang <wnhuang@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Oct 11 2017 or thereabouts, Jiri Kosina wrote:
> On Wed, 11 Oct 2017, Benjamin Tissoires wrote:
> 
> > I am not sure if libinput even uses ABS_MT_ORIENTATION
> 
> I don't think it does, so that should be okay. However ...

I had a meeting this Peter at noon today. The summary is that libinput
doesn't uses ABS_MT_ORIENTATION, and that the documentation requires
actually 3 things:
- 0 is Y-aligned, up ("north")
- maximum should be aligned with X, pointing toward the right ("east")
- negative and out of range values are allowed

>From this, we can conclude that the minimum doesn't matter, as long as
it is 0 or -max, it is the same from the user space point of view.

One thing that the documentation suggests is that if we report [0, max],
this would indicate that out of ranges values won't be triggered, and
[-max, max] would seem to indicate that the data might be negative and
so out of range values would be acceptable.

Anyway, no changes in any cases from userspace.

> 
> > , but I'd go for fixing the documentation. And re-reading it, it's not 
> > clear that the doc tells us to have [0,90]. It mentions negative values 
> > and out of ranges too, so we might just as well simply clarify that we 
> > rather have [-90,90], with 0 being "north".
> 
> ... I'd like the documentation fix to go in together in one go with this 
> patch if possible.
> 

Sounds like a plan.

Cheers,
Benjamin

> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
