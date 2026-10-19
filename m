Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA93DA5AA
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396339; cv=pass; b=QkGYx/An22fcYZPbnV1LkDitOKi64NRg/H64q1hB182tkm+rkGe2Y3AnD+PTNuR7TmoMw84PDS25IuUhrI4wb+plN5dfpeQElaltW40l7TPdjYc6Cq4Yh+dzA0tG34I3nCIPx3TZGPizNotJuNZXT94jJRLcPTffBuohy6yZxAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396339; c=relaxed/simple;
	bh=XZJueuc5j06DV+OJMym7OlAemDED0L3fnLmcjtir0Is=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XjfIfUKcc4AXQYQnmJ8c3k8Cdp7oWtN9tZgTfcoKhNG0n+eXxmiPN7Ckc96QKhvIUo17fwZ7zQ7yTo/2DAdAndupD3kTctbSt4BhubpjtL8ZObdRHm+FNcD+aQoFJRqtvbx3wN6lNPoXGrqUpd5lpkBY33f8CFx+hP2K3RHYm5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nblb2Sz9; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nblb2Sz9"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso2044540a12.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 00:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792396336; cv=none;
        d=google.com; s=arc-20260327;
        b=W2TL63Azk7ZXW+2NZ16zZru0D9yhAi/HNyry8cNxUR7nmvccqqXPi6CxINfiK9/No2
         13N+UMKt7G2QqPTXZa9VzRd30XxFKxz8HxKbG3qcZbrFCubrlEw1hZZjBbc0PW05ux0r
         zj7bCvN0nPdHitJnwK3Rq0GgsEDH1tawhPfmf5JwgMc23O93nZOOOVSSjbGV2TbO6xgP
         IzVEHHb9r5cctnvkvFyicaBb8SjkbS3mxmSfBOWcwd+SrKC4+6Fffp+ru8b7Nc1HhpOa
         q0yodA+tMGNtO6EiHKhHuGWo+24EiNUiXLvNExCSzTIc6uhvynDsG77pnirSljKvFBVZ
         qL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=d0YF84RbBDtM8CfYcy71f8ct2VM8PtglEnPjSuG0VFU=;
        fh=OLBnQV1N9ZJNuvjxgnwLOnxNUv9Ed2wf7UcsqG5mRpE=;
        b=djOSq+zwpTN4Ks5/jFGvh3syPq4OaZRm1f42vLHqloZ0/I3NPllLUn77OkN57VVgF8
         Nv815wSgGPzieBB81DRkEa+6aR6t3Yg7l6Kawfh/BYqOAa5VfovwoS8ZravFGBboFnvB
         nY9HkmlHyn9yI1aWfgU2FDoE9g9p1C21AQuHHddsDnVzfP54tOlyDgyXCFQhmvrfoTQR
         d13x7VcZsTxM7Icf6+Wuqq5tK/HSTQuwKChc6xoRhBrKpc9AY7FO9WskluN8PU42guOv
         MCjXTsARX13FU3N4+ALvcx9YX12cOGUi7GMpdEuys6JM6zGY8Pk0qVq+3nYmD1aFWFiV
         62qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792396336; x=1793001136; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0YF84RbBDtM8CfYcy71f8ct2VM8PtglEnPjSuG0VFU=;
        b=nblb2Sz9TYwIwkqxStruxmjTKlBdPbirI72ItKMhRKcgocaNOWApZ5ALfQXj12e4B9
         wKsHzZGPDC+3h4d1RiV1RlTwYzDEg3bRoTfuoukf6S48HKgMEPXxeN36L008APeUePKd
         ojTcz5+t2CscHENcqJBjUev/4W8VL9x+/LUDCKagcTvjY4wAiGbgNLwouEI5YrZ00ff5
         cJNeAN2pjKzsBfM57qcQCr6pOsekyovSy50omTG/J86OeuKVwu8Oks6owf+GPMCDbi7u
         gqvHS9elL3uifj4bf6pGRHOgRuzBYIN3BA2CG5DosR0MTvPY5czZFcoLQMR0Nj5sL6lF
         139A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396336; x=1793001136;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d0YF84RbBDtM8CfYcy71f8ct2VM8PtglEnPjSuG0VFU=;
        b=Tn8rnI1RR4bbyZ2S274CllkpsWZR2LM8Ks8pUzq2gGZI8cFj5AzT5ryy33dYr+dm/W
         /ET3TnZtbXw4sAKDDdZ1L1Xorlsc19bFhFTNMr2rm8ByiCj6NBxvBdXXa0R46kfSsUoF
         +/pPwNbkfj/MfzjN2o2yxRExnLq1/T+qodjCr1de1YF/gFIuDcx/0VffCmlTWkc+cM36
         W7AjOwCEy254cNYppfJ+MBntSZryjcLKM5jK4oyAx5ndgMO2UV6PYGMEJ8sTqyn46qd5
         jZWZ/vRkdqzVeyrc+veWRD6aYarGNg7KcJpEWUv13o02x9Q7nrgopnPLWfSfpsTv2yxf
         WH9g==
X-Gm-Message-State: AFq9FYKJUOKCRKNxyMMhj2HbycJBm2lLetSuvuAfKNwwwA/YYbxkk56L
	asBhisfogfjJtP63R5AZ91M9m4paDWdELYTLa5e4i0kAToiKwxw6/tXVxdXTKmIaqLevgoB6f/l
	hqsbpnlHosdG1IJFatRBe9IS56S3ONfkr6kHzNLeScA==
X-Gm-Gg: AYBFou2mqpwKOzLfMECtd0pX5mbHg3QcP1NXlWK2TyvIUuBQXHJ3VJIsb6GC7Xrx/J0
	3qU+hcDNorfmFXy6N5VA2IMScALSxpTxCBCsy255EjZP4s9zs47UwUSOe1eOSj/WUaB7FG92Scp
	YLGcD3cUrzjYW4VFBSrQygLspSFu5hA6XTBxnYMct7BbOSBFifXk8wPrgYSEKeqaH41li2HMZnW
	fArI6g4ZXgeBMrNL0fYsuIrGqnYL4oLBRF8x2M4WarwC1IAa4eg/6hjio39W6jCKqgXXd2aTZ9K
	ARIgUUD0ovMlrkNLmdjpXP1Ko4azF1GpSxGAsbiW2jnmfWjoEQ4rm9EJh2QMfuqIhRrUUpK7h5r
	1
X-Received: by 2002:a05:6402:190e:b0:6ac:b9b5:8e8b with SMTP id
 4fb4d7f45d1cf-6b3a8176960mr4361763a12.15.1792396336146; Mon, 19 Oct 2026
 00:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Indrath <indrathftw@gmail.com>
Date: Mon, 19 Oct 2026 13:22:03 +0530
X-Gm-Features: AclHuK_Uv-Xi8XsEvnx9gS2aD8EzCF3zYcHTItqX8kGHhGaLdcX8aA8RZReUXNA
Message-ID: <CAGFfo9K1+WJjuKsSgx+ezLnzcZ+gPFXDBQmZ8W6dDC-oHbd-iA@mail.gmail.com>
Subject: HID: wacom: avoid NULL dereference for incomplete wireless receiver configurations
To: ping.cheng@wacom.com, jason.gerecke@wacom.com
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I found a NULL-pointer dereference in the Wacom wireless receiver path.

I verified that the vulnerable source remains present in upstream
Linux v7.3-rc7 (commit 32c52ec87d6245ee2d12ed5dd509e40062939b50).

I dynamically reproduced the crash on Debian 6.12.113+deb13-amd64
using dummy_hcd and a configfs HID gadget. The gadget exposes
056a:0084 with one interface, binds to wacom, and sends the wireless
status report. This triggers:

  BUG: kernel NULL pointer dereference, address: 00000000000000c8
  Workqueue: events wacom_wireless_work [wacom]
  RIP: wacom_wireless_work+0x61/0x164 [wacom]

In drivers/hid/wacom_sys.c, wacom_wireless_work() unconditionally accesses:

  usbdev->config->interface[1]
  usbdev->config->interface[2]

For a configuration with bNumInterfaces == 1, those entries are NULL.
When the device supplies the wireless status report that schedules
this work, the first access to interface[1] dereferences an absent
sibling interface.

Expected behavior: the driver should safely reject or ignore a
wireless receiver configuration that lacks the sibling USB interfaces
required by wacom_wireless_work().

I have the reproducer, full dmesg, and test logs available on request.

AI assistance was used for the initial static source analysis and
editorial review. I independently performed the reproducer execution,
crash validation, and upstream source verification.

I have previously sent the same email  but was rejected due to it not
being plain text
Thanks,
Indrath
