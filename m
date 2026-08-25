Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC6377AA4
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653906; cv=none; b=k4/fw6/859XwAr8ubAZpgx/b5rukJNvkMpJxOONF5ezFTjSH8kF8J4nE1BVpKI7eOf6IKjfZAQqwUz8CGv4XNVCkTFQDyEg2YfQYXlMPV1eTFjkUQ6OKuz+YkzXZGSWS8POUXRjvGKD4yjepJyJMt5tKS4m9SH92AacisaQAFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653906; c=relaxed/simple;
	bh=U1RdvAP46481FUvT030ILqTW0TXUCFk5va06VBzgSmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMfR9FYdk3cSVGkHdmaqHErPwv9rpsentIZDljbqsxOiKW//bwEolkQ0kCjyzjd3O5p3249R1TErl+PkJF+JkOMJUhDpFWiyYfZ4knTFb2BzV4yhQH36ICw6k2fcr62EWsG8Fw27l5TVCcSnX6TSnvdkMw3D/FtIamUxLK5OJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFNwo7lW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFNwo7lW"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e347638adso4345333a91.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653904; x=1788258704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2k8xM7U5oQqDyHik1ipWLEdMDKcFN0PK5gALjtTJXo=;
        b=dFNwo7lWp8ZfIaIizD2CFH1QTPnQV4kBqG+Gh+u97BGyiOq98Xx56d8lmMhz6LOze7
         xn7DAPNNDqDXWXuux+stbFcvkN++Zjb+Bzb1rVRpiDpTz5/YbZzeQ9vnuUjavD46BV1z
         0vXdE2z//D1Vgt/ok0KeLatgVv1UTjxOkmWX3lrYUkh5yPKfzSva0tU/sv81tzAmJI2C
         r9RpV+bM/p/Op8MqQJFkPS4wSyXsD/8sa2tfoYUR6wzEnhNXtACsW4IJBarQt0FPlO4U
         jiKOQgndxOrf4n+64Q9JOTdbmc5cEMmKEj/iAyPRZFdGE0u5Puc/v55k8Hikn/ABqhS7
         KEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653904; x=1788258704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2k8xM7U5oQqDyHik1ipWLEdMDKcFN0PK5gALjtTJXo=;
        b=e8G/+Qk57wuowK0eEeVZxP6q69NQqeyOsNAOnpSbHBLNo4sHIALcjOKAzWxqrFq6I+
         ssIkuTi6KV2HB0feC2uwxnWgw9iMMtHSpl0t3ZceqkLUawzCCcEAhewiL19RxeH2rFHa
         kxQGwDGqxVLCAh48QBt9PiAdpsKSXVYPb4la1PSKQC9WLPKKN0LqwOb+mrU2Vvy2ycx0
         RTXLgV5t2rcgr6H/B299js8wWh23RhdMby/cAKseRAvp13tT/YOlPq+uFk55JyaBKWGx
         vFepL6yIAnk4O1XxCJEk7kYzJ9UBvK2g7aZo78lmVkKWOch+/PiLaB7jFTNze+nA4FfB
         Dt0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro6C5zzxBu0YYEIBfImvA9JPZqx7Woy6NVGLXijeVhTXoV8G2Z4CO3DZA3SMnZKlNJsOKVMmcLiqSLH9g==@vger.kernel.org
X-Gm-Message-State: AFuF++kOhStjm0L2EwR/8AbAZhbUepm9dYQk5PLN5at0wUqvOqOGW7Hw
	gRPjljOMOQwGssENXiNX2PF6uW+KzC9ML0MzNAJQVe0TzEpJKAihZgaB
X-Gm-Gg: AR+sD11MFu5PhSU+GSQQZsGtPRO69oCL6hJepB0WvTQpYeWcrvhDyAmKFlAuEs56ltY
	LHv0nepkb8ORNLyQkY37ItkBZ5LB8PC/PRvewhQBzKkbpl79T+H2RMNX821GmQ1vaQitL2sMqRa
	STf5Fi20P/t6uLGpbYUNOwxKGjnt5PQfP/ASSVmk9It3bHuCX2wlGWBL7tnPepsvsMeC3jVxwG+
	W2gJC28QVjzCtBAXmdXfhCHpvS+RIBUzQmtt0bynCVwDhLBJFfwDOPJ2kBeGant29Z21O2UP3gk
	8JvRb4JmUOYFNV1jT4z7ALa/GHz6x7c+mB3u5QfqhhlLZBfbAUUNegNssd0ZhxTecFbkT/E+zmb
	UyJfD/Sugn1BwZO32LFICKbL2kcDgUUukLx3OQXp10zkBMsvIzc1F6+zXKgiTgewk11wv4B17kK
	fvlk8GyG7isPJmrQkf9eX3R35Fzk3poTUBdJP8xH8+Vqi/OBDXN4ZUiePtSsuA044MdJ5UNWZ4y
	WRni+EFYrVof7IeKEhOsJ5paSvwRsGtK9AAMIR5Xg886o+Vq1gw8m1GbrXHksSfGiHoLTCii3o0
	kSZeWtl2BzRXhTId6OVwjEPA
X-Received: by 2002:a17:90a:e70f:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-395df3c6026mr49485366a91.14.1787653904110;
        Tue, 25 Aug 2026 03:31:44 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm3299029a91.10.2026.08.25.03.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:43 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Christopher Heiny <cheiny@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: synaptics-rmi4 - fix input_dev->name use-after-free on unplug
Date: Tue, 25 Aug 2026 18:31:39 +0800
Message-ID: <20260825103139.12314-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_driver_probe() reuses the transport driver's input device when it has
one, and then renames it out of memory owned by the RMI device:

	if (rmi_dev->xport->input) {
		data->input = rmi_dev->xport->input;
	...
	name = devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
			      "Synaptics %s", device_name);
	if (!name)
		return;

	input->name = name;

In the borrowed case the name outlives its allocation.  hid-rmi is the
transport that hits it: rmi_input_configured() hands us its hidinput
device, and rmi_remove() then tears the RMI device down first:

	rmi_unregister_transport_device(&hdata->xport);
	hid_hw_stop(hdev);

The first line unbinds this driver, so devres frees the name.  The second
reaches input_unregister_device(), whose device_del() emits the
KOBJ_REMOVE uevent, and input_dev_uevent() does

	if (dev->name)
		INPUT_ADD_HOTPLUG_VAR("NAME=\"%s\"", dev->name);

so vsnprintf() walks the freed string and copies it into the uevent that
is broadcast to userspace.  With slub_debug=FZPU the remove event carries

  NAME="kkkkkkkkkkkkkkkkkkkkkkk\xa5\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb..."

i.e. POISON_FREE, POISON_END, the redzone and the SLUB tracking metadata
past the end of the object - the read runs to the first NUL, so it leaves
the object as well.

  BUG: KASAN: slab-use-after-free in string+0x2a9/0x330
  Read of size 1 at addr ffff88810a379d31 by task name/8056
   string+0x2a9/0x330
   vsnprintf+0x5ec/0x1680
   add_uevent_var+0x165/0x390
   input_dev_uevent+0x14c/0x750
   kobject_uevent_env+0x4ed/0x11b0
   device_del+0x5ac/0x940
   input_unregister_device+0x88/0xc0
   hidinput_disconnect+0x144/0x3e0
   hid_hw_stop+0x13/0x70
  Allocated by task 7810:
   devm_kasprintf+0xb0/0xe0
   rmi_driver_probe+0x3e0/0xbf0 [rmi_core]
   rmi_input_configured+0x184/0x2e0 [hid_rmi]
  Freed by task 8056:
   devres_release_all+0x106/0x170
   device_release_driver_internal+0x3f9/0x550
   rmi_unregister_transport_device+0x34/0x50 [rmi_core]
   rmi_remove+0xd0/0x100 [hid_rmi]

This is not limited to the RMI_DEVICE_HAS_PHYS_BUTTONS models: any RMI4
sensor reaches it, because rmi_init_functions() runs inside
rmi_input_configured() and F11/F12/F30 call input_set_capability() on the
borrowed device, so hidinput_connect() finds it populated and registers
it.  11 to 14 reports per three unplugs here.

The same string is read on the add side too.
rmi_register_transport_device() returns 0 whenever device_add() succeeded,
so a probe failure of this driver - rmi_enable_sensor() failing on a
register read is enough, and a HID device that stops answering can arrange
that - does not stop the transport: devres frees the name, and
hidinput_connect() then goes on to call input_register_device(), which
prints the name and emits KOBJ_ADD, with the same KASAN report under
input_register_device() <- hidinput_connect().

Moving the allocation onto the input device does not help - device_del()
releases devres before it emits the uevent - so put the name back to a
string with static storage duration when this driver lets go of an input
device it does not own, both on remove and on the probe error paths.

That means writing to the borrowed device after hidinput_connect() may
already have thrown it away: if none of the RMI functions populated it,
hidinput_connect() calls hidinput_cleanup_hidinput() and frees it while
data->input still points there.  Take a reference for as long as we keep
the pointer, which also stops rmi_process_interrupt_requests() from
input_sync()ing a freed device.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - No code change: the diff is identical to v1.  Adds the Assisted-by
   tags required by Documentation/process/coding-assistants.rst.
 - Commit message trimmed; the KASAN reports are quoted in short form
   and the add-path report is summarised rather than repeated in full.

v1: https://lore.kernel.org/linux-input/20260825031315.51860-1-98lawweijie@gmail.com/

 drivers/input/rmi4/rmi_driver.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..8696a6aa0fa9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -369,6 +369,24 @@ static void rmi_driver_set_input_name(struct rmi_device *rmi_dev,
 	input->name = name;
 }
 
+/*
+ * Let go of an input device that belongs to the transport driver.  It outlives
+ * us, but rmi_driver_set_input_name() pointed its name at devres memory of
+ * ours that is freed as soon as we are done - input_register_device() and both
+ * the add and the remove uevent print that name - so put the name back to a
+ * string with static storage duration before dropping the reference.
+ */
+static void rmi_driver_put_input(struct rmi_device *rmi_dev,
+				 struct rmi_driver_data *data)
+{
+	if (!data->input || data->input != rmi_dev->xport->input)
+		return;
+
+	data->input->name = SYNAPTICS_INPUT_DEVICE_NAME;
+	input_put_device(data->input);
+	data->input = NULL;
+}
+
 static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 				   unsigned long *mask)
 {
@@ -1026,6 +1044,8 @@ static int rmi_driver_remove(struct device *dev)
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
+	rmi_driver_put_input(rmi_dev, data);
+
 	irq_domain_remove(data->irqdomain);
 	data->irqdomain = NULL;
 
@@ -1231,7 +1251,7 @@ static int rmi_driver_probe(struct device *dev)
 		 * One example is some HID touchpads report "pass-through"
 		 * button events are not reported by rmi registers.
 		 */
-		data->input = rmi_dev->xport->input;
+		data->input = input_get_device(rmi_dev->xport->input);
 	} else {
 		data->input = devm_input_allocate_device(dev);
 		if (!data->input) {
@@ -1287,6 +1307,7 @@ static int rmi_driver_probe(struct device *dev)
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
 err:
+	rmi_driver_put_input(rmi_dev, data);
 	return retval;
 }
 
-- 
2.43.0

