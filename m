Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701A3803DD
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206086; cv=pass; b=pcst4pUEot8f9o/fHjyxemuQvAa4BCpvg3sCxn3LnZpSjrexWP8gg5FXlur1Z9p9J21i1Hal/oIvsf0oyRRMI3SLneLMS42Wi/3No2ktH0AEZ5mitaZxDfGbXRUQnGwwzHb/1KdC8FAcS1JcjWNoJYqBOqfitX5Q8OJO2IDW6/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206086; c=relaxed/simple;
	bh=+vxCOoBvQKdVqFqRYns1+6RMpaZQVpPY0ezVOH7CkKs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tzyw/tVWVKGI0BDGLjtCrpukLZYEz+Ff/AqMgY9y0sNWfm9RW+mB2FbdxxcCMlq1VQuTLlW453lClGpzaejNbSPnMa1InPqJfpmwkwABw/xjIxRAh3wXidZl7FwawXvQgpzOqjO3lRTBcR8dsf2MfJLCEtQaYuBVcbhlQJv9dfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbaRv2Bl; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbaRv2Bl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28d7c729fso49907b6e.0
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 12:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788206084; cv=none;
        d=google.com; s=arc-20260327;
        b=qkvFSPUwVAY4rDDKtwdv7QaRwfHb/AbuP4Q3UaGzUPuzUubwx9IkQxJcgfJe/+ZRW3
         1/OiDlqnK4s22obDAmrzvO7bd+ZGj9p3H7C2ROabuLUNGolpUOv4xVpMWqmM2k5w9PtJ
         0eqnapaY4QyCOXE8X3lOP9js2qVPPh1kkk/mrUUym1sMwyOirkFe26ROG7E/7Q71ai5/
         Lf6E5GEPXxGfP+kF28qkldalr52dLJ/861nlFja9Tp0cV5R8qYlETJtHTmsGuSypSJDJ
         AKFRWgPYuQmXwDDPuMu6/qVKXLo2v9UbdwwNGbpKHhEMhf9dK1MOrRaQAxCyFMxvztSi
         lbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=+vxCOoBvQKdVqFqRYns1+6RMpaZQVpPY0ezVOH7CkKs=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=VZ/2FwfgzjNKu/DVRCKL/UjiqAD6nfP+GdRJ0/flrT9D77Q/KpO5u7UGaqmJPX6sGR
         d4ZKyEML2DLbwCwG/d65wQeaCTpEKsyRlM783pHnAM3NycQn4eQf6NSeztgcOW16xy2i
         U1tNFX+ON40Wn06IE/JRnHb+wHpHadFfZnx+LzVIJNl9ZYChdzgeG8BV8iP/64eE25E0
         kZ2X/mEGmBIaHjF24X1T1HEibjbZOgwALn13aKCoCZykjMCcleV9JFiCfFuYityONy3r
         5KUHkSGeQ5SMfKCJL+j+sC2JyfjventMv2wPIFUhMVcY1xafdWDekLaUwd/gIM+rYR78
         Xzhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206084; x=1788810884; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+vxCOoBvQKdVqFqRYns1+6RMpaZQVpPY0ezVOH7CkKs=;
        b=qbaRv2Bl7If3vIcFikYdZ30jmkjpwFq+lylihpg1dp3PChABqXpTofdvKcp5nslCE5
         xnkVsL9Q8jPVDntlLiCWCh8cnk2tTXpXZmta4u5ZC7nfr0kPc+UxyPHd/ZcDlWpETzgt
         7H6C/+q95NLZb0wlMKEVyJxjsjT0S3vAeYuSViTCWdr5/JksJEAx63Uw+utXKhJhX9cV
         FEr39kTQkarHU3KLyhJxVzvG+cKlRIBhqIP/WG7m7ViV8BQer8RVy1uxHO9YNrL7nB5r
         hrgzXZbBW2SsAlTSOj6grYR0581pRDpIaiV34Jj5bsRyneweqsQYahQGpl+Va8Jhw33Q
         tMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206084; x=1788810884;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+vxCOoBvQKdVqFqRYns1+6RMpaZQVpPY0ezVOH7CkKs=;
        b=fsHDEEjcL9AAbdPLmXVEgJYnucqcW89OFdcHj2d342c36FHMqQ5qCLtUsr2gUVGVlw
         DFCOWxp51uc6hYRMEwqzs0LQosCWSJ/dqHrCqaqY532yKXz8bMrgQVoL1HE4TnHA9BW0
         sx7JzdxuWulUGJ8XV84/dIb+e1v/8hbNLKb+CKOHugnQMUNGJftcRrvRdo49xHCZTnJ+
         3lQvqhgO5a/scv+HzMGLy7bkxNISffGHQRw25Bkk6yqTMJWFn46XH/uWclaA8TzSEdRp
         wMnUjz4InIgGaOU523Q0J4cG8ddohJFuhXnIEp+LPYLAsQV6R5vQmoAkQAIy3+rfm/30
         qprA==
X-Gm-Message-State: AFuF++lAvT5LK05D+Q72W0kkFDQSEwM2newW64PLX78c+5GUeeElKbVb
	tZ54TJysKipiPC0/zTEF+7tK++aa5fVP4T56+lX4+fLCgNsU0fZzyaA6paJOh3L3BgNFi6WYLyg
	XnMHtqElpFsyWcOEyWLqmkedBvxhYKcM=
X-Gm-Gg: AR+sD11Ko5o+eHgSwMbOPlGST29svKAh1oNcm2aT6v2O2tSh2bd5acm7RkU9PCUYPoA
	drdT5ciVgImdEdENGUG9luFV4dLexm8Jn0l7dXOwBqq0ediXyaXl8egkCiqnug9QN1Fwu2GgIZ5
	yAOZl0PvLmRsgSfYtayCA5kj+rPuwzwL7T4qGnFpTJQpunR4FuGPpr4OrzlDW3uSjWyptm7iIjY
	txj8QOocJzAfEKs+0EO1OT8hGoKT+6XX1c99NzdzcjxIQcpe6Ik2Ppx9Oqkkm42tX2X2bDZ+cGl
	C3hAgSb14UOp/fOYGbvBHTs+7SY5dLuifc3Di2Ei93Lw7Ox7kbYbyj78sgvvOQzkK7s/hDwbqQO
	mrI5NqqhmI4jeUIG8kUj8ff1k
X-Received: by 2002:a05:6808:15a1:b0:4b2:8e24:799 with SMTP id
 5614622812f47-4b39832064amr27707262b6e.17.1788206083778; Mon, 31 Aug 2026
 12:54:43 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 31 Aug 2026 12:54:43 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 31 Aug 2026 12:54:43 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <apLOXaWFZ8ueIEAm@google.com>
References: <apLOXaWFZ8ueIEAm@google.com>
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
Date: Mon, 31 Aug 2026 12:54:43 -0700
X-Gm-Features: AcwNN1WYmwScQQ-E8__J5Z0hveXA-w3_zLjxbl_iackDpkTfBKU5rR8Vf_KpjDw
Message-ID: <CAO7O_xi_egv9oa6ZSWgka6B9nExHeR2qTdix5g7QMcwqNxDA0Q@mail.gmail.com>
Subject: Re: [PATCH] Input: drv260x - switch to using fsleep()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

I tested this patch unchanged on a Lenovo Yoga Book YB1-X91L with
both onboard TI DRV2604 devices (ACPI DRV2604:00 and DRV2604:01).

The test kernel was built from commit
e5e85128bb7ce1bda7cfd7055be9821ac42b8108 and reported
7.2.0-yogabook-20260831-202310. The validation covered:

- 20 open/upload/close cycles on each device;
- strong and weak FF_RUMBLE effects on both devices;
- three s2idle suspend/resume cycles;
- repeated FF_RUMBLE playback on both devices after every resume.

All operations completed successfully, and the kernel log contained no
drv260x, I2C, regulator, or workqueue errors related to these devices.

Tested-by: Maurizio Casciano <mauriziocasciano7@gmail.com>

With Best Regards,
Maurizio Casciano
