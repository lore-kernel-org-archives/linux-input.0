From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ibm-acpi-devel] [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Thu, 31 May 2007 00:01:47 +0100
Message-ID: <20070530230146.GA8623@srcf.ucam.org>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com> <20070530152444.GD17530@khazad-dum.debian.net> <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com> <20070530172420.GA6883@khazad-dum.debian.net> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-input@atrey.karlin.mff.cuni.cz, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, May 30, 2007 at 04:25:03PM -0400, Dmitry Torokhov wrote:

> Consider ejecting a CD tray. You have a laptop with a key that maked
> eject CD. Because it is a new laptop there are no proper mapping yet
> so some adjustments are needed. With your scenario the kernel emits
> KEY_PROG26. User has first to adjust X keymap to map KEY_PROG26 to
> EjectCD event (simplifying). Then he goes into text console only to
> find out that his curses-based CD player does not recognize that key
> and also needs to be adjusted. And so on. Finally all applications are
> made aware of KEY_PROG26 amd user is happy. Couple of weeks later he
> goes and buys an external keyboard and it turns out that eject CD
> there is actually KEY_PROG21 so he need to go through second round of
> mapping for all applications. Not only that but button with volume
> increase happens to generate KEY_PROG26. Now what?
> 
> Now consider in-kernel remapping to functional scancdes that I
> propose: user says that that key should generate KEY_EJECTCD and it
> starts working in all appliations recognizing that event. Adding the
> second keyboard into mix does not mess up the first one.

That makes absolute sense when a key has a defined function, but in the
case we're discussing it doesn't. So, we have two choices:

1) Map it to a specific function system-wide (so a default of 
KEY_UNKNOWN is fine)
2) Map it to a specific function at the user level

If the key doesn't have anything printed on it, there is no correct 
system-wide default. It's intrinsically a per-user preference. But for 
the user to be able to decide what the key does, it has to generate a 
keycode. Once it does that they can use one of the existing X 
applications to bind that to an X keysym and then everyone is happy.

But for this to be possible a keycode has to be generated. We can either 
set this at boot time or in the kernel. The only argument for doing it 
at boot time is that userspace might have a better idea what the key 
should map to. However, in the case of a blank key, how is userspace 
going to have any more idea than the kernel does? The only sane default 
is something like KEY_PROG1.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
