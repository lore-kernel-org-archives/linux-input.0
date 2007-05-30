From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 15:25:16 +0100
Message-ID: <20070530142516.GA30009@srcf.ucam.org>
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
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, May 30, 2007 at 10:18:17AM -0400, Dmitry Torokhov wrote:
> Hi Matthew,
> >We've already got KEY_PROG* - is this not the sort of situation they're
> >for? (ie, keys that aren't mapped to a specific purpose but would be
> >potentially useful to userspace at the per-user level)
> >
> 
> Right. These are they keys "we have no idea how to use these, leave it
> to the user". Do we really need more of these? We have quite a few
> codes that might be useful. I just don't want to keep adding a new
> input keycode every time we encounter an unmarked key somewhere.

Sorry, I wasn't clear - I was thinking that they should just be used for 
this case, rather than that more of them be added.

> >Changing the keymap is a privileged operation, so sending /some/ sort of
> >keycode by default would probably be good.
> >
> 
> It's up to the security policy on a particular box. One could change
> /dev/input/evdev ownership to the user currently logged on physical
> console.

Most users will be logged into X, so it's the X keymap that's the most 
interesting one. X tools know how to remap the X keymap without 
requiring any sort of special privileges, so all we need is for the 
keycode to generate /something/. I think KEY_PROG* would make the most 
sense, and that's what we've adopted in Ubuntu.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
