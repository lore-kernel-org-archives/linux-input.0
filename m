From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Making KEY_UNKNOWN really useful to userland
Date: Thu, 31 May 2007 00:33:50 -0400
Message-ID: <200705310033.51230.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com> <20070531005305.GC6883@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070531005305.GC6883@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wednesday 30 May 2007 20:53, Henrique de Moraes Holschuh wrote:
> On Wed, 30 May 2007, Dmitry Torokhov wrote:
> > On 5/30/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > >It is trivial to guarantee that KEY_PROG is unique for a single input
> > >device (keyboard), but it certainly won't work across multiple devices.
> > >Userspace has to know what kind of input device it is talking to to map
> > >them to something, but since the input layer already provides this
> > >information, I was not going to raise a fuss about it.  I figure it is
> > >the price of not increasing even more the keycode table.
> > 
> > Actually I try to discourage people from using input_id during device
> > discovery but rather tell them to analyze capability bits and then decide
> > if their application is interested in that particular input device. I
> > think input_id should pretty much only used by udev & co. to adjust
> > default kernel setup for the needs of local installation (fix keymap,
> > adjust absmax, etc).
> 
> It is likely going to be used by something like udev, or an init script, or
> a thinkpad-configurator helper, or whatever.  Sounds like the sort of stuff
> that should be paying attention to input_id anyway.

Right.

> 
> We don't appear to have deployed a good kernel-userland interface that
> allows us to have generic "press an unknown key and tell me what you want it
> to do" application in userland, but if we do please correct me.  If
> KEY_UNKNOWN was always required to send a EV_MSC MSC_RAW/MSC_SCAN, then we
> would have one.
>

Yes, I think this is a resonable requrement.

> Maybe we can add that requirement and driver changes (if any, for all I know
> most drivers might already be generating such events) for 2.6.23?

I think that we should start with drivers that allow adjusting keymaps
via EVIOCGKEYCODE/EVIOCSKEYCODE. If driver does not allow changing keymap
then it does not really matter (although I will try to convert drivers
now that we have getkeycode/setkeycode per-device methods).
 
> I bet 
> Richard would like that one a lot.  Richard?
> 
> Such functionality makes most of my requests for new keycodes irrelevant, so
> I will just trim that down.
> 
> > >That said, how is one to know which hardware key was translated to
> > >KEY_UNKNOWN, so that he can inform the user to remap that key?  Should I
> > >send another event together with KEY_UNKNOWN that has the raw keycode?
> > >Which one?
> > 
> > You may try using EV_MSC/MSC_SCAN. You can even send it all the time, not
> > only for KEY_UNKNOWN.
> 
> Will do, thanks.  And I will send it all the time, that will force people to
> properly implement code that can deal with them in userland.
> 
> What is the exact difference between MSC_RAW and MSC_SCAN?  Which one can be
> used as an index to reprogram the keymap using the IOCTLs?
>

MSC_RAW is just raw data from device. It may carry make/break data encoded
in it. MSC_SCAN is what one need.

-- 
Dmitry
