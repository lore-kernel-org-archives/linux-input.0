From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: API for Setting a Timestamp from a Driver
Date: Sat, 13 Jul 2019 00:59:42 -0700
Message-ID: <20190713075942.GA243807@dtor-ws>
References: <20190710230410.9386-1-atifniyaz@google.com>
 <20190712064134.GA150689@dtor-ws>
 <CAO-hwJK-VAGpjN03XDTmmT4fYxb1V_izfvT9Z3tKDmLJ3henGw@mail.gmail.com>
 <20190712114619.GA7753@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190712114619.GA7753@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Atif Niyaz <atifniyaz@google.com>, Atif Niyaz <atifniyaz11@gmail.com>, Siarhei Vishniakou <svv@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 12, 2019 at 09:46:19PM +1000, Peter Hutterer wrote:
> On Fri, Jul 12, 2019 at 09:23:20AM +0200, Benjamin Tissoires wrote:
> > On Fri, Jul 12, 2019 at 8:41 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Hi Atif,
> > >
> > > On Wed, Jul 10, 2019 at 04:04:10PM -0700, Atif Niyaz wrote:
> > > > Currently, evdev stamps time with timestamps acquired in
> > > > evdev_events. However, this timestamping may not be accurate in terms of
> > > > measuring when the actual event happened. This API allows any 3rd party
> > > > driver to be able to call input_set_timestamp, and provide a timestamp
> > > > that can be utilized in order to provide a more accurate sense of time
> > > > for the event
> > > >
> > > > Signed-off-by: Atif Niyaz <atifniyaz@google.com>
> > >
> > > This looks OK to me. Benjamin, Peter, any concerns here?
> > >
> > 
> > No red flags from me (though Peter is the one using all of this).
> > 
> > Just curious, which drivers do you think will be using this new API?
> > I can see that we might want to use hid-multitouch for it, with the
> > Scan Time forwarded by the device, but what do you have in mind?
> 
> that'd be my question as well. I'm all for more precise evdev timestamps but
> there's some overlap with MSC_TIMESTAMP (which at least libinput isn't
> handling well right now, with the exception of some quirk detection). 

I expect it will be used by drivers that use threaded interrupts to mark
the time in the hard interrupt and avoid the latency of scheduling the
thread, slow bus communication, etc.

This is not supposed to replace MSC_TIMESTAMP as MSC_TIMESTAMP carries
timestamp acquired by the device itself.

Thanks.

-- 
Dmitry
