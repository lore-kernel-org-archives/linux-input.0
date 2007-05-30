From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 12:04:45 -0400
Message-ID: <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	 <200705262340.28219.dtor@insightbb.com>
	 <20070527121513.GC19562@khazad-dum.debian.net>
	 <200705282316.32173.dtor@insightbb.com>
	 <20070529130528.GB12935@khazad-dum.debian.net>
	 <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
	 <20070530152444.GD17530@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070530152444.GD17530@khazad-dum.debian.net>
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
> > On 5/29/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > >But I will still need to add keys, and I still think that a bunch of 32 or
> > >so HOSTSPECIFIC keys is a very very good idea to have, *even* if I add some
> > >model specific knowledge and already remap a few of the hot key keyboard to
> > >less generic events where possible.
> >
> > I think that adding anything like HOSTSPECIFIC is a failure on our
> > part. That means that you need to make programs out there aware of
>
> Well, you have to choose one of three possibilities for an unlabelled key:
>
> 1. Generate SOMETHING that has an undefined meaning or function, but which
> is unique for that keyboard (KEY_PROG/KEY_HOSTSPECIFIC)
>

How do you guarantee that KEY_PROG* is unique for the keyboard? What
do you do if you have 2 devices generating KEY_PROG1?

> 2. Generate SOMETHING that has a non-specific function, but a well defined
> meaning (KEY_FN_F1)

And we have plenty of those.

>
> 3. Do nothing.
>

Well, probably not nothing. Map it to KEY_UNKNOWN and have userspace
listen to such events and inform user when it presses such a key that
such and such happened and tell him how to map it to something useful.

> I *REALLY* do not like (3), and so far I have not seen a single good
> technical reason to go with it.

Reasons: do not require expaning current keymap preserving space for
more useful keycodes.

>  From the technically sound ones, you need
> to either have the keycodes you need for (2) (i.e. KEY_FN_BACKSPACE), or a
> big enough set of keycodes to use (1) (i.e. KEY_PROG5..KEY_PROGn, where n
> should probably be at least 8).

Why 8? Why not 16? Or 32 just to make sure?

>
> > I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
> > supposed to do? Just being an unique value to be mapped onto something
> > useful? But why not use that useful keycode to begin with?
>
> Yes, just an unique value to be mapped onto something useful, by something
> in userspace.  Just like KEY_PROG, actually.
>

In _every_ program that gets events directly?

> One can't use a "useful keycode" for two reasons:
>
> 1.      Because the key has no set function (it is unmarked)
> 2.      Because it has, or could have, a set function, but we have no clue
> which is it.
>

KEY_UNKNOWN then.

> > I'd rather leave the keys unmapped and rely on initsripts (possibly
> > with help from distributions vendors) to load proper keymap then add
> > something that must be retranslated over and over again.
>
> I don't.  I can live with it, of course, but if we are going to go that way,
> what IS the excuse for a big lot of the keys already in input.h?  We have
> been adding the unique keycodes and functional keycodes because it is
> *useful*.
>

Because they most of them describe an expected _action_ that would
happend after keypress.

[...skipped...]
>
> > And what are their intended functions would be? How KEY_VENDORHOMEPAGE
> > is different from KEY_HOMEPAGE?
>
> KEY_VENDORHOMEPAGE is exactly that.  It is marked with the vendor's name.
> KEY_HOMEPAGE has a defined function inherited from that other O.S. which is
> to open up the default browser on the default "homepage".  I can easily see
> both keys existing on a system.
>

OK, right now we have:

KEY_WWW
KEY_VENDOR
KEY_HOMEPAGE

defines in input.h. Are you sayign that none of these would suit?

> As for stuff like KEY_FN_BACKSPACE, well, I don't really care, as long as I
> have *something* unique and not incorrect to use.  But if we are not going
> to add extra KEY_FN_ keycodes, why don't we just convert them all to
> KEY_PROG, so that they can be useful to all and not just to people who have
> FN_<whatever> keys?
>

We could add aliases if you really want...

Can you tell me on _your_ thinkpad what markings you have? I mean
there should be a common pattern on thinkpads and the rest may be
guessed (you mentioned that FN-F5 is used to turn off radio quite
often so if thinkpad driver detects radio switch it makes sence to
just go ahead and mark FN-F5 as KEY_WLAN, doesn't it?)

-- 
Dmitry
