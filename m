From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Wed, 18 Feb 2015 15:04:17 -0500
Message-ID: <20150218200417.GC5928@mail.corp.redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
 <54E45A82.7090706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E45A82.7090706@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On Feb 18 2015 or thereabouts, Nikolai Kondrashov wrote:
> Hi Benjamin,
> 
> I'm copying my reply to DIGImend-devel as well.
> 
> On 02/18/2015 12:54 AM, Benjamin Tissoires wrote:
> >Hi Nikolai,
> >
> >I know you are actually merging hid-huion and hid-uclogic, so we might not want
> >to take this in this current state. We may need to postpone it when you have
> >send the merge.
> 
> I have it in the out-of-tree driver package [1], which I'll need to release
> for users to test first.
> 
> >This series makes the Huion tablet (a H610 Pro) behave like a Wacom one from the
> >libinput point of view.
> >It will introduce a change in the default behavior for the users (which I
> >believe is a good change) where the pad part of the tablet will not send
> >random keyboard shortcuts but actual button events.
> 
> That's awesome, thanks a lot, Benjamin! I tried making something like that
> [2], which seems to work reasonably. However, I was not up-to-date with
> libinput changes and left the buttons in the same device with the pen. Then I
> heard about input groups from Hans and planned to re-make it properly, but now
> you did it. Thanks!

Hmm... I should have checked more carefully your branches. I actually
redid the reverse engineering and ended up with nearly the same patch
you already have :)

Sorry for not including you in the loop earlier. We were actually really
focused on Wacom for the past few months and decided to look into the
Huion and other tablets only last week. I believe not having the pad
buttons separated in the huion tablets is not that much of a problem
(for now, the buttons are quite separate from the stylus buttons), but
in the Wacom world, we had some terrible overlapping and making those as
2 separate devices was the obvious change.

> 
> >I'd be glad if you could validate the changes with the other huions you have
> >(or the Digimend project), because, having only one PID for all their tablets
> >is rather weird and difficult to support.
> 
> I'll have to incorporate them into the out-of-tree driver [1] to simplify
> testing for users. I'll leave some comments to the changes as well, if you
> don't mind.

Sure, no problem.

> 
> Of course, it would help a lot, if you could contribute your patches to the
> out-of-tree driver, from where we could then take them to upstream, after
> testing. I can do it myself, though.

OK, will respin the patches for your out of the tree driver.

> 
> >Last, I think we could add these tablets in the libwacom project, so that there
> >will be a nice GUI to configure the buttons.
> 
> That would be a very welcome change, without doubt, thank you.
> 
> However, I can't help wondering, would it be more productive to allow libwacom
> to work with just any basic tablet, without the need to add each one to the
> database?

Actually, libwacom is not tight to Wacom devices at all (or should not
be). It is just a database of devices to add what the kernel doesn't or
can not provide. The things that are in the db are for example how the
buttons are physically mapped on the device, what is the actual layout
(one svg file), if there are LEDs attached to the tablet.

All this needs a fine per-device tuning. We can add a generic
Huion/UClogic tablet too, but having a specific per-device definition
allows to show the exact mapping of the buttons on the overlay when
setting the functions.

> 
> >However, not having the PID to discriminate between tablets is going to be a
> >problem. Do you have any reliable way of knowing the model from the kernel
> >or the user space?
> 
> Unfortunately, not. You can take a look at the data I and the users gathered
> on some of the Huion tablets [3]. The iProduct string can be used to some
> extent, but I wouldn't rely on it to make much sense. Apart from Huion
> tablets, there are also Yiynova tablets which work the same way, at least some
> Ugee tablets and at least one UC-Logic tablet, but I expect more of the latter
> work as well. Among them there is a mix of using dedicated and UC-Logic VIDs
> and mostly reusing PIDs. There is something which seems to be an internal
> model name in string descriptor 0x7a, but it also doesn't make much sense.
> 
> All-in-all it's a mess. I've even seen a tablet with a typo in iManufacturer.
> 
> Still, if we make libwacom work with generic tablets not contained in its
> database, that wouldn't be a problem.

I'll see what I can do. However, it looks like the iProduct and
iManufacturer could help to some extend (until we find a big problem). I
thought they were all labeled "HUION PenTablet" but actually only the
H610 Pro and the Huion W58 share this name. The W58 does not have
buttons so we night be able to remove the pad interface for them and
then libwacom will be happy with only the name of the input node.

Cheers,
Benjamin

> 
> Nick
> 
> [1] https://github.com/DIGImend/digimend-kernel-drivers
> [2] https://github.com/DIGImend/digimend-kernel-drivers/blob/huion-abstract-keyboard/hid-huion.c
> [3] https://github.com/DIGImend/tablets
