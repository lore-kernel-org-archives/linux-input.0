Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E4487CF0
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176083; cv=pass; b=C5ZTihEqWiwdTMxvhR+QbFfgm4cRjQZiJVALG0wlhZ1EezmOyybeOek4Bp+tsUI521ugAjqEDwwHLIiCwlGYXkC0KtpMGv+h5mKzOt41GPHxisjeRVe8hpzwrYdAoD+ioIIOwB4oUZBgB5he7HhS4JRJ0IiehveVUEsNI6j1xn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176083; c=relaxed/simple;
	bh=sg5SI8Zgz4xOGVf8V/cJ2dwzRqo3725FUwt9wMfx35s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=u/1n3M7w7axNe/etIHqLIsKmMF3KJ9cNCbve3WivLehejKiCPLoVD9yUUF4W3e4sREkL6uJwoyUNRWu9F9yXOrJLuA85k/hvNckjZGi4jLqQ9kDKaaFVzaLBs9KAzc/6nY7aVkR3IYeP2u+9QLAnBqqfU9h5FZD9jfpIwx/ii2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QehnhioB; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QehnhioB"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcf21cfbdaso271522e87.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792176080; cv=none;
        d=google.com; s=arc-20260327;
        b=bAiBKB/U86B0JiRXN196uoguRQ2rUNw1liqH6QIA3MUTaTIHLV1JXLln0i8iYkRQ02
         evXYLdtOBpSKjj/UaSNqWVhKM5ORJJchDLKDN5eWEyCQ+xTtQ4gPxlaRxFnilC/po1mP
         LheUwqWe2UMCDoWy0G6hjXRgc3tbsO7hwAc1r6yag5FoAzcSbWXKJmnn2kUBvpyuT8PA
         fntPr7QZX9f6STBwzpMAz3W/PWIrywhSQTZrvdGl1dPg5O4JZ+dymaVY3LbbIiCG7unw
         7Bdrnqe2dzgBnyDyjmK8x/v8axvYSuvHCE5XqUeGgbcMsBXR8iK66MJuP/h5spvkiRvU
         54Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QZbIC4OYmkj+YwbLq4scwlVB3hG0+rGR0Xr1bOmAyMk=;
        fh=NSgzkeHIZ8n5u3UQTELtvs2rL2gofNpFvXaV2CQ81vA=;
        b=bYJShzSqYjXGCb72rjDHsM4DYPSq8+rKmgRi/LabRS2DE0hK14ttYVpmMfXJqnZSdY
         LJIvQFT1uX4nrdE/JUpBywNTDLDGP99seD+9JZEz3ZQs/OqxYofPffVoYyuC7+gxy1iJ
         sLci9D4V4+BcJOFb0py7n2l1pUf7vjZ27PZn2t7BontRTP6x1w2jVbUh7q+wc39W+0/E
         W4zNsxyjWbbOErxLXlaM2zhy5Ln8cJCWjPyGbExSy4z/DjJTeXLsA/fHFV8+tW8FyBJe
         sRLCO+RMDXW1VpHX3Tht0ayf41V3ebGBr3y4jbL5baEQ5ZjSHrucwnrbkB7RkCqIQT/D
         U93w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792176080; x=1792780880; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZbIC4OYmkj+YwbLq4scwlVB3hG0+rGR0Xr1bOmAyMk=;
        b=QehnhioBQ2SKSwJ6CTkwf8RA2LQsc9A1kxTUVVqrTEAw/fS9vucrnRd9+CM7HCF0jW
         Sw0/KqB06nL/NkYQwyI4zfWn6qxuCA7lufZjHi+ytHuMfX2SCkvU2U2fK7RHN/6l1QXp
         DEJEnmSinu35tCz/v809BTN4TTa8fMYrEbOluFoIFCzxssiQY5eMZVrAmvM6/i3d4ByC
         QLEsWTQbevXm2DlLuJ93Bir8WZsq7GC7xopmGewZccZXjr7zmdJqQBn7fTq39wu++r/s
         dbgQDYCvYIRYxh4AwQXO15jtvgKLHxEI6hrm0CB13SgDugWJK8MMsaoVZN0EN2E5wqcn
         GDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176080; x=1792780880;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QZbIC4OYmkj+YwbLq4scwlVB3hG0+rGR0Xr1bOmAyMk=;
        b=pMwJi97ZDmVClJEzk1WNOJOPmLIGIK5fZ9OD3QAi+CrjcEThodO9QGZEuOWWKK+3qv
         R+iuToWrL9Td3jktYtT2glV/51MYUao79hhPXhFTDpBUHoiDDgFGUu+uTeMvf8GRWFWf
         EFyBFfrZETkrvNOqP9u7BgkCMMuuJ49q0JVfZnFQ8BBoZ0YyFWUlwyJyyV8iBUm2B4ni
         Hk2CPPX3XC/lVHV8ULoNKsEoxoGYiSqG356qJs0q2c2ewcHuP4Bn3cq8p3gSFNwBnL+4
         KKvU7jQLmLjoRI4fnMxu5Ekyb4h0iSRRPE+PQjJ7mQJ/Z3wCJIS7p9M+yjROYjkhmcen
         jJKw==
X-Gm-Message-State: AFq9FYLzrcF+Z4zEBCCFz9rR7ZqYx0KVkja5BvaTPKv8teZy1rcpivD4
	0dp8kcyVIWA6mEc5cR+JEyekzSwCy4EUpb7qlg9p7IKwW2vLhGZERC6h1vdwjXR1hVVJIU4mda1
	lPobF+/GHdn6nPagUGCFofuJiSNnCN1c/cLQB
X-Gm-Gg: AYBFou3FJGusHlY2RdmixU/5wmpzrV0RkT22hFJk82OeQxrcwNmYaa5OkYMX4HLz/45
	3YKPsiQAaUve1O2bkfzT/IwT5nphrVxPFz34XJyaw6umbny7s0GUOVFE5zXrCnH/b4feA6j5hDR
	m4+P/h/lD5OBdBayVEVN1rinuTXFwx3yW+jcYwgvxizwqYtx4/o5F1RDwSfH4d/SV8E1z/BWYc3
	mqv3TAEKk+mtDYdd+9cvbDDlldb0tGoLJrxZiJb5S/sAKR6I5tGspUYwC7MLvLPasZB1PA6uYAK
	7/7WDuKttuIySbQlLVtAnMckreeoW83NDpIqlIW94og4EsxNLdg9H8bh2ux3PW9OYg==
X-Received: by 2002:a05:6512:3090:b0:5bc:ec35:2be8 with SMTP id
 2adb3069b0e04-5be50a67adamr119532e87.19.1792176079673; Fri, 16 Oct 2026
 11:41:19 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 13:41:19 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 13:41:19 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jame Jao <jaojame6@gmail.com>
Date: Fri, 16 Oct 2026 13:41:19 -0500
X-Gm-Features: AclHuK_ZQQ0Ya8fhhWAGcKkx6RTeHaCg3tMgnRhCFDIeymCeWR-sj9K1ROTuskU
Message-ID: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>
Subject: [BUG] Input: atkbd: REDMI Book Pro 14 2026 (TM2426) needs dumbkbd workaround
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry and linux-input,

I would like to report a built-in keyboard compatibility issue on the
Xiaomi REDMI Book Pro 14 2026 (TM2426).

Original failure, observed on Arch Linux 7.2.8-zen1-2-zen:
The internal keyboard could not be used after Linux booted; an external
USB keyboard was needed. Adding i8042.dumbkbd=1 made it usable.

Current verification (2026-10-17):
The machine still boots with i8042.dumbkbd=1. The built-in device is
"AT Translated Set 2 keyboard", isa0060/serio0/input0, with EV=100013
and no EV_LED capability. There is no input Caps Lock LED interface.
I understand the missing LED interface is an expected consequence of
dumbkbd, rather than a separate LED regression. A local userspace
workaround writes SETLEDS through /dev/port; it is not an input driver fix.

Hardware:
  sys_vendor: XIAOMI
  product_name: REDMI Book Pro 14 2026
  board_name: TM2426
  BIOS: RMAPT4B0P0909, 05/21/2026
  EC firmware: 1.9
  CPU: Intel Core Ultra 5 338H

Current kernel:
  Linux 7.2.9-zen1-1.1-zen, x86_64
  Arch package linux-zen 7.2.9.zen1-1.1

This is a locally built zen kernel with a small bitland-mifs-wmi
suspend/resume error-handling change only. No atkbd/i8042 or graphics
change was made in that local patch. Kernel taint is 576 (U and W);
unsafe xe options and an intel_bios_init warning are also present.

The current upstream atkbd.c DMI table, inspected on 2026-10-17, has
atkbd_deactivate_fixup entries for Xiaomi Book Pro 14 (TM2424) and
REDMI Book Pro 16 2026 (TM2425), but no matching product entry for this
14-inch REDMI model. This suggests the same quirk might be applicable,
but that is only a hypothesis: I have NOT tested that change on TM2426.

Source inspected:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/heads/master/drivers/input/keyboard/atkbd.c

Limitations:
I have not repeated a boot without dumbkbd during this reporting session,
and have not reproduced the original failure on current mainline or
drm-tip. The original no-workaround failure above is historical; the
current device capability and DMI information were checked again today.
Please do not treat this as a tested patch or a Tested-by statement.

Could you advise whether testing atkbd_deactivate_fixup for this DMI
product is the appropriate next step, and what diagnostic data would
be useful?

Thanks,
Eason
