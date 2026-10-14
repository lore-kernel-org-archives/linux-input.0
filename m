Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833353445B
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985692; cv=none; b=mPUBIpC2bXmA+w0v3HbXh7t+7WzdAZfz6vop+7/FDrrA+HfUPzCySF0mdG9WuhOgtY3P87HjXF9DllHTcEaVCgk8FjDPH1OdDBhvC1EvDZ/o+6snbss4N9URt2+Z2VBVVayy8lzRvPgJDdggTgSSXirTgXwL08EGPmn5Zuw0ZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985692; c=relaxed/simple;
	bh=XZb2BuZsmSb3LQX+Gqpg0HwFJSEHBcpA1T+CRYC45/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt8WJoWDilZFphLey2bU/OAQwq3iUD6SRGeMdhOYDQu+57ToWRXbc3PvzcBYX8qme7dKdFg3Ho99LJnT508BZ6wPqoOqbTRIwNBTw5gy/Ad3HzD5+GboebPehT4TgS1foMLkn5Tl5zUxqDM5HCJklJn0qExRmhQVgrllyyWmk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0iPDEY4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0iPDEY4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8875d220446so2111608b3a.3
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791985690; x=1792590490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cb14+6Zl+Og5oq4fRzXaYkQdxU/WMK9lIAeYNNyuMS0=;
        b=J0iPDEY4gqIYItuu8Y4y63Cz5+UA1sZxHGnZ9lKPpnJYcnDLFZfKprYQIS1Jc1nAfO
         7AzWBHf+6OBm+mptGEBImFFrPKY7wgvJ1Ff8VK/K4dHGKBC/kwKUDW0rRs7iK6H+tEtj
         DrFtkfuAlH3kuiEdqFTOQGZyQ+0z1dghqY1XsE93fxkbZ8/g1ktkwhf14C0RMM6Y3BKj
         U/YO4kOduUJfEBDZ5LdyxaBjqHW/TV+MvovD/ZKtnM/FTC5ePC/q7KPp1EyRT1N7aRsR
         wuT6u5plFtYBV9VkJzk72yMjgG/wW1/9iE+GZh9aE678lSVqZ18JuINkPQSvUqBiysWo
         uE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985690; x=1792590490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cb14+6Zl+Og5oq4fRzXaYkQdxU/WMK9lIAeYNNyuMS0=;
        b=CptGDhk2GJzVuL2ml0iKuHYohRKC+HdDz69e4OWAlG9pcF7vxtsSTz6caF0IpfyYkZ
         XNoHj6tlYaUPqWC9xjEDHfqu+BFeWeHsGZt5k69XkaLULXvnateJO4mUaZT+bngTha8F
         pd/bIklegrLYJkRYi8aCERLmZLBx2fui981g7IP4qiV59xAKyV0MHdhoY8PdArNXp91D
         tUjVU+lDGu21AA7dWB1RGsEjJxbX+cF1VdIor5+eWXAzBb6pqtz8OsZosh+iiOGGctqx
         ukmxKwLtPcsxnYvkAHFxvhiIcPTrWM2LEGKjV3RIzl0vLMkCK5VmzN4Eg/yN2FsN7bO9
         zO+g==
X-Forwarded-Encrypted: i=1; AKwUvBwUUGHO94d/XzUyn8pcir743fl6gIyfydQg7mxyRU+Cow4aobF4+4ehYkJk35kBYozqsr4nD1lSkjykLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL4o2+nD3b1Xst8gfMukMUnLmawDWQTHANK82gJeFeybvQ/CKGE
	iRD5WuQ1uQsquwL3wiV4ICDqJAxSxr27vSrGa2wAHPZQKUrQ26iACtG7
X-Gm-Gg: AYBFou2Ox3+5dWxgDMvwefof5sbno9o/9Vf9/yCubxerd78FcYOQRFHCAVwZ829VaQx
	hw5aMsop9zmnG49Vg1hwd7agt59Zthb0wJxJDIIMxaSIwrdvN1qQrEG1SCoiWlGwrxh6jlqheMV
	ttBbX2POw0KyyqNyXlyxcZBQSVPwc0ou3hXrbHHzFM0nq8noaorY4IA0b1WyUL0Fzz6KsfasMMX
	iar6i34o29q+03NVDfwBuchSEmXVV4HuBnXlZJqA3IMOkMKYSBVO2ZrvMTN6yahsWwCW+wEUNed
	vvtzooZow2TnzRJ6qzX8yI7oWQkb3V4MF9cFt0ENQEdScoeqIu4wEHVt7wzZkXRwn61D7B1BkJu
	dTR14vyaH8TststotP+TBIK+TFkIN1WAbho+l3qFEWZq6HYhCcGMPIhJLCPUrAEQwL91halDGlY
	PzH7G+3xdUg9KOr/HIzZi2Oh8s5vzQ/1ioIKe96JVKIu1j9zq0CwMtUkqLge0fhvTnyog=
X-Received: by 2002:a05:6a00:b8c:b0:880:4b56:dc2c with SMTP id d2e1a72fcca58-897c69329ccmr12308668b3a.34.1791985689597;
        Wed, 14 Oct 2026 06:48:09 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89e0d1a3223sm296897b3a.44.2026.10.14.06.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:48:09 -0700 (PDT)
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
Date: Wed, 14 Oct 2026 08:47:54 -0500
Message-ID: <20261014134759.10946-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012-weightless-meaty-fennec-cdce10@quoll>
References: <20261012-weightless-meaty-fennec-cdce10@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Hi Krzysztof,

On 12/10/2026 01:24, Krzysztof Kozlowski wrote:
> How is that possible? Same OnePlus Pad 3 Pro has different matrices?

No, and sorry for the wording - within one tablet project the keyboard
is fixed.  What I meant is that the matrices differ *between* the
tablet projects that ship this MCU, not within one: the vendor trees
carry per-project geometry (caihong, the sm8650 era project: 2764x1630;
erhai, the sm8750 era project: 2764x1630; iceland, the sm8850 era
project the tested OnePlus Pad 4 belongs to: 2560x1440), while the MCU
protocol has no command to query them.

Which also means your question from v1 is answered the other way
around: the geometry *is* deducible from the compatible once the
compatible names the project.  v3 therefore drops the DT geometry
entirely:

- the compatible names the tablet project
  (oneplus,caihong-/erhai-/iceland-pogo-keyboard, the codenames from
  the vendor trees) and the driver carries a per-project description
  in its match data: feature flags for the 0x3A sub-commands that grew
  over the generations, the touchpad geometry and the per-brand
  product names;

- the common touchscreen properties (touchscreen-size-x/y,
  touchscreen-x-mm/y-mm) are kept only as an optional override, in
  case a variant ever needs one, and are no longer used by the
  example.

v3 will follow as a reply to the cover letter.

Best regards,
Yibo
