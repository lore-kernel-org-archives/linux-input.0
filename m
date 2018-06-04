From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Mon, 4 Jun 2018 11:26:58 -0700
Message-ID: <20180604182658.GC164893@dtor-ws>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws>
 <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
 <CAO-hwJKibKvqviLZ5SSYR_X3yLTzJrr0G4d6svM3FtgJ6AfvQQ@mail.gmail.com>
 <20180604172759.GA164893@dtor-ws>
 <994e5698-fbdf-05c8-b0b6-3df6af1b3dbc@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <994e5698-fbdf-05c8-b0b6-3df6af1b3dbc@bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 04, 2018 at 07:55:57PM +0200, Henrik Rydberg wrote:
> Hi Dmitry,
> 
> > > > Logically, the confidence state is a property of a contact, not a new type
> > > > of contact. Trying to use it in any other way is bound to lead to confusion.
> > > > 
> > > > Problem is that MT_TOOL_PALM has been introduced in the kernel since
> > > > v4.0 (late 2015 by a736775db683 "Input: add MT_TOOL_PALM").
> > > > It's been used in the Synaptics RMI4 driver since and by hid-asus in late 2016.
> > > > I can't find any other users in the current upstream tree, but those
> > > > two are already making a precedent and changing the semantic is a
> > > > little bit late :/
> > I am sorry I did not respond and lost track of this issue back then, but
> > I disagree with Henrik here. While confidence is a property of contact,
> > so is the type of contact and it can and will change throughout life of
> > a contact, especially if we will continue adding new types, such as, for
> > example, thumb. In this case the firmware can transition through
> > finger->thumb or finger->thumb->palm or finger->palm as the nature of
> > contact becomes better understood. Still it is the same contact and we
> > should not attempt to signal userspace differently.
> We agree that the contact should stay the same, but the fear, and I think
> somewhere along the blurry history of this thread, the problem was that
> userspace interpreted the property change as a new contact (lift up/double
> click/etc). Finger/thumb/palm is one set of hand properties, but what about
> Pen? It would be hard for an application to consider a switch from finger to
> pen as the same contact, which is where the natural implementation starts to
> diverge from the intention.

I think the userspace has to trust our tracking ID to decide whether it
is a same contact or not. The current issue is that kernel is forcing
tracking ID change on tool type change, and one of the 2 patches that I
posted fixed that, allowing us to keep the tracking ID for finger->palm
transitions.

I think it is kernel task to not signal transitions that do not make
sense, such as finger->pen or palm->pen etc.

> 
> > We could introduce the ABS_MT_CONFIDENCE (0/1 or even 0..n range), to
> > complement ABS_MT_TOOL, but that would not really solve the issue with
> > Wacom firmware (declaring contact non-confident and releasing it right
> > away) and given MS explanation of the confidence as "contact is too big"
> > MT_TOOL_PALM fits it perfectly.
> Indeed, the Wacom firmware seems to need some special handling, which should
> be fine by everyone. I do think it would make sense to add
> ABS_MT_TOOL_TOO_BIG, or something, and use it if it exists. This would apply
> also to a pen lying down on a touchpad, for instance.

OK, I can see that for Pens, if we have firmware that would recognize
such condition, it would be weird to report PALM. We could indeed have
ABS_MT_TOOL_TOO_BIG, but on the other hand it is still a pen (as long as
the hardware can recognize it as such). Maybe we'd be better off just
having userspace going by contact size for pens. Peter, any suggestions
here?

Thanks.

-- 
Dmitry
