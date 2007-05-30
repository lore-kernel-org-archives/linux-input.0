From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 10:18:17 -0400
Message-ID: <d120d5000705300718o61f01a78r67e19449f8537c55@mail.gmail.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	 <200705262340.28219.dtor@insightbb.com>
	 <20070527121513.GC19562@khazad-dum.debian.net>
	 <200705282316.32173.dtor@insightbb.com>
	 <20070529130528.GB12935@khazad-dum.debian.net>
	 <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
	 <20070530140450.GA29514@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070530140450.GA29514@srcf.ucam.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Matthew,

On 5/30/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, May 30, 2007 at 09:57:11AM -0400, Dmitry Torokhov wrote:
>
> > I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
> > supposed to do? Just being an unique value to be mapped onto something
> > useful? But why not use that useful keycode to begin with?
>
> We've already got KEY_PROG* - is this not the sort of situation they're
> for? (ie, keys that aren't mapped to a specific purpose but would be
> potentially useful to userspace at the per-user level)
>

Right. These are they keys "we have no idea how to use these, leave it
to the user". Do we really need more of these? We have quite a few
codes that might be useful. I just don't want to keep adding a new
input keycode every time we encounter an unmarked key somewhere.

> > I'd rather leave the keys unmapped and rely on initsripts (possibly
> > with help from distributions vendors) to load proper keymap then add
> > something that must be retranslated over and over again.
>
> Changing the keymap is a privileged operation, so sending /some/ sort of
> keycode by default would probably be good.
>

It's up to the security policy on a particular box. One could change
/dev/input/evdev ownership to the user currently logged on physical
console.

Overall I think adjusting the keymap at boot time (so per-installation
case) will cover most of users.

> > Well, what kind of functions you would like them to have? You, as a
> > maintainer, can chose defaults. Since you (well, not you, the driver)
> > provide a way for a user to adjust keymap there should be no problem
> > even if someone does not like the values you chose. Having sensible
> > defaults is a good thing, otherwise many people will not even know
> > that they have these "separate" keys.
>
> Some of the Thinkpad keys send events even without there being any
> label, so I don't think there's a sane default other than leaving it up
> to the user. On the other hand, I'm not especially keen on sending
> literals like "FN_BACKSPACE" - it's hugely special-cased.
>

That's why maintainer gets to chose his favorite keymap (from
available keycodes ;) ) and anyone who's unhappy with the coise gets
to add couple of lines in rc.local.

Also there is DMI and possibility to  load install different keymaps
this way (which Ithink is good for vendor-specific drivers - I woudl
not add dmi to atkbd for example because you never know what external
keyboard user may plug in).

-- 
Dmitry
