Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBD57F736
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171876; cv=none; b=q1WkBwv6kA8Ud+AtXDwqJoAWZffYl65RL//xH7EN+LZ/V5sJ1mYDEEo5ZSBu1HuKRmWrV4c7rv4sUFS299dd6GNautj1tgoDFTcxQgvYfFp7uRGhDA3z+QHHMfMFqLqBJ3LCI27PMPbr0HUMDgOj0RG+227SvMVftRVdKlpqgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171876; c=relaxed/simple;
	bh=GS/EYR98hY2wryjgXLxl9nwG+m2ja9oOJZKWvsufTwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDJHadeFvlfj/uR4bValdrP0u+qlczdu/bVhSOMmAcqrJnL4Kbqbp0eLyvedFt99c7Wfbl54WAULSBDq/HKz3wr0QWjaE4zNay65cKO2n1Zm+5dkME4GNUjs+eXtJIIj2iOccBy2B5RChM0rHvGlHDJgHY0TbQCr1mw1Lk/D2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgj8YaVP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgj8YaVP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53582498790so1516201cf.2
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171873; x=1792776673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TReqZzgYDqKUCRA8nMpcehhIY4deNasK2PBu/OtaUHI=;
        b=rgj8YaVPjyJJe2jhDcK+nRaeEgbVLVGUvEYtFIvCjOrfs1eq6SWIxYIQSLzSme6iTz
         EQU3r+m/SQz6xahvsEF4BPGLJQMnaulTfqKbu/SvjHn9o81UbNt4iuRyxJQfRU1krEmJ
         2pVryk5/vdZXS5uEqVqWJYGPgtW/svQ7SlVdBhK7e+6FTuBYPvEerPOsHVdTo5Ngv8q+
         FpJv7wTA8o68f+uuEjoObaehGZ8VGgTJ6pZIWJ/qFVf5RsI/elqulmzdIDxSqyUpNNcq
         cxAKL7XQn+b5tcLjXO9ciXrSdR0I7UjN9IGA0kyUP9likfUIVC/Wbyoi74Xk8Auod6Q2
         X26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171873; x=1792776673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TReqZzgYDqKUCRA8nMpcehhIY4deNasK2PBu/OtaUHI=;
        b=D3TenGddbQUanLNLrzy1X9/ssa8Tc2a6FoHySKccEoTm39x8AwBQ/US9YhmTfWIkTp
         tFgzfi3lqSIOIRxa+yZE+ngP/iyD1GOZl0bKEwOMPhdtIV4RQZ2IURjP39avpSPo14E0
         J3tlAP46UB6CynnAfhxdFmFlcRwx5owVnhzJ2Y8E806KgC/0BJkWIyJKhUONSU4ykYNP
         Np7O0ISgU39W/PVhKXsIURAgMlhphc4OsdEwiZ634iFAlghTNsk46RVWhE0KHKLCZRug
         pc1B/+xMeJ5NWoVl6v0UCeQirYh/jm4GxbqSJKvKW91dhUsjEvUslio1zxh0WomE1zxS
         KZ9g==
X-Forwarded-Encrypted: i=1; AKwUvBykJcdR++CFp+Xk4jeax400ipY/ygMeQRiVX3Gb1d/4Eq4A5BB6GFabaQcLLbmCPF+2xre1feQkSLk6iA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIutJhGkiw+pmVOa1FJiwyhODbRsB4x8moHlX/kxOMz/1f9EmdQ
	Mtl23HALHutIVLAwrQ5oL/8rQCif3vwl/VuW9SbRZ2po484hLtDFJrQG
X-Gm-Gg: AYBFou2sPOI+1LBIdG0k01KrkFfh6hfNrhouAwI4fClnz6HtSDcQiY7dpU95ggaxbpc
	/xDTGisfBGyroBgAVMSY0qMdYIlRCp0S67LYp0e/CIL0N0ERwd6+sFNd0xd6UWSYGS3eVKPfwPS
	8RCV89YThT6pM28v05eLmLBjuUodg01PnEYwfZBt/mE8UjDKgIyaaQziJZsitsRsrJeGy4OwqVt
	+ctMxN0z0LDoG590kZZbCwxNNL4PQn/QaNlznCdhN3Q9HaXl4yMWsXLAAjJ2ibtSGrEK/i7mR6H
	M3q6gG50utIH5wzrHJ4lTlwS93DDNbc2wevrZe2xZAZapaUeAgs4jvW9+/rIcWbKLwfxx+ptc1Y
	oNFmgbhvzFoDFPCxUG3q6VMFkd34lXAwIbJtIh03Fxti4OHlEF6CMC/XceobU/vqCcNWT7NOahB
	89tgZhCaDCAQE+KXQ0+KK/EYe6a4M6T2DMA9CayrPgDAffLJNFQNT3dk0rEMKJg5k=
X-Received: by 2002:a05:620a:4547:b0:93f:2610:fb6d with SMTP id af79cd13be357-93f29cc832bmr99546585a.13.1792171873049;
        Fri, 16 Oct 2026 10:31:13 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a18510fsm262760085a.22.2026.10.16.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:31:11 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v8 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 14:30:54 -0300
Message-ID: <20261016173056.3397211-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016163349.3293666-1-qwe.aldo@gmail.com>
References: <20261016163349.3293666-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v8 fixes issues found by Sashiko on v5-v7.

Patch 1 keeps input_set_capability(EV_FF) before input_ff_create()
(ff->ffbit needs the bit), but clears both bits on failure via a new
ff_cap_clear label so a masked error from the caller does not leave
EV_FF set with a NULL dev->ff.

Patch 2 keeps the devm_add_action() design.  Changes since v5:
  - module_put in hid_haptic_destroy (not devm_release) so the module
    stays loaded until FF is done; __module_get for devm_release itself
  - guard against double-init (return 0 when haptic->wq is set)
  - NULL haptic->hdev and haptic->input_dev after put in devm_release
  - restore dev->flush/event on devm_add_action failure

v7: https://lore.kernel.org/linux-input/20261016163349.3293666-1-qwe.aldo@gmail.com/
v5: https://lore.kernel.org/linux-input/20261016135516.2957381-1-qwe.aldo@gmail.com/
v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 108 +++++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 26 deletions(-)

--
2.53.0
