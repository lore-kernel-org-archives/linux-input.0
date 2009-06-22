From: Pavel Machek <pavel@ucw.cz>
Subject: Re: defkeymap making machine useless (was Re: HTC Dream aka.
	t-mobile g1 support)
Date: Mon, 22 Jun 2009 19:22:02 +0200
Message-ID: <20090622172201.GA21153@elf.ucw.cz>
References: <d6200be20906171436y5280ed8do561d2d53d73ca78@mail.gmail.com> <20090618101309.GC28892@elf.ucw.cz> <a55d774e0906181233p35b60cd2ga401bd1304267643@mail.gmail.com> <20090618.123845.232783995.davem@davemloft.net> <20090618230704.GB8529@elf.ucw.cz> <alpine.LNX.2.00.0906221131380.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56613 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218AbZFVRWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2009 13:22:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0906221131380.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Miller <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, swetland@google.com, arve@android.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, san@android.com, rlove@google.com, Greg KH <greg@kroah.com>

On Mon 2009-06-22 11:33:31, Jiri Kosina wrote:
> On Fri, 19 Jun 2009, Pavel Machek wrote:
> 
> > > > Yeah, I wasn't sure how to handle this.  We try to keep the 
> > > > msm/dream stuff in a state that doesn't break other parts of the 
> > > > tree, but there doesn't seem to be support for different keymaps for 
> > > > different devices.
> > > How it's supposed to work is that you have a specific keyboard driver 
> > > and that emits PC keyboard codes into the core kernel using a 
> > > translation table in your driver.
> > Of course, Dream does  that.  But that's not _nearly_ enough. Dream
> > lacks keys such as: esc, arrows, symbols (/;'[]\-=). That means that
> > for +, you can't press shift-=, you need to press altgr-P.
> 
> I don't seem to have enough context, but wouldn't writing a separate serio 
> driver, which would do all the needed translations be enough here?

Umm.

Yes, we could parse the keyboard combinations in the keyboard driver,
and then emulate the PC keyboard. It would be incredibly ugly. Such as:

If user presses Alt+I, (labeled "-" on keyboard), emulate "Shift+="
press, then let the defkeymap.map translate it back to "-".

I... guess it will be nicer if the keyboard driver specifies which
keymap to use?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
