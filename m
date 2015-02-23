From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 3.19: Sony playstation controller causes kernel oops
Date: Mon, 23 Feb 2015 13:02:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502231301360.19920@pobox.suse.cz>
References: <20150222213513.GA15224@amd> <alpine.LNX.2.00.1502222247450.19920@pobox.suse.cz> <CANq1E4Tb9waAsmJpkpjP-4rkHxDXjCGDQunsxxMRp1R4aX16uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANq1E4Tb9waAsmJpkpjP-4rkHxDXjCGDQunsxxMRp1R4aX16uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, rydberg@bitmath.org, Frank Praznik <frank.praznik@oh.rr.com>
List-Id: linux-input@vger.kernel.org

On Mon, 23 Feb 2015, David Herrmann wrote:

> Hi Jiri
> 
> On Sun, Feb 22, 2015 at 10:50 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> > [ some CCs added and full dmesg kept for reference ]
> >
> > On Sun, 22 Feb 2015, Pavel Machek wrote:
> >
> >> Hi!
> >>
> >> I plugged in part of PS move to the PC, to let it charge. Got: full
> >> dmesg in attachment. I believe I charged it in PC before, but it may
> >> be year ago or more.
> >>
> >> Ideas?
> >
> > Ok, this is embarassing. I guess the patch below fixes it, right? (the
> > spinlock got introduced in d2d782fccee, so I guess you didn't have it a
> > year ago)
> >
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index 31e9d25..3756a62 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -2140,6 +2140,7 @@ static int __init sony_init(void)
> >  {
> >         dbg_hid("Sony:%s\n", __func__);
> >
> > +       spin_lock_init(&sony_dev_list_lock);
> >         return hid_register_driver(&sony_driver);
> >  }
> 
> Nice catch. I'd prefer the patch below, though. For both:
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks. I already used the DEFINE_SPINLOCK() variant and pushed it 
our earlier today.

There was also missing sc->lock initialization in per-device probe, Frank 
sent patch for that as well.

Both now applied and pushed out.

-- 
Jiri Kosina
SUSE Labs
