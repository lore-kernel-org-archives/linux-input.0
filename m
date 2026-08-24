Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945C41A4EE
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574468; cv=none; b=NvcV3tDoIdO5MENRNkZYkmqj4I963B/Smpd0KRyJ+0OszMRCbfOI2vBBTdiqjerx88uE3p1Li0Fss6mVIKnYFhctUVc0cAaHP6nC8f+5kNeTXhYeSKmYYRLO22lRrqRYt+ex6ZrrfjycZcU5xWZOyQ2t0yiFQXPPMeycD7AyXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574468; c=relaxed/simple;
	bh=C9ljMPmOgKzzGRi9lsltS32itRvLvS7A9iFne2T9euI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSkIOtrPFG4twRnuDv9/nYkAYbALAeH6AWzZssjS99H+AXo5PL9WM4kQeKEsrtOMvQRUyzaX0jqikuRxOXKhcHSIpqFxIqaq3/4OQMGZB+2NW4vvam7n30P9Lji1moxaY21fOO2kukmp+laJVAMtzO1GFcImdMAdBZQJ8MXsq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD6InFZZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD6InFZZ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efbafa1bacso19925336d6.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574466; x=1788179266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCP4SoxE8UtElbaGnJtG7fQSm7CuB0xZVB5xSM21nbM=;
        b=LD6InFZZwRepGmXD353W2OKtohFRJRAvrHrV58XM7gacs5SvtttuOzL+H+RVQp109V
         tJm3v+7g694vBv/u4szLqSq+AThHROGsaVctI3BPxC34vEv0v1QwszhNHC2i9BN+1VBo
         mPmcr+xLSQjhejXnA1cNPllAsSAN6MIYCGB79b1XFeoBlcG421iO21S0rc0RmnmNPUXm
         nAdlqScKD0qdGVVp6Nc/okrGRBJG/SnUHz2H/hRwuu/UifZcVHScgWunYMUXfjPG3mIn
         zOcYLX4bIouePG+fv1s3vu0cfj6MBueFbvAY2FOsAWcZZH0Qa8ESosuwbbOte5ZrE6B9
         cetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574466; x=1788179266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCP4SoxE8UtElbaGnJtG7fQSm7CuB0xZVB5xSM21nbM=;
        b=sL9GQW3L/gYB8l/8fxEL4wL2to7ms5MUd0BvJGPXfdXL3S5ANn9/hmrMrU288IgJM3
         a8SIffzpu83SGOxE5lP6AGFp1qSafZcrGljLg4NGs4kr/SWWOOEvJoYsdgOsIVVvVT2c
         Wg0j1ailJpnBiMJ86fzIwCJaH9VkgWzPitaQKv6YgdvWPv3A7i9NvegKivZTnhvrK3Ox
         w6yJWChN/FDs1AHWGylioPXJYheYFTyHiNIBeqNO7DMAtQi7oSI3aPmi4oVqEbyQPutL
         S5hgc7SHA+jyNX3//f+t076g3Sx8YlQHY///FcbBbIUIef1CtvvEsH+ZYQbRNKSNvDUQ
         slUQ==
X-Forwarded-Encrypted: i=1; AHgh+RozEh99Sw+JY9v8KyGSMx++pySu0mT7td4RXjww/BkuZW7JC2AQf/+/EEg7amHD+cdxpqABmmDArW6okg==@vger.kernel.org
X-Gm-Message-State: AFuF++nV/F91ZuABSfwQWjkYo4yO2kp5E92dNMG4ZwHXwO1dgMgNigm/
	DNk8IY3K984D87xtBw7YOo3F3mggK5hmPBHCqvilnWtplErGR99iF/Az
X-Gm-Gg: AR+sD12DmdrBnf/8rLu7LXVE6RKGiRXzdR3L12iPd+3cO1pH7vIANTT71xrqeX6nQry
	OMc5t/PClepVwh49CHpfFFyNr14WJ6X9tHHvIs7PvCQKeqc1DDu6hpXpQdMv6eDDKxbB1MeM5M7
	ox2ahTq2i/8hep+7eprCo/TARgLtXVqnOKvdJrU51azAOolmlO6xuOLZznqurf46mUsdvvl9aLi
	3z82NyfwMvBEJnWkV8Xnex3Whz6dsUpW5HwGLhIXSM42qdCGeiNHtqFSjCqnUBebUCwtJBCR6qy
	IK/HV2YzPpFxb6LelbiggqLfdMZ+2+ersIRd7/wm6JcAW7PwrzSH69yjzxDaYSL7tlJ79CY60OA
	1oZES28wWBuNreNmDYXze7xMke34TP5EJkaroOORILLeA9llsSwBkVlgQ06LvdT9ztyuUAkwy7m
	+mcALertO8E98+wHQTzIQGILbInhm3XIe3/KkdvHECHY6LuEx4AZdcxVJPblbpbayzPHhmRTv2A
	OG7NDhOB2fdmMuSSABZI9QVlOg8baNa70CkiGQ/DNELi4sh0UNPRm+hQlfxuIUysEFG+i4RhZ2U
	lzbQ9yp5dIAXxi+d+8ZACAfO/5oBINYbvxA=
X-Received: by 2002:a05:6214:508c:b0:90c:576a:db55 with SMTP id 6a1803df08f44-90c8fa36499mr169713346d6.21.1787574466014;
        Mon, 24 Aug 2026 05:27:46 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a4f093sm60745276d6.37.2026.08.24.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:45 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Mon, 24 Aug 2026 20:27:33 +0800
Message-ID: <20260824122733.76321-3-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824122733.76321-1-98lawweijie@gmail.com>
References: <20260824122733.76321-1-98lawweijie@gmail.com>
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
The rejection happens before rmi_register_function(), i.e. before
device_initialize() has touched fn->dev, so the partially built function
is disposed of with kfree(): put_device() on a kobject that was never
initialised warns and then leaves the object behind, because the
saturated refcount stops the release from ever running.

Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - Dispose of the rejected function with kfree() instead of
   put_device().  See the cover letter.

 drivers/input/rmi4/rmi_driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..8dcf088a7a81 100644
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
+		kfree(fn);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < fn->num_of_irqs; i++)
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
-- 
2.43.0

