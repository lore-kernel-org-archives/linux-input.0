From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
Subject: Re: [PATCH 0/4] platform/x86: intel-vbtn: Add support for several
 more switches/buttons
Date: Mon, 6 Nov 2017 15:25:39 +0000
Message-ID: <2254450.FtXLtYGOvl@sbruens-linux>
References: <b8013fda-0f69-41d7-ade3-98ca861dc30d@rwthex-w2-a.rwth-ad.de>
 <CAHp75VfxpUJRdp9hKnPnJ7-7Kfo=DnTm-NRvE-KCQ2ZJ6eehNA@mail.gmail.com>
 <1509972865.2869.112.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1509972865.2869.112.camel@hadess.net>
Content-Language: en-US
Content-ID: <FD5040EBDAD90C43BEDA5F25F8936ABF@rwth-ad.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>
List-Id: linux-input@vger.kernel.org

On Montag, 6. November 2017 13:54:25 CET Bastien Nocera wrote:
> On Sun, 2017-11-05 at 14:31 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 3, 2017 at 9:03 PM, Stefan Brüns
> > 
> > <stefan.bruens@rwth-aachen.de> wrote:
> > > Currently, intel-vbtn only supports the most relevant buttons,
> > > although
> > > there are several more events, mostly in use by convertibles.
> > > 
> > > This series adds support for three more events. One of these events
> > > is a switch (SW_*) event, which is currently not working when using
> > > sparse keymaps. The first patch fixes this combination.
> > > 
> > > The second patch adds support for the SW_TABLET_MODE switch, which
> > > is used by current convertibles.
> > > 
> > > The third patch adds support for the KEY_ROTATE_DISPLAY. On the
> > > Dell
> > > XPS 12 (9Q33), rotation lock is implemented as a button to toggle
> > > between locked and unlocked state. In locked state, the
> > > accelerometer
> > > should be ignored, while in unlocked the screen contents should
> > > autorotate based on the tablet orientation. The same functionality
> > > is likely implemented as a switch (SW_ROTATE_LOCK event) on
> > > different
> > > hardware.
> > > 
> > > The fourth patch adds support for the "Windows logo" button/key
> > > found on
> > > the XPS 12 display (i.e. in tablet mode, it is the only key
> > > reachable).
> > > The Lenovo Helix 2 has an equivalent touch button. The event
> > > currently
> > > uses KEY_MENU, although a distinct key code may be a better choice.
> > 
> > All, except first, are applied to my review and testing queue,
> > thanks!
> > 
> > > Stefan Brüns (4):
> > >   Input: sparse-keymap - send sync event for KE_SW/KW_VSW
> > >   platform/x86: intel-vbtn: support SW_TABLET_MODE
> > >   platform/x86: intel-vbtn: support KEY_ROTATE_DISPLAY
> > >   platform/x86: intel-vbtn: support panel front button
> 
> KEY_MENU is the key for the contextual menu. You need to use
> KEY_LEFTMETA. See 791738be57473fddaf393dcedcef31b577231aaa which does
> this for soc_button_array.

IMHO LEFTMETA is a bad idea for several reasons:

- LEFTMETA aka Windows aka RightGUI key is used as a modifier/flag (see e.g. 
USB HID HUT, Keyboard Page 0x07), while on a tablet, it is the only regular 
button (save special funtions like power, volume).

- on a regular keyboard, I expect the LEFTMETA key to be handled/usable as a 
modifier key. I would not expect it to be used as a shortcut key.

So if KEY_MENU is not acceptable, a new keycode IMHO is a much better option.

Kind regards,

Stefan
