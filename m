From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
	IR  system?
Date: Fri, 4 Dec 2009 14:07:08 -0800
Message-ID: <20091204220708.GD25669@core.coreip.homeip.net>
References: <4B191DD4.8030903@redhat.com> <BEFgL6sXqgB@lirc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752288AbZLDWHS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BEFgL6sXqgB@lirc>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Bartelmus <lirc@bartelmus.de>
Cc: mchehab@redhat.com, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, khc@pm.waw.pl, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Fri, Dec 04, 2009 at 10:46:00PM +0100, Christoph Bartelmus wrote:
> Hi Mauro,
> 
> on 04 Dec 09 at 12:33, Mauro Carvalho Chehab wrote:
> > Christoph Bartelmus wrote:
> >>>> Consider passing the decoded data through lirc_dev.
> [...]
> >> Consider cases like this:
> >> http://lirc.sourceforge.net/remotes/lg/6711A20015N
> >>
> >> This is an air-conditioner remote.
> >> The entries that you see in this config file are not really separate
> >> buttons. Instead the remote just sends the current settings for e.g.
> >> temperature encoded in the protocol when you press some up/down key. You
> >> really don't want to map all possible temperature settings to KEY_*
> >> events. For such cases it would be nice to have access at the raw scan
> >> codes from user space to do interpretation of the data.
> >> The default would still be to pass the data to the input layer, but it
> >> won't hurt to have the possibility to access the raw data somehow.
> 
> > Interesting. IMHO, the better would be to add an evdev ioctl to return the
> > scancode for such cases, instead of returning the keycode.
> 
> That means you would have to set up a pseudo keymap, so that you can get  
> the key event which you could than react on with a ioctl. Or are you  
> generating KEY_UNKNOWN for every scancode that is not mapped?
> What if different scan codes are mapped to the same key event? How do you  
> retrieve the scan code for the key event?
> I don't think it can work this way.
> 

EV_MSC/MSC_SCAN.

-- 
Dmitry
