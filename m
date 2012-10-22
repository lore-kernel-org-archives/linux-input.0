From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] char_dev: pin parent kobject
Date: Sun, 21 Oct 2012 17:57:19 -0700
Message-ID: <1350867440-6109-1-git-send-email-dmitry.torokhov@gmail.com>
References: <20121021073928.GV2616@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121021073928.GV2616@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In certain cases (for example when a cdev structure is embedded into
another object whose lifetime is controlled by a separate kobject) it is
beneficial to tie lifetime of another object to the lifetime of character
device so that related object is not freed until after char_dev object is
freed. To achieve this let's pin kobject's parent when doing cdev_add()
and unpin when last reference to cdev structure is being released.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

OK, so it looks like cdev kobject's parent is unused so we can just have
users set themselves as parents of character device and have cdev_add()
pin it.

 fs/char_dev.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3f152b9..afc2bb6 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -471,9 +471,19 @@ static int exact_lock(dev_t dev, void *data)
  */
 int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 {
+	int error;
+
 	p->dev = dev;
 	p->count = count;
-	return kobj_map(cdev_map, dev, count, NULL, exact_match, exact_lock, p);
+
+	error = kobj_map(cdev_map, dev, count, NULL,
+			 exact_match, exact_lock, p);
+	if (error)
+		return error;
+
+	kobject_get(p->kobj.parent);
+
+	return 0;
 }
 
 static void cdev_unmap(dev_t dev, unsigned count)
@@ -498,14 +508,20 @@ void cdev_del(struct cdev *p)
 static void cdev_default_release(struct kobject *kobj)
 {
 	struct cdev *p = container_of(kobj, struct cdev, kobj);
+	struct kobject *parent = kobj->parent;
+
 	cdev_purge(p);
+	kobject_put(parent);
 }
 
 static void cdev_dynamic_release(struct kobject *kobj)
 {
 	struct cdev *p = container_of(kobj, struct cdev, kobj);
+	struct kobject *parent = kobj->parent;
+
 	cdev_purge(p);
 	kfree(p);
+	kobject_put(parent);
 }
 
 static struct kobj_type ktype_cdev_default = {
-- 
1.7.11.7
