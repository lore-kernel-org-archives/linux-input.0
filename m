From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] Input: silead: use msleep() for long delays
Date: Thu, 12 Jan 2017 18:50:02 +0000
Message-ID: <20170112185002.GA26272@osadl.at>
References: <1484238105-10785-1-git-send-email-hofrat@osadl.org>
 <a5d2b275-0418-280f-3cb9-516ef510a05c@redhat.com>
 <CAKdAkRRGh_kDPWz0KZhEj5+dwgjXY=vMMsE2v60+eqTJG01zQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRRGh_kDPWz0KZhEj5+dwgjXY=vMMsE2v60+eqTJG01zQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Nicholas Mc Guire <hofrat@osadl.org>, Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, Daniel Jansen <djaniboe@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Robert Dolca <robert.dolca@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 12, 2017 at 10:10:44AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 12, 2017 at 9:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >
> > On 01/12/2017 05:21 PM, Nicholas Mc Guire wrote:
> >>
> >> the delays here are in the 10 to 20ms range so msleep() will do - no
> >> need to burden the highres timer subsystem.
> >>
> >> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> >> ---
> >>
> >> Problem found by coccinelle script
> >>
> >> While msleep(10) has a worst case uncertainty of 10ms (on HZ=100 systems)
> >> this seems ok here as the delays are not called frequently (init and
> >> reset functions)
> >
> >
> > By the same logic, this is not much of a burden on the high-res timer
> > subsys though.
> >
> >> and the uncertainty of 10ms fits the permitted range of
> >> the original usleep_ranges().
> >
> >
> > Either way this patch is fine with me.
> 
> I'd rather not because next will come a checkpatch warrior and I will
> have to convince them why msleep is OK here. And another one, and
> another one... :(
>
there is no checkpatch warning here - checkpatch only throws warnings
of range < 20ms if hardcoded but this is in a #define so its fine with
respect to checkpatch.

But if there are concerns with this - thats fine - its most likely not
critical - the goal is to have a consistent usage of highres timers - 
including limiting there use to the cases where its really needed.

thx!
hofrat
