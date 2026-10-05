Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1F35F5E5
	for <linux-input@vger.kernel.org>; Mon,  5 Oct 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186562; cv=pass; b=AquO5X1gFDVbYq2T8IoWXywMQCridKImlvvstXWUgmzXSGAsoKiCP2neHUvNXSQuoZIQjWGio3RmWGxk2dXz9p7uQOVuVKn+XoG+g6n93KIWkwLgRr+d84YLCrXMGYm8kwVKOlaAy6Y/OJKdWfo8A8Z8Sg4vhYN8x1w0dI/2KnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186562; c=relaxed/simple;
	bh=VxvVXdBb0Q9qM0U9L+sOJleMerm+22DQyt5XrTMDHw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPpJuxWoRaU6Wochxmf9Yeh30MRO8n7va4Z2gXMmZktx3IfSuhRuHEKOxy+xwFpXei/V2JfdYuEgXMT9IAXNg+qHwz42AVedtCRHi5eGqzJvHYJ8fpzpb6lK5neSIs6jp0q+NDWOQxGeKHkwxYvDybFX01RPo69Uv0K+l6gvKOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvDVNAMm; arc=pass smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvDVNAMm"
Received: by mail-vs2-f36.google.com with SMTP id 71dfb90a1353d-5d4ea61c057so929897e0c.0
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2026 00:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791186560; cv=none;
        d=google.com; s=arc-20260327;
        b=L0+CZ056XQRimvVk6uv/o5+N2zhRF7Tp91FKIIuhCbNNa38NBxOJTtAPMFKSs7uedc
         IkNZ9XMTV4/EfPfyGTTJfZZLs6ts37FZ/eLFFkPmoWg0vcXta6hTI4vjkRxtUzd0APJ1
         UjxvovK//PxPjrB1kDJB+hiOeV16Mu/jGGm4bDOLPVP5pqD9KKEkKqj7OUO/zx537P35
         MF7iGNOJ31PGqLAaEFaHnnfjvwh/CQ1mADRWzuAHzUpDmueRBwCZU3jDY0r71HL4Q/gb
         Xto3NiII229bLuqgZO3matyDyjUR2PtE4xeTsn11AKbKXE7s/1T1uGvnLPZy49A9in9/
         kCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        fh=ftl42K5Xn1ReC3Na7Fmq0yAgYuVB8UCD7eLmPKqLJdc=;
        b=mR2NcqaLfxfqSeQq9FWQiR0EB1q0YrIwZHRJEchyXARyN090NxAoVyfdBIHkjfZX2Y
         SOOkzyPaOagt3ic0now7swcbXWzAOFy1clbd2S+ngP87i0hbKAgjwZ2VQbuGItvp3+BX
         4td+4CZ7jg9gY6zm5wgbYC0nFNFwu88nJEIuHL/95L9/bcpWCk6RcOJtmImLrOicn+wD
         qVrLjMDheh1JU+WEoaj0H6SbFucsQbw42doJMaAwJSJlfXq79bS6UWiKeUt/QkZ0BvcF
         4fzDl+KAqVQ49zld+GoWcJmzk50ZOxOjon1AXktAwMpdrtalxu7vV4O4yZcK4lclJkVL
         Huwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791186560; x=1791791360; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        b=MvDVNAMm5Apco/LvPRu7/v3PrX28fbFvPGHrYeh3nb4EEAWZSoC86rkKMlBN7cpi8j
         OMKIngMLReYrtGl6ni5G0c37L4QxvIYyILyg1wQc6h5qoEBbiHKuPx8ncQmOqjEoOH9D
         AwwgUko+Sn0lxZGsa73Yj1v1sWc1IMBB7G0n5vXlUsr6IdKxHjVvePgFC93+gdrIz4x/
         QB3i907RgwE8o2VYZHPGs7V71RK9yyprbbEwFPhbL1wch7RH2arqEnOUY1pJbrib7/5/
         mFeRYoNDefamPRdh4Mw8FxBmjM5DMjPAsp1x1JgsfFWPve06ZmK4AywF1vm4RXm5pGkn
         XzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791186560; x=1791791360;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        b=msm0Grm6IzymsFSUg9eh8LUJOs3BFrnPmGK8AXlH4OOAuokZF59DLk7uyt+MDfwmRg
         mVZGxYP3oyj3iCKlaw8rLFLMY0kwaNgZrW4JknhR6iCMw/QM48q72+G79R5JqmE6+/22
         lEfkYzb95jDRY2GnGTCi2NCl+PldHPMjSeqbx05mrLZ0OxOvtakQjnQ3J6rIjcGQrban
         OctXUKLYlskgAEM4SIojWQXUNUGqSNIuXdX/o5FzShCefzOMeecNHCL5/4F1AlIT5YiX
         zA7TGZ5sxmSFRc4bEFb2jwjSfGDr3vgv+FGGwOAGy6hDtWgH4NMbUXHKlaZa1CRv7MF6
         YDmA==
X-Forwarded-Encrypted: i=1; AKwUvBwEBKXbfHtcr/EiX61xP4PUmMmnsgqQpNlXgZ46z5Xoz+u/NPjj93gCa3TswHaTB5/qOpmIfY3vEetRlg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLMY2sg7z87dRpPRHKSleNcKOlztj/tFKySA3j3uSL2/UapsOKs
	L+8uXP3zqrVl0OvetncU7GTe0FZ0hiJncMi36mocNpRjA2Np7rZr1BWXhyjfIinjtqp3n6Fusmo
	pNgvefeG6vqC9iYpCBc8giISNSJrnnkw=
X-Gm-Gg: AYBFou3CO4ATCCCLAVG92JyKe1B+IwpSRaOr2KYhYYc/+mkReIf6Ey1IYLyAooJAaqq
	GKOQz3qXMIBNMiX5mBfugUIgIuMYlvFNohlqt40QhF+APLyzW4tqZ9BuFzs6DbByYWd3vP2qzm0
	haJrbq1MNAnynG4kbWpLv3bFY2PapIwnn/O/aqoJhSTYkU+kYg3BdXT3AoO5SmZozKbrhHdUCS0
	DL7rTkvsYPrgd5SIb489TXdud4Xfb15ZpJrflvGWAG/eR226RQk3a0DmwJCyeeQb0erh60+qUKa
	aBNdpSd5TWh61VPs7z/TfPTssJPEn6nJFN7LLcwJLw7Kc7+cvUbV/bOu3zkCuOa13g0qq6B+i3U
	GdGIgy6gA1SF1NlZSpcMHy726SN3ABexli9sy8VRmCUFYGDQAsd5t/IlxyD+R1ZJjrcnfpJOeyu
	V3YKfdCWlqTZdPHIvQ9iupSgbCVNd1mlfgkNU3w0ltCahPm1/neW2L1dc=
X-Received: by 2002:a05:6122:8715:b0:5d2:f636:7577 with SMTP id
 71dfb90a1353d-5dab041c44fmr2930910e0c.9.1791186560164; Mon, 05 Oct 2026
 00:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-a7ab598efbc5@gmail.com>
In-Reply-To: <20260930-b4-elan2514-irq-route-v1-1-a7ab598efbc5@gmail.com>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Mon, 5 Oct 2026 12:49:08 +0500
X-Gm-Features: AclHuK8DOWIEo0q05q6gq0-QkBnvI9dA5B05mEZp1IjaXwekuF5jwY5vqNmLm1k
Message-ID: <CADeB2Yob9aevFYWM6QaFLybHs+5Wqq4UqmJNNQ3Zbtnz48VEGw@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: iamwaqargulzar@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional data since posting: the same firmware bug and fix were
confirmed by other owners using an equivalent ACPI table override:

- OmniBook X Flip 16, board 8DA1, BIOS F.10, ELAN 04F3:43EF
- OmniBook 7 Flip 16-au0773cl, board 8DA0, BIOS F.08, ELAN 04F3:43EF
- a third 8DA1 unit (BIOS F.10, 04F3:43F5) shows the same ~620 IRQ/s
  storm

Correction to the commit message: 8DA0 is the HP OmniBook 7 Flip 16,
a sibling model, not a second board ID of the OmniBook X Flip 16. The
DMI match is correct as is; I will fix the wording in v2 if one is
needed.

Details: https://bugzilla.kernel.org/show_bug.cgi?id=220854

Thanks,
Waqar
