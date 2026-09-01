Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A333263B
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267997; cv=none; b=Ack5TmnaxwVf5P6oZZLqZt80Cnz1YzugHvk/mITrG7XuuLEyfFsjDlFT8F5LLYQS2I62BXsL7Jfipr+pF6qKS/CDDBfcpiUxVuuZDR81lH/wOKNJVHj2eYyAg2KKe+C0ERBd2HPCgsLdUiYn3Ort8ndiMQqcU9Ik+eVqUw49ze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267997; c=relaxed/simple;
	bh=+aSS3GsUC+5ykoHOso9YQs/0VWovAtIdiffXxIc9lCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sr1VxHxd7Etb/uNbPpYOx66Z1kwu/crIcdPoPjBwv6bpjcHYjcwI/2j20+y3LpwVY32sZk5I3DgIijUTCK/7tHxY9EguForwhTP6S3PTTLq/4CgKVhwTSkMb5pF9XRXv5jHzI3FZ1oKs4S0U2xrLn8hENkyfTHIvXu4fOWAvYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLliAHWA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLliAHWA"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-861a2ae9c51so7283627b3.0
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267995; x=1788872795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/VKJC3MqZBrocLkf3UenbeidJdbk9BN7cs7RjfXB2Q=;
        b=bLliAHWAROTalquPY8T8YzaXupd8fBk+hx/8ptRKzbN8E5Ss8rUlx4MEROXzn0cPMT
         H+yBc3Q9QGFpC6GQdpV8MdWfEljWDP1bpWRClnijKlP7FwugWjzRMPTQZAfbVhlDSrHR
         I6MzyH24FCTFf1vnflWPiKlDaSdLjipH37euz0OhnxxwvFJt8sX9KIiGTPXO2/vOo9w8
         tgEOcz6Fp51Xa86k7BQtx3n2w9uaqvx3d/YvfhrKQe3q9lD68jen4f1mu7Tq6XFIPEAo
         u6ZNI9FYkvtYOXzB7Pr0SUz7FCxIiK3yZKW8UCnSItNqqG6NUBvyicHUcaX1Cu5f9zS6
         rTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267995; x=1788872795;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/VKJC3MqZBrocLkf3UenbeidJdbk9BN7cs7RjfXB2Q=;
        b=bdUrp8wmmyxN/f9Shb1WdKoFak/2FEtI0yDGE+3F5qA7VpBmHz4cAATwiskR1Ue7F6
         mZ+coxQLrY3OZ6BYvuedzk/SPO7PuS/lxamF2ej/5l6qh8Iucd12sa4R4bb8SKt224hq
         WeVbTIjzJATbBSlvR9TbzCjquHG25+CMHSIhu9zZexswSVrY8GYCQQYxM6oTfCbA746K
         uuK6bSvPJh16+2oaGSttB/gylSyLD9tK4OsMVQOXw42rzOUiEUkXLiIIx6/cRt4tXeDr
         nIAO8SHyDnC1UmSldtqHTZhy/LFQi/MyLhZdv9B7DmCOkqrxO/D4oW0vVgvxhDoz9Ldn
         dF9g==
X-Gm-Message-State: AFuF++kffpEJ21kXVzlDHjuvtxRzDxXDWu2iLWkM4H/pb+YOh19CiGsq
	1MtVrNunJeDCdXUY8TBM/8vugcVvF4fivTqPOZpfPuXNJph1x3NzPmlC
X-Gm-Gg: AYBFou2DM7A77T6cTSnTjrH61mXRuWhNZDol45/gNsFiVxzEWPy+W/wIZSI9avFf70f
	K6jL6za7bKIJTQ0xq5VcMU4s2gjTndBfTC0Bcl0k4zdMMp/Zz7J7RsdevENqNJ6Lmgwn9gSMY2h
	cyuvf0wSsBB2PyUlnxNVKedxeGc0gMSYS5MKdyi2kxxWnOtkyyCHIsqYWgcbw1wJgHUmq7q9V/H
	MmxJbbqNvDVB2U5/F8XgOi5gZdDWycxE+XUU/yq9LqecnyicD47PNs23IcZqEkSrCAhvMLvSGsh
	Co7NtoBPDi1bY+2RoKKBwE+DZsEr9sQv8ZbnuPFjmh0rZVWqhW2KRS/KWuKV7O0wZi8S47TpZre
	hhgcSbjmOGsOurM0+w1/ZmM/UzqeDe+RXIs4/D+VaZfLmEURNhj3djOL+tsD5lUGVbn98u9mLTT
	e0x6qajlKblhgbs1P8r28WV3sO6aDFrjZU4AYWuOriepS/ysE+Df5jubYHkjAYdhf7
X-Received: by 2002:a05:690c:f:b0:866:4769:d60d with SMTP id 00721157ae682-86647793634mr55746487b3.22.1788267994609;
        Tue, 01 Sep 2026 06:06:34 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1cd5bsm73290547b3.17.2026.09.01.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:06:34 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 0/2] Input: fix two kernel stack disclosures via ioctl
Date: Tue,  1 Sep 2026 10:06:26 -0300
Message-ID: <20260901130629.24078-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two places in the input layer copy a user supplied, possibly short
buffer into an uninitialized on-stack structure and then keep the whole
structure, including the part that was never written. In both cases the
stale stack bytes can be read back from userspace.

Patch 1: EVIOCSABS copies min(_IOC_SIZE(cmd), sizeof(struct
input_absinfo)) bytes into an uninitialized struct and stores the result
in dev->absinfo[]. EVIOCGABS returns it. Only the resolution field is
currently cleared for short sizes.

Patch 2: the compat path of input_ff_effect_from_user() aliases the
native struct ff_effect with the smaller struct ff_effect_compat and
copies only the compat sized prefix, leaving the tail untouched.
input_ff_upload() stores the full structure, which a uinput based force
feedback daemon can read back via UI_BEGIN_FF_UPLOAD.

Both are fixed by zeroing the structure before the copy. The patches are
independent of each other.

Compile tested on x86_64 with CONFIG_INPUT_EVDEV, CONFIG_INPUT_UINPUT
and CONFIG_IA32_EMULATION enabled.

Iván Ezequiel Rodriguez (2):
  Input: evdev: zero absinfo before partial copy in EVIOCSABS
  Input: zero ff_effect before compat copy in input_ff_effect_from_user

 drivers/input/evdev.c        | 2 ++
 drivers/input/input-compat.c | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.43.0

