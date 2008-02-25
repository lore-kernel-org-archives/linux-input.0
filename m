From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/3] xen pvfb: Para-virtual framebuffer,
	keyboard and pointer
Date: Mon, 25 Feb 2008 14:00:16 +0100
Message-ID: <87tzjx6vj3.fsf@pike.pond.sub.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com
List-Id: linux-input@vger.kernel.org

This is a pair of Xen para-virtual frontend device drivers:
drivers/video/xen-fbfront.c provides a framebuffer, and
drivers/input/xen-kbdfront provides keyboard and mouse.

The backends run in dom0 user space.

Differences since last post:

* Required patch fixing 32-on-64 xen-blkfront included.

* Cleanup when xenkbd_probe() fails fixed.

* Don't store event channel in device info.

I started with the Xen version at
http://xenbits.xensource.com/linux-2.6.18-xen.hg?rev/ca05cf1a9bdc

Differences to that Xen version, for those who care:

* Rewritten on top of fb deferred I/O

* IRQ handler names visible in /proc and /sys match the driver names.

* Use framebuffer helper functions appropriate for framebuffer in
  system RAM.

* write() refreshes the framebuffer properly.

* off-by-one height of some screen refreshs fixed.

* Crash when register_framebuffer() fails fixed.

* Test for empty ring in input_handler() fixed.

* Deadlock in xen-kbdfront resume fixed.

* Cleanup when xenkbd_probe() fails fixed.

* General clean up.

I have a step-by-step patch series from that Xen version to my
version, if anybody is interested.  Might be useful for reviewers
familiar with the Xen version.

The patch consists of three parts:

1. xen: Make xen-blkfront write its protocol ABI to xenstore

   Could do without, but then I'd have to put the same bug in
   xen-fbfront and xen-kbdfront.

2. fbdev: Make deferred I/O work as advertized

   I need fb deferred I/O, but is utterly broken.  A fix has been
   floating around on linux-fbdev-devel as part of a larger patch,
   which as far as I know has not been merged anywhere, yet.  This is
   just the fix.

2. xen pvfb: Para-virtual framebuffer, keyboard and pointer driver

   The actual drivers.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
