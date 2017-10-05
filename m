From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Wed, 4 Oct 2017 17:40:45 -0700
Message-ID: <20171005004045.GD16508@dtor-ws>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <CAPzFB+XZopNPTuOD-xttq-0dqEF2hSXLftQvzfDHLhJ+9ZuB-Q@mail.gmail.com>
 <744568EA-8FEE-4A0E-B431-F054B0827261@gmail.com>
 <CAPzFB+U-mCj7N2dM2HHQTCxxWeEBT4zpQ3zc_H6y1mmQFwqB_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPzFB+U-mCj7N2dM2HHQTCxxWeEBT4zpQ3zc_H6y1mmQFwqB_w@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: David Lin <dtwlin@google.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 28, 2017 at 12:22:13PM -0700, David Lin wrote:
> On Wed, Sep 27, 2017 at 10:43 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >>One thing I noticed is that input_ff_create_memless() also does not
> >>use high-resolution timer hence it also does not have the stop-time
> >>precision that I'm looking for.
> >
> > I'll take patches for high resolution timers in ff memless, they should also help with more accurate scheduling of ramping up and fading of events.
> 
> Thanks.
> 
> >
> >>
> >>Another thing is that ff_reply duration value is maxed-out at 32767 ms
> >>(u16) while the Android/userspace requires size long for performing
> >>long notification alert.
> >>
> >
> > You need unattended vibrations lasting longer than 30 seconds? Anyway, replay.length == 0 means endless IIRC, so you only need to schedule stopping. We still will clean up properly if your process crashes or exits or closes the fd.
> 
> Yes, it's up to the application to vibrate for as long as it requires.
> Is there any concern making the duration variable a type long? [If
> this is getting off-topic, I'll follow up with another email]

Yes, given ABI constraints that is not really feasible. I think for
effects longer than 30 seconds you'd have to handle it in the framework
by using replay.length 0 and cancelling the effect some time later.

Thanks.

-- 
Dmitry
