From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 16:25:03 -0400
Message-ID: <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	 <200705262340.28219.dtor@insightbb.com>
	 <20070527121513.GC19562@khazad-dum.debian.net>
	 <200705282316.32173.dtor@insightbb.com>
	 <20070529130528.GB12935@khazad-dum.debian.net>
	 <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
	 <20070530152444.GD17530@khazad-dum.debian.net>
	 <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com>
	 <20070530172420.GA6883@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070530172420.GA6883@khazad-dum.debian.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/30/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Wed, 30 May 2007, Dmitry Torokhov wrote:
> > >1. Generate SOMETHING that has an undefined meaning or function, but which
> > >is unique for that keyboard (KEY_PROG/KEY_HOSTSPECIFIC)
> >
> > How do you guarantee that KEY_PROG* is unique for the keyboard? What
> > do you do if you have 2 devices generating KEY_PROG1?
>
> It is trivial to guarantee that KEY_PROG is unique for a single input device
> (keyboard), but it certainly won't work across multiple devices.  Userspace
> has to know what kind of input device it is talking to to map them to
> something, but since the input layer already provides this information, I
> was not going to raise a fuss about it.  I figure it is the price of not
> increasing even more the keycode table.
>

Actually I try to discourage people from using input_id during device
discovery but rather tell them to analyze capability bits and then
decide if their application is interested in that particular input
device. I think input_id should pretty much only used by udev & co. to
adjust default kernel setup for the needs of local installation (fix
keymap, adjust absmax, etc).

Applications should focus their attention on functional aspect of the
device. That's why I don't like KEY_PROG* and KEY_FN*.

> > >2. Generate SOMETHING that has a non-specific function, but a well defined
> > >meaning (KEY_FN_F1)
> >
> > And we have plenty of those.
>
> Yeah, but not enough of them or I would not have asked for five more :-)

You already have 4 (KEY_PROG*) and your hardware does not event
generate the 5th so there ;)

>
> > >3. Do nothing.
> >
> > Well, probably not nothing. Map it to KEY_UNKNOWN and have userspace
> > listen to such events and inform user when it presses such a key that
> > such and such happened and tell him how to map it to something useful.
>
> Not optimal, but certainly much better than "do nothing".  I will go with
> this one, if I can't have my extra FN keys or PROG keys.
>

OK.

> That said, how is one to know which hardware key was translated to
> KEY_UNKNOWN, so that he can inform the user to remap that key?  Should I
> send another event together with KEY_UNKNOWN that has the raw keycode? Which
> one?
>

You may try using EV_MSC/MSC_SCAN. You can even send it all the time,
not only for KEY_UNKNOWN.

> > >I *REALLY* do not like (3), and so far I have not seen a single good
> > >technical reason to go with it.
> >
> > Reasons: do not require expaning current keymap preserving space for
> > more useful keycodes.
>
> We should either reclaim space then (remove all of KEY_FN_* and make them
> KEY_PROG* generic stuff), or double the entire keycode space (add one bit to
> KEY_MAX) so that new keycodes can be added for a while.  Declaring a keycode
> crunch on drivers when one gets close to exausting each bit of KEY_MAX is
> not a solution IMHO.

We have space for about 30-40 more functional events (0x1b*, parts of
0x1c* and 0x1d*) so using them wisely we should last for a while. I
think we have most relevant parts of HID usage tables covered. KEY_MAX
and the rest of KEY_* are exported to userspace, that's why we can't
remove any existing definitions and I am hesitant to change KEY_MAX.

>
> > > From the technically sound ones, you need
> > >to either have the keycodes you need for (2) (i.e. KEY_FN_BACKSPACE), or a
> > >big enough set of keycodes to use (1) (i.e. KEY_PROG5..KEY_PROGn, where n
> > >should probably be at least 8).
> >
> > Why 8? Why not 16? Or 32 just to make sure?
>
> Eight is a bare minimum (and enough for my needs if the KEY_FN already there
> don't go away :p), but I already told you that if it were up to me, I'd
> convert all of FN_ to such codes, and cover 0x1d0 to 0x1ef with them, which
> gives us 32 generic codes.  We would have 36 KEY_PROG then, which hopefully
> would be enough for a while.
>
> > >> I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
> > >> supposed to do? Just being an unique value to be mapped onto something
> > >> useful? But why not use that useful keycode to begin with?
> > >
> > >Yes, just an unique value to be mapped onto something useful, by something
> > >in userspace.  Just like KEY_PROG, actually.
> >
> > In _every_ program that gets events directly?
>
> Yes.  It is not nearly as nice as functional key codes (like KEY_WLAN), but
> it is better than KEY_UNKONWN or wrong keys.   Of course, if you *know* a
> key's function, you use that.

I guess we have different opinions. For me KEY_UNKNOWN is better
because it encourages user to adjust keymap table in the kernel at
startup (or at hotplug time) and then rest of userspace does not need
to be aware at all about host specific settings. Most higher level
keymaps will work automatically when kernel emits "functional" events.
Userspace is only responsible for translating combinations of events
(i.e. when someone presses KEY_A with shift held it means capital A.
But it works for all devices that have key A on them).

>
> > >One can't use a "useful keycode" for two reasons:
> > >
> > >1.      Because the key has no set function (it is unmarked)
> > >2.      Because it has, or could have, a set function, but we have no clue
> > >which is it.
> >
> > KEY_UNKNOWN then.
>
> KEY_UNKNOWN requires that userspace remap it for it to be usable.
>

As well as KEY_PROG* or KEY_FN*. It is just the mapping happens on
different level.

> > >> I'd rather leave the keys unmapped and rely on initsripts (possibly
> > >> with help from distributions vendors) to load proper keymap then add
> > >> something that must be retranslated over and over again.
> > >
> > >I don't.  I can live with it, of course, but if we are going to go that
> > >way,
> > >what IS the excuse for a big lot of the keys already in input.h?  We have
> > >been adding the unique keycodes and functional keycodes because it is
> > >*useful*.
> >
> > Because they most of them describe an expected _action_ that would
> > happend after keypress.
>
> But why can't we get those that do NOT do that and are not around most
> keyboards to be completely generic, then?
>

We have a few of them and I think that is more than enough.

Consider ejecting a CD tray. You have a laptop with a key that maked
eject CD. Because it is a new laptop there are no proper mapping yet
so some adjustments are needed. With your scenario the kernel emits
KEY_PROG26. User has first to adjust X keymap to map KEY_PROG26 to
EjectCD event (simplifying). Then he goes into text console only to
find out that his curses-based CD player does not recognize that key
and also needs to be adjusted. And so on. Finally all applications are
made aware of KEY_PROG26 amd user is happy. Couple of weeks later he
goes and buys an external keyboard and it turns out that eject CD
there is actually KEY_PROG21 so he need to go through second round of
mapping for all applications. Not only that but button with volume
increase happens to generate KEY_PROG26. Now what?

Now consider in-kernel remapping to functional scancdes that I
propose: user says that that key should generate KEY_EJECTCD and it
starts working in all appliations recognizing that event. Adding the
second keyboard into mix does not mess up the first one.

> > [...skipped...]
> > >
> > >> And what are their intended functions would be? How KEY_VENDORHOMEPAGE
> > >> is different from KEY_HOMEPAGE?
> > >
> > >KEY_VENDORHOMEPAGE is exactly that.  It is marked with the vendor's name.
> > >KEY_HOMEPAGE has a defined function inherited from that other O.S. which is
> > >to open up the default browser on the default "homepage".  I can easily see
> > >both keys existing on a system.
> > >
> >
> > OK, right now we have:
> >
> > KEY_WWW
> > KEY_VENDOR
> > KEY_HOMEPAGE
> >
> > defines in input.h. Are you sayign that none of these would suit?
>
> KEY_VENDOR would work for me.  I had not searched around for one yet, and I
> would have found it out before sending you a patch asking for
> KEY_VENDORHOMEPAGE.
>
> KEY_PROG, on the other hand, looked to me like an function (like program
> macro or whatever).
>
> > >As for stuff like KEY_FN_BACKSPACE, well, I don't really care, as long as I
> > >have *something* unique and not incorrect to use.  But if we are not going
> > >to add extra KEY_FN_ keycodes, why don't we just convert them all to
> > >KEY_PROG, so that they can be useful to all and not just to people who have
> > >FN_<whatever> keys?
> >
> > We could add aliases if you really want...
>
> If you add aliases to the whole FN block, and add a few more KEY_PROG to
> fill the holes so that the entire 0x1d0-0x1ef range is usable by
> thinkpad-acpi, that would be enough for me.  I am not sure how that is any
> better (or any worse) than the other possible solutions that change input.h,
> though.
>
> > Can you tell me on _your_ thinkpad what markings you have? I mean
>
> http://www.thinkwiki.org/wiki/Default_meanings_of_special_keys
>
> Mine is a T43.  That table is not 100% correct, the T43 doesn't label the
> fn+f8 or fn+f9 keys.  And it is still very very much incomplete.
>
> > there should be a common pattern on thinkpads and the rest may be
> > guessed (you mentioned that FN-F5 is used to turn off radio quite
> > often so if thinkpad driver detects radio switch it makes sence to
> > just go ahead and mark FN-F5 as KEY_WLAN, doesn't it?)
>
> For that particular key, yes... until we find out a thinkpad that has that
> key elsewhere.
>

That may or may not happen. So far I can see some patterns -
brightnell control seems to be in same place, sleep, etc.

-- 
Dmitry
