Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F6374A1B
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653911; cv=none; b=lzpNIuOojs6ZZ3cU/qNRBCA6145t0NwabmJG4PAKCgHIab/8mHEAc+HnE4djZosVvci9DAqCM5iS8u394pLzR5I9BjYCC3b3MHScKw9aqQ/jHyPUkubYA17d7hpjZQqnw2F60rrB2uhI+v6DyZ2lB6HG5UCNaOhS5k8rWFjUubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653911; c=relaxed/simple;
	bh=l2bWokjjDY0chpe0fnrpQgfAeQ6dFl5ffvZ1a8RD9ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIFPXwpyTPGkGf2CcBicUNfGCJSm7gszWCBpioMPP+wlaBYD1jpuvpUhh0W+LU+7Bteah7CsjxS84hN7Pqb/0ahzsuNY8e1zbxAH1vVHikn55RB2UsH+8XmAWVoiGBVI/WSSwnVehT+uTd/GhNhlJVkSRD1iNBy9yYCRzAFXM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au7iaoTi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au7iaoTi"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e7109321dso3315050a91.3
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653909; x=1788258709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=paSjqA23OneL+rTygITLT6pmiH7WkUSFEzJPB30mI9w=;
        b=au7iaoTiq9Gss7tblsAgVQVhTUzKpOpe7oJ+DnOAKzIZgtIfBgHXjzv0NNvc0O8E4w
         IfaIMvfKKL+ufgFunfSsARnt36XsO3K0AfY7vo0wdopjUX3V91HOe0rXo9DnmZZAcMkh
         /fP6YLfrQSpYGaToHStQCFCpRJ3BtRrTf+V/4wCln17WcELTzq5df/7D9dvMkEqDOPlg
         QOmAmEk4XaRg9IMxU/Qmz/xb2T+69r3O+/CqpPeKZZLpgmvqqbytA7aFaTVXNtmXz8jE
         8umUy7Tre2srTs2CTA9OAqu9iqoLfHlxUhqIfSGgwZZ12RWnn62uSOO/QrcJa83hg/pt
         hK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653909; x=1788258709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=paSjqA23OneL+rTygITLT6pmiH7WkUSFEzJPB30mI9w=;
        b=RANuiXueHrVWL/xmYc5UYkp4goGFM3YjKKQSNAcD3zUX7alUIoFsYnLGtwHBo/96UD
         MXXbKKaB6r+Z6WP5k7RrkuSgJMHfHb9fG1StkUWejzbvURk43BUqz7iMh7uEtHdtCTjl
         +30Siq4nbrskwpN2cNPmcCBt/asYOeudX1LDs77AAsaSdcKUo0pk5p8vfRWXEiafUrw3
         OPzaZu5mwy7WSzhTQOvwn2TwxLFMrVq8naOHl3vMId7F6ivwWv8g/Y6ro/6Nsn3KMF9a
         5tAg64aDN/a7PZRoBn8mNdoG4a+/8GgXR9wKD75WYeeZbZULvd4+O7cp9CYQkx74Z1q9
         yuBw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8k8NxEB5z9Vx9M7GxD8qf30GfeayjLEjswYbr8W5E+MLZtZhLqzrvhMefunyTV9yfDA+2dIp/GODWOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++naPVixbmoPntJPypOge9Gu0jlgy7u+7DgIHG2e61PYORO1N2Bb
	vvRwUqN4dOluIKKlIlBvfg9ZCLv230J8apFujntFa1mK5vAhxZSlfYdhkYuhQztYBvc=
X-Gm-Gg: AR+sD13WM+UcR3lzmR7NPXbGsTX4h36MxWWdU0P0nGIbj7CzMjjt1yOBjEcvJzw45Sk
	DQfhYNt+EhG0CjyF27Qh3o3n8+ickl34ndlwsVrs8Axy1b7tlSseNEAKfL9bnfC1D+DOQmK6rNz
	MFtX7YC4KW8s3aJfEFh6dhw2zzQuO8QXtoJqOUuJzYrhQ75Op0aLYqFKMyY51KOibEHRzXDfwuv
	59O0xh/31z+tPLS8XGlU3bsY9qPxtyJdwAWqpxvV3lyTkEpVL4ICZAnNh/uLJWMbS+PAEX4eW7j
	F5CUr24A3TOzHuZ2BbObl5jWaLz8eilHpGlApRLFMPVAV93HLgAb0En2RTD6X9wKFVaO+Fr6yf2
	18Q46P8s3C7TgaQJNJa9/0jWIxtixJNAzp/Xy2W6tW60fQdRT8Bz7fqfKvIQgMCccWzwlWMz55F
	TxGiJ6c5mCOk2hJLeQmft6JrQfsFpwg7Nfmt0yT4CDtpGfXAOMQDWEG6cwk7dnr+pFagP1F7ev+
	0p6NpMA2JJw85tCIllUrGHH3VEXjTFlzFWhy6MJf9gdEW6eJITv+DuFspAOHtq4DhkokU+o30ot
	egEb7iegNIOjDlsSXNsHlbOQ
X-Received: by 2002:a17:90b:2e4b:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-396464a18c5mr11957498a91.10.1787653908966;
        Tue, 25 Aug 2026 03:31:48 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965547159asm1916964a91.12.2026.08.25.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:48 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: rmi: fix use-after-free of struct rmi_data via reset_work
Date: Tue, 25 Aug 2026 18:31:44 +0800
Message-ID: <20260825103144.12356-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_event() queues hdata->reset_work for any pointer/mouse usage as soon
as RMI_DEVICE is set, but rmi_remove() only cancels the work when
RMI_STARTED is set:

	if ((hdata->device_flags & RMI_DEVICE)
	    && test_bit(RMI_STARTED, &hdata->flags)) {
		clear_bit(RMI_STARTED, &hdata->flags);
		cancel_work_sync(&hdata->reset_work);
		rmi_unregister_transport_device(&hdata->xport);
	}

RMI_STARTED is set at the very end of rmi_input_configured(), so a device
that advertises the RMI report IDs - which is what makes rmi_probe() set
RMI_DEVICE - but then makes rmi_input_configured() fail leaves the work
schedulable and never cancelled.  Never answering the SET_REPORT that
rmi_set_mode() issues is enough, i.e. exactly the unreachable-device case
the guard was added for.  rmi_probe() still returns 0 there, because
hidraw claims the device, so the driver stays bound and rmi_event() keeps
running.

struct rmi_data is devm_kzalloc()'d on &hdev->dev, so hid_device_remove()
releases it as soon as ->remove() returns, with the work still queued or
still running.  The workqueue then reads and writes the freed object:
process_one_work() stores into work->data, list_del_init()s work->entry,
and loads work->func out of freed memory before calling it, while
rmi_reset_work() dereferences hdata->hdev, which the same unplug freed.

  BUG: KASAN: slab-use-after-free in process_one_work+0xd96/0x10b0
  Read of size 8 at addr ffff8881095c0540 by task kworker/0:4/3058
  [...]
  Allocated by task 450:
   devm_kmalloc+0x7c/0x220
   rmi_probe+0x36/0xcf0 [hid_rmi]
   hid_device_probe+0x286/0x430
  Freed by task 9278:
   kfree+0x125/0x420
   release_nodes+0xf0/0x260
   devres_release_group+0x23a/0x3a0
   hid_device_remove+0xf5/0x220

The read is of hdata->reset_work.func, 320 bytes into the freed 512-byte
region, which process_one_work() calls straight afterwards.  Without KASAN
the same reproducer oopses in rmi_reset_work() and leaves the kworker
"exited with irqs disabled".

Cancel the work unconditionally in rmi_remove(), and do not queue it
before rmi_input_configured() has succeeded or after rmi_remove() has
cleared RMI_STARTED.

A report can still pass the RMI_STARTED test in rmi_event() just before
rmi_remove() clears the bit and queue the work after that cancel, so cancel
once more after hid_hw_stop() has stopped the report flow, and make
rmi_reset_work() bail out when RMI_STARTED is clear - by then the transport
device it would reset has been unregistered.

Fixes: 8725aa4fa7de ("HID: rmi: Check that the RMI_STARTED bit is set before unregistering the RMI transport device")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - No code change: the diff is identical to v1.  Adds the Assisted-by
   tags required by Documentation/process/coding-assistants.rst.

This is independent of the pending "HID: rmi: fix OOB access with
undersized RMI reports" [1] (whose v5, also a tags-only respin, is being
sent alongside this) -- they touch different functions, and either order
applies cleanly.  They are worth taking together, though.

That patch makes a zero-length READ_DATA reply fail rmi_hid_read_block()
with -EIO instead of spinning in it, so rmi_scan_pdt(), and hence
rmi_input_configured(), now fail where they previously hung with the
device lock held.  That failure leaves RMI_DEVICE set and RMI_STARTED
clear -- the state this patch is about -- and, because the probe no
longer hangs, it also lets the unplug that triggers the use-after-free
complete.  The route described above, never answering the SET_REPORT
that rmi_set_mode() issues, reaches the same state on an unpatched tree,
so this is not a regression from that patch; it is a second way in, and
an argument for the two landing in the same release.

[1] https://lore.kernel.org/all/20260825060954.104890-1-98lawweijie@gmail.com/

v1: https://lore.kernel.org/linux-input/20260825034854.63555-1-98lawweijie@gmail.com/

 drivers/hid/hid-rmi.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17fdba46..13a301404ff8 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -313,6 +313,14 @@ static void rmi_reset_work(struct work_struct *work)
 	struct rmi_data *hdata = container_of(work, struct rmi_data,
 						reset_work);
 
+	/*
+	 * A report that raced with rmi_remove() may have queued us after it
+	 * cleared RMI_STARTED, i.e. after the transport device we would reset
+	 * has been unregistered.
+	 */
+	if (!test_bit(RMI_STARTED, &hdata->flags))
+		return;
+
 	/* switch the device to RMI if we receive a generic mouse report */
 	rmi_reset_attn_mode(hdata->hdev);
 }
@@ -412,7 +420,13 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
 				return 1;
 		}
 
-		schedule_work(&data->reset_work);
+		/*
+		 * Only reset a device that finished rmi_input_configured();
+		 * before that, and after rmi_remove() has cleared the bit,
+		 * struct rmi_data may go away under the work.
+		 */
+		if (test_bit(RMI_STARTED, &data->flags))
+			schedule_work(&data->reset_work);
 		return 1;
 	}
 
@@ -739,15 +753,29 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void rmi_remove(struct hid_device *hdev)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
+	bool started = test_and_clear_bit(RMI_STARTED, &hdata->flags);
 
-	if ((hdata->device_flags & RMI_DEVICE)
-	    && test_bit(RMI_STARTED, &hdata->flags)) {
-		clear_bit(RMI_STARTED, &hdata->flags);
-		cancel_work_sync(&hdata->reset_work);
+	/*
+	 * reset_work lives inside the devm-allocated hdata, which is freed as
+	 * soon as this returns, so it has to be cancelled whether or not the
+	 * device ever reached the RMI_STARTED state.  Cancel it here, while
+	 * the transport device it resets is still registered.
+	 */
+	cancel_work_sync(&hdata->reset_work);
+
+	if ((hdata->device_flags & RMI_DEVICE) && started)
 		rmi_unregister_transport_device(&hdata->xport);
-	}
 
 	hid_hw_stop(hdev);
+
+	/*
+	 * A report that passed the RMI_STARTED test in rmi_event() just before
+	 * the clear above can queue the work again after that first cancel.
+	 * Such a work item does nothing, but it still has to be reaped before
+	 * hdata goes away.  hid_hw_stop() has stopped the report flow, so no
+	 * further queueing is possible by now.
+	 */
+	cancel_work_sync(&hdata->reset_work);
 }
 
 static const struct hid_device_id rmi_id[] = {
-- 
2.43.0

