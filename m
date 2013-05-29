From: Jean Delvare <jdelvare@suse.de>
Subject: Dependencies in the HID subsystem
Date: Wed, 29 May 2013 21:19:34 +0200
Message-ID: <1369855174.4306.198.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Michal Marek <mmarek@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi all,

I am worried and confused by some Kconfig dependencies in the HID
subsystem.

There are 11 HID device drivers which are defined in drivers/hid/Kconfig
with:

	tristate "..." if EXPERT
	default !EXPERT

Unless EXPERT is enabled (and that's not the default), these driver
entries are hidden and automatically selected. If CONFIG_HID=m, they are
selected as modules. If CONFIG_HID=y, they are built into the kernel. So
it is impossible to have CONFIG_HID=y and build these device drivers as
modules - as device drivers typically are.

I would like to understand the reasoning behind this complexity. What is
so special about these 11 drivers, that we can't just let the (kernel
configuring) user chose if he/she wants them and in what form?

Wouldn't "default !EXPERT" and a good old "If unsure, say Y" in the help
text be enough?

I would be fine with "tristate ... if EXPERT" if I still had the choice
between built-in or modular when both are possible. Is there any chance
to change the meaning of this construct to that?

Also I find it unpleasant that this construct completely hides the
option from the user, as if it did not exist, except if other options
depend on it. This is inconsistent and makes it difficult for the user
to know whether a specific kernel version includes a given driver or not
(one has to check .config afterward to know the answer.)

Put in short, I don't like the way things are today and would welcome
changes in this area.

Thanks,
-- 
Jean Delvare
Suse L3

