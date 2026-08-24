Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EA321457
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575116; cv=none; b=py1E4MucReaxZDLQAJSP9IYCd8aoD2RiLrcAyi1kItOhO5Q7kZCuzw7kbgIySOyxhlP1VaO0LVi5HouEW5EShl6DDdA1EcPOPXHBhD4vrIPh5G02r9kVGrmW7kvNsxwmcUAWzZloTaixkX8dpKmeEB+zi56Q1W5qYU+W5+WRGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575116; c=relaxed/simple;
	bh=8SXieS64rB24czgYz9k6iF4+Hn+8FHko7SGtPgmurAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu45B1qtbIQVut9WuEUsnN/PcbRpXc1lratJ5sCwVNaY/6XW++GiGojefD5rtq4CJRTy2Gmr8BYwVzUMLhG9+sGVy9LlQ2HwsEjCOnV30qzGuImKWBhcgXDN/J1h0hGK4OLmjKbEF66kj2c5RAJy5zDbsWrtMZG/y6YLSF9hN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq9ZG45a; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq9ZG45a"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b69cfc6dso3191224fac.3
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787575114; x=1788179914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZSSEV3fsCHMk2C/EdG9DdvXqKnsOxZXSr8k9DTxFw8=;
        b=lq9ZG45aQ+7XiGsn+nm2mgYZ7eWSCewRMiWeEcAiw6jlbrGGDRRNjQc7Tp2+yXh3cN
         6SzefUv2mnDacUM8KC3YQFmVWwD1F1iGkVKqu00Stw07yVIKs28F6LuYpGiu2jwX5CDx
         wl7uGH4nYgMmnPbl4KZnBtssiTlzOf351Ot3qiZpnmhLxaZNdx21CPZGam0WI0G7/rkh
         ri+RmB8rXjBHRsgimm6nIMHmvoJc42NuVtH3M+muYO7StKdF/PeTIdO7TN3BANEtKgLd
         6bKeHMAplMPYZAH+l2lDgu0NncOUcSkMKOEzpc8flvttoy8tzCGabLH/fxjXY5jU55Fi
         JU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575114; x=1788179914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZSSEV3fsCHMk2C/EdG9DdvXqKnsOxZXSr8k9DTxFw8=;
        b=rt3KI/VhBxlCQc3CORJRBb3jJfiOCUsx4eKc4EagAAO9+68mPbP5c3adfcKyY7u6wM
         Y0x96RPWgnoflcZnQlClbrwHD/HFmwdlmkwwciFVvzrEpxYbCXpIhFfCUXs9SGj3YeHg
         /1u/NMrigM50BntWKYF8RvkSv6htw5DhM8lsXuUOEKHn9wYHvo1G8BT3JlDUGCYrHLh0
         r2QdccheDrcQsR7Yba+9RcF9Mx7eSoL6dFAaMfslcziY/GBia7cYEuDkwbSXlbBcN2Jh
         w5/eW1qJc5XDyIkxa21fCGpLE3aHABU9WJ0Bm3b8gNazFFZuq490VjwgawNWc4GMAtyL
         EaCg==
X-Forwarded-Encrypted: i=1; AHgh+RpU2kJBjsY0/vblt/KadeWk7Mxz5Ku8SChgLxtcgWEYGmCQY1bodK5AWZipQd96VKar1cd3liOZ6UzTDw==@vger.kernel.org
X-Gm-Message-State: AFuF++n0CWA2+0iNjHGURl4bGPTomD67SMr+iL0Jsn2stIbdRGfpiWrU
	2R4B+p6YnYyGw/MaoB4VGMDYvCfxsVvDQ2jQfPtENpLfr2vh0jQH8VeT
X-Gm-Gg: AR+sD13iA61330sTltNJXi/NhBG03qCNOv22R+e6U6ezitk0HUw+GfYBo4P4RjmceUo
	rWrDhO9prmu/rrnwoykkNyzp0kNc2e2d5BrhaR4jPM/c6kJ6SA3HPl4WNHXW+IkckrOcspVuulC
	3mhrAf/RKjw5029WuhSfoleV0bATInbCB+8VLGSOmiF60mD0AbfPy6o/VGgK1Or+2WbUGYgLqoQ
	eqr2mqDD9TJMwl9oQ5pUd7vgwrBHj8d9CTWmvloMKJ68DyumYEGnLkaE8BB0gMU9cvmI3SBlOSA
	nZFpx+jxueuRC8ZkRr4xilfZWrFKdyIMcx43DQULZRkBRF1xAWtokIhpd8Axe6dIe57shIkQLJu
	9S2rIjw5J096dQSGgtKFxXfH0SC5gRRwnasH2Uc+uJA0LQkzEPEUZxWOEzYnAQ1PfXMQv8heSXj
	nNZYT6iFYODh/BrpjngtrqJlCBHslgbA6M/4z/EVZntMQZpLcs0vEkego3JZtfJu8JAGdK6PMKs
	oq7a35kLAwIYAq83KQ4jQMmz1J6gyNPBb/II+uYa/ekdhViNG7fjTF+KcNsbMfLqfXlG2lbeLj5
	mZj3Yf80cdX4HreH7CCrzgBk
X-Received: by 2002:a05:6820:55c6:20b0:6b1:55d0:6e69 with SMTP id 006d021491bc7-6b159334ee0mr17231528eaf.18.1787575114407;
        Mon, 24 Aug 2026 05:38:34 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fcb8e88sm4444352a34.27.2026.08.24.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:38:33 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: rmi: fix OOB access with undersized RMI reports
Date: Mon, 24 Aug 2026 20:38:29 +0800
Message-ID: <20260824123829.78659-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com>
References: <00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by v3:
https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/

Please do not apply this version.  It bails out of the read loop on a
zero-length reply without clearing RMI_READ_DATA_PENDING, and that flag
is what the wait at the top of the loop tests.  Leaving it set makes
every later wait_event_timeout() return immediately on the stale reply,
so the four remaining retries of that call -- and every subsequent
rmi_hid_read_block() -- fail instantly with -EIO without ever waiting
for the device again.  One zero-length reply from an otherwise honest
device is enough to kill the read path for the rest of the device's
life.

v3 clears the flag on that path.

Please mark this one superseded.

Thanks,
Wei Jie
