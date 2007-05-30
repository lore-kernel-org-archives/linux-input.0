From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 12:24:44 -0300
Message-ID: <20070530152444.GD17530@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 30 May 2007, Dmitry Torokhov wrote:
> On 5/29/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> >But I will still need to add keys, and I still think that a bunch of 32 or
> >so HOSTSPECIFIC keys is a very very good idea to have, *even* if I add some
> >model specific knowledge and already remap a few of the hot key keyboard to
> >less generic events where possible.
> 
> I think that adding anything like HOSTSPECIFIC is a failure on our
> part. That means that you need to make programs out there aware of

Well, you have to choose one of three possibilities for an unlabelled key:

1. Generate SOMETHING that has an undefined meaning or function, but which
is unique for that keyboard (KEY_PROG/KEY_HOSTSPECIFIC)

2. Generate SOMETHING that has a non-specific function, but a well defined
meaning (KEY_FN_F1)

3. Do nothing.

I *REALLY* do not like (3), and so far I have not seen a single good
technical reason to go with it.  From the technically sound ones, you need
to either have the keycodes you need for (2) (i.e. KEY_FN_BACKSPACE), or a
big enough set of keycodes to use (1) (i.e. KEY_PROG5..KEY_PROGn, where n
should probably be at least 8).

> I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
> supposed to do? Just being an unique value to be mapped onto something
> useful? But why not use that useful keycode to begin with?

Yes, just an unique value to be mapped onto something useful, by something
in userspace.  Just like KEY_PROG, actually.

One can't use a "useful keycode" for two reasons:

1.	Because the key has no set function (it is unmarked)
2.	Because it has, or could have, a set function, but we have no clue
which is it.

> I'd rather leave the keys unmapped and rely on initsripts (possibly
> with help from distributions vendors) to load proper keymap then add
> something that must be retranslated over and over again.

I don't.  I can live with it, of course, but if we are going to go that way,
what IS the excuse for a big lot of the keys already in input.h?  We have
been adding the unique keycodes and functional keycodes because it is
*useful*.

Again, let me remind you that I have nothing against using functional
keycodes (KEY_HOMEPAGE, KEY_WLAN) when we know the key is actually that, and
that all I am asking for is some non-wrong keycode to use when we don't (so
that I don't use KEY_F13 for KEY_FN_INSERT, for example).

Heck, I even proposed to write a patch to do away with most of the KEY_FN
and make them into KEY_HOSTSPECIFIC (now it would be KEY_PROG, of course),
which would stop wasting keymap codepoints for stuff that has no set
functions, anyway.

Of course, if I needed keys for a specific function, I'd be asking for them
instead, but I am not there yet.

> And what are their intended functions would be? How KEY_VENDORHOMEPAGE
> is different from KEY_HOMEPAGE?

KEY_VENDORHOMEPAGE is exactly that.  It is marked with the vendor's name.
KEY_HOMEPAGE has a defined function inherited from that other O.S. which is
to open up the default browser on the default "homepage".  I can easily see
both keys existing on a system.

As for stuff like KEY_FN_BACKSPACE, well, I don't really care, as long as I
have *something* unique and not incorrect to use.  But if we are not going
to add extra KEY_FN_ keycodes, why don't we just convert them all to
KEY_PROG, so that they can be useful to all and not just to people who have
FN_<whatever> keys?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
