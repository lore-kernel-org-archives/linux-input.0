From: Anton Zinoviev <anton@lml.bas.bg>
Subject: Bug#514464: caps lock led does not show up
Date: Thu, 2 Jul 2015 19:39:06 +0300
Message-ID: <20150702163905.GA7518@logic.fmi.uni-sofia.bg>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
 <20150609141723.GE3045@type>
 <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
 <20150611080809.GD3184@type.bordeaux.inria.fr>
 <20150611142803.GA3056@type.access.network>
 <20150611153755.GA2247@type>
 <20150625154112.GF3093@type.bordeaux.inria.fr>
Reply-To: Anton Zinoviev <anton@lml.bas.bg>, 514464@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.514464.B514464.143585514810091@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20150625154112.GF3093@type.bordeaux.inria.fr>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Samuel Thibault <sthibault@debian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 514464@bugs.debian.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 25, 2015 at 05:41:12PM +0200, Samuel Thibault wrote:
> 
> The patch got into Linus' tree, so it will most probably get into Linux
>
> [... skipping some long comprehensible explanation ...]

At this point I had the feeling I understood everything I needed.
 
> Anton, do you have all the informations you need to match that with the
> xkb data?

But here, I don't understand what matching with xkb data you mean?

I have the following questions:

1. Is there a packaged Debian kernel with this functionality I can use?

2. Suppose the new keyboard layout requires a trigger different from 
kbd-ctrlllock (because the user used KMAP in /etc/default/keyboard or 
installed console-setup-mini).  I can echo the new trigger for the 
existing keyboards, but what about the udev rules?  Can they change on 
the fly?  Or maybe there is some way not to hardcode the trigger in the 
udev rule but read it from a separate file each time the rule activates?

BTW, at the moment I think it will be best if I write a script kbd_leds 
and propose it for inclusion in the console utilities package 'kbd'.  
Definitely, this is a functionality useful not only for console-setup 
users.  Then console-setup will be able to use the combination 
kbd_mode+loadkeys+kbd_leds in order to configure the keyboard.

Anton Zinoviev
