From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 15:04:51 +0100
Message-ID: <20070530140450.GA29514@srcf.ucam.org>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, May 30, 2007 at 09:57:11AM -0400, Dmitry Torokhov wrote:

> I really don't like KEY_FN_F1..KEY_FN_BACKSPACE either. What are they
> supposed to do? Just being an unique value to be mapped onto something
> useful? But why not use that useful keycode to begin with?

We've already got KEY_PROG* - is this not the sort of situation they're 
for? (ie, keys that aren't mapped to a specific purpose but would be 
potentially useful to userspace at the per-user level)

> I'd rather leave the keys unmapped and rely on initsripts (possibly
> with help from distributions vendors) to load proper keymap then add
> something that must be retranslated over and over again.

Changing the keymap is a privileged operation, so sending /some/ sort of 
keycode by default would probably be good.

> Well, what kind of functions you would like them to have? You, as a
> maintainer, can chose defaults. Since you (well, not you, the driver)
> provide a way for a user to adjust keymap there should be no problem
> even if someone does not like the values you chose. Having sensible
> defaults is a good thing, otherwise many people will not even know
> that they have these "separate" keys.

Some of the Thinkpad keys send events even without there being any 
label, so I don't think there's a sane default other than leaving it up 
to the user. On the other hand, I'm not especially keen on sending 
literals like "FN_BACKSPACE" - it's hugely special-cased.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
