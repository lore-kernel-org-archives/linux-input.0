Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD43C4565
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957212; cv=none; b=fwL6er5i3Z4VuOcnwGMtYhqcCvgNv9TLXf3/L8BlNySTovduIzzFuq1O5dKzG5IAFZAsQwr3v634pkL/WE+ZpqcaZERE8hR2epwPsolVFC8l62zxEN/rBFg8ZiAutUB6XINAcyT5s7vzSGXO4zTsG1uRZIiyKDVSvaZ0q+SX67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957212; c=relaxed/simple;
	bh=15Ca4hPE05SiENMHQ+W7zZFIQTfIYV9YjHhP5ARJ6oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOiqLu+KpJWOwIyR+R17cWW1JHhkG4sTDbZ1rIxRTYIylQ3CPdTsMLQYACm+j1wP7WBHzJw9wKSqhwujeguSTBBZ0JJBEH0TaAIlzyykxiWQtEPKRQCzR23BaV5jlTf9pwFxsM8QSJ6v89lalSFicnAcTvM6Du4DlaUE6Bv7GpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6aaOMfr; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6aaOMfr"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-130b2295ed0so879644c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957210; x=1778562010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RRhjJtJFJxOdzYObvWhXXSj8K0QXTzb6EDUu+SZqpc=;
        b=S6aaOMfrBY2JgzK9vOlinQs1uE7igmqCSeC63k8sT6sZ4aN90cl5tRF4AQBAAFN8na
         M1vqiGLkkPZfRkq9qrRXuZTmLI8fFlfKWqwdTGZJo+NqxuB35RMSiD77tow2RIGK4c0B
         uMc/qXNTwhVc9cYYHTWmoB0botsQEFputi3fWaejFz9jXjFJ4F2Fj3LibUzL3+ldeK0X
         3wCnwh2oKX4nsrMMWq5PfPBaVVhBMozSqJmQgENQYxECYLMTcrx4I8DA89p5e/1VvXaC
         7XYxYttJfvrip7LDQvJV3uz3UPrJ+XTK/QrBURQF+GeKe8rWSO6g1/PC9ohlD8Q6tb7y
         c64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957210; x=1778562010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2RRhjJtJFJxOdzYObvWhXXSj8K0QXTzb6EDUu+SZqpc=;
        b=i7ex8VQDO2MkEf0wam5Cbfn9MS7CrOGnUEYv7s+T146EKBfH2mLv+48LU5fihxrOMa
         aHsI86jxp58uvB1xyKiXOsQCeB8VKtcyXEgDljYRaSp7lJW3C+8gz6adLhddKdEdX/Qp
         HiDaGzaB/VbUh6/EVRmUxJH8n2/PiA0ECFz3AhIa1pD2ukL/XQLz0no6rHdqYGnHL7nh
         XWlzQg4wS8XC+A/RGaKT9Lnwo6R9BlowZByqjZX+Cu+pytTqCkOUkmnpyUdYNBWP70UV
         5yTJri2Lkx1CpcZNDu3zJ4XQEZAcFAxN//nKDcJS4TkqyFaj8jksXhotnWVLw38vs2u8
         xbEQ==
X-Gm-Message-State: AOJu0YzKV+kQDWC3cb7+do0QkcDT+pXfiuSgLLMq+9LckSv8YPIdNUUj
	RIUHdJGBWbkN4QMVhLZNmvpIu+xNyR3JPZ0LvejkVE8n6wfj0dNqpOvYDTCFQw==
X-Gm-Gg: AeBDievPSf1jU4n43Ob3zKxP1dvofZ3tN6/IbcXxOvtgNov+GidJtwiXnMPHNhQFeaW
	Ht5kB+vVQNB+mgOkXVnAuIOx+OPU0byadvciI+Ph6pCBxuZVa2/6HDEsOa6FrKO4FuO/UFeVD+j
	PtKUgvdpe0qb8mnIl/VfVutuNN6cVo/0Yr/cjV96MV5f4PiEYPqdP7xIcooLsTWbctyVf+5tmiQ
	SmgMPh8NzzfHsU+nk/1/xH13rzYpCOSGhzC1Pr+s5aGHqorVdZeahX2IqQM3tWfnLGmFFmbTkN0
	rDW87JL1Rs++X0IjduJythOuZiZs/XThaFa7z5gHQQYUnw1RpeUL+ANVjnXbZpq9o1WBWJhnOIY
	L1DfaW7lX8spYAO/MtD0Nhi2kgoAcS39xezGo2TCve/qEvdHlB+uInSe+bGvU+/E8GvgdeHlhD5
	D2SeaxFHgd6q0kwr3pZ19LmYC8hlqQigBPWhK/C6LZJ7CpzKrgCVCIWNjL5dkC1HQAxcSQwO8Q6
	CwVPuev1xU5jq9NBXvRx14hB/S6/7idOQBe
X-Received: by 2002:a05:7022:3d0a:b0:12c:87f1:f41a with SMTP id a92af1059eb24-130b1b55067mr844522c88.21.1777957210224;
        Mon, 04 May 2026 22:00:10 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:08 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/20] Input: rmi4 - fix limit in rmi_register_desc_has_subpacket()
Date: Mon,  4 May 2026 21:59:38 -0700
Message-ID: <20260505045952.1570713-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_register_desc_has_subpacket() should use RMI_REG_DESC_SUBPACKET_BITS,
not RMI_REG_DESC_PRESENCE_BITS, as the limit for subpacket_map.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ebff1ce07e58..84cf7df705f9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -769,7 +769,7 @@ int rmi_register_desc_calc_reg_offset(
 bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
 	u8 subpacket)
 {
-	return find_next_bit(item->subpacket_map, RMI_REG_DESC_PRESENSE_BITS,
+	return find_next_bit(item->subpacket_map, RMI_REG_DESC_SUBPACKET_BITS,
 				subpacket) == subpacket;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

