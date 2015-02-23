From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Mon, 23 Feb 2015 17:34:53 -0500
Message-ID: <20150223223453.GA28675@mail.corp.redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
 <54E45A82.7090706@gmail.com>
 <20150218200417.GC5928@mail.corp.redhat.com>
 <54E5CEE9.1050909@gmail.com>
 <20150220053458.GA23069@jelly.redhat.com>
 <54E9CCB1.9000705@gmail.com>
 <20150222232817.GA1645@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150222232817.GA1645@jelly.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On Feb 23 2015 or thereabouts, Peter Hutterer wrote:
> On Sun, Feb 22, 2015 at 02:33:53PM +0200, Nikolai Kondrashov wrote:
> > On 02/20/2015 07:34 AM, Peter Hutterer wrote:
> > >On Thu, Feb 19, 2015 at 01:54:17PM +0200, Nikolai Kondrashov wrote:
> > >[...]
> > >>>>>Last, I think we could add these tablets in the libwacom project, so that there
> > >>>>>will be a nice GUI to configure the buttons.
> > >>>>
> > >>>>That would be a very welcome change, without doubt, thank you.
> > >>>>
> > >>>>However, I can't help wondering, would it be more productive to allow libwacom
> > >>>>to work with just any basic tablet, without the need to add each one to the
> > >>>>database?
> > >>>
> > >>>Actually, libwacom is not tight to Wacom devices at all (or should not
> > >>>be). It is just a database of devices to add what the kernel doesn't or
> > >>>can not provide. The things that are in the db are for example how the
> > >>>buttons are physically mapped on the device, what is the actual layout
> > >>>(one svg file), if there are LEDs attached to the tablet.
> > >>>
> > >>>All this needs a fine per-device tuning. We can add a generic
> > >>>Huion/UClogic tablet too, but having a specific per-device definition
> > >>>allows to show the exact mapping of the buttons on the overlay when
> > >>>setting the functions.
> > >>
> > >>I agree, that's a nice feature. However, I think being able to configure all
> > >>the applicable Wacom driver features relatively comfortably, even if the
> > >>tablet on screen doesn't exactly match your tablet, is still a win, compared
> > >>to not being able to do it.
> > >>
> > >>For the unknown tablets we can just draw abstract tablets, emphasising that
> > >>control locations on the screen don't map to the actual locations. For
> > >>example, have the tablet drawn like an exploded diagram: surface, buttons,
> > >>dials - all separate.  Something like this:
> > >>
> > >>     Buttons: * * * * * * *
> > >>       Dials: O O
> > >>   Work area: +------------+
> > >>              |            |
> > >>              |            |
> > >>              |            |
> > >>              +------------+
> > >>
> > >>I think the users will be able to figure out the mapping by experimentation.
> > >>
> > >>While it's just about possible to keep an up-to-date database of Wacom
> > >>tablets, I don't think we'll ever be able to list all those generic tablets
> > >>out there. Meanwhile a lot of people are left in the cold of xsetwacom and
> > >>xinput.
> > >
> > >not a reason to give up, IMO. most of these generic tablets are relatively
> > >simple, so adding a libwacom entry should be a matter of minutes.
> > >we'll never get full support of everything, but perfect is the enemy of good
> > >here.
> > 
> > Hmm, I see having all the tablets listed in the database as perfect and having
> > generic tablet handling as more practical, i.e. the other way around.
> > 
> > It might be easy for us to add a tablet entry, but not for the general user.
> > They will need to figure out they need to add that entry first and they'll
> > need to figure out what to put there and how. This will need to go through us
> > in the end and we'll need to extract all the information from the user, which
> > will likely require several e-mails for *each* tablet.
> 
> yeah, but the thing is: those emails are only necessary _once_  per tablet.
> if they're not in the database, you'll get those questions for the lifetime
> of the tablet :)
> 
> Also note that libwacom_new_from_path() has a fallback option, you can get a
> generic tablet from it and then proceed as normal. gnome-settings-daemon
> already uses this.
> 

I also expects that the settings configuration tool under wayland will
rely on the actual capability of the devices. This way, even if the
tablet is not registered in libwacom, we will still be able to show a
default configuration UI.

I really believe the registering in libwacom will be just to have a
prettier interface, not a requirement.

Cheers,
Benjamin

> > 
> > Meanwhile most users just want to draw.
> > 
> > I might be misunderstanding something, though.
> > 
> > Regardless, Benjamin work is making it all better, I cannot complain :)
> > 
> > Nick
