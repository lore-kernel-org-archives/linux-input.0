Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674809;
	b=uu+8sxm50wiUC14Y4N8xadeeu/MvVjZb08X0sQRRCvzj3aK406A0xIba6oaejojlyJy+
	 uJXEtdmcm9GJmVsCunWi36SM+jCODfHXaYwpqyL2NpsSD4gH8QXfa/48+Da/Tm1XSYUJx
	 VnuLj7OxquvgaMvNKQKkYVjGV5/oY7UasuWvzf3uvFJ1s45eLbx7TXtktua5L6dv3JTeh
	 BDhl6kuNLHG6BMnZyMaMBM3FyvMLUJ1VXEAufwAEsxz3Tx/6/te+VQ7G4BEyQtBhzQIJj
	 LfDUX1JAKGnltQtJCnpPHbDkjMs3a/nmWJU3wpwG/gB9lCbWCSP0vs6AqJOhGPvGJiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=yVOQ1L8O+8jKxtIQtsjnk6fzaZoe6ThQio4f1IPG6QM=;
	b=Qy4NX1lBxTH8t2fBHey+bTnnxZywMppTRY6fQjNShQOR8Aflvw28OFwKjINaEs6cpddS
	 C/Y90rU4Ngn/nLBdjvkC1+PjEHnelORy3GKT3PFOyG79IdxABdoiKbS+PqWUamgFiznV0
	 5VeGgNcwEITxVcdyMORm+kO1GcUh7Z5Mnp1p2SwfGbH3MONVq1G66IpjJKU43hya5i4pS
	 W1OzXUnh3zuCorbNM51ckREK1fQgJGe+GTSBd6PdGXkF9Fyx0HKzrKFm09p8RiSbvM3Js
	 KaEXcthEK1S/1L2u38qV2chIdqWueQUfvJf6SLzwkHVCfxEZYyl5LJw8JOsXdpzJjGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWKww995;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19155606A32E
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 03:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19155606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWKww995
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so2877834a91.3
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 19:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674808; x=1794279608; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVOQ1L8O+8jKxtIQtsjnk6fzaZoe6ThQio4f1IPG6QM=;
        b=IWKww995EvtZZoHiYy/wXjTGbmZog9wtq5/Jc+an6R2jG84GS2Eu2YsnzdYVWofwPs
         bUsKacRZmhscQLX7lCKMlB1X35QGKhrzLjgI0T1/jdPT6t8PiY5S4UqsU75X5nzusTAi
         x+TZLy+OUgvncCeMHBiNtzX6Lrq3PFus696BRDfhNOTyaPbV62l6MbtvOIweI3UjeTto
         NyGBxB1mjUU9xbF/bV2+kogfkJKfWhjLgB1t8K3KcHpwx00x7lZ+sCOo0l46m9i9NE5/
         F+ZdWWPD5/2ErfBXCvZPeYWK32peHv24HTt0AJgMm/ZDr4ouChLdJ4tD9nP/JKIecR+a
         St4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674808; x=1794279608;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVOQ1L8O+8jKxtIQtsjnk6fzaZoe6ThQio4f1IPG6QM=;
        b=TyeOPPq8deILNlGPbSH2uF/tUFKsl1ayM1pYXjaRA11e2nHuZZC3P3fLhOKJze3LwF
         aSN8pv6op1O6Ko6o530itUqfJdU5Vf9xjP3cpFnNLtB29xiXy3R/1NymJaLKwi3WCads
         AK0F2otYDuW5DQHIaQrEbSmtooYFGSKJe5ukH8sS15uIeRnZ10jMO8l6FK8RvX711eWZ
         KtEFNMKMZGcowZi+Gmdjf5yH2xdLQgD7u+Vb9N0Al9xddM7xVXHqhvAUles1QYfQcR20
         AQ8USet49bN+wZLs+mw4G7dg/RwdEzTzvgauPHt1+/TXv6m/PsnLKxXkCWIa1MmNlQVK
         bcDQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7IXLXAUcBRXAWe39bC0wyOfJbp68SfKxaKHCL2fsDX2Nb1WqpO0PXp4w2CJjF/W0A3Isj5NKxkIaTSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+/9FL1nYnftbZlQopX+YXA7UYThp7uiPxijXz+ZciKX4X+JS8L
	bhOU1KjzrdisZ9rROzBM+wRTn7YXRsTBNm2o71owVCst/zSQXiM+WtYX
X-Gm-Gg: AYBFou1CqI0jzZVJFjOa5KKpqlasTPiR46zwDTWl/4vFwXWXq700ustA2P5YhE0266k
	YN0yBZHRiGS5fHaXp0TSVKApCFInD+Cj8q6aCISyeOdyGA/aVQ8xxRm4KflDqz9L87dsOo+Xe/j
	z8S5twk9FyWHakyCVGDU7vDYc+mAPx0ZR8EG6dy5pV/4FEm9HKvKuYiUPRjWnFMf9nERbNLCwRy
	rV8aM0c4uEH2DFJZQDJNZdw/ZzzQE++Lo1AuVw3pb9ZUc3RpYNKmePL+pK2yFSjapsdQH9flQia
	soCgqdlHhyp/hLyvJwZ5UYbXsyuiziOoZRM4WzOtFmmHCgBqK5FKY9xgaPooFzgeAVU4vC3baJb
	8blz0aswBKkS3wp+Cc364kOr+qV88WOzlOd/j6pHQPA5Ty39j4E9h1swYnhglKrx/Ju1/ByE+ay
	PfcDPLnWna8VQ+EZnsVXhI4D9aiPVc0f8iaVr0nPO1qhsqm64a2jXZdan0tkraaGmMJd7EbiVLR
	okKvoKifE+rBQz5DqGacFN+MbrLfXDcbapmCAVyNwDoTmI8A6pUZo2nb9jsT9bkR2BcKOsuRnMd
	3lQmvfmdONP9t+gPmUFMR4EIETqb5THGBI9LAi6DCq95B6NN2ZZ+4HXzV9KTJ/4qP2WgwmByMYh
	lkEbgZrGg/XZTOAvOUb+iqoXkqV/l+J+VHw==
X-Received: by 2002:a17:90b:1d03:b0:3a8:49f2:8ddb with SMTP id 98e67ed59e1d1-3ae8984de33mr10126233a91.60.1793674808172;
        Mon, 02 Nov 2026 19:00:08 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5adc33sm1790498a91.1.2026.11.02.19.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 19:00:07 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 03:00:07 +0000
Message-Id: <DML8NIYTERIZ.1GLZ1R1VJPLUG@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <linux-input@vger.kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] HID: bpf: synchronize hardware operations with
 device destruction
In-Reply-To: <179367391951.8187.17327354719079930667@stu.pku.edu.cn>
References: <179367391951.8187.14164894863012056170@stu.pku.edu.cn> <179367391951.8187.17327354719079930667@stu.pku.edu.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 06:45 PM Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:
> Add a lifetime lock that serializes admission of HID-BPF hardware
> operations with device destruction.  Take an SRCU read lock while holding
> the lifetime lock before accessing the report tables or the low-level
> driver.  Destruction marks the device destroyed under the same lock and
> waits for the SRCU readers before cleaning up the SRCU state.

The lifetime lock is needed only because hid_bpf_destroy_device() calls
cleanup_srcu_struct(). After that a reference to hid_device is not
enough to call srcu_read_lock().
The splat in patch 2 has the same cause. So does
commit 578e1b96fad7 ("HID: bpf: abort dispatch if device destroyed").

Lets keep hdev->bpf.srcu valid until hiddev_free().
Then the check of 'destroyed' goes inside the SRCU section.
No need for the 2nd mutex.

The dispatchers have the same race and this patch leaves it.
hid_bpf_destroy_device() runs before hidraw_disconnect():

  hidraw ioctl                        hid_destroy_device()
  dispatch_hid_bpf_raw_requests()
    destroyed == false
                                      destroyed = true
                                      synchronize_srcu()
                                      cleanup_srcu_struct()
    srcu_read_lock()   <- use after free

hid_close_report() also runs on unbind and on device_reprobe().
SRCU doesn't cover that. Neither this patch nor the diff below fixes it.

Instead of patches 1 and 2:

and Pls wait for Benjamin before sending v3.

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 6b467c7..6c2b136 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -99,13 +99,15 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 	struct hid_bpf_ops *e;
 	int ret, idx;

-	if (unlikely(hdev->bpf.destroyed))
-		return -ENODEV;
-
 	if (rtype >= HID_REPORT_TYPES)
 		return -EINVAL;

 	idx = srcu_read_lock(&hdev->bpf.srcu);
+	if (unlikely(hdev->bpf.destroyed)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
 				 srcu_read_lock_held(&hdev->bpf.srcu)) {
 		if (!e->hid_hw_request)
@@ -139,10 +141,12 @@ int dispatch_hid_bpf_output_report(struct hid_device *hdev,
 	struct hid_bpf_ops *e;
 	int ret, idx;

-	if (unlikely(hdev->bpf.destroyed))
-		return -ENODEV;
-
 	idx = srcu_read_lock(&hdev->bpf.srcu);
+	if (unlikely(hdev->bpf.destroyed)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
 				 srcu_read_lock_held(&hdev->bpf.srcu)) {
 		if (!e->hid_hw_output_report)
@@ -423,6 +427,11 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 	if (ctx_kern->from_bpf)
 		return -EDEADLOCK;

+	/* hid_bpf_destroy_device() waits for us before the transport goes away */
+	guard(srcu)(&ctx->hid->bpf.srcu);
+	if (ctx->hid->bpf.destroyed)
+		return -ENODEV;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype, true);
 	if (ret)
@@ -483,6 +492,10 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	if (ctx_kern->from_bpf)
 		return -EDEADLOCK;

+	guard(srcu)(&ctx->hid->bpf.srcu);
+	if (ctx->hid->bpf.destroyed)
+		return -ENODEV;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, HID_OUTPUT_REPORT, true);
 	if (ret)
@@ -641,13 +654,9 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
 	if (!hdev)
 		return;

-	/* mark the device as destroyed in bpf so we don't reattach it */
-	hdev->bpf.destroyed = true;
-
 	__hid_bpf_ops_destroy_device(hdev);

 	synchronize_srcu(&hdev->bpf.srcu);
-	cleanup_srcu_struct(&hdev->bpf.srcu);
 }
 EXPORT_SYMBOL_GPL(hid_bpf_destroy_device);

@@ -659,6 +668,13 @@ int hid_bpf_device_init(struct hid_device *hdev)
 }
 EXPORT_SYMBOL_GPL(hid_bpf_device_init);

+/* A reference to hdev is enough to use hdev->bpf.srcu */
+void hid_bpf_device_free(struct hid_device *hdev)
+{
+	cleanup_srcu_struct(&hdev->bpf.srcu);
+}
+EXPORT_SYMBOL_GPL(hid_bpf_device_free);
+
 static int __init hid_bpf_init(void)
 {
 	int err;
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index c90b689..f3bbe11 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -197,10 +197,13 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 	if (IS_ERR(hdev))
 		return PTR_ERR(hdev);

-	ops->hdev = hdev;
-
 	mutex_lock(&hdev->bpf.prog_list_lock);

+	if (hdev->bpf.destroyed) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+
 	count = list_count_nodes(&hdev->bpf.prog_list);
 	if (count >= HID_BPF_MAX_PROGS_PER_DEV) {
 		err = -E2BIG;
@@ -222,6 +225,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 			goto out_unlock;
 	}

+	ops->hdev = hdev;
 	if (ops->flags & BPF_F_BEFORE)
 		list_add_rcu(&ops->list, &hdev->bpf.prog_list);
 	else
@@ -324,6 +328,8 @@ void __hid_bpf_ops_destroy_device(struct hid_device *hdev)
 	int count = 0;

 	mutex_lock(&hdev->bpf.prog_list_lock);
+	/* mark the device as destroyed in bpf so we don't reattach it */
+	hdev->bpf.destroyed = true;
 	list_for_each_entry(e, &hdev->bpf.prog_list, list) {
 		e->hdev = NULL;
 		count++;
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b4fd482..827a0ee 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -768,6 +768,7 @@ void hiddev_free(struct kref *ref)

 	hid_close_report(hid);
 	hid_free_bpf_rdesc(hid);
+	hid_bpf_device_free(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 19fffa4..0db7f67 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -213,6 +213,7 @@ int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
 int hid_bpf_device_init(struct hid_device *hid);
+void hid_bpf_device_free(struct hid_device *hid);
 const u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned int *size);
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
@@ -232,6 +233,7 @@ static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
 static inline int hid_bpf_device_init(struct hid_device *hid) { return 0; }
+static inline void hid_bpf_device_free(struct hid_device *hid) {}
 static inline const u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc,
 						 unsigned int *size) { return rdesc; }


pw-bot: cr
