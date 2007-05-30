From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 09:57:11 -0400
Message-ID: <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	 <200705262340.28219.dtor@insightbb.com>
	 <20070527121513.GC19562@khazad-dum.debian.net>
	 <200705282316.32173.dtor@insightbb.com>
	 <20070529130528.GB12935@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070529130528.GB12935@khazad-dum.debian.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/29/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Mon, 28 May 2007, Dmitry Torokhov wrote:
> > On Sunday 27 May 2007 08:15, Henrique de Moraes Holschuh wrote:
> > > On Sat, 26 May 2007, Dmitry Torokhov wrote:
> > > > I am unconvinced that we need new keycodes. Isn't there a better default
> > > > keycodes for these keys? You mentioned that fn+f5 controls radio on many
> > > > thinkpads, why don't you use KEY_WLAN in your keymap?
> > >
> > > No can do the KEY-WLAN thing, sorry.  I *don't* have a way to know, unless I
> > > add a model-specific map table to the kernel, and I have been told by
> > > numerous people to don't even try, unless it is for quirks, etc.
> >
> > Why not? It thinkpad-acpi is a box-specific driver and you could try to
> > setup proper keymap depending on models. We do that in wistron_btns and
> > it doers not even need alot of memory (keymaps and dmi data is marked
> > __initdata and is discarded).
>
> Well, I will try, let's see if ACPI upstream will take it after I tell them
> it was decided to be the best approach by the input layer people.  Yes, it
> can be __initdata, so it should not cause any drawbacks.
>
> But I will still need to add keys, and I still think that a bunch of 32 or
> so HOSTSPECIFIC keys is a very very good idea to have, *even* if I add some
> model specific knowledge and already remap a few of the hot key keyboard to
> less generic events where possible.
>

I think that adding anything like HOSTSPECIFIC is a failure on our
part. That means that you need to make programs out there aware of
multiple hosts and their usage. You can't just say that you going to
teach X and the rest will use X facilities because there is world
outside of X. Programs like HAL, network management (rfkill) other
daemons getting input directly from /dev/input/eventX will have to be
made aware. This is not good.

I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
supposed to do? Just being an unique value to be mapped onto something
useful? But why not use that useful keycode to begin with?

I'd rather leave the keys unmapped and rely on initsripts (possibly
with help from distributions vendors) to load proper keymap then add
something that must be retranslated over and over again.

> > > Really, what are we to do with that input.h scancode map?  It *IS* supposed
> > > to be absolute, i.e. one is not supposed to reuse keys in there if the
> > > functionality *or* the generic description is not an exact match.
> >
> > Are there any markings on those keys?
>
> Only a few of them.  And the ones I wanted to add are *not* marked in most
> models :-)
>
> The markings change a bit from model to model, and we have a *very*
> incomplete list of those...
>

Well, what kind of functions you would like them to have? You, as a
maintainer, can chose defaults. Since you (well, not you, the driver)
provide a way for a user to adjust keymap there should be no problem
even if someone does not like the values you chose. Having sensible
defaults is a good thing, otherwise many people will not even know
that they have these "separate" keys.

>
> Alternatively, if you let me add keys, I will need a few of them, and they
> are also generic (not necessarily thinkpad-specific).  Stuff like:
>
> KEY_FN_BACKSPACE,
> KEY_VENDORHOMEPAGE,

And what are their intended functions would be? How KEY_VENDORHOMEPAGE
is different from KEY_HOMEPAGE?

-- 
Dmitry
