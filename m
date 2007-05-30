From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 14:24:20 -0300
Message-ID: <20070530172420.GA6883@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com> <20070530152444.GD17530@khazad-dum.debian.net> <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 30 May 2007, Dmitry Torokhov wrote:
> >1. Generate SOMETHING that has an undefined meaning or function, but which
> >is unique for that keyboard (KEY_PROG/KEY_HOSTSPECIFIC)
> 
> How do you guarantee that KEY_PROG* is unique for the keyboard? What
> do you do if you have 2 devices generating KEY_PROG1?

It is trivial to guarantee that KEY_PROG is unique for a single input device
(keyboard), but it certainly won't work across multiple devices.  Userspace
has to know what kind of input device it is talking to to map them to
something, but since the input layer already provides this information, I
was not going to raise a fuss about it.  I figure it is the price of not
increasing even more the keycode table.

> >2. Generate SOMETHING that has a non-specific function, but a well defined
> >meaning (KEY_FN_F1)
> 
> And we have plenty of those.

Yeah, but not enough of them or I would not have asked for five more :-)

> >3. Do nothing.
> 
> Well, probably not nothing. Map it to KEY_UNKNOWN and have userspace
> listen to such events and inform user when it presses such a key that
> such and such happened and tell him how to map it to something useful.

Not optimal, but certainly much better than "do nothing".  I will go with
this one, if I can't have my extra FN keys or PROG keys.

That said, how is one to know which hardware key was translated to
KEY_UNKNOWN, so that he can inform the user to remap that key?  Should I
send another event together with KEY_UNKNOWN that has the raw keycode? Which
one?

> >I *REALLY* do not like (3), and so far I have not seen a single good
> >technical reason to go with it.
> 
> Reasons: do not require expaning current keymap preserving space for
> more useful keycodes.

We should either reclaim space then (remove all of KEY_FN_* and make them
KEY_PROG* generic stuff), or double the entire keycode space (add one bit to
KEY_MAX) so that new keycodes can be added for a while.  Declaring a keycode
crunch on drivers when one gets close to exausting each bit of KEY_MAX is
not a solution IMHO.

> > From the technically sound ones, you need
> >to either have the keycodes you need for (2) (i.e. KEY_FN_BACKSPACE), or a
> >big enough set of keycodes to use (1) (i.e. KEY_PROG5..KEY_PROGn, where n
> >should probably be at least 8).
> 
> Why 8? Why not 16? Or 32 just to make sure?

Eight is a bare minimum (and enough for my needs if the KEY_FN already there
don't go away :p), but I already told you that if it were up to me, I'd
convert all of FN_ to such codes, and cover 0x1d0 to 0x1ef with them, which
gives us 32 generic codes.  We would have 36 KEY_PROG then, which hopefully
would be enough for a while.

> >> I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
> >> supposed to do? Just being an unique value to be mapped onto something
> >> useful? But why not use that useful keycode to begin with?
> >
> >Yes, just an unique value to be mapped onto something useful, by something
> >in userspace.  Just like KEY_PROG, actually.
> 
> In _every_ program that gets events directly?

Yes.  It is not nearly as nice as functional key codes (like KEY_WLAN), but
it is better than KEY_UNKONWN or wrong keys.   Of course, if you *know* a
key's function, you use that.

> >One can't use a "useful keycode" for two reasons:
> >
> >1.      Because the key has no set function (it is unmarked)
> >2.      Because it has, or could have, a set function, but we have no clue
> >which is it.
> 
> KEY_UNKNOWN then.

KEY_UNKNOWN requires that userspace remap it for it to be usable.

> >> I'd rather leave the keys unmapped and rely on initsripts (possibly
> >> with help from distributions vendors) to load proper keymap then add
> >> something that must be retranslated over and over again.
> >
> >I don't.  I can live with it, of course, but if we are going to go that 
> >way,
> >what IS the excuse for a big lot of the keys already in input.h?  We have
> >been adding the unique keycodes and functional keycodes because it is
> >*useful*.
> 
> Because they most of them describe an expected _action_ that would
> happend after keypress.

But why can't we get those that do NOT do that and are not around most
keyboards to be completely generic, then?

> [...skipped...]
> >
> >> And what are their intended functions would be? How KEY_VENDORHOMEPAGE
> >> is different from KEY_HOMEPAGE?
> >
> >KEY_VENDORHOMEPAGE is exactly that.  It is marked with the vendor's name.
> >KEY_HOMEPAGE has a defined function inherited from that other O.S. which is
> >to open up the default browser on the default "homepage".  I can easily see
> >both keys existing on a system.
> >
> 
> OK, right now we have:
> 
> KEY_WWW
> KEY_VENDOR
> KEY_HOMEPAGE
> 
> defines in input.h. Are you sayign that none of these would suit?

KEY_VENDOR would work for me.  I had not searched around for one yet, and I
would have found it out before sending you a patch asking for
KEY_VENDORHOMEPAGE.

KEY_PROG, on the other hand, looked to me like an function (like program
macro or whatever).

> >As for stuff like KEY_FN_BACKSPACE, well, I don't really care, as long as I
> >have *something* unique and not incorrect to use.  But if we are not going
> >to add extra KEY_FN_ keycodes, why don't we just convert them all to
> >KEY_PROG, so that they can be useful to all and not just to people who have
> >FN_<whatever> keys?
> 
> We could add aliases if you really want...

If you add aliases to the whole FN block, and add a few more KEY_PROG to
fill the holes so that the entire 0x1d0-0x1ef range is usable by
thinkpad-acpi, that would be enough for me.  I am not sure how that is any
better (or any worse) than the other possible solutions that change input.h,
though.

> Can you tell me on _your_ thinkpad what markings you have? I mean

http://www.thinkwiki.org/wiki/Default_meanings_of_special_keys

Mine is a T43.  That table is not 100% correct, the T43 doesn't label the
fn+f8 or fn+f9 keys.  And it is still very very much incomplete.

> there should be a common pattern on thinkpads and the rest may be
> guessed (you mentioned that FN-F5 is used to turn off radio quite
> often so if thinkpad driver detects radio switch it makes sence to
> just go ahead and mark FN-F5 as KEY_WLAN, doesn't it?)

For that particular key, yes... until we find out a thinkpad that has that
key elsewhere.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
