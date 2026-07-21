Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BD33689D
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601714; cv=pass; b=pI1thHDqd7ilcNlCQdigm4NDCmp2/JxddzZTDAMHy7AvMtq3V2kp0LHxCEOheHZOWBK6xYs1Ti/46JGux8kjSx8tynv1MDXMQMUUs0As0+4i6yAuonXtBuijcRisiOj9/nImnZ0s1vJf5pLycoQ1YidBSAdFuum8wiJkJrSnPf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601714; c=relaxed/simple;
	bh=P5Rx+hZ1VAUn39W9or7sj7c3Y75XSbTymkUZ8AZHss0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNnvoEk9JayOmlXvh1+d55RLyvVEMLVbEHn7px3tjrvGmxVGPJp/Ukp3/hyLESWmaawwt4/qvjn7Cf9OD/W/a9eAA0sKpS2XU9rWw6z8ZFbcAM3oFiLuFpzE5oADPic2PepLifSIV3yz270PT6Ryp1kfTlSqyb0o1vOp9kB2S0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS/VFP/Z; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS/VFP/Z"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so7718966a12.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 19:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784601712; cv=none;
        d=google.com; s=arc-20260327;
        b=KCdI/tmO/DT3ETEuIFs5TGLERTZCxZPBrXVKAAfl/jps38Gz6+lsUICvKWykVJt6w/
         y8MA2pbYrlgkMQVp/Lby1Jf2iWoar7BIVDROELTGLeXSOJnhs9ASe5SpylwbIDmcdh3d
         WfZxZRrg45CKquXnV2fafS8yzswjtZfuDZ1qz7HuKqKxsiJg9hBOkfLf2Ujx9WXl5nS5
         j3Y7GsrroHMCRD4Jsgj0pjgTsXzFXAFtE8p/xmgHabskbe0oQnRRABdm1HbGCrrGTPiT
         Sz48+jCcAqO0HXTqTqPfHk7pxxI/OtG7aeBgKJBeXLnoWKWdo6t0TsMbKb8F4tDVILbd
         hghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P5Rx+hZ1VAUn39W9or7sj7c3Y75XSbTymkUZ8AZHss0=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=qEOTfiCT6iglzgAG9xlwxJLmPCdGoIhynPZ6OTU4aN8veJ2kE1L8CPX/JRVgF7ZY1d
         PxDIe53I0ilWQkhUK+Ssc+wfdp2K/JEOiG/TB1Xny9LOf+eeRcbmLM1+Eku9J5M/yggi
         o2DY4XeTQOyf9Khro3Iwf/gL0WzTaUo1DsG/yCQNc+chD5UgNYbExq2sD/SvWg1gsqZr
         JKR4Ni7FPsl+E/+Fa5Wy8lPJm/Am1KX3T2aParYCWIcPGE2oE9NkuhvzUCzto9veWB+F
         Xt/RbSnT+T6A0MSHG3ANEx6p1dEZUa2/S6pZT4zlx+RrNPCcuteenf0S2pcH0EmqcFNq
         Zoww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784601712; x=1785206512; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5Rx+hZ1VAUn39W9or7sj7c3Y75XSbTymkUZ8AZHss0=;
        b=sS/VFP/Z34RtiMqr9eDYzPXDvkO2Geb7e4M/2IekElgEZaNBSIrhVuhMFMVXAhn3k7
         oNx1jNBDuANxSP68hmK+AQbEs4VvOj0m6F4dqXF3t7onNHflkzJN7HuAhAcGQ0F6q/ou
         aw9tNABug0hMunUCbTkxRdjY6jjX4wMAH/DVMQnlAt06lVQsZosQlgAH4r/8EkiPswgA
         WlMKG7Nsmo+aYDKzWdq/i5kKs4Zru5iEaNn4V5UbKUzXS9po1L1mtwQmkQ1lZ3qXKOPj
         0cBQ/nEthZFF1Y6VQOiOjIM6MAjuK7psvwdeJOIQ4IRKmtVU56g2K3ilnKCojJbUjwyZ
         hZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784601712; x=1785206512;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P5Rx+hZ1VAUn39W9or7sj7c3Y75XSbTymkUZ8AZHss0=;
        b=C8i0GJfl1VUbhamzKlf9XlPrb1FGs9bHkD77KhfRTphvuv1Z8sO/cX/RHPgZBE1DbA
         MptqWDeXE1LINd1q1AQEwE+IIE3eJi7YeJCPLQe83wwsKRpd4MPZtW5TKHJ0zE19qqA7
         OmqP8HgaQxEb3lz5yXgoDRbutYp8Hab4948gzHkQnKhXbyq7rlBk8d13rgsl4CCFRfT6
         +LPhmcRNCBn0DPpZtcWUoHwU5ET7tVzg8Txj3xpAz3xj85pkWxwG/iVJeUhrzXV2i6V7
         xYinnF1Q1lNX4/gMOXiu4vsnsQOAfm7JzQJsobeHSQj141ExwRC56t+5Do2Cn5HMsMug
         QeCA==
X-Gm-Message-State: AOJu0YxBuf3IzcmDph8QANtshLvdd5WRHXG5ZhfHHVUz9O+ZqGr7x9Sh
	z0Kn89PsENMTiC9QEIB9KhV/ZJVIditBEtMH6+6ZRPql+8oKgelJFpXPfR6L1v7LgMXYtQ1d+B2
	CZ0jmRNSTcC+Jgb6k+q8bHTjJUfG8swhRUz6x
X-Gm-Gg: AfdE7cmGy3s9Vw6AtkBPaLCXbsYBKeZGnOYeFXafMK6O4i7eMOjhXPswB8GWvlw6aai
	BrjSvpY3AtporyJl8i32jnn3G4YvOBYf49A/wkZZN76LDe0uI8zU939prAWJbFigCsLWichgyNj
	HIP+Jok6s9y8Dqlm1g+pYL+795bQo58ju/2e4ZiqeuPDbLooxcyGjYmEQSt6KFlKmkr7SHpvN5x
	o4H53N827yAO/VCrrQBp+Hp5HQHvsEuDzyOPpBxPqiGYKgN2RIqxczZA0WfnNqdEc/qW73jFGLx
	DgdVwRRNzHxvNmOy
X-Received: by 2002:a05:6a20:549b:b0:3bf:9c93:ac44 with SMTP id
 adf61e73a8af0-3c3ad66b543mr19404501637.19.1784601712226; Mon, 20 Jul 2026
 19:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
 <20260720090851.230244-2-phucduc.bui@gmail.com> <al5V0Ym6zCGqPqJI@google.com> <CAABR9nGCv3J0cZCb8MYVYXby6HZhoMbpfKdsNeTxFJS3dzuNwA@mail.gmail.com>
In-Reply-To: <CAABR9nGCv3J0cZCb8MYVYXby6HZhoMbpfKdsNeTxFJS3dzuNwA@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 21 Jul 2026 09:41:41 +0700
X-Gm-Features: AUfX_mziN14F_1Eu87SytID4eet9ZE_ywrnKNhPfKYqKnxxYBSWU8Que_z62HEU
Message-ID: <CAABR9nHfCm=UbDR2mJ-m1Fg7mf6GBE4zVF7E3L6J_UBfwmpGVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Additionally, using dev_err_probe() here also simplifies the error
handling path
by combining logging and returning into a single statement,
making the code shorter and cleaner.

Best regards,
Phuc
