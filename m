From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Keyboard problem
Date: Mon, 30 Jul 2007 16:26:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707301624330.26532@jikos.suse.cz>
References: <32209efe0707152028h69b507b1j6ecd6c8e358ead62@mail.gmail.com>
 <d120d5000707160629y2c866d1enb2af1e2f89f5f00f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707160629y2c866d1enb2af1e2f89f5f00f@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Natalie Protasevich <protasnb@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

On Mon, 16 Jul 2007, Dmitry Torokhov wrote:

> What keyboard driver are you using in X? Isit the standard keyboard 
> driver or xf86-input-evdev? If the former you can try loading evbug 
> module (which will dump all input events into syslog) and wait for the 
> condition to appear. Then connect to the box remotely (ssh/telnet) and 
> see if keypresses still make to syslog. If they do that means that 
> USB/HID and input core work fine and the propblem lies in the upper 
> layers.

You could also enable CONFIG_USB_DEBUG and CONFIG_HID_DEBUG (*) and see 
whether there are any error messages reported when the hang occurs.

(*) with the latest vanilla kernel (2.6.23-rc1 and later) CONFIG_HID_DEBUG 
defaults to 'y', but you have to pass 'debug=1' parameter to receive the 
debugging output).

Thanks,

-- 
Jiri Kosina
SUSE Labs
