From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.38-rc2
Date: Fri, 28 Jan 2011 23:23:24 -0800
Message-ID: <20110129072324.GA26915@core.coreip.homeip.net>
References: <20110107065448.GC29038@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110107065448.GC29038@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Nothing interesting, just
small fixups for recent breakages.

Thanks!

Changelog:
---------

Alexandre Peixoto Ferreira (2):
      Input: synaptics - fix reconnect logic on MT devices
      Input: synaptics - retry failed resets when reconnecting

Rakesh Iyer (2):
      Input: tegra-kbc - fix build error
      Input: tegra-kbc - fix keymap entry for LeftMeta key


Diffstat:
--------

 drivers/input/keyboard/tegra-kbc.c |    6 +++---
 drivers/input/mouse/synaptics.c    |   32 ++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 11 deletions(-)

-- 
Dmitry
