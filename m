Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C9371D13
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204479; cv=none; b=ECG4nXlwFr8IP+Oyy/VHQBX1GUmJj2xJ0sGfKJiPfJI5k0lLiR/+RxypQdxQaqgOk0DQThRZp/COOdaJuitCWWnZ7Q5J2xf+VgwPOXoukBMltm0+Qf1r5izds1Xo3lhPo1OSN+kGG5pa8YF6fRwrsTtw3DNY573oVysa5iSN4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204479; c=relaxed/simple;
	bh=0J0rrWYUiVLAksHg9IVVtSh+S6/aABTBFX3sYST6KT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFixQub+PkOSNRO/9Bel+c/HrndoqyMhYc132FhcEi/R9GhV6RC6+zUKmhsRevEJtseyQwYj6yxmU1Pz8nBpnr6oLVLoErnc8tKDAQJIYdEzSTAK4x/tn5Lt/8/iomcPz20hXAOzN98Tk38U/lTwlGiRJUTzhVov08YsgbUBeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTfJqdcY; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTfJqdcY"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97e76cabd96so993098241.3
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204477; x=1788809277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVoenmTqunik2MYCw0cJLWwNntrXBEuFLZk+q099Yuw=;
        b=cTfJqdcYOcn2XbjHRO/OpZJeg+JFx6AREdj/oMyhkY3TvTZxi1lybe51PdTqaDywVK
         TyfIIpDq7YXSZPkI7LuxkL3BsiM37czb14Mv+rYuGBb7qrWgzGb8yJXTkGN396NHX6hU
         zDNUHC1kMGKyuOcjs/BA1QELlbVMaMm/uQAwKjqWnWuNT+7DyIQx+nbMDp0KDKvEsvzN
         3EsE9ez1wju+cRI/LhztyOE42dOjxCIrWTUltVCZXou5n3k8hvwx95DgM4En1awMYuIT
         p7fxbj0DF2zwptT0YuatQWikw2gl+ITeflOzK3YemazmtBqhSNqmvdSh/Z87uz2nBtsS
         vtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204477; x=1788809277;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVoenmTqunik2MYCw0cJLWwNntrXBEuFLZk+q099Yuw=;
        b=e2qnKbUYXQhlNdx0tXT86aoO1r7Xp/Ch/vLN+9B7E7bdNrvCDTuql3pEtwH/Y3pWWl
         gkUdrrTbBcd/BcEoCX5K1lCYHasuWFhVdP4DomRdkipS+5dwIBe8PteJ/1hTZuXPTotx
         XMYhacRYtommw1/O5jV736Ggyv4xob2UhOx3Zt39EDjG2qWICNtQu3Eh7mXBfglv/6pd
         c70IgE6nbj4kVKIJOD69XjeUeEZgNbjC23DjgCkEwPPRo2PbznsJ4EpfkQSsmsF015oM
         mhv78uzwuKlasXOxReg2MoTfFJYKdgDtVpy74XGIv7Mkyg2TfP9OtzNrvYMtmgbmYPMk
         jsnQ==
X-Gm-Message-State: AFuF++kRBYbqJ6lQEPpci9Q3HZeGQcFb21AZBpotiatINPjiMRc7OGY9
	4K2kMtlWxxmjgX4IPAcE5OI6KkgPegJC69M8KnyRHN8/I6/KpkSxI3JO
X-Gm-Gg: AR+sD105QfdS+YDPwizb/Xo/1QzMZEMu+OxNaTE7MDwse7Fgm8lV3tUSWJW8qjaQ5Te
	kcxpEDBtP2+//xuqT8H7RHhm8KQEWeq2WC0BfezzOPYU5ozdEkOFw0R4ri14oBZyW7gYnsWkOgS
	LA9ylzLmm90wStvEdxjjZrOy3pxJYK0Z1ZSthb4vcEG3kOmD4Th11lm0AgkxxKzNeorBt9RHUEl
	xcSaniMZ0y2AOchcpIhIThkHKWHvtpNGcIORV+Ovw3bbHrHyiR1W5x6vLd9prIehZyfduOzcAUm
	nrUvQaoGcP6W02XBm5skEJZDvH0SC46TrJYTCuxptzXaxQFKl9QmS9CocUWZ/kpKNf7cavLHQtc
	0h2KE0ksPkYxFEjJreeZA6TzpMc12HVZFwVK2keck7Cp3J16I89aVaDnZyPOyWKpOZbyfQ8BUKo
	ufhg1C6p7r48yIZAriiZKbmSMVGNWj4K7sLdtLkd3hR9vLMQDJyt9h5Cs=
X-Received: by 2002:a05:6102:a50:b0:77e:6f90:4aad with SMTP id ada2fe7eead31-785962b2f0fmr8702931137.2.1788204477208;
        Mon, 31 Aug 2026 12:27:57 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f247e397sm7359428137.0.2026.08.31.12.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:27:56 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v2 0/2] Input: evdev/uinput errno alignment
Date: Mon, 31 Aug 2026 16:27:50 -0300
Message-ID: <20260831192752.258550-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831152156.166514-1-ivanrwcm25@gmail.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two small fixes making evdev and uinput report the error codes their
uapi documentation promises.

Changes since v1:
 - Dropped the ABS_MT_SLOT "minimum must be 0" validation from patch 2.
   It was a userspace regression: uinput_create_device() already calls
   input_mt_init_slots() for devices declaring ABS_MT_SLOT, and
   input_mt_init_slots() overwrites the axis with
   input_set_abs_params(dev, ABS_MT_SLOT, 0, num_slots - 1, 0, 0).
   A non-zero minimum is therefore accepted today and silently
   corrected, so rejecting it with -EINVAL would break existing
   callers.
 - Patch 2 is now limited to the -ERANGE to -EINVAL change and its
   commit message was reworded accordingly.
 - Patch 1 is unchanged.

v1: https://lore.kernel.org/linux-input/20260831152156.166514-1-ivanrwcm25@gmail.com/

Iván Ezequiel Rodriguez (2):
  Input: evdev: propagate EVIOCSFF copy errors correctly
  Input: uinput: return -EINVAL for out-of-range UI_ABS_SETUP axis code

 drivers/input/evdev.c       | 5 +++--
 drivers/input/misc/uinput.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

