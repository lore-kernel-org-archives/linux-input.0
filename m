From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Tue, 19 Oct 2010 08:53:22 -0700
Message-ID: <20101019155321.GB22303@core.coreip.homeip.net>
References: <4CBE02F00200002300022497@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CBE02F00200002300022497@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 19, 2010 at 03:43:28AM -0600, Joey Lee wrote:
> > > +
> > > +static const struct key_entry acer_wmi_keymap[] = {
> > > +	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
> > > +	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
> > > +	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
> > > +	{KE_KEY, 0x22, {KEY_PROG2} },    /* Aracade */
> > > +	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
> > > +	{KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key */
> > > +	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
> > > +	{KE_KEY, 0x82, {KEY_F22} },      /* Touch Pad On/Off */
> > 
> > We need to standardize this. Some people use F13/F14, here we have
> > F22...
> > 
> 
> Currently, evdev is mapping the F22 to XF86TouchpadToggle:
> 
> http://cgit.freedesktop.org/xkeyboard-config/commit/?id=1d05eda8dfc706d6450cab5883120e0d5e1100c
> 

Yes, but evdev is key-squatting ;) We should have a dedicated keycode
for dedicated functions.

-- 
Dmitry
