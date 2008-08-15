From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 15:38:33 +0100
Message-ID: <20080815153833.7a86a244@lxorguk.ukuu.org.uk>
References: <20080814044337.GA11632@emu>
	<1218725645.907.27.camel@thor.sulgenrain.local>
	<1218736209.4467.11.camel@localhost.localdomain>
	<20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi>
	<20080815080247.GA17613@fooishbar.org>
	<20080815082629.GB16680@sci.fi>
	<20080815100717.ZZRA012@mailhub.coreip.homeip.net>
	<20080815143119.GB2779@fooishbar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <20080815143119.GB2779@fooishbar.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Daniel Stone <daniel@fooishbar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michel D?nzer <michel@tungstengraphics.com>, xorg@lists.freedesktop.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> So it would seem that an ioctl to say 'I'm dealing with this, don't let
> the TTY layer and mousedev get at it' would be helpful, but one that
> stops short of a full grab.

There is a requirement for secure attention key processing in some
environments. Being able to divert the SAK key wouldn't be acceptable so
some care is needed.

Alan
