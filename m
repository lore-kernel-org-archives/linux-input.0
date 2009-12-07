From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Mon, 7 Dec 2009 14:20:59 +0000
Message-ID: <20091207142059.GA32617@srcf.ucam.org>
References: <1259826317-18809-33-git-send-email-corentincj@iksaif.net> <20091203075404.GK9121@core.coreip.homeip.net> <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com> <20091206065829.GI5340@wrars-comp.wrarsdomain> <20091206071751.GD14651@core.coreip.homeip.net> <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com> <20091206145415.GA16414@srcf.ucam.org> <20091207114749.GD20076@khazad-dum.debian.net> <20091207125553.GA31448@srcf.ucam.org> <20091207132334.GG20076@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091207132334.GG20076@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Corentin Chary <corentin.chary@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrey Rahmatullin <wrar@altlinux.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 07, 2009 at 11:23:34AM -0200, Henrique de Moraes Holschuh wrote:
> On Mon, 07 Dec 2009, Matthew Garrett wrote:
> > On Mon, Dec 07, 2009 at 09:47:49AM -0200, Henrique de Moraes Holschuh wrote:
> > > What I do know, is that I will miss a keycode that rfkills just my WLAN... I
> > > use that for power management, it is nice to have a key that is for WLAN
> > > only, and another that is for bluetooth-only...
> > 
> > KEY_WLAN will still be there, and you can still remap. But the default 
> > behaviour should be for thinkpad-acpi (for instance) to generate 
> > KEY_RFKILL, since Fn+F5 isn't supposed to be wlan only.
> 
> That's not what I got from this thread.  What I got was that KEY_WLAN would
> be overloaded with KEY_RFKILL semanthics, regardless of anything we did in
> the kernel side.

No.

> I am strongly with you here: add a *new* KEY_RFKILL, fix the kernel drivers
> and any eventual userspace to use the new KEY_RFKILL, and have KEY_WLAN do
> what it is supposed to do.

Right. That's what the patch I sent does.

> And, if what we call KEY_WLAN is actually supposed to be KEY_RFKILL, swap
> their definitions when adding KEY_RFKILL, so that USB HID devices will
> generate KEY_RFKILL instead of KEY_WLAN.

I don't think this is in HID?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
