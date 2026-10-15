Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904A49BD84
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062540; cv=none; b=AI6uIFiPnE4cPy0aYwLYoqrtLaQJfxkc0Zy488UedgGXhr8Zt4J7v8BRlWg8T2fs9qeeUr+k+JQ+JVqfM8JsLIGw+dujJwNQo5qlnO7T7Ldth3jOwUx+xj10UQtC3RNWf4BDmPdgWeydYQOx3+DglmZfHFai9D5f+2QAEdBvE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062540; c=relaxed/simple;
	bh=LJ68nMqit4wbD1dHEmU5fA+ecIwlMsBD2qIgYG53ORo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5I0t4KUN2Kh+yG8v8SzkHn9wqaCwc4IwOz0TYcd1mWFKXOT7LTTnP7e/t+w4VjWneZDzogr+W1uk7j1OWVC6/1QSOmczkGlOtKGCjPnQQm9+ZN2v1PwKnsqa+bAasr2oTF16UbOuTu45JWfbJPVh8AX8okxepqrOeK3ZFqRBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl2q8UM4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl2q8UM4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e61ac64ec3so44501315ad.2
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062539; x=1792667339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rE60GILgiHa1Mt84O+CQTG7z+YecfD/icyWt/tzZLH0=;
        b=Zl2q8UM4DgMTDYOLYZ5HAzzjcEeiaBAWLZEz02wmmAd8I+SuPSS/kGAoz5yTisYh0c
         YRolQfRPQUGL+ZVaplSmNOMP1yciNuDUPncSpPcFr4Gk7SteqByc9x6SxjRjpmXCPgde
         guWWwW9LbNgu5oGaE7OLPe8JSeMCkUpX0S5BP17HjtgNtRUn2h2QE2h0uT8JMb+nvBfC
         pt/uqs825m56JN/w5adgiDZx2D+bNoqYM1XeHRxOgBPKpJPCcQLDYIme01NWGiuxGf8+
         3qwFtGtCDDMSVywv7S+zd8sPNpt/yfkWo88uVLHin2IbOJB5w8YeW9K9/UIDyH4McEEF
         s6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062539; x=1792667339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rE60GILgiHa1Mt84O+CQTG7z+YecfD/icyWt/tzZLH0=;
        b=wrOcrPFZ2R0QGksspRR1BOpGEgsHe1sZodln8eKBL9i0ka1QtBk2lzhtaRa+mu7Z2/
         1vonDcTq6vV1iHgdcQXVNSMcYgd1T4X9bwE4XBw4TUjXEj7qSePu6wK9/DS+iao3GRPg
         YPKJr7hA5kbA70mMx/hZpbMckfEmmbbP9xJEoUxXiAMmmr2NxdA3tTBoYi8eZDhTcob4
         wS0zeb/KheInvKGTfn0qqYMo8l4BLvwfCHobSDK5Am0eUkEgoh73RBqLcM95rKG8Z3db
         hnC9w3tV4DJpoF3KLeCgqmA/byOd2Od05UwqeIQFlrjAkB8r4fiYpmTmN7zHSNRV6rVw
         fyFg==
X-Forwarded-Encrypted: i=1; AKwUvBy3j0BYG8GuJAzRP+4fNNBDD8wsksw5WHUbYU3oP+y99C8HpfZsuBVcF/DhNFBW4gnovPSYy90jlSTzUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLi/w1U4JdylbsKREL+40gMUK+jXuuVkpM27XvGfzqXXKe2Ef8+
	agV8Xhst3qIStWhi65nxvOPQKx5NfKsTSN76ClpiMOuokHpPmPmMDpBp
X-Gm-Gg: AYBFou0LQruBvNlda6bKmZnkfY+hYpCKGKjnchtUBPyaxi19tDBcizRdkphvtiAlGT+
	r3UKAzLF4ehCmw5gsYe0xLFGf9/2RFMADHH+K7Pz7vNvjIHFDpwhEFOG1JMjgeyR0xGUYWiZGs/
	kpJ50FY8qHcst5JWiNswK9UhTKh64mrmVF3RorreC6DrtVbFk1dwa0pwt5scIUaXvw52dmuEXdx
	V2oqJVMP1+sT26TCwoJT3pgb6EfMwX3nIyJim8oAswzJ1g02FHP5Hopj/WQVZM6ZQu9ruZ+2jlw
	DIFkN/KPvI5d92OJ62g7BsJC0yICt1rxCDC4S6LWB23tMNPQN+o+mX5tKmLtpGmyo97u4SSWa0A
	1jmTR4nRSerMTU/DLGoopCHo1edhziL9vjC8LCeUrFG8BJYYP1QzvQRU9qQjx1NxOz8i9SywxJ8
	xVxOHDFFKsv1i0Kzz5XcQHTiMJA2ln1WvHuGCyVDp0QOSJ7t4pztgrOQeE5066Fy71Y1Y=
X-Received: by 2002:a17:902:f601:b0:2e9:5772:9ab2 with SMTP id d9443c01a7336-2e95772a81fmr24126705ad.41.1792062539043;
        Thu, 15 Oct 2026 04:08:59 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e8c9sm79918475ad.23.2026.10.15.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:08:58 -0700 (PDT)
From: wyibo6109@gmail.com
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yibo Wang <wyibo6109@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Thu, 15 Oct 2026 06:08:00 -0500
Message-ID: <20261015110807.203881-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015-melodic-cooperative-chital-afa0fd@quoll>
References: <20261015-melodic-cooperative-chital-afa0fd@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Hi Krzysztof,

On Wed, Oct 14, 2026 at ... Krzysztof Kozlowski wrote:
> I don't think we are describing here the MCU, but the keyboard, thus
> it's physical geometry is fixed.

Agreed - the node binds the keyboard, and a keyboard's geometry is
fixed with the hardware.  That is exactly why v3 does not describe it
in DT at all: the touchpad geometry and the product names are
per-compatible constants in the driver's match data.  I also reworded
the binding to describe the keyboard (built around the Tinno MCU)
rather than the MCU itself, and the touchscreen properties remain only
as an optional override for the unlikely case of a variant.

The rewording will be folded into v4, which follows as a reply to
the v3 cover letter.

Best regards,
Yibo
