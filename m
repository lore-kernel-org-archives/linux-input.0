Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B1418A5E
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574480; cv=none; b=qV1MMlBpVb2IptiTUBYwlvFthMXyMdOFDY4JQGKsBGagq6SPk80Z49kpxHNT5+hLDDiskrrDuRL4Et6eC2YZgggjVb3d/ARF643pMAqkzmNiBxUJnG68ysN1FiMzE9nSYGijYhGvJCrlG/USElfkjhfFj1dmNCzDky3xadhGSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574480; c=relaxed/simple;
	bh=ETROJDsxEGHCNly6BqUeDGahKOR2T6ekhSuAfmym0TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDElTd+S33vZktIv0LAFwWIQZLxV45MJIGSiCWaRaTFkqDMfIEMpmfFR8/sMqlCd2zRYR15A5Bm1M4rxtZ+c9TV9pkv6+4/9EtY6B2l3MjkLjeN52c7Kd1c8EU4hYLStGvqku2qQuzcGWN5/4nOSI57dQu5fsJooAOvWTu1C8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th7fNvuF; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th7fNvuF"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930c0f9c1b1so176846385a.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574477; x=1788179277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmihAs/QGjMhC6/wKUWvWaxgALVzhT8oi+LyRJ/OtTY=;
        b=Th7fNvuFyi1yHl3liuzGE3iuuDuedKPhHUPhZzvhf4UIJpC1dwi6Mlm01506aYoDq3
         c/jw2O6BfSW/mjH1kkGPLCQ25C7j1LPEP8U1pZXUBJsyppHucNZcDCwL8D9H8IUhlmCB
         GpCXW0wUb5V9Hlp1v2FYNqx8SB5QPQq0sui+rc/kwq3Y2TgW7J/MQ5Uu8gvVQHPJAbVv
         Ja1+iJuvhD9X9gqj2pKNHImKI3Zp4AgHjMBwpx88QKbk7yXmSJHFMNTYJtadsOqcQyFN
         EGMfQJQgQDR67p8PwUT60ss8SoFXsa1wf4RkXl+2xfwfxy4uvUvUoE5F5NaZ9KqdIloM
         47IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574477; x=1788179277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmihAs/QGjMhC6/wKUWvWaxgALVzhT8oi+LyRJ/OtTY=;
        b=qChGlRF+20ajb2rImZ93P9aOLBHgcJfUUXUCBR9/+4CEzNi90r2/zyuyfiw4v0/U8O
         2qlPrDnGaNGxwl01jhOJp5Ubsd+EM+VqyYt50Z6XhGEtA6b5XILhqUpCYDZbQJ93n8tU
         jAFFO2d4yhz59JKS+fkU5u6lJQC2oPlbj1AFMcYBayTRMeCmvh+n/fKCzzAj9JWrbuNM
         voQEqTWe8+Jvwk8rla1us1HO2lhfh0aYgWB09WhNRJe8YTMJOsbb0aLTREFsoEOQ046U
         UYvKAU5oU7Dm+kiZGLPc6m2j4zfx3+LdvxbEUO4Wya9dyFdTY5SN4CqUekSeBC+XJIhw
         LygQ==
X-Forwarded-Encrypted: i=1; AHgh+RrddGswYIIMMn/FQjyhUBHGjKjUfZ9zuDUUa947zP2dwXDlWmaHl+yoRih9aURzRaaEUqOsVxWJBLrzbA==@vger.kernel.org
X-Gm-Message-State: AFuF++mVhvrw5lQNcbBf4XJ7cvqkfNlxYFt8C+MNVLRWBAVcZ41F4549
	sT1imjQYiHILd/HNHNON/IeGY+rqZ4fKB/0OeQI/iFF86ddrtr21f75d
X-Gm-Gg: AR+sD1305b0cEiob5xRHbAX/N6DQKgBihhQu9XIRcZfqKzzHskL3xS+GOv7ADfgZYBZ
	jzYx1OKSsrVxKgONXqX+gHc3Pej1L+DHk4m/CJL8Jb94fCjuz3GFZKYt4bJQbwt7jfnS1BmoqTr
	Y1lK6RqmQcloUHYLMfhyK2/Jwc6jTs8VhOMv7YR2KznWGy5bxTD8WmV416mR7TKNAo0lCYrsJDg
	pAGI7BGnFotzg5Nb+mNND6jghFIZmG3E2siaq+raC1rCpe1cKy4ymLj4HTOskLXVtEZkUoRH2ak
	9LHO8WcuLLwbLPaQo1znhJ/5P1D2YEidhIY1Alq/Ypm+JhVIb2hiD3gFH5RGqrHMbLYtjeX9MSM
	b92H+OHSCJatkf2jlrAnCw3++SSyfIkMDpyZgxG9n3TVd6ZxobXpSl8Y8bCEtFrf64gPMeY7gUJ
	qXAuTK1o4Yl330hTHDLQbG6PdJhszOB4yzrmVd3ueegwKoIQgF/c1nnBe3gKV8kR/XKDE++nqz5
	/Bd9ocjIN9JN3QUsex6Zlot9Snw+DYiHUWppwQhHpXUCFJeqR9gYAS5B5heFHKH75zrb7EVq0uA
	Ikh00BN+JfIiwP/u7wV/DbD1
X-Received: by 2002:a05:620a:ac13:b0:936:af9f:4c30 with SMTP id af79cd13be357-93739652c16mr2068104785a.25.1787574476700;
        Mon, 24 Aug 2026 05:27:56 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749af9384sm488132985a.20.2026.08.24.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:56 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails
Date: Mon, 24 Aug 2026 20:27:51 +0800
Message-ID: <20260824122751.76415-1-98lawweijie@gmail.com>
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
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
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

