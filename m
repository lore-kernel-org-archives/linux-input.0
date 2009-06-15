From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: How to unset CONFIG_SERIO_I8042 on x86?
Date: Mon, 15 Jun 2009 19:32:29 +0200
Message-ID: <1245087149.6821.4.camel@localhost>
References: <1244915236.3288.7.camel@localhost.localdomain>
	 <4A366E67.4040300@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761337AbZFORci@vger.kernel.org>
In-Reply-To: <4A366E67.4040300@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Am Montag, den 15.06.2009, 08:53 -0700 schrieb Randy Dunlap:
> Thomas Meyer wrote:
> > Is it possible? Does it make sense?
> 
> Enabled CONFIG_EMBEDDED, then disable KEYBOARD_ATKBD and
> disable MOUSE_PS2, then you can disable SERIO_I8042.

Thanks. Works. I missed to unset the AT keyboard.

> 
> 
> Is the Macbook all USB for input devices?

Mine is.

And in general also, I guess.

> 
> 
> > I always get this message at boot up on my macbook pro:
> > 
> > [    0.929828] PNP: No PS/2 controller found. Probing ports directly.
> > [    0.930761] i8042.c: No controller found.
> > [    0.931038] mice: PS/2 mouse device common for all mice
> > 
> > Or please make these messages warnings only, so I don't see them with
> > kernel option quiet.
> 
> 
