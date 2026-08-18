Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5828448CE4
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054674; cv=none; b=X1b7Y194xQwNWiQv7j8UMAG1YCUlvTh40EZ7sGkr5MWkLZKWZfHt3n1urQIeaPiIIKHpKwEMx98FOIhyFs0ndCpdkOtwN9Q4W4G2UssPGtuAPfNNgBQh7JhOq7v33pw5jRZdxQf731qm0t6RwLTQDqWH8IFnEfwsB4DQqiqkLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054674; c=relaxed/simple;
	bh=pTT7qBp+WwKNO/c77Q6ABkmdFmw3o2ARDNzMO0aj2XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+M+cvsVB+cW1+HQVqFvhTMNqV82AU7JAqYL+LGhK1b4h0A1qjVSnDruUyNX5dVz7bqZWvyuTCRh72JWbBggPt8ZwKc2eNcduIvXM7KrY0puOLd4jZ9FeXNwLkHrDAhUC3oo9J562zC5fL+7oSNMn9/W89H+53k7rasWVH9O3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mofg/T+S; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mofg/T+S"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so38004091fa.2
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787054671; x=1787659471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5SA3qexvx0UXWIAtCFlkPfhyZbzB9r1OKgCFasYg5A=;
        b=mofg/T+SZOP7Yo11ffvnvQjcnTSLpCnVdmeItvjT6TX1wl5Sfe0U5MocxkiHiIlaYW
         R8PKrj6nUmZJfzmTdWLbaw1G39onHBd1lYF39w2PRUQF4UbzEG96w8zHmSTm0nxySBmm
         k2wiMe/97TdeHyX6/ESu6bGKvwYZaizhmzA0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054671; x=1787659471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5SA3qexvx0UXWIAtCFlkPfhyZbzB9r1OKgCFasYg5A=;
        b=UUkSWtYXSUIqG5vfnv3nRHdOyBLOKKCoZf3PuO+dt3kA1FUtSioHzwLcVH6QIspuSu
         PLSyoMf0jppv9fFp6J+xuGOEZaU6cY3ZCgYnZqmJSAIIltqbcpa2VuxUqYr9Tks/Kdcb
         wtf3Zr1H+4ru2nYKzlsrAMDrqTj8tJ1qyipqacgFmPfwSuEQOudXHMQgt/WevniItDDM
         H+usQxslOej2Yj1WLf00fNIsD6a+tb9Wwtmu9954ic33DULfPGAHFLu4zl5DbCBSBf0l
         LvcvN9Wd3IY8H6pzMePVJ4xlspap4lRnIbflZNeLKnTrb4xbZdBcu9QSwZ+on31Zs+bO
         HEwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgYjkrmI8YFItVFIZ1NpmMfGs3QfoK7EYs85t21C68raAAygKd7dryShOukCSj9qZScy9wDdTVK4Ce8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPYd16wkb67fuXOK87kVeFgKRmlkPISeNK8tAOknGsAC9mST/
	GoD9vKxUnBbyLbHxiTfRRarCagzuMxnb/lMvShJlyd3h/yhNAnf7wIwI/gYXhepyxTJbw1Z0TUE
	OP/hLPQ==
X-Gm-Gg: AR+sD12YkU+Co+PaxSfKhmqyxBVkS7gsle5fPJ0u6iPz1Xubcjsql+Xo8R9rLpn5ADE
	bi8ZAhadIYANQEmPTSwvCdDkQ0v7DXBKrSZw0tIJSezyVvGOtZNiUi9IbD2ctC6dpoR+8nj9ClL
	bVl3akeholtZ00gmN1wGsRpP3qJ4oV+J4XAZYlIV6H38DFY9YnXmaR90wvm8p+HyXpQWDUB3BgZ
	hyNV4bXFEdoDkPNafEjc2+kQhOx2Ximwy+lEPCi4lAFVbsD4sjZLyVCecMElGfDfqBq4Y3CQtGd
	wB3LpyRklut9F7PtKvf1ajXRtwYAix5G5FTIm9yXgtO9PUB4EfUpRKyFPZTryvqKzDZZV1aBOPA
	ZPw8dbE3ZhI4fV8fvR2zViIux3SFsm3tho02r0smW6TNKc/qB4WMK6aGks8uZXMQkh8RS5mpJYp
	PGLKvboWuTETG1x1+jcS0qncTRA9uPsU/4nrjhL2Wbitt1IodmMTbpDQ6oi78MpkT12EYEgbGsW
	Qyze+GgteJt0C3Br+nryVb0zyBAAab0dol7/UwOyPdE
X-Received: by 2002:a2e:bc84:0:b0:3a1:39d7:c6ea with SMTP id 38308e7fff4ca-3a1751ee9b7mr13195061fa.11.1787054670724;
        Tue, 18 Aug 2026 05:04:30 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b204389sm12047321fa.42.2026.08.18.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:04:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: Julia.Lawall@inria.fr,
	bentiss@kernel.org,
	cocci@inria.fr,
	corbet@lwn.net,
	hadess@hadess.net,
	jikos@kernel.org,
	lains@riseup.net,
	linux-doc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.palix@imag.fr,
	skhan@linuxfoundation.org
Subject: re: HID: add documentation and Coccinelle script for FF registration race
Date: Tue, 18 Aug 2026 12:04:28 +0000
Message-ID: <20260818120428.2546810-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
In-Reply-To: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dimitry

Looks like media-ci is not particularly happy about this patch:

https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/108127901

/usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /builds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch /builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/ribalda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include/generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/include/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/uapi -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-media/users/ribalda/include/generated/uapi --include /builds/linux-media/users/ribalda/include/linux/compiler-version.h --include /builds/linux-media/users/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1
Position variable r.p2 on line 20 must be attached to some other token using @.
coccicheck failed


The following change fixes the issue for me... but you probably want to double
check it, I am not proficient at cocci.

diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
index 479f5d1e3184..7cf84936db13 100644
--- a/scripts/coccinelle/hid/ff_race.cocci
+++ b/scripts/coccinelle/hid/ff_race.cocci
@@ -9,7 +9,8 @@ virtual report

 @r@
 identifier probe_fn;
-expression hdev, flags;
+identifier hdev;
+expression flags;
 position p1, p2;
 @@

@@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {
   <...
   hid_hw_start@p1(hdev, flags)
   ...
-  \(input_ff_create\|input_ff_create_memless\)@p2(...)
+  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
   ...>
 }


Regards!
