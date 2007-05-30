From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 12:07:42 -0300
Message-ID: <20070530150741.GC17530@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com> <20070530140450.GA29514@srcf.ucam.org> <d120d5000705300718o61f01a78r67e19449f8537c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000705300718o61f01a78r67e19449f8537c55@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 30 May 2007, Dmitry Torokhov wrote:
> On 5/30/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >We've already got KEY_PROG* - is this not the sort of situation they're
> >for? (ie, keys that aren't mapped to a specific purpose but would be
> >potentially useful to userspace at the per-user level)
> 
> Right. These are they keys "we have no idea how to use these, leave it
> to the user". Do we really need more of these? We have quite a few

Drat, I didn't know of those, otherwise I would not have asked for
KEY_HOSTSPECIFIC_*.  Thanks for the hint, Matthew!

But there are too few KEY_PROG symbols.  I'd need more than four of them for
the entire set of thinkpad hot keys (including nvram-based ones).

> codes that might be useful. I just don't want to keep adding a new
> input keycode every time we encounter an unmarked key somewhere.

A big enough set of KEY_PROG* would fix this.  It is basically my argument
for KEY_HOSTSPECIFIC, only that it has a different name, and that we already
have four of them.

> >> Well, what kind of functions you would like them to have? You, as a
> >> maintainer, can chose defaults. Since you (well, not you, the driver)
> >> provide a way for a user to adjust keymap there should be no problem
> >> even if someone does not like the values you chose. Having sensible
> >> defaults is a good thing, otherwise many people will not even know
> >> that they have these "separate" keys.
> >
> >Some of the Thinkpad keys send events even without there being any
> >label, so I don't think there's a sane default other than leaving it up
> >to the user. On the other hand, I'm not especially keen on sending
> >literals like "FN_BACKSPACE" - it's hugely special-cased.

Well, I'd like to have a keycode I could use so that I have it working
out-of-the-box.  It can be KEY_PROG*, if there are enough of them (can I add
more?).   Or it will be something with a specific function, when I know what
the marking on the key is.

But really, not sending a keycode at all is non-optimal.  And using a
keycode that should be for something else (say, KEY_F13) is just wrong.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
