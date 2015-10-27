From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 2/3] input: Changed keyreset to act as a wrapper for keycombo.
Date: Tue, 27 Oct 2015 09:33:05 +0100
Message-ID: <1445934785-5659-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Daniel Rosenberg <drosen@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-input@vger.kernel.org

=46rom: Daniel Rosenberg <drosen@google.com>

keyreset now registers a keycombo driver that acts as the old
keyreset driver acted.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/input/Kconfig    |    1 +
 drivers/input/keyreset.c |  206 +++++++++++++-------------------------=
--------
 include/linux/keyreset.h |    3 +-
 3 files changed, 58 insertions(+), 152 deletions(-)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 47a5143..3898074 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -190,6 +190,7 @@ config INPUT_APMPOWER
 config INPUT_KEYRESET
	tristate "Reset key"
	depends on INPUT
+	select INPUT_KEYCOMBO
	---help---
	  Say Y here if you want to reboot when some keys are pressed;

diff --git a/drivers/input/keyreset.c b/drivers/input/keyreset.c
index 36208fe..eaaccde 100644
--- a/drivers/input/keyreset.c
+++ b/drivers/input/keyreset.c
@@ -1,6 +1,6 @@
 /* drivers/input/keyreset.c
  *
- * Copyright (C) 2008 Google, Inc.
+ * Copyright (C) 2014 Google, Inc.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, an=
d
@@ -21,200 +21,104 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
-
+#include <linux/keycombo.h>

 struct keyreset_state {
-	struct input_handler input_handler;
-	unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
-	unsigned long upbit[BITS_TO_LONGS(KEY_CNT)];
-	unsigned long key[BITS_TO_LONGS(KEY_CNT)];
-	spinlock_t lock;
-	int key_down_target;
-	int key_down;
-	int key_up;
-	int restart_disabled;
+	int restart_requested;
	int (*reset_fn)(void);
+	struct platform_device *pdev_child;
 };

-int restart_requested;
-static void deferred_restart(struct work_struct *dummy)
+static void do_restart(void)
 {
-	restart_requested =3D 2;
	sys_sync();
-	restart_requested =3D 3;
	kernel_restart(NULL);
 }
-static DECLARE_WORK(restart_work, deferred_restart);

-static void keyreset_event(struct input_handle *handle, unsigned int t=
ype,
-			   unsigned int code, int value)
+static void do_reset_fn(void *priv)
 {
-	unsigned long flags;
-	struct keyreset_state *state =3D handle->private;
-
-	if (type !=3D EV_KEY)
-		return;
-
-	if (code >=3D KEY_MAX)
-		return;
-
-	if (!test_bit(code, state->keybit))
-		return;
-
-	spin_lock_irqsave(&state->lock, flags);
-	if (!test_bit(code, state->key) =3D=3D !value)
-		goto done;
-	__change_bit(code, state->key);
-	if (test_bit(code, state->upbit)) {
-		if (value) {
-			state->restart_disabled =3D 1;
-			state->key_up++;
-		} else
-			state->key_up--;
+	struct keyreset_state *state =3D priv;
+	if (state->restart_requested)
+		panic("keyboard reset failed, %d", state->restart_requested);
+	if (state->reset_fn) {
+		state->restart_requested =3D state->reset_fn();
	} else {
-		if (value)
-			state->key_down++;
-		else
-			state->key_down--;
+		pr_info("keyboard reset\n");
+		do_restart();
+		state->restart_requested =3D 1;
	}
-	if (state->key_down =3D=3D 0 && state->key_up =3D=3D 0)
-		state->restart_disabled =3D 0;
-
-	pr_debug("reset key changed %d %d new state %d-%d-%d\n", code, value,
-		 state->key_down, state->key_up, state->restart_disabled);
-
-	if (value && !state->restart_disabled &&
-	    state->key_down =3D=3D state->key_down_target) {
-		state->restart_disabled =3D 1;
-		if (restart_requested)
-			panic("keyboard reset failed, %d", restart_requested);
-		if (state->reset_fn) {
-			restart_requested =3D state->reset_fn();
-		} else {
-			pr_info("keyboard reset\n");
-			schedule_work(&restart_work);
-			restart_requested =3D 1;
-		}
-	}
-done:
-	spin_unlock_irqrestore(&state->lock, flags);
 }

-static int keyreset_connect(struct input_handler *handler,
-					  struct input_dev *dev,
-					  const struct input_device_id *id)
-{
-	int i;
-	int ret;
-	struct input_handle *handle;
-	struct keyreset_state *state =3D
-		container_of(handler, struct keyreset_state, input_handler);
-
-	for (i =3D 0; i < KEY_MAX; i++) {
-		if (test_bit(i, state->keybit) && test_bit(i, dev->keybit))
-			break;
-	}
-	if (i =3D=3D KEY_MAX)
-		return -ENODEV;
-
-	handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->dev =3D dev;
-	handle->handler =3D handler;
-	handle->name =3D "keyreset";
-	handle->private =3D state;
-
-	ret =3D input_register_handle(handle);
-	if (ret)
-		goto err_input_register_handle;
-
-	ret =3D input_open_device(handle);
-	if (ret)
-		goto err_input_open_device;
-
-	pr_info("using input dev %s for key reset\n", dev->name);
-
-	return 0;
-
-err_input_open_device:
-	input_unregister_handle(handle);
-err_input_register_handle:
-	kfree(handle);
-	return ret;
-}
-
-static void keyreset_disconnect(struct input_handle *handle)
-{
-	input_close_device(handle);
-	input_unregister_handle(handle);
-	kfree(handle);
-}
-
-static const struct input_device_id keyreset_ids[] =3D {
-	{
-		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
-		.evbit =3D { BIT_MASK(EV_KEY) },
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(input, keyreset_ids);
-
 static int keyreset_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret =3D -ENOMEM;
+	struct keycombo_platform_data *pdata_child;
+	struct keyreset_platform_data *pdata =3D pdev->dev.platform_data;
+	int up_size =3D 0, down_size =3D 0, size;
	int key, *keyp;
	struct keyreset_state *state;
-	struct keyreset_platform_data *pdata =3D pdev->dev.platform_data;

	if (!pdata)
		return -EINVAL;
-
-	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
+	state =3D devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
	if (!state)
		return -ENOMEM;

-	spin_lock_init(&state->lock);
+	state->pdev_child =3D platform_device_alloc(KEYCOMBO_NAME,
+							PLATFORM_DEVID_AUTO);
+	if (!state->pdev_child)
+		return -ENOMEM;
+	state->pdev_child->dev.parent =3D &pdev->dev;
+
	keyp =3D pdata->keys_down;
	while ((key =3D *keyp++)) {
		if (key >=3D KEY_MAX)
			continue;
-		state->key_down_target++;
-		__set_bit(key, state->keybit);
+		down_size++;
	}
	if (pdata->keys_up) {
		keyp =3D pdata->keys_up;
		while ((key =3D *keyp++)) {
			if (key >=3D KEY_MAX)
				continue;
-			__set_bit(key, state->keybit);
-			__set_bit(key, state->upbit);
+			up_size++;
		}
	}
-
-	if (pdata->reset_fn)
-		state->reset_fn =3D pdata->reset_fn;
-
-	state->input_handler.event =3D keyreset_event;
-	state->input_handler.connect =3D keyreset_connect;
-	state->input_handler.disconnect =3D keyreset_disconnect;
-	state->input_handler.name =3D KEYRESET_NAME;
-	state->input_handler.id_table =3D keyreset_ids;
-	ret =3D input_register_handler(&state->input_handler);
-	if (ret) {
-		kfree(state);
-		return ret;
+	size =3D sizeof(struct keycombo_platform_data)
+			+ sizeof(int) * (down_size + 1);
+	pdata_child =3D devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!pdata_child)
+		goto error;
+	memcpy(pdata_child->keys_down, pdata->keys_down,
+						sizeof(int) * down_size);
+	if (up_size > 0) {
+		pdata_child->keys_up =3D devm_kzalloc(&pdev->dev, up_size + 1,
+								GFP_KERNEL);
+		if (!pdata_child->keys_up)
+			goto error;
+		memcpy(pdata_child->keys_up, pdata->keys_up,
+							sizeof(int) * up_size);
+		if (!pdata_child->keys_up)
+			goto error;
	}
+	state->reset_fn =3D pdata->reset_fn;
+	pdata_child->key_down_fn =3D do_reset_fn;
+	pdata_child->priv =3D state;
+	pdata_child->key_down_delay =3D pdata->key_down_delay;
+	ret =3D platform_device_add_data(state->pdev_child, pdata_child, size=
);
+	if (ret)
+		goto error;
	platform_set_drvdata(pdev, state);
-	return 0;
+	return platform_device_add(state->pdev_child);
+error:
+	platform_device_put(state->pdev_child);
+	return ret;
 }

 int keyreset_remove(struct platform_device *pdev)
 {
	struct keyreset_state *state =3D platform_get_drvdata(pdev);
-	input_unregister_handler(&state->input_handler);
-	kfree(state);
+	platform_device_put(state->pdev_child);
	return 0;
 }

diff --git a/include/linux/keyreset.h b/include/linux/keyreset.h
index a2ac49e..2e34afa 100644
--- a/include/linux/keyreset.h
+++ b/include/linux/keyreset.h
@@ -1,7 +1,7 @@
 /*
  * include/linux/keyreset.h - platform data structure for resetkeys dr=
iver
  *
- * Copyright (C) 2008 Google, Inc.
+ * Copyright (C) 2014 Google, Inc.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, an=
d
@@ -21,6 +21,7 @@

 struct keyreset_platform_data {
	int (*reset_fn)(void);
+	int key_down_delay;
	int *keys_up;
	int keys_down[]; /* 0 terminated */
 };
--
1.7.9.5
