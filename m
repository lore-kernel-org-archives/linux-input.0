Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9553DEAEC
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550632; cv=none; b=nbKRq2OA1A4qmURSoBUDkJ2lwju8l6V/77yJKSyvTNyV7JPDg5VfhGWdx/nY9Q/3TNzGH/iJBQO1Rp1Bo0BfYBNT62462fO69YJkY9m0TLkDxHckHfAASV6QwUnFdSHaIlHaF5/JdLp/TZfG5+iyD/t0wsAI+TBQyuWbGDztUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550632; c=relaxed/simple;
	bh=ILGgGBJIjFFiPwTQaTOvL/nQywIa0UNzzJZhVum0lV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTwUXHERxoT7bkpusO1VY/XRPJMSBV9POOwrQLWFfml1TAu/E8zNZLqYA9wGw5s9RN9UGjgTO1otRHmK7L73wRbS9nydF7ethD2vQCtacCRRq5T/EVp/QcW4fYmuBtcH0oDF4hWgsYGhk18MpTkgN/PxMFU3ZfUu2yx4/R+yOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTq0NYKY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTq0NYKY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceb096e675so34888815ad.0
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550630; x=1788155430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eujiq6V03TrGWMcsHjzyrL4w51Ezbmmle/EXKToc6k=;
        b=XTq0NYKY+cVGL+TLnihE+3Wgqf/0DrID52UVCjcKGSZKotDyE4CdPIWgUyYpU4TFLz
         Z42HRTTq6rzg695RC0yM6IlbS579zyeg3KISxdeHHxLe6BQ888WpSo9FAJ4k/crSIKUp
         VpCS484WFEBP4r80vGRVzrqj2x9FnUc6BylT9AuNjKq3iqJWj8GUZUMQogPAXJ4XwEfS
         0v2D2piz2YudAy1Vf0UDp6VafWPdnoLTIaKemGF+FxSZbycxFnBNZFOHw4DB4b3DLLsR
         +tLNC2DcAOTQe4n9WWIBU+NoehX+4PIg1ceJl2EKRyJCXMdcyldNUIiDGXyUASQtK5ZB
         I/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550630; x=1788155430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eujiq6V03TrGWMcsHjzyrL4w51Ezbmmle/EXKToc6k=;
        b=UWy637KU5TdrCqOARc0oOXWeLpjTgO4eRDTar+f7xG0aUm8cJIep+JRu9lxcjZfFk4
         yxywz7Oa75yjPMtNgtePPZnbaUixud7kZiHRSNQ/Fq0eVApBZolYHEOlbLOAWxb3HeFM
         vrId60udrqBwT1YcrtbRjzEl9olviqHi+SN8e18YZioeDk0ycQ1C5NcJXEN4K2PKKwrk
         I6AlqsxRURI7iziz/hfb+NgDpP1g+myqvZNqVush2Slagpv3TbacPdLazjTHqAL+crG5
         JGq6A2KkX6+94GsuCFeqCpyAW4chSum+e9cBhmdbd6O3CxEoizcbrJhuiyqn3HoJFdi6
         7VJA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnsd5nUg4ssd2lpeZfhtOX/ati4dFGcanxqhV3bW13SxEqw0AqSUN26/ZAcQb6pDMfndfyE8Gcn5ATeQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kXIcYiAWwNk1ByzOaeOnDxefUCOh7toHk9eXzJC7LDvwOZjkN5
	x8yB5tKe3LqbW713A9gUg9pmQOgGBpbqjy+DK2hlBCk4SHKK3OjOxOrj
X-Gm-Gg: AR+sD12PQMcQAZ87g1ShkwSX8uItAnSRTaVhHQA2ZDtv/x/UDalzm/6WmQVBvT139ec
	PjUL9/YrxxgPPY9iv3/wdeojayIADFKKV+9htyTyOvZ2hNYVOIcC12gfhpnjCkOXvZU1p93rtgW
	b//f/RK3A9NYiK94UWtAoMD+Drj8HOUBPhJI+05/ZkkX6020ZftFnUMcG3iSxtlqhacGIZYecYG
	BYNv3AkKkimonc0AtWD9ZcxI4NN/14nW4PuKopUtqrwkrfpRtZwDRL+UwkN6HJuovxaxWm71z6/
	3pjAm5oK59jOI4PZmbArmmXabCqU7daLfXagFiByCYHeXvnElZuzoOlgrJihIV9giUMRfRDzGk7
	ubQEA/YBkoE4kKs0cf/bXCgATtLGejBt1l9+j46gUYW9PktlhDtG9OBw9CgwtR1c4kQEwpla7KP
	plrRWbqqmM/v+sx6Wz1+vTSMbACOzWaSEl+PQS1w2Ju/IkHpticNs3pgE7WaFjQb9C6FvlbliUY
	qYndQ8abpLvT9S+m47km/p4TXOlKrMz9O9t19khqF8y6SERzHaDiB625feXOevW6t0PYUu0NyF/
	eAi1iKPeHac82W8I7MbPwyGCS/eKWA==
X-Received: by 2002:a17:902:e804:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d670bee7a0mr271595585ad.8.1787550630113;
        Sun, 23 Aug 2026 22:50:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768c9876sm13955655ad.68.2026.08.23.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:50:29 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Mon, 24 Aug 2026 13:50:12 +0800
Message-ID: <2c26d7ce8c6b7371ab55607f53443961220e4b24.1787549234.git.98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787549234.git.98lawweijie@gmail.com>
References: <cover.1787549234.git.98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_driver_probe() walks the Page Description Table three times, and each
walk reads the table back from the device:

  1. rmi_initial_reset   - issue the reset command in the F01 entry
  2. rmi_count_irqs      - total the interrupt sources
  3. rmi_create_function - create the functions and set their irq bits

Scan 2 fixes data->irq_count, data->num_of_irq_regs and the size of every
per-function irq_mask[].  Scan 3 then accumulates fn->irq_pos and does

	for (i = 0; i < fn->num_of_irqs; i++)
		set_bit(fn->irq_pos + i, fn->irq_mask);

without checking the result against the count that sized the bitmap.
Nothing makes the device answer the third scan the way it answered the
second, so a device that reports one function with one interrupt source
on scan 2 and a long list of functions on scan 3 walks set_bit() past the
end of the flexible array at the tail of every struct rmi_function:

  BUG: KASAN: slab-out-of-bounds in rmi_create_function+0x560/0x930 [rmi_core]
  Write of size 8 at addr ffff888110c92b58 by task kworker/1:2/129
  Workqueue: events uhid_device_add_worker
   kasan_report+0xc6/0x100
   kasan_check_range+0x105/0x1b0
   rmi_create_function+0x560/0x930 [rmi_core]
   rmi_scan_pdt+0x190/0x3f0 [rmi_core]
   rmi_init_functions+0xb8/0x320 [rmi_core]
   rmi_driver_probe+0x31e/0xbf0 [rmi_core]

one report per corrupted function object.  The same unvalidated
fn->irq_pos is used again by the set_bit() and irq_create_mapping() in
rmi_create_function_irq().

Validate the position before using it and fail the probe instead.  The
check is exact, not conservative: when both scans see the same table,
fn->irq_pos + fn->num_of_irqs is the running total that produced
data->irq_count, so it never fires for a device that behaves.

Reproduced with an emulated RMI4 device driven over /dev/uhid, and again
over dummy_hcd plus raw-gadget, on v6.12.69 booted slub_debug=FZPU and on
v6.12.105 built with CONFIG_KASAN=y.  After this change the same device
gets

  rmi4_physical rmi4-03: F40: interrupt count changed between PDT
      scans (pos 1 + 6 > 1)
  rmi4_physical rmi4-03: Function creation failed with code -22.

and a device that answers both scans consistently still probes normally.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..c0e91a372eff 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -899,6 +899,24 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
+	/*
+	 * irq_mask[] was sized from the interrupt count collected by the
+	 * earlier rmi_count_irqs() scan of the PDT.  Nothing guarantees that
+	 * this scan sees the same table -- the PDT is read back from the
+	 * device every time -- so a device that grows its interrupt counts
+	 * between the two scans would push these set_bit() calls past the end
+	 * of the flexible array.  Refuse the function instead.
+	 */
+	if (fn->num_of_irqs > RMI_FN_MAX_IRQS ||
+	    fn->irq_pos + fn->num_of_irqs > data->irq_count) {
+		dev_err(dev,
+			"F%02X: interrupt count changed between PDT scans (pos %u + %u > %d)\n",
+			pdt->function_number, fn->irq_pos, fn->num_of_irqs,
+			data->irq_count);
+		put_device(&fn->dev);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < fn->num_of_irqs; i++)
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
-- 
2.43.0

