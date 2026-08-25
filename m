Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD23F1676
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654829; cv=none; b=rx3dxfU4mYRVzexSHAn0dR7aUCy4kAL4ATfLEx6E9sMv8qivF5fvKX8SLlDbX03sm6Ms1uUNDJh7svarm+f7R86piFNSpapPWmW42DidsmXKa9DRiLve28pLtrCkm7MDSJzpQkoh/ns3H7mxz6DZFzOMp4bwEHIGxbuSsCcK0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654829; c=relaxed/simple;
	bh=KoWnSXBGaCj0jbCTvpHVOuxUQJsRstO2RferBywnX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chBO1g4AyJIoF+uG06j6IoG52FIEoYyURxMPbMR5TCiIeJlQBlucsr6YDQTgw4nl79LQlm11WhBPJOhYCSwxDVrPA17q+6z6pZCNwK/qGhYIqIYpH+Wrc1R+xkeiSMrFgvlhb5CPYLigq5jAMJ+9/mUfBJtybGZtw/J6tqA8M5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/AbB6nz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/AbB6nz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce98cb8165so6380475ad.1
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654827; x=1788259627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=r/AbB6nzyVDv4MhKtw7UNa0FCSddWRptTcq7tPC0JPyFORgaqMlxOuUzeyvSlDH3bp
         I7YiUXRZ0fenXogObzQLn1N+0kS6QCNamAXtDNPFN3Q0Jf8+cT1JTv3cA4n73rEqzsya
         NqjTdGPSysaxccPbY7nXiYHYcRWqjZtD2TrmDrRA+8o7nsqqkpsX73ap0a1mV1zdowaC
         daa+6P0NE838PQzOOLCacXKFyCygteN/s8luIxKsG4oAeVg+BcaEPwmzPZ6ayO0eDAmq
         OmeCFs1jQfTFgROtu8KNzU7Yd66GMFooejFtnAIhpmLtBzJ3Ri2UcINt+K/2w9NUkOxE
         082Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654827; x=1788259627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=Dce73S1IXmPE55Qq5CI7OmujkB3OE38Ly8tFlJETKwQJp8tqlsItcChs8jUeOrGjHo
         ELM8hYLYAfmSNQdj3I8jfYxScJWwe9RfMRMIF2uacres5P/KnE6oeWvZ+5FuMVkOHwtH
         uKGtpVtovmssVELjI1EQBD0y6EByXE7kB0/Z0pqG3/4aejExCsMTMjAE4y+n/lD0A1Tr
         zwnGtaQ1gxE3nnXDIzxFy8rDS8tj9Qer/rm67HtVuHNW0SI4WY7wbDNPs5bxpTuvUGOO
         rtdCSMtXiV/dfepdblahCIqFmQLnF1tnnruZk8axRZlULx2JY2bMPl2Sl1U9e3HZ0kA0
         9cJg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5yI8tYqR/pOkxusBwcIUDrO3G52nmEGikxw2at+WEgXoM12tC9oB+NKZKtVv5RFqhz3xafca/57uj9w==@vger.kernel.org
X-Gm-Message-State: AFuF++namHY9TWp2gnpJBkehimfiQZk2/NeHPvHJ7UVkLBfqW88E9cPB
	lySWdSQPVi3BHHfrbuYTibA4wBaJpn+MuxrWY6VfBVaLBJd6GcEz5vI8
X-Gm-Gg: AR+sD13zi716ZsJqTFkXhh1pNYpgDwF6e7oVsRlM8n2JqV5fEvBynQ+fK0mSeS9yL2n
	jS4h9EVzELjbCe2DbUu2dIyR1D5o7NeI/qsXiuPDdgJRAzLyQDF6QEDv5y8HMnfhYXdRlLlarMY
	qZcRcp59dEWjCPuzEIRt+bVjZYBRewysRecpIpdHLYrhWMSxZv3dcTGJ1IZJhBue1T7dcwZT7/j
	fkUY/Q02gPFHKRkNiJx8UZ6R7DswTZgvFmWnQiFGxYauz1lSwzFmpB8CUu3OfgnlVwMv+foSSVY
	lQq1iNFnkFDeA1vbzjgSxXgFjUmWIlNf3fgjtyilqBmMOP5MXRa80Pol7TfhZLh4ZWVbZrsdZIb
	oo/FUUa38k2ep8HyDOf58pmTOS6+gtjIAcg57P5tQx84AJn7j6znuPS/bf9DsxSQVh5g/3iy/BS
	eblfKtqZXY8RvDVtv7cvR+Rfqg8+BD4gRMB5tIJwKm3Yen2vCGvNEz2Y71iqMYrZnTLOfDmnXke
	xhpDs6Q4TxXSecNq40ak4r5HgaB6cNDjsIvQNfYoUtjTtrOaSmcj3V+J9hgLMh/dizzjg+VV//T
	GkMEtb/haee2jrDPzrL6SxVp
X-Received: by 2002:a17:903:19cd:b0:2c9:d277:2cdb with SMTP id d9443c01a7336-2d6dcab5925mr73666195ad.9.1787654827563;
        Tue, 25 Aug 2026 03:47:07 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6eee850b7sm4561755ad.3.2026.08.25.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:47:07 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Tue, 25 Aug 2026 18:46:59 +0800
Message-ID: <20260825104659.16251-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-3-98lawweijie@gmail.com>
References: <20260825061027.105062-3-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by the v4 series:
https://lore.kernel.org/linux-input/20260825103123.12216-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing these bugs and I should have
acknowledged that in the earlier postings.  Neither diff is changed.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
