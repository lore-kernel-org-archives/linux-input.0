From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] Input: sysrq -- ensure sysrq_enabled and __sysrq_enabled are consistent
Date: Mon, 24 Jan 2011 14:06:12 +0000
Message-ID: <1295877972-363-2-git-send-email-apw@canonical.com>
References: <1295877972-363-1-git-send-email-apw@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295877972-363-1-git-send-email-apw@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Andy Whitcroft <apw@canonical.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Currently sysrq_enabled and __sysrq_enabled are initialised separatly
and inconsitantly, leading to sysrq being actually enabled by reported
as not enabled in sysfs.  The first change to the sysfs configurable
synchronises these two:

    static int __read_mostly sysrq_enabled = 1;
    static int __sysrq_enabled;

Add a common define to carry the default for these preventing them becoming
out of sync again.  Default this to 1 to mirror previous behaviour.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 drivers/tty/sysrq.c   |    2 +-
 include/linux/sysrq.h |    3 +++
 kernel/sysctl.c       |    3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c556ed9..8e0dd25 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -46,7 +46,7 @@
 #include <asm/irq_regs.h>
 
 /* Whether we react on sysrq keys or just ignore them */
-static int __read_mostly sysrq_enabled = 1;
+static int __read_mostly sysrq_enabled = SYSRQ_DEFAULT_ENABLE;
 static bool __read_mostly sysrq_always_enabled;
 
 static bool sysrq_on(void)
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 387fa7d..7faf933 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -17,6 +17,9 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
+/* Enable/disable SYSRQ support by default (0==no, 1==yes). */
+#define SYSRQ_DEFAULT_ENABLE	1
+
 /* Possible values of bitmask for enabling sysrq functions */
 /* 0x0001 is reserved for enable everything */
 #define SYSRQ_ENABLE_LOG	0x0002
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index bc86bb3..0f1bd83 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -170,7 +170,8 @@ static int proc_taint(struct ctl_table *table, int write,
 #endif
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static int __sysrq_enabled; /* Note: sysrq code ises it's own private copy */
+/* Note: sysrq code uses it's own private copy */
+static int __sysrq_enabled = SYSRQ_DEFAULT_ENABLE;
 
 static int sysrq_sysctl_handler(ctl_table *table, int write,
 				void __user *buffer, size_t *lenp,
-- 
1.7.1
