From: Adam Cozzette <acozzette@cs.hmc.edu>
Subject: psmouse-base.c: printk messages still list old filename
Date: Tue, 2 Aug 2011 22:47:15 -0600
Message-ID: <20110803044714.GC23520@[192.168.0.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I was looking at drivers/input/mouse/psmouse-base.c and I saw that there are a
number of printk messages that refer to the nonexistent file psmouse.c, e.g.:

    printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
        psmouse->name, psmouse->phys);

I saw on the archives that you had a patch lined up for this last year. Is that
patch still on the way or has it been dropped? I would be happy to provide a new
patch for this if it is still something that needs to be fixed.

Thank you,
Adam

-- 
Adam Cozzette
Harvey Mudd College Class of 2012
