From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Mon, 25 Jul 2016 14:01:08 -0700
Message-ID: <20160725210108.GK27415@dtor-ws>
References: <CADemMPNEv+kq21rXQMmB_BjgTsnEjscOCS5A02VAapOOM-ryMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35062 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbcGYVBM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 17:01:12 -0400
Received: by mail-pa0-f65.google.com with SMTP id cf3so11985365pad.2
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 14:01:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADemMPNEv+kq21rXQMmB_BjgTsnEjscOCS5A02VAapOOM-ryMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Laws <mdl@60hz.org>
Cc: KY Srinivasan <kys@microsoft.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Linux Input <linux-input@vger.kernel.org>

[ resending to inlude the list ]

Hi Mark,

On Tue, Jul 19, 2016 at 06:22:57PM -0700, Mark Laws wrote:
> On Tue, Jul 19, 2016 at 4:34 PM, KY Srinivasan <kys@microsoft.com> wrote:
> >> -----Original Message-----
> >> From: Mark Laws [mailto:mdl@60hz.org]
> >> Sent: Tuesday, July 19, 2016 1:29 AM
> >> To: Van De Ven, Arjan <arjan.van.de.ven@intel.com>
> >> Cc: KY Srinivasan <kys@microsoft.com>
> >> Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
> >> Hyper-V VMs
> >>
> >> On Tue, Jun 21, 2016 at 7:41 PM, Mark Laws <mdl@60hz.org> wrote:
> >> > On Wed, Jun 22, 2016 at 11:36 AM, Van De Ven, Arjan
> >> > <arjan.van.de.ven@intel.com> wrote:
> >> >>> Hi KY and Arjan,
> >> >>>
> >> >>> Does anything remain to be fixed in this patch?
> >> >>
> >> >> it works great for me.... 8042 is no longer on my radar of trouble makers...
> >> >
> >> > Glad to hear it. I hope it can get merged soon, as it's surely been a
> >> > nuisance for at least a few other folks.
> >>
> >> Hi,
> >>
> >> Is there anyone I should ping about getting this merged? Should I CC
> >> Dmitry again?
> >
> > Please do.
> >
> > K. Y
> 
> Hi Dmitry,
> 
> Could you please take a look at the patch earlier in this thread and
> merge it if it's OK? K.Y. and Arjan have said it's good. I can provide
> a rebased version if needed, though I think the one from this thread
> should apply cleanly.

Sorry for the delay, the reason is that I absolutely hated exporting the
ports array from i8042 and into yet another module. Even though I was
the author of i8042_check_port_owner() I do not like this mechanism at
all and I think it is worse than doing a small layer violation and
having a shared PS/2 mutex directly in serio port structure.

Can you please tell me if the patch below solves the issue for you?

Thanks!

-- 
Dmitry

Input: i8042 - break load dependency between atkbd/psmouse and i8042

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

As explained in 1407814240-4275-1-git-send-email-decui@microsoft.com we
have a hard load dependency between i8042 and atkbd which prevents
keyboard from working on Gen2 Hyper-V VMs:

> hyperv_keyboard invokes serio_interrupt(), which needs a valid serio
> driver like atkbd.c.  atkbd.c depends on libps2.c because it invokes
> ps2_command().  libps2.c depends on i8042.c because it invokes
> i8042_check_port_owner().  As a result, hyperv_keyboard actually
> depends on i8042.c.
>
> For a Generation 2 Hyper-V VM (meaning no i8042 device emulated), if a
> Linux VM (like Arch Linux) happens to configure CONFIG_SERIO_I8042=m
> rather than =y, atkbd.ko can't load because i8042.ko can't load(due to
> no i8042 device emulated) and finally hyperv_keyboard can't work and
> the user can't input: https://bugs.archlinux.org/task/39820
> (Ubuntu/RHEL/SUSE aren't affected since they use CONFIG_SERIO_I8042=y)

To break the dependency we move away from using i8042_check_port_owner()
and instead allow serio port owner specify a mutex that clients should use
to serialize PS/2 command stream.

Reported-by: Mark Laws <mdl@60hz.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042.c  |   16 +---------------
 drivers/input/serio/libps2.c |   10 ++++------
 include/linux/i8042.h        |    6 ------
 include/linux/serio.h        |   24 +++++++++++++++++++-----
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 4541957..b4d3408 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1277,6 +1277,7 @@ static int __init i8042_create_kbd_port(void)
 	serio->start		= i8042_start;
 	serio->stop		= i8042_stop;
 	serio->close		= i8042_port_close;
+	serio->ps2_cmd_mutex	= &i8042_mutex;
 	serio->port_data	= port;
 	serio->dev.parent	= &i8042_platform_device->dev;
 	strlcpy(serio->name, "i8042 KBD port", sizeof(serio->name));
@@ -1373,21 +1374,6 @@ static void i8042_unregister_ports(void)
 	}
 }
 
-/*
- * Checks whether port belongs to i8042 controller.
- */
-bool i8042_check_port_owner(const struct serio *port)
-{
-	int i;
-
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].serio == port)
-			return true;
-
-	return false;
-}
-EXPORT_SYMBOL(i8042_check_port_owner);
-
 static void i8042_free_irqs(void)
 {
 	if (i8042_aux_irq_registered)
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 316f2c8..83e9c66 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -56,19 +56,17 @@ EXPORT_SYMBOL(ps2_sendbyte);
 
 void ps2_begin_command(struct ps2dev *ps2dev)
 {
-	mutex_lock(&ps2dev->cmd_mutex);
+	struct mutex *m = ps2dev->serio->ps2_cmd_mutex ?: &ps2dev->cmd_mutex;
 
-	if (i8042_check_port_owner(ps2dev->serio))
-		i8042_lock_chip();
+	mutex_lock(m);
 }
 EXPORT_SYMBOL(ps2_begin_command);
 
 void ps2_end_command(struct ps2dev *ps2dev)
 {
-	if (i8042_check_port_owner(ps2dev->serio))
-		i8042_unlock_chip();
+	struct mutex *m = ps2dev->serio->ps2_cmd_mutex ?: &ps2dev->cmd_mutex;
 
-	mutex_unlock(&ps2dev->cmd_mutex);
+	mutex_unlock(m);
 }
 EXPORT_SYMBOL(ps2_end_command);
 
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 0f9bafa..d98780c 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -62,7 +62,6 @@ struct serio;
 void i8042_lock_chip(void);
 void i8042_unlock_chip(void);
 int i8042_command(unsigned char *param, int command);
-bool i8042_check_port_owner(const struct serio *);
 int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio));
 int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
@@ -83,11 +82,6 @@ static inline int i8042_command(unsigned char *param, int command)
 	return -ENODEV;
 }
 
-static inline bool i8042_check_port_owner(const struct serio *serio)
-{
-	return false;
-}
-
 static inline int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio))
 {
diff --git a/include/linux/serio.h b/include/linux/serio.h
index df4ab5d..c733cff 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -31,7 +31,8 @@ struct serio {
 
 	struct serio_device_id id;
 
-	spinlock_t lock;		/* protects critical sections from port's interrupt handler */
+	/* Protects critical sections from port's interrupt handler */
+	spinlock_t lock;
 
 	int (*write)(struct serio *, unsigned char);
 	int (*open)(struct serio *);
@@ -40,16 +41,29 @@ struct serio {
 	void (*stop)(struct serio *);
 
 	struct serio *parent;
-	struct list_head child_node;	/* Entry in parent->children list */
+	/* Entry in parent->children list */
+	struct list_head child_node;
 	struct list_head children;
-	unsigned int depth;		/* level of nesting in serio hierarchy */
+	/* Level of nesting in serio hierarchy */
+	unsigned int depth;
 
-	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */
-	struct mutex drv_mutex;		/* protects serio->drv so attributes can pin driver */
+	/*
+	 * serio->drv is accessed from interrupt handlers; when modifying
+	 * caller should acquire serio->drv_mutex and serio->lock.
+	 */
+	struct serio_driver *drv;
+	/* Protects serio->drv so attributes can pin current driver */
+	struct mutex drv_mutex;
 
 	struct device dev;
 
 	struct list_head node;
+
+	/*
+	 * For use by PS/2 layer when several ports share hardware and
+	 * may get indigestion when exposed to concurrent access (i8042).
+	 */
+	struct mutex *ps2_cmd_mutex;
 };
 #define to_serio_port(d)	container_of(d, struct serio, dev)
 
