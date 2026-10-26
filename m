Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024813;
	b=iv3FVJ5l1zELP5513r7UpY7+27bMpsZLb3i/8lyACsDLODuNIUQrzOzeLerPoJvZ6upV
	 IeASFBWBr+ahOU9GnFUUroiUY6V1TZPcElP3abZfGGZWjM9H3SYSOna0x2zeldVP83YPp
	 CIQd7oiS0oVGcbM/Ui+6Zc/0AZy2nVhdz0XWNlYRQYx5Jh3WqEG9IA/d5zSVG/laT4mUT
	 pVyMo8NVNylLdh7I4JuW3PYaP/nx1HrlccP/yRAH+vAculZw2nKfFIHaiAudmF9qKhNbE
	 yIeijN6rWoyq4zCb/EXYo9dRzyVX+iIJ9WQ7dvhWS1g3hLi5lhFjdlZL7a4DyyXBz0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NMA8b2FLsw89EHpRJHOM22y2TeL8WKaQgR/1AzfY5T4=;
	b=oNbdaChvQFAvgeK1fRiEqoxtinghEQC43MGPqKuWuY/y8VolYFpEs8x5dFu30JQmdHUm
	 2KX22P1NUXkkoycQgBnYyvozMjdlTKl4XlwFdvDq/ch4+jn/IGk13MOuSTgDShBHyk4ph
	 AzmztlJQLUZEfrdDTq0IgiDs89agC+chiRrdsSB2ObNvvkCVQ24gR/ibyLWlKghLFUXcA
	 wLkx/gryqYXwZhQ8+S1fjfksZp8j+YmNju5ALNAFHc1VSKscKQ3FDLDhe+CA4pnCIdiYN
	 FwlMUlfn51UeTsgIjGfaayds4CG17eq2ZAz8mlMf8vdriMMuPDEw8qUbdi0+SVXJe9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rttoZkvF;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950B606A324
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 14:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7950B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rttoZkvF
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bb7acc6fa0so447662e87.2
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793024812; x=1793629612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMA8b2FLsw89EHpRJHOM22y2TeL8WKaQgR/1AzfY5T4=;
        b=rttoZkvFyzfEFvSMKW/6ag3jOjMW0V3y6KTZr1jNtBJhLZzaWWgZWLp6wSLZW2+nK/
         dmYwL2t7hh4HAX3TKw52QFVtE1exjV/0qHknx2qbi4f6+/D/JNCmpsUFgKkqrTcgqWQn
         lQMbMnLD0ycw4HKMA8i1tOeI4c7Djc81XbNWnMo48k0XKvaNfTDmlByJTmf+1VKE52fE
         NwuPkvM1xm+hxfiaVkKtPoiNNbJUHKYkASZ3EICfGrEcd5O+/q7fC2ZDGEjzlE4FHm1V
         u2ev/jxUvqYF4ChHXhJCT73UzQybdT3lYpNwGSCNvTZWrVQsscglxWQq1lAga8PLKLUR
         6dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024812; x=1793629612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMA8b2FLsw89EHpRJHOM22y2TeL8WKaQgR/1AzfY5T4=;
        b=iwYQGKfSE+yBfgWmeqSCU1hP6MH3PVR/rPy0AqacSCXkYv//qsUO1rfFH38BtBjsQS
         lCHfm5E4ekA5NvJISKOT24tGhH+hDQ0VacLUeLOuD9nTTMS//F4Lbk+nsuQS/LTRLQ0X
         q9yq6qHoOxvC8MEl0wimvZjR606ZRruoKznVlCuPcJvSm/oJ5/RKpk8FaFXvmdrjT2hw
         IlHvav3dJlyXRNA+hkBgXDw6vwFgf3zx/mQAI3HMsAzJe3mU4hdQSKG1xFBbSY8PwdhK
         0BDaPIEOrMhcJyDrr5kpms5U6LUyg9/mfR4SabncFy72sjPEiUzW8MW++LlsVsK3FHTf
         sz1A==
X-Forwarded-Encrypted: i=1; AKwUvBwNFmqBAOV7i8C+OTJwLRj7zSQW+tk20RRfmjq20yAre0eDXjNdbIUKN12T5yMSytZf70n59SQpZ5zAIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIT/dBQpig/s/9q7TPK1g3gB/dxqT7ExNzfk+ImlAEZ0oNDYw6Z
	S0GRRZZjyJZeV9wn9XYBgc7I+VdHvhD7XyjqbWiNlzs0E4mBONcZoJcqP1I4YwXDGj0=
X-Gm-Gg: AYBFou3pUJVjQA+yIlNONHyV7qlnhDj/wd1e+yJjE4TPa+GfwafMqjdrBO38H/RBO9+
	3AB0LdwTiLia63pA+mfPRxfz5JP/FOwG30hBdf12AA+RMRglVWuG82tsNVb/oUtdRtYY97tAchz
	SAjf0yEgSCI3Wdd+Hp9g0ZEwffuk2KGh++DoD9xpthgqHTgeP7wZ5SO+I7yOszwNFgbZm/zCwjI
	9TSvjSvyw0mqmfGAEfreyF4g4qBSFxLUHhz1Qfl9eI9UyWL6XcX7eBP2v3c1CcZ3U1u0JC0lJRs
	ECma7XrIfD0oF/OXv8Vp4MjQRZSeN+ZMS/NCs+ChYY53xJaivDDEQ8r9b6c4/P2ju5MGp5TuCUS
	VFIxztXAGKpzVV0IQPcPXgN+UXXAK8h6rd8k2Yz9qoHGxn9+HBoLIIYx3GkOlvqHxtX/dFcC3e+
	PZHyNrMZ+vANXH12lzv0SooKkiu+h0uxB9ZzzsmgiR8d7jfN9XkAGh8MVUSRmQpWLpocc8xYUE9
	CRit9r4oJt3M0h6sxzFdViN6C2gdr4mECV0QIC+mgRhMXnJgK8eOo00/1ml91rufv//sBYuNSmQ
	7cUQCZ+m0XYF6ku4T1tGO40wdkwUt43906sca+WHo/alcWJnMy3us/DM+1DGwYe+jeCJc++OMQ=
	=
X-Received: by 2002:a05:6512:230a:b0:5bf:b9ef:d033 with SMTP id 2adb3069b0e04-5bfb9efd289mr2016966e87.5.1793024811386;
        Mon, 26 Oct 2026 07:26:51 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm16400703f8f.4.2026.10.26.07.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:26:50 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Input: synaptics-rmi4 - f12: pass Data1-relative size to process_objects
Date: Mon, 26 Oct 2026 15:26:46 +0100
Message-ID: <20261026142648.2567233-2-dmitry@kernelgen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026142648.2567233-1-dmitry@kernelgen.org>
References: <20261026142648.2567233-1-dmitry@kernelgen.org>
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

rmi_f12_process_objects() gets a pointer to Data1 and limits the number
of objects it parses by the size it is given, but rmi_f12_attention()
passes valid_bytes, which counts from the start of the F12 data packet
rather than from Data1. When Data1 is not the first data register,
the bound is too large by data1_offset bytes.

On the attention data path valid_bytes can be smaller than the full
packet, so objects may be parsed from beyond the bytes that were
actually received. Pass the number of valid bytes starting at Data1,
and skip object processing if Data1 was not received at all.

Fixes: 6d0dbeae71f0 ("Input: synaptics-rmi4 - handle incomplete input data")
Signed-off-by: Dmitry Mikushin <dmitry@kernelgen.org>
---
 drivers/input/rmi4/rmi_f12.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 841884d967a3..34f24de34465 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -278,9 +278,9 @@ static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 		}
 	}
 
-	if (f12->data1)
+	if (f12->data1 && valid_bytes > f12->data1_offset)
 		rmi_f12_process_objects(f12, &sensor->data_pkt[f12->data1_offset],
-					valid_bytes);
+					valid_bytes - f12->data1_offset);
 
 	input_mt_sync_frame(sensor->input);
 
-- 
2.56.0

