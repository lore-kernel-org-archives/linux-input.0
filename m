From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: use after free in serport
Date: Sun, 31 Oct 2010 10:16:22 +0100
Message-ID: <4CCD33E6.7000104@suse.cz>
References: <20101030111618.GA29915@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000505040901050302050301"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61265 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab0JaJQ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Oct 2010 05:16:29 -0400
In-Reply-To: <20101030111618.GA29915@Chamillionaire.breakpoint.cc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000505040901050302050301
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

On 10/30/2010 01:16 PM, Sebastian Andrzej Siewior wrote:
> Now we have the struct serport freed but the first process is still
> using it.
> 
> Any idea how to fix it?

I think so:
http://lkml.org/lkml/2010/10/21/223

(the updated patch attached)

regards,
-- 
js
suse labs

--------------000505040901050302050301
Content-Type: text/x-patch;
 name="0001-Char-TTY-restore-tty_ldisc_wait_idle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Char-TTY-restore-tty_ldisc_wait_idle.patch"

>From 769b2920731dabb4408ee68aec39c01765659430 Mon Sep 17 00:00:00 2001
From: Jiri Slaby <jslaby@suse.cz>
Date: Thu, 21 Oct 2010 15:49:18 +0200
Subject: [PATCH] Char: TTY, restore tty_ldisc_wait_idle

It was removed in 65b770468e98 (tty-ldisc: turn ldisc user count into
a proper refcount), but we need to wait for last user to quit the
ldisc before we close it in tty_set_ldisc.

Otherwise weird things start to happen. There might be processes
waiting in tty_read->n_tty_read on tty->read_wait for input to appear
and at that moment, a change of ldisc is fatal. n_tty_close is called,
it frees read_buf and the waiting process is still in the middle of
reading and goes nuts after it is woken.

Previously we prevented close to happen when others are in ldisc ops
by tty_ldisc_wait_idle in tty_set_ldisc. But the commit above removed
that. So revoke the change and test whether there is 1 user (=we), and
allow the close then.

We can do that without ldisc/tty locks, because nobody else can open
the device due to TTY_LDISC_CHANGING bit set, so we in fact wait for
everybody to leave.

I don't understand why tty_ldisc_lock would be needed either when the
counter is an atomic variable, so this is a lockless
tty_ldisc_wait_idle.

On the other hand, if we fail to wait (timeout or signal), we have to
reenable the halted ldiscs, so we take ldisc lock and reuse the setup
path at the end of tty_set_ldisc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/tty_ldisc.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/char/tty_ldisc.c b/drivers/char/tty_ldisc.c
index 412f977..5bbf33a 100644
--- a/drivers/char/tty_ldisc.c
+++ b/drivers/char/tty_ldisc.c
@@ -47,6 +47,7 @@
 
 static DEFINE_SPINLOCK(tty_ldisc_lock);
 static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
+static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_idle);
 /* Line disc dispatch table */
 static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
@@ -83,6 +84,7 @@ static void put_ldisc(struct tty_ldisc *ld)
 		return;
 	}
 	local_irq_restore(flags);
+	wake_up(&tty_ldisc_idle);
 }
 
 /**
@@ -531,6 +533,23 @@ static int tty_ldisc_halt(struct tty_struct *tty)
 }
 
 /**
+ *	tty_ldisc_wait_idle	-	wait for the ldisc to become idle
+ *	@tty: tty to wait for
+ *
+ *	Wait for the line discipline to become idle. The discipline must
+ *	have been halted for this to guarantee it remains idle.
+ */
+static int tty_ldisc_wait_idle(struct tty_struct *tty)
+{
+	int ret;
+	ret = wait_event_interruptible_timeout(tty_ldisc_idle,
+			atomic_read(&tty->ldisc->users) == 1, 5 * HZ);
+	if (ret < 0)
+		return ret;
+	return ret > 0 ? 0 : -EBUSY;
+}
+
+/**
  *	tty_set_ldisc		-	set line discipline
  *	@tty: the terminal to set
  *	@ldisc: the line discipline
@@ -634,8 +653,17 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	flush_scheduled_work();
 
+	retval = tty_ldisc_wait_idle(tty);
+
 	tty_lock();
 	mutex_lock(&tty->ldisc_mutex);
+
+	/* handle wait idle failure locked */
+	if (retval) {
+		tty_ldisc_put(new_ldisc);
+		goto enable;
+	}
+
 	if (test_bit(TTY_HUPPED, &tty->flags)) {
 		/* We were raced by the hangup method. It will have stomped
 		   the ldisc data and closed the ldisc down */
@@ -669,6 +697,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	tty_ldisc_put(o_ldisc);
 
+enable:
 	/*
 	 *	Allow ldisc referencing to occur again
 	 */
-- 
1.7.3.1


--------------000505040901050302050301--
