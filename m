From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH] Input: sparse-keymap - add managed version of sparse_keymap_setup()
Date: Tue, 28 Feb 2017 10:45:25 +0100
Message-ID: <20170228094525.26683-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some platform drivers use devm_input_allocate_device() together with
sparse_keymap_setup() in their .probe callbacks.  While using the former
simplifies error handling, using the latter necessitates calling
sparse_keymap_free() in the error path and upon module unloading to
avoid leaking the copy of the keymap allocated by sparse_keymap_setup().

To help prevent such leaks and enable simpler error handling in these
drivers, add a new function which allows automatic freeing of the keymap
copy upon probe failure and on driver detach.

As devm_input_allocate_device() adds its devres to the device owning the
input device, we do the same for managed input devices to ensure freeing
the keymap copy is properly slotted in the devres stack.

The new function can also be used by non-managed input devices, though
in this case the devres is attached to the struct device embedded inside
the input device itself.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/input/sparse-keymap.c       | 51 +++++++++++++++++++++++++++++++++++++
 include/linux/input/sparse-keymap.h |  4 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index e7409c45bdd0..9cb37762f5fd 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -228,6 +228,57 @@ int sparse_keymap_setup(struct input_dev *dev,
 }
 EXPORT_SYMBOL(sparse_keymap_setup);
 
+struct sparse_keymap_devres {
+	struct input_dev *dev;
+};
+
+static void devm_sparse_keymap_free(struct device *dev, void *res)
+{
+	struct sparse_keymap_devres *devres = res;
+
+	sparse_keymap_free(devres->dev);
+}
+
+/**
+ * devm_sparse_keymap_setup - set up managed sparse keymap for an input device
+ * @dev: Input device
+ * @keymap: Keymap in form of array of &key_entry structures ending
+ *	with %KE_END type entry
+ * @setup: Function that can be used to adjust keymap entries
+ *	depending on device's needs, may be %NULL
+ *
+ * The function calculates size and allocates copy of the original
+ * keymap after which sets up input device event bits appropriately.
+ * The allocated copy of the keymap is automatically freed when it is no
+ * longer needed, thus drivers using this function must not explicitly
+ * call sparse_keymap_free() for the same input device.
+ */
+int devm_sparse_keymap_setup(struct input_dev *dev,
+			     const struct key_entry *keymap,
+			     int (*setup)(struct input_dev *,
+					  struct key_entry *))
+{
+	struct sparse_keymap_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_sparse_keymap_free, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = sparse_keymap_setup(dev, keymap, setup);
+	if (ret) {
+		devres_free(devres);
+		return ret;
+	}
+
+	devres->dev = dev;
+	devres_add(dev->devres_managed ? dev->dev.parent : &dev->dev, devres);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_sparse_keymap_setup);
+
 /**
  * sparse_keymap_free - free memory allocated for sparse keymap
  * @dev: Input device using sparse keymap
diff --git a/include/linux/input/sparse-keymap.h b/include/linux/input/sparse-keymap.h
index 52db62064c6e..bb8cc7bd6a29 100644
--- a/include/linux/input/sparse-keymap.h
+++ b/include/linux/input/sparse-keymap.h
@@ -51,6 +51,10 @@ struct key_entry *sparse_keymap_entry_from_keycode(struct input_dev *dev,
 int sparse_keymap_setup(struct input_dev *dev,
 			const struct key_entry *keymap,
 			int (*setup)(struct input_dev *, struct key_entry *));
+int devm_sparse_keymap_setup(struct input_dev *dev,
+			     const struct key_entry *keymap,
+			     int (*setup)(struct input_dev *,
+					  struct key_entry *));
 void sparse_keymap_free(struct input_dev *dev);
 
 void sparse_keymap_report_entry(struct input_dev *dev, const struct key_entry *ke,
-- 
2.12.0
