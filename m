Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BB1A3AB0
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965471; cv=none; b=LvJ20fEeNNIx5E45kc8ump/KSPlfcXLQlRPq3V1yFEqgdR327YqWX51pdgHpCeUT0eiXsKWZfajw45RlSUfGIgcAwwg3/yjGJameU6FXaGrB1NSE0ctsvI5fYaESTUKLM12+FCIJboJMaU0/2+xhEtnTNiy6m0itmpUfEuQfjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965471; c=relaxed/simple;
	bh=8YWpV4BxrKzVyIl/iwj/YMPjck27je3e2lc5dcgDYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoX+HkgKQjoTVbpScOWnXSPR5mj8hDH4Gt2Da6On70p+FtV8D/ZSaXCG10gd6JgZ9Pp4J6FrdnVgM0nt4G6T5I+iwQQ2T4Llkcjs7Z66DKnsr4/kmf7XSjJTZhV/m+FIAtL86M+fEhqKNA+OHIgofnA60n859D2ebBa417Q/1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6I+F1f4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6I+F1f4"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1065740a12.2
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787965470; x=1788570270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=whJWdgZLbjtRSnzZmPCdoj842hOmWmmPzuhg02zkVIw=;
        b=X6I+F1f4Y1yuquyP9TKTplvq14zi0U7Xcf/4iFkEw05pOLcGh64YQCKIKxBBmHVUA0
         pUjMhPGmlLkzqdr/aGrNT4OpvXCxK6RQLRmaiz/BOBPjdr9dEUUIVEN9ZAcU/rZ4UNep
         eroO57JaIaFo6l30iYkIg4iIvU+ti9J4kYIRHGUibMT898OzYHUeLfYs+NCb+08jXhzK
         M02joZsnhI9zfniE5mOQWfwdpogxo+rAGZ2pAlFA+gp9qIJGC4qRT5qgjho3v76xxDkQ
         pUk4ywZCB8IUE3k/RsV7pIS7G3NVOn+xJoeuheLyYpGa407Xk5jfEUYTzvyaERMY4sKl
         uxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965470; x=1788570270;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=whJWdgZLbjtRSnzZmPCdoj842hOmWmmPzuhg02zkVIw=;
        b=P2oV7UqdFTmpOHVOX1TE2jiG5jsbygTAeclmEm8Pu7M0nG5NQFbrob+vaKfQ6t0dRr
         0YYZz80KfOXlhJ9n7fnCaXjGkO23yQlBonTC7P1/hr6sJgzJrfalghPbddIbCZQIAZD7
         f0NuPCzWcedfnN1vLz4M11UcwkB4+1XHk2Xu3jwibjH6kXboWi5SY07qZ6R6t+xGcyOh
         mgoOCm6Y8Nlj1EgKsUUsveNm5BgyR9xUhTxi9r5G48v9tPkcgsupneFZonsdLCF8c8qV
         lg86ElDVL+CoDhJ+HOCE/yC2ZtGXh7cpv0Lc8sWEUEvZfcjF39QTgGZDtIew7C/6riCT
         yqlA==
X-Forwarded-Encrypted: i=1; AKwUvBwbxaFRBEOmYcmHl21/CusvrsJoegoPFgonivVOtSsfgjHqKndAMfrDNaPI3l6rtgcRY48+7OMpFSv0Og==@vger.kernel.org
X-Gm-Message-State: AFuF++mS9lPp2jyPqe4GrCoV/amPiGOea4S1+PkC07STJVWyNbEI0ExI
	GzHGQ5GZ6QMDMlzvHCxxVDc8qGCU252/DKwZH629C+4mT7CoJQDf6aDn
X-Gm-Gg: AYBFou2JuD68FlamP3nTFBGJzAzXKM+LRLnT3XzvrOL/RmIkLXLzmhTH3oY6hTK3XlU
	9/EzGKPLaThNpnFYfbymHtonrjCI/BckoqqDiYJBB5+BcwObuSabK6hUBMs5bd2aBpoZbS4p5jB
	8Arsg6OT/I3dMtWWPtdthDG745OyFod/D/QG1FG/68+pwrbuDItHAJ/wwjEArbvSo9ltELQDtAU
	guwhJYA0h+Xc8mVVw8RcVEsE0A4bqL3srBNesbDteRDJmwfWM3QH/A762NHlAlKlwPFXGBOlaKt
	6ZzDkJ5ijGn7mWFPCmIsTV5ZkWrqOnAvPnv8Wl/fAvaApmVDFo+BQJE/Lmy6SQaK9j86ARwDfAS
	8vEO5S7txgMAFcb+6QUCETguM2Tg5nZkDyOu2bxbG5kVaB+ljjon1r5pb9ivxq384tByC1eJvbY
	lLaja4DWxX0/FBaW6pMucz/J3N8JDojHkldsHVV64BMgfyd3UVcx5KhEH95/28XX5IGRt1iw7xN
	kJb5T6qzAkeFrSaG0QTyxgVd8F58L6UdbmXtm+cbr61EfEzL16WfdOpOkvZD0rUPFwANhSX77wu
	sZ+eH0QDKMVW4QRhqQuDlTOv
X-Received: by 2002:a17:90b:3ec7:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-396d1041324mr16954197a91.16.1787965469892;
        Fri, 28 Aug 2026 18:04:29 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186803asm9247989a91.11.2026.08.28.18.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 18:04:29 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Sat, 29 Aug 2026 09:04:09 +0800
Message-ID: <20260829010411.7874-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
References: <20260825103104.12090-1-98lawweijie@gmail.com> <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 12:02 PM Jason Gerecke <killertofu@gmail.com> wrote:
> I would appreciate an update to this patch with less confusing wording.

Reworded in v3:
https://lore.kernel.org/all/20260828033323.82958-1-98lawweijie@gmail.com/

> I don't believe there is any situation where maxusage could be less
> than report_count since it is initialized as max(usage_index,
> report_count).

You are right. Thanks for the correction.

> We would also *want* to read fields beyond the last-declared usage

Agreed; the submitted v3 keeps that, and the changelog 
notes the 6.2.2.8 reuse rule.

> Given the above, I propose simply making the loop condition " j <
> field->report_count". Thoughts?

That is v3, with Suggested-by: you.  Retested on v6.12.105 with a
kprobe on hid_field_extract(): with your condition the 12288-usage /
Report Count 1 descriptor extracts nothing in the driver loop (the one
remaining call is the core's own in-bounds fetch) and trips no KASAN;
stock extracts at bit offset 98296 and does.

As a side note, I am also looking into a separate but related read in 
the same function based on Sashiko's review. I do not want to hold 
up this patch over it or speculate before I have it pinned down. 
If it turns out to be a real bug I will send it as its own patch.

Also my bad, I realised I had not replied to this thread addressing 
some things you have said, after submitting the v3 patch.

Wei Jie
