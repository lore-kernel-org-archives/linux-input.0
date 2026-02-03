Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAF34C815
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113386; cv=none; b=UlmH3G+K3oB34pSi6WwAsWYs8uAaAvS4WNWTMI7O9cXlczTEivC+AXGQfb9/SNgauAv+jN+vHeyAjCg9nXTbr7t5q9aU/PMnHefKygJx4WpDMjXylE1WnFv8QCn7DyFWg42bZyzvmcicpug0Ta8oW35+LT8JahAuuO5I+NByg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113386; c=relaxed/simple;
	bh=Avkd5uawzD+P96BD8QVvLdDr1iaqtLTQy1JmyFPxlmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZh6EU38nsLCpHH3//oglvDDuETJx+Upog/qaFf6O/v/udCzfOlDMdg+B4ukVAaPM3p8gvt3QzhGATvea7muc4iaL5FO76fXd1EkhXGMC7cKCCuFdZGNEGASoNy8j7rPqZEV5uxLo6gxJ8wNcmwhy4oHveXnPxehyqVLlV426+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdX1N6rO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdX1N6rO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09d981507so4938615ad.1
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113384; x=1770718184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttX84+X9hteT0QV4zhWLgsisrXh5PIQqyosrzt2r48I=;
        b=PdX1N6rOo0B8hmsKeoA49+GrPkL/MZTUODgbTLK8imXPgROwMxu8sRpR58J/NcLjAB
         MOZPYNUKsVDdkV5rReP9MqSQhVXqN1rpfNjzE/BiRAtqg/jCph3kacHba+NRC9toBxWL
         x+eJxRwOBuJaT1YnlEW5p3+woLBlxvVlv7ZmW45jvD92RG32CpxDJf/r/H5vnPtxx+1Z
         sFxhWPvkmeneIsJ9Ub92Nkpl2xQWfSOfjLaE2uS4aU6lTmCek2LIUas1lvEhQJht3YeU
         LrsRzH73X5YkQPiqvSawMlXm5w1jq/bHXMEraJNl+2Xl4ZSSr/1QZNU5/SOLxhMzEZSM
         kcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113384; x=1770718184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttX84+X9hteT0QV4zhWLgsisrXh5PIQqyosrzt2r48I=;
        b=Nwjce8i1IbrG+dX4ijL6unYHOhXYq1jAvjwoU8kIrhoMuOyoNskKKQic5DoTp0BTy0
         UF31U6pi04NYSLG/cbmzppfjiahTFfgSyb/IzJMwzo0+PlSYPWAUWltNhjZak9WuLSLe
         VurBp3aP/dqHnqLxTnU1uqWL+31vzSA0+TWFtx3gVhnmTOtl3q7RkjgJ0UXZZBdGGMef
         iClaVyYLuHVp/AC3oucQIprRru5PWXcfRV/Lz+uK4XLm6c10xAF57mzvE+C027MUJfPf
         /ydiVO0nBi/kDjQg4Zsf616owr9F9ZssrENv90C0OK4vzqyYhn+kPJ+l6kRQfvMs67sa
         PTKw==
X-Forwarded-Encrypted: i=1; AJvYcCVrtpmVSS1crV45aK3jG2k0lnI9aX6c+SFe1rEZ+E/5Cr9BGY9EtQTF94MaZtiuUe2sdY8Hla06OpHM6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvlvwHQwROEAhGfROxOt4oac+c29I/ZJ9Gq6AHCYK3N0AT4b8S
	VN0vhE/87hU37r0c3UOxeZv8efWem43bu0yZPgaYKC1ydpp1rh1ixRgW
X-Gm-Gg: AZuq6aKWl/jntqaHPJWuK5XvI/wSOpiVfl1AbFCvMyffxAA0DDCuv+5/DwsN78pRWci
	e7RC732v+w88d6546QUGN6NBnDgvHgRLGPT7+mxZKax3SVK66DqRunZ+Kpq5IllQlDh7+n4ZKOh
	fvnXfDPUmqFWQQBCKqaDhzSYGEpA2qZhwgFSFh4LnjmzlC+gvzHRLwVUFElA31N/oqa6/1dO0YE
	ppfvi3k2GIdbgvbzji38sGxORONZxslP8DsO5gkF3lD4RUzAQXLiKoHCuMmBdSNG651yiH3VJkH
	hskdHUp4FOG0dYjW6cfN2oZ1B+TcFbJgq+btS6wzH+EimNu+0fGJ9fWvBnyrXlr2p9DDD6mfNXw
	xW7LLZZaCv8+YWnW/h2lAYfl5geCRWCaT3az4LZ0qvqOc+mHzOwRlhZpJrc5QH8hePRXl4SsuDe
	xlAWIDw6kRWtMXpRolxX0/ieqCaw==
X-Received: by 2002:a17:902:e851:b0:298:639b:a64f with SMTP id d9443c01a7336-2a924595003mr27390035ad.6.1770113384045;
        Tue, 03 Feb 2026 02:09:44 -0800 (PST)
Received: from chandna.localdomain ([106.222.233.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4173a2sm176663725ad.30.2026.02.03.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:09:43 -0800 (PST)
Date: Tue, 3 Feb 2026 15:39:20 +0530
From: Sahil Chandna <chandna.sahil@gmail.com>
To: syzbot <syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com>
Cc: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] WARNING in asus_remove
Message-ID: <aYHJUJzHlkBD_Nza@chandna.localdomain>
References: <697baa8f.a70a0220.9914.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <697baa8f.a70a0220.9914.001f.GAE@google.com>

#syz test
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -147,6 +147,7 @@ struct asus_drvdata {
  	unsigned long battery_next_query;
  	struct work_struct fn_lock_sync_work;
  	bool fn_lock;
+	struct mutex lock;
  };
  
  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -960,8 +961,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
  	}
  
  	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
-		drvdata->fn_lock = true;
+		mutex_lock(&drvdata->lock);
  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
+		drvdata->fn_lock = true;
+		mutex_unlock(&drvdata->lock);
  		asus_kbd_set_fn_lock(hdev, true);
  	}
  
@@ -1258,6 +1261,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
  		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
  
  	drvdata->hdev = hdev;
+	mutex_init(&drvdata->lock);
  
  	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
  		ret = asus_battery_probe(hdev);
@@ -1343,8 +1347,10 @@ static void asus_remove(struct hid_device *hdev)
  		cancel_work_sync(&drvdata->kbd_backlight->work);
  	}
  
-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
+	mutex_lock(&drvdata->lock);
+	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
  		cancel_work_sync(&drvdata->fn_lock_sync_work);
+	mutex_unlock(&drvdata->lock);
  
  	hid_hw_stop(hdev);
  }
-- 
