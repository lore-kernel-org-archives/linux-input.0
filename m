Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487372749C1
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243826; cv=none; b=PspfEaBIDNWm+kQZiz1NkmIeng7+bKSnDbHVOIhEKZQ0eEfZ/bzzUEj7UqELgE6FzQuGqXLGwdJQA/tVaUdEWH5ScOEZi3QucEKP45ewsjTUJOpL2Nsxmm1tTQcgy4eTSNgGvtm7PJbVJjhGWbDjQPOeHBy4dwigkfFA2/D1fm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243826; c=relaxed/simple;
	bh=6SSKXQexS1yqS8sN26FO83aeNAo9obWv36BeneynOeM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqYbmBcP4xG9rmIYf62l0/VOlvD29PrPLXK/nQ7QoTkhZdkBF2Ys9Vvn43H0x0ScDiRvpRMq79NQtaHBssVE1SGNhWVmCqkrmW8fDGelcVPH8IWDtyapp437no9KKWm3EjUeDDqeo7XuQ4Vxm8Ct+R9R0UoeK6igQ/uINkbxwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=devZmknZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="devZmknZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so445300a91.1
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 04:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771243823; x=1771848623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GvC/7lwViA/LhXh3QnEjql7Fe/Y/aDrac39++6dSLQ=;
        b=devZmknZ1jORQPbCqqhXRpCsH7wN2l3Ce2NSjVfiGqAUCuNbZ4ZlNM01aUtBuA3oX3
         qJLTBuCkBu1OJlj6TF3VmKeRhYQJ/Guf/HcLKTqGBCtnX35ur6GWLIM67RO3V2XyhkQd
         M3t+oDNIJN5dbtD+MEuoOOq0DnpNSnyULBlsssXdlSlu9lf+2GpTAIRWmk8AQms3A4zD
         C5Ru2BTVmkHr06+8S8NPjOWdAfU3jMNkZFGRp+ggosjJbXjdK1StxPDMBjp+YgetN2zl
         s1oENgOohct0tYLQIwPi9iVZsA9bhnkG7N5BvPjKyC0PySpT3an+al0pjdT/E1st0lwb
         WJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771243823; x=1771848623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1GvC/7lwViA/LhXh3QnEjql7Fe/Y/aDrac39++6dSLQ=;
        b=g0c2D9vBpVN3b+o9n1qkviHYOG0AkS2it7kezvDWi+h5W1uhqM06d7+zY8UupWQB+o
         Ooc7oogK3HVZbbXP75hWUKhyrfgcLV27DjL9AbI2pehvWHOTcGvWVLeLoJkPcHuRA35u
         uZBVns6ame8hIeLPYXi6CQfxbpVY4jPIACltZJNocFH2LlBNPF3cf82l4DRbF9P0Nhlj
         6HMilx2+EdkAlrNSkgTSqvY9+ZtwpbwXxiX8ASbb5ZW0q+ETmaBB/NE5pTDd9AQHSJO8
         sFXdyf/NuRJS36VizkuuanRCRAjAj8ktRkXVUPfhbxtLXQigEYPVNlh3OajVWaNBeMkm
         NbQA==
X-Forwarded-Encrypted: i=1; AJvYcCXc8IW2kAGz8RKLefHEhfzfnU5+aI8PuKPpksstCBE14igiHGE88pPXm/NoAQftIL0r/dwrPw6AeCmRcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2UTKigKX4MGPm3boD99rVlGENFB/0gb+JNDo5ZVX8Lg3Czth
	zBkCgotopx2fiSYAk66+Goz5EB3ek7+DtMbVxxIWBf7/X0zk7ADY5iVN
X-Gm-Gg: AZuq6aLFJK8RxUohcW74ypxYEyxWmUoEmIgw/W2UAJpI0k9rX7PCbKkRfDKJhyNnZVw
	7CISVfidd91f/ughkivkmG+zi+nOPbdr9WtB5kKf+4Lym7b58djKFpojXApKPxg/G8Qm/Ae/sQy
	j1T/Z5saOg6wY7qrY3jWSese7XZafYtBrJo607UiGDWew6yoypfhTTY89VsJBm58u9IibloKDA1
	CSc483VY55+esdnxjdcOdxzPLfQtYt6fZ6m37XMhbgCcWF5TRU3Npjpua3rxqCgN2Dxzc5WVeKc
	5h2qQNq4iwp+wMhI8PUnk9WntXh0EMjYoULf5eadmqf1W0zB9I80K4+s+OVmIMGS86k597hc08C
	aFtJeAFYi0lb0eMQawTAFuTYYDEP8fJXITJ4mUVm7o5tTNGrJUmpgWjxW2iacJ4psj0nJIGzGCX
	yiicBtu3CajTo9pwOVT9blycVosX0fxjoKSU7fwBc=
X-Received: by 2002:a17:90b:53cf:b0:354:7e46:4a8e with SMTP id 98e67ed59e1d1-357b50e2d6dmr7124766a91.7.1771243823383;
        Mon, 16 Feb 2026 04:10:23 -0800 (PST)
Received: from chandna.localdomain ([106.222.234.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a69ac09asm5573331a91.0.2026.02.16.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:10:22 -0800 (PST)
Date: Mon, 16 Feb 2026 17:40:17 +0530
From: Sahil Chandna <chandna.sahil@gmail.com>
To: jikos@kernel.org, bentiss@kernel.org, connorbelli2003@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v2] HID: asus: synchronize fn_lock_sync_work
 initialization and teardown
Message-ID: <aZMJKTHErGipzL0d@chandna.localdomain>
References: <20260204182029.278659-1-chandna.sahil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260204182029.278659-1-chandna.sahil@gmail.com>

On Wed, Feb 04, 2026 at 11:50:29PM +0530, Sahil Chandna wrote:
>Syzbot reported a workqueue warning where cancel_work_sync() was
>called on an uninitialized work_struct. Fix this by adding a mutex lock and
>initializing fn_lock_sync_work before marking fn_lock as enabled.
>This ensures cancel_work_sync() is only called for an initialized work.
>
>Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
>Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=13f8286fa2de04a7cd48
>Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
>---
>link to v1: https://lore.kernel.org/all/20260130155204.96831-1-chandna.sahil@gmail.com/
>changes since v1:
>- Add mutex locking between init_work and cancel_work.
>
>Testing:
>- Reproduced bug on local setup and original syz reproducer.
>- Tested with fix and original C reproducer, issue is not reproduced
>locally.
>---
> drivers/hid/hid-asus.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>index 1b9793f7c07e..2d6b6e363bde 100644
>--- a/drivers/hid/hid-asus.c
>+++ b/drivers/hid/hid-asus.c
>@@ -147,6 +147,7 @@ struct asus_drvdata {
> 	unsigned long battery_next_query;
> 	struct work_struct fn_lock_sync_work;
> 	bool fn_lock;
>+	struct mutex lock;
> };
>
> static int asus_report_battery(struct asus_drvdata *, u8 *, int);
>@@ -960,8 +961,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
> 	}
>
> 	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
>-		drvdata->fn_lock = true;
>+		mutex_lock(&drvdata->lock);
> 		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>+		drvdata->fn_lock = true;
>+		mutex_unlock(&drvdata->lock);
> 		asus_kbd_set_fn_lock(hdev, true);
> 	}
>
>@@ -1258,6 +1261,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> 		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
>
> 	drvdata->hdev = hdev;
>+	mutex_init(&drvdata->lock);
>
> 	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
> 		ret = asus_battery_probe(hdev);
>@@ -1343,8 +1347,10 @@ static void asus_remove(struct hid_device *hdev)
> 		cancel_work_sync(&drvdata->kbd_backlight->work);
> 	}
>
>-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>+	mutex_lock(&drvdata->lock);
>+	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
> 		cancel_work_sync(&drvdata->fn_lock_sync_work);
>+	mutex_unlock(&drvdata->lock);
>
> 	hid_hw_stop(hdev);
> }
>-- 
>2.50.1
>
Hi, 
just checking if there is any feedback regarding this patch.

regards,
Sahil
