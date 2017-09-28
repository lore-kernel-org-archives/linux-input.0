From: David Lin <dtwlin@google.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Thu, 28 Sep 2017 12:22:13 -0700
Message-ID: <CAPzFB+U-mCj7N2dM2HHQTCxxWeEBT4zpQ3zc_H6y1mmQFwqB_w@mail.gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com> <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com> <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com> <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <CAPzFB+XZopNPTuOD-xttq-0dqEF2hSXLftQvzfDHLhJ+9ZuB-Q@mail.gmail.com> <744568EA-8FEE-4A0E-B431-F054B0827261@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <744568EA-8FEE-4A0E-B431-F054B0827261@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 27, 2017 at 10:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>>One thing I noticed is that input_ff_create_memless() also does not
>>use high-resolution timer hence it also does not have the stop-time
>>precision that I'm looking for.
>
> I'll take patches for high resolution timers in ff memless, they should also help with more accurate scheduling of ramping up and fading of events.

Thanks.

>
>>
>>Another thing is that ff_reply duration value is maxed-out at 32767 ms
>>(u16) while the Android/userspace requires size long for performing
>>long notification alert.
>>
>
> You need unattended vibrations lasting longer than 30 seconds? Anyway, replay.length == 0 means endless IIRC, so you only need to schedule stopping. We still will clean up properly if your process crashes or exits or closes the fd.

Yes, it's up to the application to vibrate for as long as it requires.
Is there any concern making the duration variable a type long? [If
this is getting off-topic, I'll follow up with another email]
