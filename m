From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 3.7-rc3: mouses stopped working
Date: Fri, 16 Nov 2012 13:37:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211161335180.20577@pobox.suse.cz>
References: <20121115132849.GA4062@elf.ucw.cz> <alpine.LNX.2.00.1211151429240.15877@pobox.suse.cz> <20121115140736.GA2651@elf.ucw.cz> <alpine.LNX.2.00.1211151508350.15877@pobox.suse.cz> <20121116013405.GA2002@elf.ucw.cz> <alpine.LNX.2.00.1211161153290.20577@pobox.suse.cz>
 <20121116122400.GA10994@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121116122400.GA10994@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 16 Nov 2012, Pavel Machek wrote:

> > > root@amd:/tmp# uname -a
> > > Linux amd 3.7.0-rc5+ #236 SMP Thu Nov 15 20:07:26 CET 2012 i686 GNU/Linux
> > > root@amd:/tmp# cat /dev/input/mice
> > > cat: /dev/input/mice: No such device or address
> > > root@amd:/tmp# ls -al /dev/input/mice
> > > crw-rw---- 1 root root 13, 63 Apr 25  2010 /dev/input/mice
> > > root@amd:/tmp# 
> > 
> > Let's see whether this is /dev/input/mice issue or something else first.
> > 
> > Is anything coming out of corresponding /dev/input/eventX node?
> 
> /dev/input/mouse0 and /dev/input/mouse1 generate events when I move
> internal/USB mouse.
> 
> ls -al /dev/input/mouse0 
> crw-rw---- 1 root root 13, 32 Apr 25  2010 /dev/input/mouse0
> pavel@amd:/tmp$ ls -al /dev/input/mouse1
> crw------T 1 root root 13, 33 Aug 30 16:41 /dev/input/mouse1
> pavel@amd:/tmp$ 
> 
> > And /dev/hidrawX?
> 
> /dev/hidraw0 seems to correspond to USB mouse and generates
> events. Could not find hidraw corresponding to PS/2 mouse.

That is correct and expected behavior.

> So it seems to be "/dev/input/mice" issue. Does it work for you?

Yes, it works for me properly (testing with rc4+, 1b42fc4 more precisely). 
Even after disconnect/reconnect cycle of USB mouse, I am getting events 
properly from /dev/input/mice (frankly I am surprised that you noticed ... 
Xorg has been using evdev driver for ages already by default, right?)

What was the last kernel version that worked for you in this respect?

Adding Dmitry and linux-input.

-- 
Jiri Kosina
SUSE Labs
