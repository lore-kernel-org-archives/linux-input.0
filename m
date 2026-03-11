Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01142C159A
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203121; cv=none; b=obzs71W2tQAmeitm94C2eYp8f3mdJ4wnwUa0W8XS1HR3PJfZS8LUIj+gk73oAi4WulF+dQlHVBij/gAYgnbNDftqRdyDZd9+eyYmwAX2sFE7Lkgbmu0wCkCEUlslnewuTGzpPZv+N/+KWcDqi94spbndlNozVsT4Yh8BhoJxCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203121; c=relaxed/simple;
	bh=ay7kLC7nSOMoueeuZ07rwxwG7DCmth5fcpnKLvgPIH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGxkNTNYu2nq46+Lrw17/fVZOUsbfCrAu8gzhAkmTsv87DG9MN7he3NFpxKO+ey2JLJLqL/T7KxjkYWtJsVaBL8V5sBcaM42a51ml8Glr/7rKa2uL8/+e7joxmfml/xqhb+QXtaGTtN6jVE+0X5Zm97xAb043HcVlBSR7D1uE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULejNhSc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULejNhSc"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35983877dc5so4592657a91.2
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773203120; x=1773807920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay7kLC7nSOMoueeuZ07rwxwG7DCmth5fcpnKLvgPIH0=;
        b=ULejNhScN1UcAPrEvNAAuintkrPizdGF4EJi1g9MuM9X0aaj/tRDAsUYrB0VfRjH5F
         UrxJ4GsQ3cNVwgHhVo61ZSUaMS4YAX6gLLGYpTpHC03rHO66V7yQSiCDS8HP4s4+nWhE
         Asx2gbOYpQb7ux5qlqRPvG6hL+z3p8jUS2HFHVow1BUy1gji5HzUi1ESwW/3x4vDATIh
         Q8PJtCVwXpkFHwgDuXAX8rcoFKQvi4/6eU9GHmQb6O2s7OXQiNs0uIb7t5TOdviF8lHl
         1m+nAKrpPTUn7uqeHASeSpjIWRmlMKx8QEa82HZAYyn89mN2AjiYbsdhcmu9XHCYixMT
         Dvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773203120; x=1773807920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ay7kLC7nSOMoueeuZ07rwxwG7DCmth5fcpnKLvgPIH0=;
        b=ErqRudPfrgSX62GZvClBkTDkbGRlx1onccoh0L3QHlOdjFg3TlNTWX/8LilDLHnkja
         oQuWO2oZg2F7fNPtcCIPOqQtrlBPBMzngIJpKe5N+wIKN6xuxSFwYTQRUUgP5Wif9HVN
         nnvA8G4QiDlKbx2QNGlcEy+dXs8iWw+Ie+Igy55h7kkQXWE3gpcXCdrp/iNxsIbEkLHw
         Ai6P44QY50OF1zlOOBiV7B4BjhmUZwtDFlXNGJPe7OB3PCxJsFp8abLkhy0C9Vp8iqvG
         Omp4rPl1eSlZ7jtI+IIqabwEoMSecMSaP0vaS1Cc+Z73amx3vXWUnHcIf96FPCnQa0bq
         HiRw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUp5gUCX9F/THAWVKhspqx1wct9wEFLdqPtzwsh1noYHiJId7CjNrDcd00iY2mA3bXN/FGFxfKbkGXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYK1bdmrzEVDH8iREn0EKAlEA/C+bSzGmXPQ2oDtadgohVI54
	ypTOitH1bOI46jYznUghsmhr+VKl3xZi5fFpD7DKyQcBMtfBAVBxqkPw
X-Gm-Gg: ATEYQzxIUMk8JKmUfl7vFJ+P0D8YxY0/wPX+5ZoNxeoFI1TTy2dqUTb7fduumb+2uZB
	aSitPkylr/yhhaFmllywXZKx2JeRUxNZN/RGwXfoujdHj6FMSzwvmIH/qI1kA4xBopC4PoWvQgu
	nBdq1Y92t/BfLyt7ZVwY5V5O6otyP251ZD6rdCSI+/JI0eIwd6SPvzVOOorU6TRBqCOkgcgF4My
	1Wnvzc7TWbdNQxedxnxoBePEOfvN93mKmjV4uFmQeJzXbLIHyyilQNIafTC9omBlN8GOXZvy5Xc
	C6oo18FVsu8XR6w24mdRGsGX6dwM6yat507kTIiN/FO2IzFhbYHrryTLCjSTrCKfQZnDUTt7fxM
	KmBnqeO6SJu5XtqAy2o5BziFm485Vxk/II0dQdGrkMvuPMnHuzkVfi9bWiKGa5oTuSdH7L7aNlF
	NFsYT6aXDBcQ63khTYwJYMiTk0s4A5dsFlIE/9GuGURH20bOA9Zd+8JdK84LuG1fluNaqiz5u8Y
	PhZ0j2N5UI=
X-Received: by 2002:a17:902:c94b:b0:2ae:456d:b843 with SMTP id d9443c01a7336-2aeae90b61fmr13064715ad.48.1773203120198;
        Tue, 10 Mar 2026 21:25:20 -0700 (PDT)
Received: from localhost.localdomain ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae361a00sm8316975ad.76.2026.03.10.21.25.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 21:25:19 -0700 (PDT)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	phucduc.bui@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v4 1/2] dt-bindings: input: touchscreen: 
Date: Wed, 11 Mar 2026 11:25:13 +0700
Message-Id: <20260311042513.2434-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <abCqyU2-iQgcghzy@google.com>
References: <abCqyU2-iQgcghzy@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Thank you for applying the patch.

Best regards,
Phuc
