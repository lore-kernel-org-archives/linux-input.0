From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Another HID problem this merge window..
Date: Mon, 29 Oct 2018 09:49:25 +0100
Message-ID: <CAO-hwJJjP1SJjcfGkr84yyPqYpCx-_6LSk5uDP2Twg2ouy_3+w@mail.gmail.com>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
 <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
 <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com> <nycvar.YFH.7.76.1810272338590.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810272338590.23511@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, joe@perches.com, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Sat, Oct 27, 2018 at 11:45 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sat, 27 Oct 2018, Linus Torvalds wrote:
>
> > I wonder if there is some truly old historical legacy there, ie the old
> > PC keyboard support would have been configurable out only for expert
> > users to avoid errors, and maybe the HID Kconfig file started getting
> > ideas from that...
>
> This really goes waaay back to times when we extracted all the quirks from
> the generic driver (which became unmaintainable exactly because quirks
> being sprinkled left and right) into specialized drivers, but didn't want
> to cause too many user surprises that all of a sudden their configuration
> regressed when it comes to hardware support.
>
> We've had exactly this discussion multiple times before, see for example
>
>         https://lkml.org/lkml/2010/5/20/227
>
> So I guess there is no need for replaying it, I think we're in complete
> agreement.

On the things I have on my plate, I'll try to remove all of the tiny
HID drivers that does nothing but some small remapping. This will
probably need help from userspace ("firmware" or bpf loading), and I
have not settled my plans yet.
I also think we should probably clean up the Kconfig now that
hid-generic can unbind itself if there is a special driver coming in.
And that means that we should probably start removing the blacklist of
devices that have special modules, to let them be taken by hid-generic
on boot until their driver is loaded.

>
> That being said, benff Kconfig setting definitely escaped attention. That
> should never ever have been set to default y, I take blame for not
> noticing that while applying the patch.

Not sure I have actually reviewed this one (I don't think so), but
I'll keep this in my head for next drivers.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
