Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73583382DA
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636536; cv=pass; b=JkUUo9vYBeAmpLkjY4jJsj/Q7Pjwo13BZNa5/J5rXZPXalDEeuKjoLIaUV9m8uXK9Qoa5/2YEN3BV+P29hr0fkAQLL+zj8Re+tR8YfmD5nU6XDId3o6rjYv8v1AAh8GS1ktvk4vBWr4hhFC/PBhuxjWuYUgb1H27H1lEShD9B5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636536; c=relaxed/simple;
	bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pLTAwq1VZdSct6AcOQE45V3Z1W8DuGkmPbqjx3ikL7H8IL5iSll0jJbKqv5C0C39Qo7qDgsvtyhfNrzFfncXfhnqW9BNQ2g37ITxAPb0fAw3qiCgSbxqcnlrykWko30w24rwvTCel8buZCdJWIDJvlSeykqH3OOfujKDu3FXfGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GagjfwBz; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GagjfwBz"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-679f6ee3fb0so3138660eaf.2
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 07:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772636533; cv=none;
        d=google.com; s=arc-20240605;
        b=PlH/EHeo/jG3RMHuOuOAFlIFfjEVa9dDRti+ultwwtKpb+Z/CEMF+/i8poqojYlnla
         DAtulGUYUb1n9W96fM+avc7wNIjQdMaNaOP1VDXtfRhzuDztG56H6wToH5lbKHuF71i6
         eN4oHb5I83y185rPMiOueE2b8U4dWbD/AMH4+6ZjN0PW1ZJM8jvS1vsJZlB+MEwkAErE
         J579g+xASiC4H2bHcUkdZTG8kktO5oj2TJk/WRXn+QMcwmOun4j4yuXsLZ+hjgC1kuI7
         n6C44Y8gU6nXGzeV+w6ZNDlax8n1f24qNJ9CnnvyntuIc9WCTHDid0VOVSmhE22JOGGA
         nkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
        fh=y7YEEQHl9xisAUve2IvZpJmNnpsB/uhZc3YMDBJMEPM=;
        b=ClU5G9oH6bOq+4VsA4L3DlYb18+8VHSxcvgI3DfHpfymgFJCkJx/dcord2CD0UW9g1
         60nixIoS1clgbxUFXWZ2zGNKhbD11nSWkHClhw7GipaEmoG5GtMCNeXx4d3EyszxLkCR
         CzHnmzB4azMBtxsB6cdGrvS8aw5zNp9pDO1pYEDX5X7uwLxzweqDtHeeDTHR8z10//3Y
         KNTqShAF1Qm7EN+9AGsXUJXcdP3TfpOeKMq9SyuZEvWp1yzpNkGZfHdK78QUdoz9uB+1
         keT3EiHFMI30UV4EJBiN3dxrInRnUfsvX/Oh5i/FgIhKfwv15qzS9kdKOWMfDVyjFY0n
         WlMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772636533; x=1773241333; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
        b=GagjfwBzvPUrJUVgvH3hBHsrRDtB+nkej0xKO9BZNWIgNV3TGjDENKDbOwJvedun8k
         O6MOQ9eJyt2ZhCq+BfCmpm177ZPZpviiv194H1DLGkElyXxoS9Vyaoe/bVLK/qEOgubg
         qv4smHILv/4SX/aGhkyrLxD/pY3gd+ZZEnXTVgIOxGgX0qJHQY4ffz93t+8JY4DN+92E
         V4MzDP7oTKzVNezBPeVZAF/upsRYicX9vMemJPszTvLpbWd9MTItjFKwi8eQPPoLA7PG
         0h00/S1qUPVEygLIWN68l1d1r9ucThZC4TGNL4P0WAkT9nytf9l1AIehgtcZHzYEx31/
         BDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636533; x=1773241333;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
        b=rWUCsK5JVy7r48EaLrT/LOK8O74rZw1TXjoezlO+kkiYupl+7rSWII0h+8PTMYi3NO
         Br5zKRzq3V3B6u5K4KlTjyQyDXOdtK2dOtkVn618K0Cq5vptT08PBNU1hjJvSMgj23cj
         LTCnB+ffnSYWtcx8vYEKf1Nq/HJds3uyWkSZLluXNjyE8y7TANmDoClUARbj2yHTzsPZ
         AFxuYNPcCmyiFHK/Zh8UZy/9uvwSmWfHHgrsmsBSZfmWY/rHaoOl7jC61DxtcqqncZ+7
         RxBaJOnGnqB2eFtme2f15Cu4/Tm/xfB1HE95Eka437uM3U7P2r5EZWSAiPgQ1tyYTIQ9
         03ew==
X-Gm-Message-State: AOJu0Yz92lXqIj05lqeK87tw1MtObj3u0AE/qnvFieQTeQDtO7Bf/S/X
	Ve5Z/R4x/uz54mR07GmqjUP9AqIqqXSnOCzqw2sHYXNvZIa7fAs6r4KqkLWmAlp7Q3ez0B9ml/r
	F1Bq0/CuQbFox/5z2vyBQKn2xN5EFZQ8pfZL7
X-Gm-Gg: ATEYQzzjlS1Kkiw8LQ+c6hrXGkIAEVFcB02nclGdT7c4JXgbUsFupIX9lplrdWCYvix
	fZ4CNG9ci7VF7oddQalwszCpyLXNI7OR7b8ymxC9M9ISWAzy3SnqyRUnfM/rjtQaSmuiwyDEP+a
	HrweKE2GOhjieVbEzp7eUlYTRjoV80cOkdxIHBq1EKWOdxyoEDjJ9D3WQpRdCEcYx4hIqAEaCqN
	pjWGw7cQ7/1k6vUPpFEfRFQbWuKDawvjDykYIJA7RwDROqKiSE5Ps8JMjhElGHkkBDVG5pL8aO/
	C6R3kxjRSHhgwMINwnYy
X-Received: by 2002:a05:6820:4410:b0:65f:7470:38bd with SMTP id
 006d021491bc7-67b1e909f56mr888184eaf.58.1772636533212; Wed, 04 Mar 2026
 07:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
In-Reply-To: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Wed, 4 Mar 2026 16:02:01 +0100
X-Gm-Features: AaiRm53WpMLirIo8D6jGIgns39aLQmDjbG0I0U5xvR78o8KaLNSvGnl4_G2CFPg
Message-ID: <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This might be related to the earlier report from 2021:

https://lore.kernel.org/linux-input/3d6f7f74-3214-4c03-b352-a2a0d27ea42b@amd.com/

and a similar report from 2025:

https://lore.kernel.org/linux-input/b2d0af40-876e-4a2d-99a2-236b583e9497@gmail.com/

The 2021 report describes incorrect SMBus address detection with
i2c_piix4 on ThinkPad P14s Gen 2 (AMD), resulting in RMI4/SMBus not
functioning correctly and the device remaining in PS/2 mode.

On my system (LEN2073), the behaviour appears very similar:
- intertouch has no effect
- "SMBus companion is not ready yet" in dmesg
- device stays in PS/2 mode

It seems possible that the same underlying piix4 SMBus detection
issue is still present.
