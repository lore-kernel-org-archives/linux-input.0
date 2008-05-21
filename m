From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/5] xen pvfb: Para-virtual framebuffer,
	keyboard and pointer driver updates
Date: Wed, 21 May 2008 10:37:31 +0200
Message-ID: <87d4ngm4s4.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, Pat Campbell <plc@novell.com>, linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

This is an update to the Linux part of the Xen PVFB.  Linux Xen PVFB
is a pair of Xen para-virtual frontend device drivers:
drivers/video/xen-fbfront.c provides a framebuffer, and
drivers/input/xen-kbdfront provides keyboard and mouse.  Their
backends run in dom0 user space.

Parts in this patch series:

1. Enable Xen console by default in domU
2. Pointer z-axis (mouse wheel) support
3. Module aliases to support module autoloading
4. Zero unused bytes in events sent to backend
5. Dynamic mode support (screen resizing)

To the best of my knowledge, these patches are independent.  The last
one needs a bit of trivial merging to apply without the first one.  I
tested only 1, 1+2, 1+2+3, 1+2+3+4, and the complete series.  I'm
happy to split this into different parts if that helps.

Complete diffstat:

 arch/x86/xen/enlighten.c         |    4 +-
 drivers/input/xen-kbdfront.c     |   20 ++++-
 drivers/video/xen-fbfront.c      |  211 ++++++++++++++++++++++++++++++++-----
 include/linux/console.h          |    2 +
 include/xen/interface/io/fbif.h  |   29 +++++-
 include/xen/interface/io/kbdif.h |    2 +
 kernel/printk.c                  |    3 +
 7 files changed, 235 insertions(+), 36 deletions(-)
