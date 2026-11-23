Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394590;
	b=FJfd87Eo7pI2W81ZjqcbppS6HbRXPqnmG2rtKWSdFsZvjFIhrCDA5b5ZXdZ1+L/AajpF
	 yXiTjWhN/Ggh+rvlh2hePM2fM/q+hDLknbqw03dTMsVQylsThlorZKAwN6wQrWANG9/J0
	 7gM8mT9rzoDZaYA6aISK1oj/ESP54l6x3h2I4kbZ+feg1siDXqtWfBJ+4LC5GnA4CIzZu
	 HfHHDUDZiT+T5p3TUpfj4O2oDdbkE4sRCkPpcszwMLo0xICusu8O0Fh5iLrusCC7kcjjY
	 HoGiQ6i4S0EJbwjHg6m2RRxLAIPrOTilQHGP4fKjiDoW+vMnOkaPKqfZRNXbpxbKssA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jTgPktzzCX0U6Xgk6gq7x9JrADSU8d0FHm8FeZ3xBtE=;
	b=1klU5nf8HnWdBKkDumzCEyEt6skIKm+1xGVyoGMCX60RK4HkbaGfgSWbBA46YZqyDGGH
	 XB7MP35ZZP5D4HFfC7gRygw43ClFcr/ugAY1Ml2tdzwfd7e/tsWK+ugpG13KOyWAZ0V3X
	 Z+E9SLCYg5ZrUwtHX6eZA1kxcg5xJQMp/E0i4OQcGV6bCvouEgiavpMU/WrCqNAV+elvr
	 pcXBAXCPQfJCCcw6NC6XlOAEXQ7xWAIyr3S0n3OWDiHtqXKxSYCrn6PtNECRD3zjls+S3
	 AKYa2iEuN7TVUSS6KOeglmKTg0rrC6uiJMMsN31WxBlq9wgkX7sBwpTQrCtqOIqU72g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgSw82MQ;
	arc=none smtp.remote-ip=74.125.227.7
Received: from mail-vs2-f7.google.com (mail-vs2-f7.google.com [74.125.227.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D44606A330
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 00:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D44606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgSw82MQ
Received: by mail-vs2-f7.google.com with SMTP id ada2fe7eead31-7d2ca792b3cso3426773137.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394589; x=1795999389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTgPktzzCX0U6Xgk6gq7x9JrADSU8d0FHm8FeZ3xBtE=;
        b=dgSw82MQQw+s4AzQb47S5922e/wvGBIQLOvJTThY3Waxbxch9PRSayC8gZd+MGs2bC
         mrEAWujfAS11BxDSa+iZO0R97HKmQD0SqJ22E7ShLupHAQtW3F79J5u8v/Xn5mgRUNqC
         eceFWPv+Wk51erIkdEBVb8/i8V6K0KWrOA1ZVUeE392XDoGbnxTjXuzskps8sPfdGW7z
         J+UtybIvdHRcimMQfGoQioKR/rC66z7YU7zGa3kajslfTIiDOZp7hzdAWLAMyysRBZVF
         9TgUW5U4jbG75Tsxr0cFSUflmSZg8fJBHt3SK4dWRAw0/9ORuSw4mPuJZRhH/KqaUpMj
         nxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394589; x=1795999389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTgPktzzCX0U6Xgk6gq7x9JrADSU8d0FHm8FeZ3xBtE=;
        b=0GokODpZBesUH+UjQJ4lbSemrTeW2lerPasIs8lw1esVkM9HLGQsujnLQGVEMpBjIf
         W4nJ6MTPJNxySvhm5A4Qg0rjb01QvzIsz7OFN+DtNKHLSDGoWc3ZvgJkfHh1A5KD3eXb
         MvMyR0SMZZEBfR5xfnjno0Bs1XZn52bhaUCJUY7a956StPUzJduqdcwkxbPeL8XgAZ14
         3RAxuafdEPeQxDujgA2cdkgY7VtdDVeE9Zxo/vd2pc/m/bgPWEF/KaMvRlYDVEh5raYj
         2rEGO8zG45/4VZtxxzy4+5Q+lgkhaNoV/lstI1AfcDWxXSoTBtjoSYhSA1egfdMW8zSa
         qxLw==
X-Forwarded-Encrypted: i=1; AL+hErEvqHPxt/Jm7dyFrgnyywuI7e3705jvpU5p9LJz0LDc2ooI2k0PvhmUOSPOoh/UDvjfIGypIU1XU+BnmQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hSFKJppIS1rYPsl2++fqggkshWelIMi2IhBQLvwZWqgcZOjYu
	1ahfkc5N9N8/BUvju3CMO6JTyEg/7T1i1ZIZx5AhPoeLhoY+5Cmjt9K3mroP0pXMJxM=
X-Gm-Gg: AZFdTZdwW0f5MeoEnO5O9q1s+wL0je1Wdp6xFpf4LWVKLcDjxSODgG1Awf6AqhZqSYO
	wBkmGIxokpgQRfrdSqN73Lu3M8XIOz3CQGh8L+D/SByQAQzUVqfBExDm9dVsqmV+8QONklfWHIi
	jHlIDQKfOVKiQdo2JE9LTqAYS1ifw1RsssMzFql913+OTbZO2YNbzY+01ujFON7GYvHeMrRTzdU
	WXijrNVq4KCgvPwBHqhmhZqrEk4e1m9VUx0JOYZAUMq05iN8VEV5GBejcS2NPLSkeXEjS/6HVeq
	1IuOk+CK0c0DZVp09g4CmpW/x7I50F7rsNkwTJhoJZTBe0yyTlfDzAPlnxjVt1HYK1t2SmMD/5t
	ERK2fO5r5qwOM3hbbcpF73UE1gjvQk3/bRE0t2BzgpmOA97EAOrgGdZg141Zl95GJ/f6ZYi7TP9
	2lnUhlANQ6jKtQjZ9HDP+ekWGfyJltbO3ub4ajnlWbFygnITQA3M49H5ftSIAkvLYVxMREYbRGT
	3W7ilWRqWzRdrBLzlg2RI8czvCzFYWrCEjfkPacF4AOJxdvuZPmlYWifOkJEgaiAezHnPjuyCxL
	Yd9YclGz99aSBjQXIvJf5fy+X3fo7fcv1g8hbA4h
X-Received: by 2002:a05:6122:792:b0:5d1:dd67:3a02 with SMTP id 71dfb90a1353d-5ee8aed042bmr4861203e0c.10.1795394588676;
        Sun, 22 Nov 2026 16:43:08 -0800 (PST)
Received: from linuxmint.. ([2802:8010:9a19:ab01:aa4d:752a:473f:6f2b])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm9124221e0c.4.2026.11.22.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 16:43:08 -0800 (PST)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: wacom: replace sprintf calls with safer alternatives in wacom_sys.c
Date: Sun, 22 Nov 2026 21:43:04 -0300
Message-ID: <20261123004304.60693-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108012327.89115-1-nehuenlian.kernel@gmail.com>
References: <20261108012327.89115-1-nehuenlian.kernel@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason,

Just wanted to follow up on my previous suggestion regarding the error
handling when using snprintf() or implementing scnprintf() directly. Did
you get a chance to consider it?
If you prefer a different approach or need more information from my side,
please let me know.

Thanks,
Nehuen 
