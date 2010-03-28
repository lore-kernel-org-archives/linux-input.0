From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: [PATCH] drivers/media/IR - improve keytable code
Date: Sun, 28 Mar 2010 22:53:01 +0200
Message-ID: <20100328205301.GA7899@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:52559 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab0C1UxJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Mar 2010 16:53:09 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mchehab@infradead.org
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org

The attached patch rewrites much of the keytable code in
drivers/media/IR/ir-keytable.c.

(applies to http://git.linuxtv.org/mchehab/ir.git)

The scancodes are now inserted into the array in sorted
order which allows for a binary search on lookup.

The code has also been shrunk by about 150 lines.

In addition it fixes the following bugs:

Any use of ir_seek_table() was racy.

ir_dev->driver_name is leaked between ir_input_register() and
ir_input_unregister().

ir_setkeycode() unconditionally does clear_bit() on dev->keybit
when removing a mapping, but there might be another mapping with
a different scancode and the same keycode.

Signed-off-by: David H=E4rdeman <david@hardeman.nu>
---
 drivers/media/IR/ir-keymaps.c  |    2 +
 drivers/media/IR/ir-keytable.c |  516 ++++++++++++++------------------=
-------
 include/media/ir-core.h        |    4 +-
 3 files changed, 190 insertions(+), 332 deletions(-)

diff --git a/drivers/media/IR/ir-keymaps.c b/drivers/media/IR/ir-keymap=
s.c
index 55e7acd..bae8522 100644
--- a/drivers/media/IR/ir-keymaps.c
+++ b/drivers/media/IR/ir-keymaps.c
@@ -39,6 +39,8 @@
 struct ir_scancode_table tabname ## _table =3D {			\
 	.scan =3D tabname,					\
 	.size =3D ARRAY_SIZE(tabname),				\
+	.len =3D ARRAY_SIZE(tabname),				\
+	.alloc =3D 0,						\
 	.ir_type =3D type,					\
 	.name =3D #irname,					\
 };								\
diff --git a/drivers/media/IR/ir-keytable.c b/drivers/media/IR/ir-keyta=
ble.c
index ad41af0..cd51bab 100644
--- a/drivers/media/IR/ir-keytable.c
+++ b/drivers/media/IR/ir-keytable.c
@@ -16,344 +16,216 @@
 #include <linux/input.h>
 #include <media/ir-common.h>
=20
-#define IR_TAB_MIN_SIZE	32
-#define IR_TAB_MAX_SIZE	1024
+#define IR_TAB_MIN_SIZE	1024
+#define IR_TAB_MAX_SIZE	8192
=20
 /**
- * ir_seek_table() - returns the element order on the table
- * @rc_tab:	the ir_scancode_table with the keymap to be used
- * @scancode:	the scancode that we're seeking
+ * ir_resize_table() - resizes a scancode table if necessary
+ * @rc_tab:	the ir_scancode_table to resize
+ * @return:	zero on success or a negative error code
  *
- * This routine is used by the input routines when a key is pressed at=
 the
- * IR. The scancode is received and needs to be converted into a keyco=
de.
- * If the key is not found, it returns KEY_UNKNOWN. Otherwise, returns=
 the
- * corresponding keycode from the table.
+ * This routine will shrink the ir_scancode_table if it has lots of
+ * unused entries and grow it if it is full.
  */
-static int ir_seek_table(struct ir_scancode_table *rc_tab, u32 scancod=
e)
+static int ir_resize_table(struct ir_scancode_table *rc_tab)
 {
-	int rc;
-	unsigned long flags;
-	struct ir_scancode *keymap =3D rc_tab->scan;
+	unsigned int oldalloc =3D rc_tab->alloc;
+	unsigned int newalloc =3D oldalloc;
+	struct ir_scancode *oldscan =3D rc_tab->scan;
+	struct ir_scancode *newscan;
+
+	if (rc_tab->size =3D=3D rc_tab->len) {
+		/* All entries in use -> grow keytable */
+		if (rc_tab->alloc >=3D IR_TAB_MAX_SIZE)
+			return -ENOMEM;
=20
-	spin_lock_irqsave(&rc_tab->lock, flags);
+		if (oldalloc =3D=3D 0)
+			newalloc =3D IR_TAB_MIN_SIZE;
+		else
+			newalloc *=3D 2;
+		IR_dprintk(1, "Growing table to %u bytes\n", newalloc);
+	}
=20
-	/* FIXME: replace it by a binary search */
+	if ((rc_tab->len * 3 < rc_tab->size) && (oldalloc > IR_TAB_MIN_SIZE))=
 {
+		/* Less than 1/3 of entries in use -> shrink keytable */
+		newalloc /=3D 2;
+		IR_dprintk(1, "Shrinking table to %u bytes\n", newalloc);
+	}
=20
-	for (rc =3D 0; rc < rc_tab->size; rc++)
-		if (keymap[rc].scancode =3D=3D scancode)
-			goto exit;
+	if (newalloc =3D=3D oldalloc)
+		return 0;
=20
-	/* Not found */
-	rc =3D -EINVAL;
+	newscan =3D kmalloc(newalloc, GFP_ATOMIC);
+	if (!newscan) {
+		IR_dprintk(1, "Failed to kmalloc %u bytes\n", newalloc);
+		return -ENOMEM;
+	}
=20
-exit:
-	spin_unlock_irqrestore(&rc_tab->lock, flags);
-	return rc;
+	memcpy(newscan, rc_tab->scan, rc_tab->len * sizeof(struct ir_scancode=
));
+	rc_tab->scan =3D newscan;
+	rc_tab->alloc =3D newalloc;
+	rc_tab->size =3D rc_tab->alloc / sizeof(struct ir_scancode);
+	kfree(oldscan);
+	return 0;
 }
=20
 /**
- * ir_roundup_tablesize() - gets an optimum value for the table size
- * @n_elems:		minimum number of entries to store keycodes
- *
- * This routine is used to choose the keycode table size.
+ * ir_do_setkeycode() - internal function to set a keycode in the
+ *			scancode->keycode table
+ * @dev:	the struct input_dev device descriptor
+ * @rc_tab:	the struct ir_scancode_table to set the keycode in
+ * @scancode:	the scancode for the ir command
+ * @keycode:	the keycode for the ir command
+ * @return:	-EINVAL if the keycode could not be inserted, otherwise ze=
ro.
  *
- * In order to have some empty space for new keycodes,
- * and knowing in advance that kmalloc allocates only power of two
- * segments, it optimizes the allocated space to have some spare space
- * for those new keycodes by using the maximum number of entries that
- * will be effectively be allocated by kmalloc.
- * In order to reduce the quantity of table resizes, it has a minimum
- * table size of IR_TAB_MIN_SIZE.
+ * This routine is used internally to manipulate the scancode->keycode=
 table.
+ * The caller has to hold @rc_tab->lock.
  */
-static int ir_roundup_tablesize(int n_elems)
+static int ir_do_setkeycode(struct input_dev *dev,
+			    struct ir_scancode_table *rc_tab,
+			    int scancode, int keycode)
 {
-	size_t size;
+	unsigned int i;
+	int old_keycode =3D KEY_RESERVED;
+
+	/* First check if we already have a mapping for this ir command */
+	for (i =3D 0; i < rc_tab->len; i++) {
+		/* Keytable is sorted from lowest to highest scancode */
+		if (rc_tab->scan[i].scancode > scancode)
+			break;
+		else if (rc_tab->scan[i].scancode < scancode)
+			continue;
=20
-	if (n_elems < IR_TAB_MIN_SIZE)
-		n_elems =3D IR_TAB_MIN_SIZE;
+		old_keycode =3D rc_tab->scan[i].keycode;
+		rc_tab->scan[i].keycode =3D keycode;
=20
-	/*
-	 * As kmalloc only allocates sizes of power of two, get as
-	 * much entries as possible for the allocated memory segment
-	 */
-	size =3D roundup_pow_of_two(n_elems * sizeof(struct ir_scancode));
-	n_elems =3D size / sizeof(struct ir_scancode);
+		/* Did the user wish to remove the mapping? */
+		if (keycode =3D=3D KEY_RESERVED || keycode =3D=3D KEY_UNKNOWN) {
+			rc_tab->len--;
+			memmove(&rc_tab->scan[i], &rc_tab->scan[i + 1],
+				(rc_tab->len - i) * sizeof(struct ir_scancode));
+		}
=20
-	return n_elems;
-}
-
-/**
- * ir_copy_table() - copies a keytable, discarding the unused entries
- * @destin:	destin table
- * @origin:	origin table
- *
- * Copies all entries where the keycode is not KEY_UNKNOWN/KEY_RESERVE=
D
- * Also copies table size and table protocol.
- * NOTE: It shouldn't copy the lock field
- */
-
-static int ir_copy_table(struct ir_scancode_table *destin,
-		 const struct ir_scancode_table *origin)
-{
-	int i, j =3D 0;
+		/* Possibly shrink the keytable, failure is not a problem */
+		ir_resize_table(rc_tab);
+		break;
+	}
=20
-	for (i =3D 0; i < origin->size; i++) {
-		if (origin->scan[i].keycode =3D=3D KEY_UNKNOWN ||
-		   origin->scan[i].keycode =3D=3D KEY_RESERVED)
-			continue;
+	if (old_keycode =3D=3D KEY_RESERVED) {
+		/* No previous mapping found, we might need to grow the table */
+		if (ir_resize_table(rc_tab))
+			return -ENOMEM;
=20
-		memcpy(&destin->scan[j], &origin->scan[i], sizeof(struct ir_scancode=
));
-		j++;
+		/* i is the proper index to insert our new keycode */
+		memmove(&rc_tab->scan[i + 1], &rc_tab->scan[i],
+			(rc_tab->len - i) * sizeof(struct ir_scancode));
+		rc_tab->scan[i].scancode =3D scancode;
+		rc_tab->scan[i].keycode =3D keycode;
+		rc_tab->len++;
+		set_bit(keycode, dev->keybit);
+	} else {
+		/* A previous mapping was updated... */
+		clear_bit(old_keycode, dev->keybit);
+		/* ...but another scancode might use the same keycode */
+		for (i =3D 0; i < rc_tab->len; i++) {
+			if (rc_tab->scan[i].keycode =3D=3D old_keycode) {
+				set_bit(old_keycode, dev->keybit);
+				break;
+			}
+		}
 	}
-	destin->size =3D j;
-	destin->ir_type =3D origin->ir_type;
-
-	IR_dprintk(1, "Copied %d scancodes to the new keycode table\n", desti=
n->size);
=20
 	return 0;
 }
=20
 /**
- * ir_getkeycode() - get a keycode at the evdev scancode ->keycode tab=
le
+ * ir_setkeycode() - set a keycode in the scancode->keycode table
  * @dev:	the struct input_dev device descriptor
  * @scancode:	the desired scancode
- * @keycode:	the keycode to be retorned.
+ * @keycode:	result
+ * @return:	-EINVAL if the keycode could not be inserted, otherwise ze=
ro.
  *
- * This routine is used to handle evdev EVIOCGKEY ioctl.
- * If the key is not found, returns -EINVAL, otherwise, returns 0.
+ * This routine is used to handle evdev EVIOCSKEY ioctl.
  */
-static int ir_getkeycode(struct input_dev *dev,
-			 int scancode, int *keycode)
+static int ir_setkeycode(struct input_dev *dev,
+			 int scancode, int keycode)
 {
-	int elem;
+	int rc;
+	unsigned long flags;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(dev);
 	struct ir_scancode_table *rc_tab =3D &ir_dev->rc_tab;
=20
-	elem =3D ir_seek_table(rc_tab, scancode);
-	if (elem >=3D 0) {
-		*keycode =3D rc_tab->scan[elem].keycode;
-		return 0;
-	}
-
-	/*
-	 * Scancode not found and table can't be expanded
-	 */
-	if (elem < 0 && rc_tab->size =3D=3D IR_TAB_MAX_SIZE)
-		return -EINVAL;
-
-	/*
-	 * If is there extra space, returns KEY_RESERVED,
-	 * otherwise, input core won't let ir_setkeycode to work
-	 */
-	*keycode =3D KEY_RESERVED;
-	return 0;
-}
-
-/**
- * ir_is_resize_needed() - Check if the table needs rezise
- * @table:		keycode table that may need to resize
- * @n_elems:		minimum number of entries to store keycodes
- *
- * Considering that kmalloc uses power of two storage areas, this
- * routine detects if the real alloced size will change. If not, it
- * just returns without doing nothing. Otherwise, it will extend or
- * reduce the table size to meet the new needs.
- *
- * It returns 0 if no resize is needed, 1 otherwise.
- */
-static int ir_is_resize_needed(struct ir_scancode_table *table, int n_=
elems)
-{
-	int cur_size =3D ir_roundup_tablesize(table->size);
-	int new_size =3D ir_roundup_tablesize(n_elems);
-
-	if (cur_size =3D=3D new_size)
-		return 0;
-
-	/* Resize is needed */
-	return 1;
-}
-
-/**
- * ir_delete_key() - remove a keycode from the table
- * @rc_tab:		keycode table
- * @elem:		element to be removed
- *
- */
-static void ir_delete_key(struct ir_scancode_table *rc_tab, int elem)
-{
-	unsigned long flags =3D 0;
-	int newsize =3D rc_tab->size - 1;
-	int resize =3D ir_is_resize_needed(rc_tab, newsize);
-	struct ir_scancode *oldkeymap =3D rc_tab->scan;
-	struct ir_scancode *newkeymap =3D NULL;
-
-	if (resize)
-		newkeymap =3D kzalloc(ir_roundup_tablesize(newsize) *
-				    sizeof(*newkeymap), GFP_ATOMIC);
-
-	/* There's no memory for resize. Keep the old table */
-	if (!resize || !newkeymap) {
-		newkeymap =3D oldkeymap;
-
-		/* We'll modify the live table. Lock it */
-		spin_lock_irqsave(&rc_tab->lock, flags);
-	}
-
-	/*
-	 * Copy the elements before the one that will be deleted
-	 * if (!resize), both oldkeymap and newkeymap points
-	 * to the same place, so, there's no need to copy
-	 */
-	if (resize && elem > 0)
-		memcpy(newkeymap, oldkeymap,
-		       elem * sizeof(*newkeymap));
-
-	/*
-	 * Copy the other elements overwriting the element to be removed
-	 * This operation applies to both resize and non-resize case
-	 */
-	if (elem < newsize)
-		memcpy(&newkeymap[elem], &oldkeymap[elem + 1],
-		       (newsize - elem) * sizeof(*newkeymap));
-
-	if (resize) {
-		/*
-		 * As the copy happened to a temporary table, only here
-		 * it needs to lock while replacing the table pointers
-		 * to use the new table
-		 */
-		spin_lock_irqsave(&rc_tab->lock, flags);
-		rc_tab->size =3D newsize;
-		rc_tab->scan =3D newkeymap;
-		spin_unlock_irqrestore(&rc_tab->lock, flags);
-
-		/* Frees the old keytable */
-		kfree(oldkeymap);
-	} else {
-		rc_tab->size =3D newsize;
-		spin_unlock_irqrestore(&rc_tab->lock, flags);
-	}
+	spin_lock_irqsave(&rc_tab->lock, flags);
+	rc =3D ir_do_setkeycode(dev, rc_tab, scancode, keycode);
+	spin_unlock_irqrestore(&rc_tab->lock, flags);
+	return rc;
 }
=20
 /**
- * ir_insert_key() - insert a keycode at the table
- * @rc_tab:		keycode table
- * @scancode:	the desired scancode
- * @keycode:	the keycode to be retorned.
+ * ir_setkeytable() - sets several entries in the scancode->keycode ta=
ble
+ * @dev:	the struct input_dev device descriptor
+ * @to:		the struct ir_scancode_table to copy entries to
+ * @from:	the struct ir_scancode_table to copy entries from
+ * @return:	-EINVAL if all keycodes could not be inserted, otherwise z=
ero.
  *
+ * This routine is used to handle table initialization.
  */
-static int ir_insert_key(struct ir_scancode_table *rc_tab,
-			  int scancode, int keycode)
+static int ir_setkeytable(struct input_dev *dev,
+			  struct ir_scancode_table *to,
+			  const struct ir_scancode_table *from)
 {
+	struct ir_input_dev *ir_dev =3D input_get_drvdata(dev);
+	struct ir_scancode_table *rc_tab =3D &ir_dev->rc_tab;
 	unsigned long flags;
-	int elem =3D rc_tab->size;
-	int newsize =3D rc_tab->size + 1;
-	int resize =3D ir_is_resize_needed(rc_tab, newsize);
-	struct ir_scancode *oldkeymap =3D rc_tab->scan;
-	struct ir_scancode *newkeymap;
-
-	if (resize) {
-		newkeymap =3D kzalloc(ir_roundup_tablesize(newsize) *
-				    sizeof(*newkeymap), GFP_ATOMIC);
-		if (!newkeymap)
-			return -ENOMEM;
-
-		memcpy(newkeymap, oldkeymap,
-		       rc_tab->size * sizeof(*newkeymap));
-	} else
-		newkeymap  =3D oldkeymap;
-
-	/* Stores the new code at the table */
-	IR_dprintk(1, "#%d: New scan 0x%04x with key 0x%04x\n",
-		   rc_tab->size, scancode, keycode);
+	unsigned int i;
+	int rc =3D 0;
=20
 	spin_lock_irqsave(&rc_tab->lock, flags);
-	rc_tab->size =3D newsize;
-	if (resize) {
-		rc_tab->scan =3D newkeymap;
-		kfree(oldkeymap);
+	for (i =3D 0; i < from->len; i++) {
+		rc =3D ir_do_setkeycode(dev, to, from->scan[i].scancode,
+				      from->scan[i].keycode);
+		if (rc)
+			break;
 	}
-	newkeymap[elem].scancode =3D scancode;
-	newkeymap[elem].keycode  =3D keycode;
 	spin_unlock_irqrestore(&rc_tab->lock, flags);
-
-	return 0;
+	return rc;
 }
=20
 /**
- * ir_setkeycode() - set a keycode at the evdev scancode ->keycode tab=
le
+ * ir_getkeycode() - get a keycode from the scancode->keycode table
  * @dev:	the struct input_dev device descriptor
  * @scancode:	the desired scancode
- * @keycode:	the keycode to be retorned.
+ * @keycode:	used to return the keycode, if found, or KEY_RESERVED
+ * @return:	always returns zero.
  *
- * This routine is used to handle evdev EVIOCSKEY ioctl.
- * There's one caveat here: how can we increase the size of the table?
- * If the key is not found, returns -EINVAL, otherwise, returns 0.
+ * This routine is used to handle evdev EVIOCGKEY ioctl.
  */
-static int ir_setkeycode(struct input_dev *dev,
-			 int scancode, int keycode)
+static int ir_getkeycode(struct input_dev *dev,
+			 int scancode, int *keycode)
 {
-	int rc =3D 0;
+	int start, end, mid;
+	unsigned long flags;
+	int key =3D KEY_RESERVED;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(dev);
 	struct ir_scancode_table *rc_tab =3D &ir_dev->rc_tab;
-	struct ir_scancode *keymap =3D rc_tab->scan;
-	unsigned long flags;
-
-	/*
-	 * Handle keycode table deletions
-	 *
-	 * If userspace is adding a KEY_UNKNOWN or KEY_RESERVED,
-	 * deal as a trial to remove an existing scancode attribution
-	 * if table become too big, reduce it to save space
-	 */
-	if (keycode =3D=3D KEY_UNKNOWN || keycode =3D=3D KEY_RESERVED) {
-		rc =3D ir_seek_table(rc_tab, scancode);
-		if (rc < 0)
-			return 0;
-
-		IR_dprintk(1, "#%d: Deleting scan 0x%04x\n", rc, scancode);
-		clear_bit(keymap[rc].keycode, dev->keybit);
-		ir_delete_key(rc_tab, rc);
-
-		return 0;
-	}
-
-	/*
-	 * Handle keycode replacements
-	 *
-	 * If the scancode exists, just replace by the new value
-	 */
-	rc =3D ir_seek_table(rc_tab, scancode);
-	if (rc >=3D 0) {
-		IR_dprintk(1, "#%d: Replacing scan 0x%04x with key 0x%04x\n",
-			rc, scancode, keycode);
-
-		clear_bit(keymap[rc].keycode, dev->keybit);
-
-		spin_lock_irqsave(&rc_tab->lock, flags);
-		keymap[rc].keycode =3D keycode;
-		spin_unlock_irqrestore(&rc_tab->lock, flags);
=20
-		set_bit(keycode, dev->keybit);
-
-		return 0;
+	spin_lock_irqsave(&rc_tab->lock, flags);
+	start =3D 0;
+	end =3D rc_tab->len - 1;
+	while (start <=3D end) {
+		mid =3D (start + end) / 2;
+		if (rc_tab->scan[mid].scancode < scancode)
+			start =3D mid + 1;
+		else if (rc_tab->scan[mid].scancode > scancode)
+			end =3D mid - 1;
+		else {
+			key =3D rc_tab->scan[mid].keycode;
+			break;
+		}
 	}
+	spin_unlock_irqrestore(&rc_tab->lock, flags);
=20
-	/*
-	 * Handle new scancode inserts
-	 *
-	 * reallocate table if needed and insert a new keycode
-	 */
-
-	/* Avoid growing the table indefinitely */
-	if (rc_tab->size + 1 > IR_TAB_MAX_SIZE)
-		return -EINVAL;
-
-	rc =3D ir_insert_key(rc_tab, scancode, keycode);
-	if (rc < 0)
-		return rc;
-	set_bit(keycode, dev->keybit);
-
+	*keycode =3D key;
 	return 0;
 }
=20
@@ -369,24 +241,12 @@ static int ir_setkeycode(struct input_dev *dev,
  */
 u32 ir_g_keycode_from_table(struct input_dev *dev, u32 scancode)
 {
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(dev);
-	struct ir_scancode_table *rc_tab =3D &ir_dev->rc_tab;
-	struct ir_scancode *keymap =3D rc_tab->scan;
-	int elem;
-
-	elem =3D ir_seek_table(rc_tab, scancode);
-	if (elem >=3D 0) {
-		IR_dprintk(1, "%s: scancode 0x%04x keycode 0x%02x\n",
-			   dev->name, scancode, keymap[elem].keycode);
+	int keycode;
=20
-		return rc_tab->scan[elem].keycode;
-	}
-
-	printk(KERN_INFO "%s: unknown key for scancode 0x%04x\n",
-	       dev->name, scancode);
-
-	/* Reports userspace that an unknown keycode were got */
-	return KEY_RESERVED;
+	ir_getkeycode(dev, scancode, &keycode);
+	IR_dprintk(1, "%s: scancode 0x%04x keycode 0x%02x\n",
+		   dev->name, scancode, keycode);
+	return keycode;
 }
 EXPORT_SYMBOL_GPL(ir_g_keycode_from_table);
=20
@@ -463,8 +323,7 @@ int ir_input_register(struct input_dev *input_dev,
 		      const char *driver_name)
 {
 	struct ir_input_dev *ir_dev;
-	struct ir_scancode  *keymap    =3D rc_tab->scan;
-	int i, rc;
+	int rc;
=20
 	if (rc_tab->scan =3D=3D NULL || !rc_tab->size)
 		return -EINVAL;
@@ -473,51 +332,45 @@ int ir_input_register(struct input_dev *input_dev=
,
 	if (!ir_dev)
 		return -ENOMEM;
=20
-	spin_lock_init(&ir_dev->rc_tab.lock);
-
-	ir_dev->driver_name =3D kmalloc(strlen(driver_name) + 1, GFP_KERNEL);
-	if (!ir_dev->driver_name)
-		return -ENOMEM;
-	strcpy(ir_dev->driver_name, driver_name);
-	ir_dev->rc_tab.name =3D rc_tab->name;
-	ir_dev->rc_tab.size =3D ir_roundup_tablesize(rc_tab->size);
-	ir_dev->rc_tab.scan =3D kzalloc(ir_dev->rc_tab.size *
-				    sizeof(struct ir_scancode), GFP_KERNEL);
-	if (!ir_dev->rc_tab.scan) {
-		kfree(ir_dev);
-		return -ENOMEM;
+	ir_dev->driver_name =3D kasprintf(GFP_KERNEL, "%s", driver_name);
+	if (!ir_dev->driver_name) {
+		rc =3D -ENOMEM;
+		goto out_dev;
 	}
=20
-	IR_dprintk(1, "Allocated space for %d keycode entries (%zd bytes)\n",
-		ir_dev->rc_tab.size,
-		ir_dev->rc_tab.size * sizeof(ir_dev->rc_tab.scan));
-
-	ir_copy_table(&ir_dev->rc_tab, rc_tab);
-	ir_dev->props =3D props;
+	input_dev->getkeycode =3D ir_getkeycode;
+	input_dev->setkeycode =3D ir_setkeycode;
+	input_set_drvdata(input_dev, ir_dev);
=20
-	/* set the bits for the keys */
-	IR_dprintk(1, "key map size: %d\n", rc_tab->size);
-	for (i =3D 0; i < rc_tab->size; i++) {
-		IR_dprintk(1, "#%d: setting bit for keycode 0x%04x\n",
-			i, keymap[i].keycode);
-		set_bit(keymap[i].keycode, input_dev->keybit);
+	spin_lock_init(&ir_dev->rc_tab.lock);
+	ir_dev->rc_tab.name =3D rc_tab->name;
+	ir_dev->rc_tab.ir_type =3D rc_tab->ir_type;
+	if (ir_resize_table(&ir_dev->rc_tab)) {
+		rc =3D -ENOMEM;
+		goto out_name;
 	}
-	clear_bit(0, input_dev->keybit);
=20
-	set_bit(EV_KEY, input_dev->evbit);
+	IR_dprintk(1, "Allocated space for %u keycode entries (%u bytes)\n",
+		   ir_dev->rc_tab.size, ir_dev->rc_tab.alloc);
=20
-	input_dev->getkeycode =3D ir_getkeycode;
-	input_dev->setkeycode =3D ir_setkeycode;
-	input_set_drvdata(input_dev, ir_dev);
+	set_bit(EV_KEY, input_dev->evbit);
+	if (ir_setkeytable(input_dev, &ir_dev->rc_tab, rc_tab)) {
+		rc =3D -ENOMEM;
+		goto out_table;
+	}
+	ir_dev->props =3D props;
=20
 	rc =3D ir_register_class(input_dev);
 	if (rc < 0)
-		goto err;
+		goto out_table;
=20
 	return 0;
=20
-err:
-	kfree(rc_tab->scan);
+out_table:
+	kfree(ir_dev->rc_tab.scan);
+out_name:
+	kfree(ir_dev->driver_name);
+out_dev:
 	kfree(ir_dev);
 	return rc;
 }
@@ -546,6 +399,7 @@ void ir_input_unregister(struct input_dev *dev)
=20
 	ir_unregister_class(dev);
=20
+	kfree(ir_dev->driver_name);
 	kfree(ir_dev);
 }
 EXPORT_SYMBOL_GPL(ir_input_unregister);
diff --git a/include/media/ir-core.h b/include/media/ir-core.h
index 87dd738..c250e36 100644
--- a/include/media/ir-core.h
+++ b/include/media/ir-core.h
@@ -46,7 +46,9 @@ struct ir_scancode {
=20
 struct ir_scancode_table {
 	struct ir_scancode	*scan;
-	int			size;
+	unsigned int		size;	/* Max number of entries */
+	unsigned int		len;	/* Used number of entries */
+	unsigned int		alloc;	/* Size of *scan in bytes */
 	u64			ir_type;
 	char			*name;
 	spinlock_t		lock;
--=20
1.7.0.3


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
