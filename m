Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F13C7DF2
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957211; cv=none; b=VRlCHvoET+eEq1jEy73T8oaOdih/K4a3hn3//KtnaFmWbrzp7vY1bKZA72eV0pe2SsTeaBIE1b2M87cQ5+s5fFQtIuUY4MD/Nq/Qaf25oywU9xeEog0bFsZ3zQIpGipTv5w4xEEjhA8yknkwzMXZBtOo5pRmPHE/wJurLteOMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957211; c=relaxed/simple;
	bh=OE7RwNJe3nm3qgZgFykw16tgadYTz+cmpc/WT0kxgP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OurjcaJtdhFms00nSpF+qj6vdnUvT5ySSHlH/JsVFvq97lLqTP+Cq41h1EBEwzvFaR6RH6PCe6Mx07BfsYh1iX6lQVUJ02JUp/d7vbqNf9KAb5XXJeT4Eb94/yGyGQgUnpYaqaJmZqLiFFQD2kY4s81k7kPTDvSoOf7s1FIJX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ96OCHK; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ96OCHK"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-130c653cce4so59560c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957208; x=1778562008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y28fQgT8s+6wgnNieeWIuVixLHD6fzupoBYBwsX0f0=;
        b=hQ96OCHKRHb5QEgRCrK2m+RexCT1Fyt8BfGcOuvYQL/5pgjRKUkPvpq2q/NVOjgtBQ
         8li/8VL/n4NWMLZQA8zAprdDW3nviUl7903RjK8BBnrznNim29hLoUh9apyGi4LTuvqV
         xGQweAsq5/mzcbVZx1EgyEna2jAa8MrYzi8gOHERCwnPG8nL0BOOnOEFSYmCxLQaRKEi
         tvjZoT4ks8pg7tyQELRBu+MUa4sLLfp4ZGQgSPoM5eg4McG2lNVx3BSmXM6ml61Iipg9
         yEi1CNupaZ/cFBQhWG0dFS5MPfNeHNYMoKCjEJTGfQwJmNCRZKes+O1ros1kmC4rsq6J
         /Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957208; x=1778562008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Y28fQgT8s+6wgnNieeWIuVixLHD6fzupoBYBwsX0f0=;
        b=Lrf7cQN5QXSUkltTB2QVkwqmHNWGAx4CrfLxEORLpPl8YMdZSQZJMk432GHOMinAhS
         4juGzgU34Qsij7hR0b3CCzAaYgw3EJ+A8yZ1EYsVOROHpz2mHrAu82l315lCCK4yineg
         nYLau9hBNNdRSb+s2/SZwMPA0Wshn5+jWaTAMNYxVGzntAhmzLTLVQqHBLis222Ibhrt
         sVoq8cmdV2pRJwaODyCrpZIAOWJnSi3RNZQOA77F3z9o/LbfhjyzWd/fL46ctZZp17rB
         NPtiT49RAP37YuL5ClnGLWtdnXI5bHRryKLDcYID4WS9eRhP1LmiidOLkdlvsxcw5wOM
         YyqQ==
X-Gm-Message-State: AOJu0Yz9RepXD48Uz5ND9QINzTJYK+WHuTzrK86eGKSMQ3kII/fPN5gU
	KcQ6O3HIi11zlFiPa1VZcku+thqQMRenpGEl0eQTkVjV5pTZha+7iGiY1RZblw==
X-Gm-Gg: AeBDievckrtZCMDWDfxzn4ww7AjyT4JVy5L5S9RbjipSs93kNrg7rWeD+pmz2WPQjqR
	YcLII2JWAAdS4lLDrVeD2YsGfHIB2JQDXUjRL0/X5AipUAKMP47aYxXYivv060+k0DXf1nX0hcK
	/ej5FjKNn7iV69pbNCXx+BitZ7URMLlo7K3Mra4s/aIcY7Iy4kQDs3wJFWV3fgUKRDwqW7YhyWV
	dk9WsWvaFHDHm/7PNEbBMTqtu0xZavKOsoFht/PjglfengynNmDrMf0jQBawyzr78xDmAWaIDY0
	+ZJDN4lnhsCTv7olfRPwQhXk0zml2hG9YMlZ6kNhN//Xz5kREgfQVGpaGUnxWXdzWMoUcM5k7uh
	4pA1ZejN0ucx3b3AHnOIsA7eSLnxdMT0T5+Lw8rIfc6NP+qz9d3acqMX6XF4/i11rFEZubMqqQX
	wKDkt80l4gTjQ5/Lf4L3ddrGWnntG0emVVoNN5s/b0B087t6hJL8ljS94dQCVZItCv8UyTGMtJ4
	36tAmGoOBHE9o7zAPm6Io8YuA==
X-Received: by 2002:a05:7022:239e:b0:130:aa42:167b with SMTP id a92af1059eb24-130aa42171fmr1256387c88.36.1777957208284;
        Mon, 04 May 2026 22:00:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 07/20] Input: rmi4 - fix bit count in bitmap_copy()
Date: Mon,  4 May 2026 21:59:37 -0700
Message-ID: <20260505045952.1570713-7-dmitry.torokhov@gmail.com>
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

bitmap_copy() takes number of bits, not bytes (or longs). Correct
the bit count in rmi_driver_set_irq_bits() and
rmi_driver_clear_irq_bits().

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index c2843c21f0b9..ebff1ce07e58 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -388,9 +388,8 @@ static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 							__func__);
 		goto error_unlock;
 	}
-	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
-		    data->num_of_irq_regs);
 
+	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 	bitmap_or(data->fn_irq_bits, data->fn_irq_bits, mask, data->irq_count);
 
 error_unlock:
@@ -419,8 +418,8 @@ static int rmi_driver_clear_irq_bits(struct rmi_device *rmi_dev,
 							__func__);
 		goto error_unlock;
 	}
-	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
-		    data->num_of_irq_regs);
+
+	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 
 error_unlock:
 	mutex_unlock(&data->irq_mutex);
-- 
2.54.0.545.g6539524ca2-goog

