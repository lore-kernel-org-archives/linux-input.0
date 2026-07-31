Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1835C6AD
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476549; cv=none; b=d97Snp6tcVzYHg/AhFVzWq2aoX4/UujsmmpwytADpHM5l6E3i68omJIdY8e+tMB7EGSVIMNvHN8mx5n2QpNdbT6/eLLOwqNuOggcHWgcfv1zf1uGCv2q7sw/Q4B2zcK+Q4o3/mQ4ledjPp8JL81Mhbg3j9YmT7NGi/uGuUfqgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476549; c=relaxed/simple;
	bh=U6QB4MnHdBIHYeizwxxukTDFw4uQE3ezii4oQvWyL/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSic0AbmRbHX0UV7ztVNIZ6uHC/8QiP9F5vXx/Uz0YZnoE4ui2PdKAZSN2qnBpzijbt9ioN0fQnkIDlGqda1GSB+m8EJ4izoGpVXQWmT3uzQsjY5OQ7YAfDCBabZ5zuWgcuhrpkPjt8O8LT3n5K3OWUwY2t1WlfRUAIoSXIITHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfjnbIy+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfjnbIy+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4758bd3731bso481065f8f.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785476546; x=1786081346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4/IxvVyXaXnWBb9xawSOoIIvBUnkDkziVXhjgbdIiU=;
        b=gfjnbIy+O0k7UJ6UIEuD3ymNlk4RqKy74yM2fQZe+hpBo+a+2ShQa5nTvS7y/CD0yQ
         56iDvqPdgj2D4rMCnxAC/HtCTTh+ehzW2Vtm64/zjfWtPJPidaiawsxhrZ28mcAAzZFb
         +Hjvg1nPv2kHb1F/vuqluNg4fTKZqpbS7B3EozIrQdPQ6jGdaJxMcURJqr+tt5zNefxH
         J1sbRItFxL+5RnekPRqHNFFyyO4FopB+/yq5f3k4VZUWpv8PhoQJX81D8EYGnmGhIJ3w
         5b4C7W8X3dJWl0fnzFT7XwYOjI/ql2eR7LG+g00Fpv7GGWAWkAt5KTDduhLsbdMC3gPc
         ZhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476546; x=1786081346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K4/IxvVyXaXnWBb9xawSOoIIvBUnkDkziVXhjgbdIiU=;
        b=iUNbTdXyeiyMcPhatoyYyEsF3OuirvG31zelx+I5r2J0xn8+wSTLH9OLqtqbg6Khfa
         F++4tJVlH8sDPg2ykxC5soJBxHcBDWL6M19oSOZ+B6DkNgn4sXg7dsOpOdjfv+A67ORY
         ZNpu4DskNnX+CQ1JuZW/fOyUXcGpsUIyYixYyELrD85Rvxl6yFztfIm3aTUUBi7l6qkd
         j2EFLxcqRZZKXTQaADVZiLvxq2C0P9XghDf7MKD/AioeH6GySBQq04hImUcd/rN1I6Tp
         SJW9PzUVceBs7K7B828OV3+c8Lh+72BQ3gS774M4Y2Q+Osn3y+ErEFLrbxDCt83ubnkb
         hfLA==
X-Gm-Message-State: AOJu0Yx8LyOF3t0svOCR7NDYOvEKlokXDZ9L4xO2hXEsAO/p5VMfOkB3
	1owPqJLLrdNLMkiVUf9KAyUS+jkpTUGFoILEPaam3+UZ7Npnuk0IbJ+S
X-Gm-Gg: AR+sD10gtKbkI4EIGNp53B62ipdIHsdCUwmuZMVZHdOnugJRRoZLzfnGAQ/N9S8Umck
	34GOmRGcmfqLZJtBJVxLQLTXQHWzB3a9Rz6mdDbqu4haeeFJdFakL1knopcWqAJuLxGhVOeJ0OX
	v2Jg0iKEtbpUepLGYgwFzQAx+0G7WGAE+kk2FDDututg2/pTe8qyU7wAqUBiymsidHkjd0KgEZb
	vq9gvZAM7veyvmN8Kz8NDvRbm4p3aS+0EdEB1ot1sdYDoaBrhxRCZ/9WiaIo82wb620Fdzdg8fa
	TdQ4K8EfZdWAOydUkpfXvUIetWiWuNzpvbJWRPp0WxJgNKXDMO2PFnT5T5UuehhKAaNcU5DH0Zg
	xRgt/a5etmmDLz76RtdIwKkEY8/tzOIDVzFVH/VRM/NUSQELQ8md1dJJqeL/a7ahwdmzEUUkoqz
	ldZBdTlCTbkJnxIEf71s0f+wKq6sbCdqyfSKKuJoP3D4tG0tyICCm0rWWgqiXy+/JqJv53rSXQU
	kgU3FbipUNrfLMxq4A5qim+GWqmGxg=
X-Received: by 2002:a05:6000:2989:20b0:47f:9208:9e4 with SMTP id ffacd0b85a97d-47fd33c1111mr664319f8f.31.1785476546290;
        Thu, 30 Jul 2026 22:42:26 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm412873f8f.33.2026.07.30.22.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:42:25 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v3 2/4] input: ff-memless: Handle FF_TRIGGER_RUMBLE
Date: Fri, 31 Jul 2026 07:41:57 +0200
Message-ID: <20260731054159.1982164-3-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
References: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
 <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine trigger rumble effects the way the other types are combined, so
that drivers using input_ff_create_memless() receive them.

Because ml_get_combo_effect() groups playing effects by type, a trigger
rumble effect forms its own combo and reaches the driver in its own
play_effect() call, leaving FF_RUMBLE untouched. An effect that has
finished still contributes its type to the combo with zero magnitudes,
so the existing stop path works unchanged.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -289,6 +289,15 @@
 			min(weak + effect->u.rumble.weak_magnitude, 0xffffU);
 		break;
 
+	case FF_TRIGGER_RUMBLE:
+		effect->u.trigger_rumble.left_magnitude =
+			min((u32)new->u.trigger_rumble.left_magnitude * gain / 0xffff +
+			    effect->u.trigger_rumble.left_magnitude, 0xffffU);
+		effect->u.trigger_rumble.right_magnitude =
+			min((u32)new->u.trigger_rumble.right_magnitude * gain / 0xffff +
+			    effect->u.trigger_rumble.right_magnitude, 0xffffU);
+		break;
+
 	case FF_PERIODIC:
 		i = apply_envelope(state, abs(new->u.periodic.magnitude),
 				   &new->u.periodic.envelope);
