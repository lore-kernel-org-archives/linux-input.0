Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564503E2AD3
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914342; cv=none; b=fZUaCDKgw/8cXIJ6ldnlrdNekCyTYfrVMAUyeMcZgtADlbiHtIeJ7j5IF1rQUJcVTHvMkoruN19hoEPxKz2ediKBQiWZOVmcnHDhWFG71TAeI9C1pijuR8zuPmgGdZJvM3NU26/BahOS4t7Lw1iW720QHJLe+7sjL6K9eWgKip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914342; c=relaxed/simple;
	bh=4ZCH2KYsfOTUbtlKT2mLRczyTJUzzJTe96QufBuGP9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptTMNc/YtrAVt+vYtbv4xsg8/oK5b5KL915lNe8XvG2CIMNkgXSoAZLb73PCppkbLkf9OgsuUVDuOdPa3Q/4THR6GUQ7bbwyQJ6O58FqhW/knjOMRAjM5qwj0Urm+TG6mNryYu7MLQDkW1/wLKmUOFNdmoTaqy9cEatNME+0nt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hArl6Thr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hArl6Thr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1042044b3a.1
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914341; x=1786519141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZCH2KYsfOTUbtlKT2mLRczyTJUzzJTe96QufBuGP9Y=;
        b=hArl6ThrgeKLvwHjeBXfJRnHq+78uQbSiD42Onm3u/X+mVtVQtA45Ml8+fUZ0NoQwp
         67Z0Bo4Z3Ns4ia6+0S9lpPy4fE8bSy89h8s0+3DNbpUd/QqiedqnWnggmZ3d4Dtgid7F
         LkoWflAAO0tNM9nj1iTGJBfs2xLU2yPC5pYt1GGryj6jfehTbOn+8g37XVsa3Cbei6f1
         fXYf/eGiVKs/5uercv+MwAx1KWDXlCOf3d9fMCY/NBXzt8sRApsAAuZXGvZKhCDAhJtp
         NfQIjbyC2KYljPk6jHyvsUCFgN3Bcw8qiE74llHLbSjM7XWNcmOiUUWm/Ibmuv/MKbE4
         9F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914341; x=1786519141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZCH2KYsfOTUbtlKT2mLRczyTJUzzJTe96QufBuGP9Y=;
        b=sudA3NdTy7xI5kGJMIcjbmHGWk3ZxpSJgUU5dxJXnS4pfNlxSnklUn9A99HN/vGe97
         991YnwYsa/iGx/EaylJfcIC7Srr4I9IN3/VIHcv+9xk6AQbfqeRTM2cXqxjkFsK97uNm
         wbEeeOOg4f0tfRp2F3BIoSm/2pxo1IqSRwCBodRA5W3D+Tcikf0jxwY8RJW0qFHbN5aO
         szawqunG4tT1rafyn5o8yssr5Xk3dw8co17O2KAVPB7jzk2GQvbSWldD0waWpikR35Z6
         Bp6bEn2H4ml8eGjja3A5LI1pQvbI34CB8r9Dz5zg3qKpLYhQEBkPLjEBL2quqLFZgMEK
         QMkQ==
X-Gm-Message-State: AOJu0Ywxj7bgyTNjEOEdenUfaHc/22ic7sFiWKvZWNd+hq63ooyLQmqb
	oxGHIMuYlMpduHddBoU4RFSwXnTHRiI/PV6xKEY/VWpeSBFna/33oIxH
X-Gm-Gg: AR+sD10aoZDLPlMgq5whIhpFem4wnyNuxPf7J4VIHiQUWSp+XZy6fMJwXz4BVkRra+8
	63dtjWeBuecmUjQGMGm9V33WrXwh8xYHC23AJmNA+QNNkpapOMewnBLNXZ4u44893JV70J2oAjO
	swO7B95ld5b1pFvSM+8XmfgmlCVYL0kUFdrS/fmltAFdv1lVqZb7C1b/rWmMiWPb93sTLK80I/Y
	XasvQgtz+YLhAzHZ67rGMxGFN5DAaGKgPt/Dpv91kgiQ1W1RTCcveGacnLxPP1XPcFPcyJs0pz4
	lwye/3lt8DQxYYaEkGuKCuIb/h0iq8fD5KuRwVEh89pkjYZUjRVp/AymGgvjmruXx0owWDfLlyv
	65qO6woZ7hl8+zAgqfibU+271jRzrhB/AYH+V18h2Jls9LJPJj4H59hq3A34mWIm5AAeeg2DUA8
	kZDIJP/vn6Wy+EjNimEmIn1eUw37jS0Ve1Nw1CfVQfhXyhxa7psgJ9jM30MvDsax76D0q6aWVKB
	Dha/wENEpbIaphNcik=
X-Received: by 2002:a05:6a20:d38f:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3cb85dcc9abmr5747517637.3.1785914340546;
        Wed, 05 Aug 2026 00:19:00 -0700 (PDT)
Received: from arsenalgear ([2601:647:4082:9090::f7af])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm12326462eec.4.2026.08.05.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:18:59 -0700 (PDT)
From: Uddhav Swami <uddhavswami@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: add driver for Gigabyte Aero vendor-specific brightness keys
Date: Wed,  5 Aug 2026 00:18:58 -0700
Message-ID: <20260805071858.32899-1-uddhavswami@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715055951.15144-1-uddhavswami@gmail.com>
References: <20260715055951.15144-1-uddhavswami@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri, Benjamin,

Gentle ping on this patch. Happy to address any feedback.

Thanks,
Uddhav
