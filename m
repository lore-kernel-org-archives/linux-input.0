Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E6304BDF
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653902; cv=none; b=YA8VaCD/BR2poTgGK/CUsFUQH/P+nAHYaQYXKoPf0UchWxCxQsCacyWEjsaoOm4MeP/686YAU7YEbTz8glJfLAxer/f88f+0Afmm5OyWBgsWC1AHgYpa9WS6NKIS1If0B5Y1JewFNCJXxHPArv8jkh0znrH7xpE/KWn+5VRzg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653902; c=relaxed/simple;
	bh=6aKXkXmB9UM2GPNzWdjgxSN8+02ddriLlYf0VdTO3UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqmKF4ihMgKTmsJT3f8YQxVcSi+hY7KJjEyzX6vEmGrwOCQl5YHcr+RZiDUIFmaaxWIs6M+F4B5eN/QvrP/B9342jXyIvYD30FoA6+pacvhu20CZOZaU/Lb0VeRnMdAdwkP/0NLndlP++n5Ni7+0MKVZ511FiNOOUs14gxLbtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rghjj6Qy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rghjj6Qy"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc11a30a259so4738495a12.3
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653899; x=1788258699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7qtv1Y8lxAp+OLsB54r6tSX8f8bw4F2ktQgQBuN1kCY=;
        b=Rghjj6QyaH9fG/QkaYJZBA85TpEXGX/9D2aG61XJe1jsUgYFmLPsav+beCWyOoMT+D
         aLNBzjfMb0B2O6UOzsMlkg1NeoW4aLYe4e0XnNI1pSw/9Z7toN2k/AwdzyijFQ3959zQ
         Forph8Kk4sxEglmQBl9SiM/MAmrNpDCMqClMmpLgVXPcTvmTizfAMgU9TgZqmsMaKdgs
         /5ldL5X7j7hukLfQwcJOA54csNsLtaYwbM5xtVywQlfEp1zO9Zq5Ox/qZHWmiXc+qn1W
         CfErEQ3NexHyMmgL6+YPG9Rm0B/l1aZn6nzHAC65H7YjSfN3Sy/zcpKAlzBv6DA22s3V
         cQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653899; x=1788258699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qtv1Y8lxAp+OLsB54r6tSX8f8bw4F2ktQgQBuN1kCY=;
        b=Ke8b7fXjDyn+7vR8t8WSv4+awQBnefElZqp67UpGQAbPA5lHYi+Z0f/gdXWdqHOY76
         mBnQZfam3G8Q38w22+B8h1F+0tBqH6ASbsN4GShUOgAXgdY6c2yCpHUiHxLnc1pfU5g1
         cp8dM81ENMNvPw6Co0jomUg6VZIivVXVC6q1wmatQOks9azo2/hK1smtoZgdeM095Zok
         FV1rIeKZKYsTq6mzBkbTBr006/DSi5HpLSjjxlNi+sY5Z6Hwbd1h/F6wuXKvFFgqr/Uu
         P8W+/hKdFzn+btObhaKXe1612GMWem8tNSn6CfzPpoj4my7NjZeVZOFoFjbxbyJwGclg
         TCZw==
X-Forwarded-Encrypted: i=1; AHgh+RpwKcT5y9ZEMWTX81C443xRNqTq0EZZNl31DgKG67NSzFmD6JTyjjs6ayhSZ6zY23RIycLDucMpkKhIFA==@vger.kernel.org
X-Gm-Message-State: AFuF++lBMYRsM79OYS7SpqlqGcC4f4mFgJqR1gtuP8V+IzrnRu6bJMrg
	D5emRS3dQCzUhvUqYWFai3PG73/ud9jC6x6UgE5TwTS6o0BIYkC1exAW
X-Gm-Gg: AR+sD13tp9AjZHUMA3FbujJDSQLXvAiiCRUToqktnytyXrR5wVI/BT1DhSubymUhL93
	GbcjXY4AtyjLS2NjnEMKXEIf4WQtMs/t4H8nW2GKSs3GDK4cbc7iqxpMICDpDR6pX/9pSKGmvnZ
	iz0n1c31jIJbX9EpN4a2Ad+cFgfvFWusEg84d9dS6RlPsy43zJcdwzydAXJMRbuxh8NEqrf1CH+
	MfH74rlGR0OSjzqO0hHHS0564wVeK30nCzWbVAOmwMUI6nIPLU3CZfDHQPujEZkVFhWnVuryJiY
	BY50CMihV+6PoJxuqkPN/1TV0MeZMBdkuVudvHtH/k984xwdLl4cwDGVrPbvsQ103rEb1K7ToeC
	azkzMORvrGziVHBMNcoHE0mmvQA/O+Atrje5HVe4i4WR7CmyLhqoZq0LI8NPhavVJ1lf5o/rett
	eI7ZElxkFvtakMVFUVCgHKePT41c42N1mFNbyAbj7dULIjTsvr0sSzhPGbzHi5w4dVlZky1ZG+k
	ZPi9XBTGoqd77sly7xCBVVn3cmWf5ZUKGnJpK0i30UFKqLyYGYAlfIAYQExdzZhOXoLogNc+mig
	sCjcKtRXDQPaLJMkRb+lJ90E
X-Received: by 2002:a17:90b:3b48:b0:393:1cf4:d972 with SMTP id 98e67ed59e1d1-395dee55f7emr43547390a91.3.1787653898935;
        Tue, 25 Aug 2026 03:31:38 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b1a54asm3343197a91.1.2026.08.25.03.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:38 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails
Date: Tue, 25 Aug 2026 18:31:34 +0800
Message-ID: <20260825103134.12278-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_driver_probe() creates the F34 firmware attribute group directly on
the rmi_device's kobject:

	retval = rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;

but rmi_f34_remove_sysfs() is only ever called from
rmi_driver_remove(), which does not run when probe fails.  Every error
path taken after that point -- input_register_device(), rmi_irq_init(),
rmi_enable_sensor() -- therefore leaves the group in place on a device
that never finished binding.

The driver core clears the device's driver data when probe fails, so
what is left behind is a set of world-readable attributes whose show()
handlers dereference that now-NULL pointer:

	static ssize_t rmi_driver_bootloader_id_show(struct device *dev, ...)
	{
		struct rmi_driver_data *data = dev_get_drvdata(dev);
		struct rmi_function *fn;

		fn = data->f34_container;

bootloader_id, configuration_id and update_fw_status are all mode 0444,
so any local user can dereference it.  Reaching the failure does not
need privileges either: a device that simply stops answering a register
read makes rmi_enable_sensor() fail, which is past the group creation.

An emulated RMI4 touchpad over /dev/uhid that leaves the second read of
the F01 interrupt-status register unanswered, on v6.12.105 with
CONFIG_KASAN=y:

  rmi4_physical rmi4-00: Failed to read irqs, code=-11
  rmi4_physical rmi4-00: probe with driver rmi4_physical failed with error -11

and then, from an ordinary user:

  $ cat /sys/bus/rmi4/devices/rmi4-00/bootloader_id

  Oops: general protection fault, probably for non-canonical address
        0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
  CPU: 0 UID: 1000 PID: 1851 Comm: cat Tainted: G            E
  RIP: 0010:rmi_driver_bootloader_id_show+0x4d/0x1b0 [rmi_core]
   dev_attr_show+0x46/0xc0
   sysfs_kf_seq_show+0x1f1/0x3c0
   seq_read_iter+0x2f8/0x1150
   vfs_read+0x699/0xa00

one oops per attribute.

Add an err_remove_sysfs label that drops the group, and route the error
paths below rmi_f34_create_sysfs() through it.  rmi_f34_create_sysfs()
failing on its own account goes to err_destroy_functions instead, which
also repairs a second leak on that path: it used to "goto err" and skip
rmi_free_function_list() entirely, leaving the function devices
registered on the RMI bus with a parent whose driver data is gone.  The
resulting order matches rmi_driver_remove().

After this change the same device leaves no attributes behind, the reads
fail with -ENOENT, and no oops is reported; a well-behaved device still
probes and keeps its F34 group.

Fixes: 29fd0ec2bdbe ("Input: synaptics-rmi4 - add support for F34 device reflash")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - No code change: the diff is identical to v1.  Adds the Assisted-by
   tags required by Documentation/process/coding-assistants.rst.

v1: https://lore.kernel.org/linux-input/20260824122751.76415-1-98lawweijie@gmail.com/

 drivers/input/rmi4/rmi_driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..144b203e636a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1255,7 +1255,7 @@ static int rmi_driver_probe(struct device *dev)
 
 	retval = rmi_f34_create_sysfs(rmi_dev);
 	if (retval)
-		goto err;
+		goto err_destroy_functions;
 
 	if (data->input) {
 		rmi_driver_set_input_name(rmi_dev, data->input);
@@ -1264,14 +1264,14 @@ static int rmi_driver_probe(struct device *dev)
 			if (retval) {
 				dev_err(dev, "%s: Failed to register input device.\n",
 					__func__);
-				goto err_destroy_functions;
+				goto err_remove_sysfs;
 			}
 		}
 	}
 
 	retval = rmi_irq_init(rmi_dev);
 	if (retval < 0)
-		goto err_destroy_functions;
+		goto err_remove_sysfs;
 
 	if (data->f01_container->dev.driver) {
 		/* Driver already bound, so enable ATTN now. */
@@ -1284,6 +1284,8 @@ static int rmi_driver_probe(struct device *dev)
 
 err_disable_irq:
 	rmi_disable_irq(rmi_dev, false);
+err_remove_sysfs:
+	rmi_f34_remove_sysfs(rmi_dev);
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
 err:
-- 
2.43.0

