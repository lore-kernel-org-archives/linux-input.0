Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D03F99F3
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003113; cv=none; b=N3r0xA3Wv7lZ7suOB32guaG9sBsxvgAwPQUB/D007kUEnDwdMq71Ah9kqiWW/teazhgYSUusgTJhWd4H0RWnRTrexOSK+I8HC/4SZgipzlTWazKSVlkd8YhxiZO7ERqk1QEitUQTNmJX/WRI1asPAu631uItbBaXuVcU5dQmZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003113; c=relaxed/simple;
	bh=kjw1avFU8520DRpYQDxuY9SvIAlSgQxLqUBUN9Yb05w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4lB+TvGRnY9O6Xp/jv1vy/vo25xlAXQLh/vSTgYA8r7n6Oc61k4oldjj1lc6V+JHepXn+V/4BdxqjjmADQ7KLJC748GPYCgL1POOp2k7dKkn26QdPcedjkLoJ4qrK7+jFAVoIzo6ezwsdl634QmiSyd08LB26o+Nh7Vp1QfoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ5AHDgV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ5AHDgV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf36a6905cso37655905ad.3
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781003111; x=1781607911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjw1avFU8520DRpYQDxuY9SvIAlSgQxLqUBUN9Yb05w=;
        b=LQ5AHDgVFf8+XKXrafeTgWm9/5qitbhWyjjGliRtULNeO5ecUkYAnuGsG9F2zKCd0V
         j4w75Tm7HeGs8e3IolTN+2HuSn9C3YALQ8fexMWxBfj8tu+Bf7IWVmiz/KsYs/ysN8Uy
         a3SHzXkazI5ymUOfafG8MBbcoCwjqpmYQtHCNB7eatZslq6viaGrfZR8xFmBWrOAHMuh
         oWRnahcdC+PILHKbyM4lXYK355AWNKfxEBTzMWoo9radY+hi2ue+15ubgEWjtM16pivy
         dXmIf3dE9AuSWa94/eWMPvrtbR0+XnhGHHDZR1jMlKnFSH9eB8pBfVCnBrBS+Ey2AYXm
         utww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003111; x=1781607911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjw1avFU8520DRpYQDxuY9SvIAlSgQxLqUBUN9Yb05w=;
        b=tG9bRwicfIxXOpJ0T4AAlyhNafMz4+UOQEgALMIQ4pqcsKHHIKAzY6gM9RoGKmEn7y
         oR8GlD9GM7xSlK0ZIzbjTNlR6QbHPmG8N1TfpgQ+fGArnr7unDMIlGb56ykgJIo/95TT
         JIxQTCa0HN2o3r5jvWqEenMjy0WzJqW50sqqGs2W7aNG5rw00OwlU5Rr6LFow1iqRoef
         4qmJaMZH+EdvvoDdRwnW30gCUomBp7038AP4yD/DPTLYB3V6hAYjX2DdudT0LYoFpvsI
         ha8Qqdqe9GSWRqV9y7/9gm8C8TWR2VAuciSfxLFh7hU1ZPAbjR4JICo/Fg4T6GQDnwCA
         WVkg==
X-Forwarded-Encrypted: i=1; AFNElJ9tLiXbbirEXUPkePLcMQSVSnIh2nxZv2H08Sb/WjMDdyO1RYMS9Tqg2c8nqz0SluTgGk0UZ9YF4otRGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+JgxK/2lQK2+CPq9//2zSkEewNN+sYQK3o958nwSsxQlz1Is
	gtE3Sin9EJ/4VOcy4KJsV4a311IP34zwevbyk5U8Ni/mlyNqOFAzNl6C
X-Gm-Gg: Acq92OHBPVW38HuTv9jXCnz01F1uS+eVuLgxiWfM4hF/JsiQTiGKXo3p6mkoNwIiLWL
	aaCBmucs1BzFGOso+pHHKNZsMV6U9wVGs49ijVAvrHMQGXVEmSItr9n1vYT9G3T/DBUrbdC5f+q
	2kKzfZRL/gmK35y8GwbqjDnjZBa4xo0z/urq6AW5vhP0OJZHpm9fgQNYi3tLn7KrLebMkMXKTgB
	GFiKMUqENw91/xu+lgY8/18XZ8ea2+c6JrBzHg4ipxlpAiwcxOF8I8x4C5NbGdiYMlGjyyoZy1p
	iDZBlyexnpeq7Rn8rRSOhSpBZzyJW0A3uJk64p6d6Jf86gM8ZfJB9oFbbZkSqKCJjUlddirlGoc
	v0dQnUADq3CKxg3FtQEMrZrqdfB3Sx4IqxCFabGQbGHxskhCmSYWpFcvcqqXWEhm/GJJ3e5K9Qw
	Mn+01ziIvYwYlE4iMYREsrpM8DS22lePxjage1ZhpcPxfJTPQ+5nGmP11ZaEHQVVD1vMZqXFNsj
	aL5HTJAfkxa3ELVSbirPfZc
X-Received: by 2002:a17:902:f645:b0:2c1:6259:cda8 with SMTP id d9443c01a7336-2c2a1c873a1mr29134585ad.25.1781003111332;
        Tue, 09 Jun 2026 04:05:11 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.lan ([58.164.4.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm211687815ad.22.2026.06.09.04.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:05:10 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org,
	bentiss@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	harrison.vanderbyl@gmail.com,
	jikos@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Microsoft Surface Pro 12in
Date: Tue,  9 Jun 2026 21:04:29 +1000
Message-ID: <20260609110429.11427-1-harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4ced3207-a132-4ec5-a0eb-79f75f5cb4bb@oss.qualcomm.com>
References: <4ced3207-a132-4ec5-a0eb-79f75f5cb4bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/9/26 11:30 AM, Konrad Dybcio wrote:
> Because we'd put the subnodes for devices under the 'status' line (DTC
> enforces that), please move the comment below as well

Will do,

> Or since it's @28, perhaps it's just nxp,nxp-nci-i2c and it could work
> for you ootb?

Unfortunately for me, the device/antenna is not present on the consumer version,
I was able to confirm this during a speaker replacement.

> Please align the <s (or is it my mail client playing tricks on me?)

The alignment changes depending on what text editor I copy paste this section into.
I have them aligned the same as the other device trees are aligned though.
