From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/2] xen,input: xen-kbdfront pointing device resolution support
Date: Tue, 11 Apr 2017 10:50:26 +0200
Message-ID: <20170411085028.6750-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com, andr2000@gmail.com, Juergen Gross <jgross@suse.com>
List-Id: linux-input@vger.kernel.org

As my patch tying the resolution of the xen pointing device to that of
the framebuffer wasn't accepted add support for different resolutions
via a module parameter.

Another possibility would be to set parameters via Xenstore, but this
is broken (patch 2 fixes that) and not yet supported by Xen tools.

V2: patch 1: make resolution changes via xenstore visible in sysfs

Juergen Gross (2):
  xen,input: add xen-kbdfront module parameter for setting resolution
  xen,input: repair xen-kbdfront resolution setting via xenstore

 drivers/input/misc/xen-kbdfront.c | 50 ++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 16 deletions(-)

-- 
2.12.0
