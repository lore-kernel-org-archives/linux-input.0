Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209396;
	b=WLwUwxq4aYMKdyEc+49eqTnJ5ZD6azdukccvN7DkTUh3VnODSXwDeWbdDdwH9GYyyGDG
	 UyvZTNtgJAfMG7F16DQJUbOkb4SYcBesJN6b2FxM6SEpL/I/of2Ur26izbL77tDnQeCAH
	 QvWRUJ545D8PaLfxgrPqbABZqtHGm9BEg0/Dnnj6viflwIZyug47IXQnXXeimEzgoGcB+
	 0zvPxwdanKyXyf4F7OorS6lmX22HgkgCArqI8zAc3zC/npHDW1ildQmnV6OGc2IKeRiRl
	 /iA7PwZXmHMer7QFYzcKQzl9F/ExHPlH+m8D/XtESuyfjvuDWKbpZarLRGgr5w+ROPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+iS8GsvwX998BKoi2x1NItUNP3KaRUAQFikRJSM616w=;
	b=2xVAncc4WB8RsxBaRXN0uT8M1zOi85PfjFX2k+w/sie5lxIu1f//mLTNulwIaIKwziaf
	 xVLv/PN35g+HYE5WJBMd+SUOYnINMYGB2MNDUZatEu21EvhALSD0GSgR7h8wiInZSfma9
	 wZyV2yDR1xWPwN6UNL1ugjl6KupSsGQwtPnQ4/J/YUGbWibelhpxTNgnfyU0E7wrEkT0w
	 YzjKs+oC13PXecM2WVios3sAqxAqr47xm1ZGzxCfovq776ZYsaGTbUvXe2Y4USkYxZlyu
	 4qvl+pgOcVLcgRqGmFnnAne2dwNFesD8xgIN9Ncabm0/bVh6Ku0WklZSgHmnUcnB/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhleE8Wx;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6FC606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6FC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhleE8Wx
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so591525c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794209395; x=1794814195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+iS8GsvwX998BKoi2x1NItUNP3KaRUAQFikRJSM616w=;
        b=MhleE8WxP8f/9gwFta6ieKkHTh6bne+8NEHiWL8t5AxaXp7jMdEnYIog2f9ztkLUjs
         ycWkBQ7XlP7c6mSYsJfkafzZ1IYL7AAXvtkM7dhQOl2TyE9b0shpMeXXeAceYGF17tjf
         9YxFhQU54N7KJZb3P0lB3p7vCXOcP/dDYiFvSdSS45D2JZjWwrVsYOFJGJwqT5LsuKzQ
         FsO6hbrLnxhFNroAd0hNFjcyLqeEW4+eEaB+vRPHOuLeZmXpkGz6knlQE3QT/F6P6Rr4
         X5eA5P4/kR5jWATKoatn+tSUWmzxIY9U7mAGwcd3IKP5rS3d7J3OKIG7DsuUzfwQxNcu
         CnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794209395; x=1794814195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+iS8GsvwX998BKoi2x1NItUNP3KaRUAQFikRJSM616w=;
        b=gRAh/S13rfv8mCKZV/fgDzJiC5SDpRR0t78ySFD8fmv1gDU8EOOf7Ezm7y5ZMb0c7B
         DGTqmnXc+35jPhrDMMwB7Ky1N/88p/Uvf2IuuLvfs1/LGzOx/PXODvxDa5Ds/YPSvhzy
         eFyiKjrMpKwSKN+I7iSlq47VKa/Hnzq6A/z/tqqB9pxJvCOYGSzVuGuF5MoLUtZaShhn
         EUB9VAZM9KRsVftH5M07a6OloARvBWXNwT+J+fPEWPZjd39JZDt0ESvCPaFwwXOEu5T/
         It/JoJbJWB2yuNonp499h29FkKscDJkCffoAkt63KdzXie8/F2XZ6jpV92V+u0cmABSm
         JvEQ==
X-Forwarded-Encrypted: i=1; AL+hErGHsxck/HX9y+uk8Kz5vLTISS01dpVb07qoi4uG1J7fwWaSaMhvKYX1tiAlFlHuZHIfnkdqNtBNN6WoOw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5KcvKbKLQJSROFcRXffjldCiIyKbcUi77lgtrLPaiNcs8FlGg
	x9VKdsfT3dr4b8uf5FP4twxrytaHdi1nd4hhgv8Kx83EyTRbifdOYST9
X-Gm-Gg: AYBFou3MDUtHzPm9pvVGmQi9Cl2MxUGTjAIXkntOuq8tYbB3ovr4SbEwTu7yc7btleS
	OA4niFRA1IZvcP4VplaV6SdS4sDGmlRpDOH+KtCfT8UZ3zs7oIMZy5q2/+OytMwzeM8XucfwEyU
	IGAE0q2dTO6lKODSjOhM/ZrlrR3y4Kq9MmkXQspLIdg5sCzWBweBMd+Bpw0wGGmivATEGvsDOzM
	cUzeRNm7EO6sIIxww8B/AQ1IrdkLfK1l6eZwHbli+JiF+2jL4XqG90pCa3+Dy8i3uISX+p5TPwp
	DTwt4ZRzNd5pf/I5KoyF5mjxvntPh5yNoTcijnnTIIQzkLi2k723x7TcvY1KU4O9j1tYArba4Uy
	DlAEdkmKqL8BECMzXJSDMHRelY8N/FUZg4OKsi5Po0o6/nPJTkpzfNjxO3W+EwyhjdfKeut2MVy
	YlBKozeb40sYOKUuI8PMlqkjTN1k5nBmu+70wJynvGGSU2vtKVxG/ViLvbTSMzcFldaLgIKrVDC
	0XZXgCY1Wkc2JyaRII2PhC4zYZ2iOVEDQebNmf5sd1cF9ahrEY6GCIJdFs2It2E4JNSRALEXNPx
	K2EeyIJgiF/1xebK+KywSob0j2PdKeXu1gH5iYPKnPO+DtStJBjqwQrZ3KIAjwrHWem/HVM2Isq
	YzCoqhSruIns6mWGh
X-Received: by 2002:a05:701b:231a:b0:1ae:4ead:8cef with SMTP id a92af1059eb24-1b39feb43a3mr5081732c88.30.1794209394874;
        Sun, 08 Nov 2026 23:29:54 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f0e0fsm15265320c88.20.2026.11.08.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:29:54 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Hyunjung Ko <hj351016@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: remove unused lm8323 and lm8333 keypad drivers
Date: Sun,  8 Nov 2026 23:29:48 -0800
Message-ID: <20261109072950.3474308-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
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

Both the LM8323 and LM8333 keypad drivers strictly require legacy
platform data, lack Device Tree or generic device property support, and
have no users in mainline.

Follow up on the earlier mailing list inquiry [1] (where Wolfram Sang
confirmed that LM8333 can be dropped and no objections were raised for
either driver) and remove both drivers along with their platform data
headers.

[1] https://lore.kernel.org/r/Zr6I9RB5mibU_12N@google.com

Thanks.

Dmitry Torokhov (2):
  Input: lm8323 - remove driver
  Input: lm8333 - remove driver

 drivers/input/keyboard/Kconfig       |  22 -
 drivers/input/keyboard/Makefile      |   2 -
 drivers/input/keyboard/lm8323.c      | 813 ---------------------------
 drivers/input/keyboard/lm8333.c      | 213 -------
 include/linux/input/lm8333.h         |  24 -
 include/linux/platform_data/lm8323.h |  34 --
 6 files changed, 1108 deletions(-)
 delete mode 100644 drivers/input/keyboard/lm8323.c
 delete mode 100644 drivers/input/keyboard/lm8333.c
 delete mode 100644 include/linux/input/lm8333.h
 delete mode 100644 include/linux/platform_data/lm8323.h

-- 
2.56.0.506.g506a7eabc5-goog

