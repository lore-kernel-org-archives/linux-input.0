Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13632B10A
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297639; cv=pass; b=lSZgEvlCkBubwZPBzUE3YCkbhwru8/XG+n6K33okKYLxWMOk/fenh0cglTgOdNFOjvSFL+MhPzdNOQubdrH5oizwWS6xlwnvd9NfMxvsZb1g6XEJ5XcqyupQUOQTwG8n9pdM3dmNAlmdm2Yt1ex0WDHsHoxz0Sbmo+hMYK+EcdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297639; c=relaxed/simple;
	bh=WKBx8JvfBbjsBY1i2H+N0uRa1D9VefcAbA8vGLEQOUY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LZk66X6nTXADqSFNWTOh2UVg5+ZtEzVspsXr9n/bVlVCltIFKqeJn95AsGCl2uJuyRREBAdTF0iCq4nIg7FGgjOXV4NOlv8c8niQPsuQti5plnU9vXkTRUDqhvBkISzgE/vWGQx883V0lNVE21F7Svjjjy7d5HyMXhGOGRMyuRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBiwol+R; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBiwol+R"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dc67a5e102so36841887b3.1
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 00:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780297637; cv=none;
        d=google.com; s=arc-20240605;
        b=Ea2F4wai45TuiCB01sO/HC2pPQ/sohuTqYIC7jDg5akEyRb3sxF+7PkF8kWttLZXix
         TgUz/x8OvliMDGmdSrpmibySeVl7hISX0tnTJuDG5KVlggBB2UIdBPv7Zkd0myn/jXF5
         GCpxPYiSJuojVkTRkCodNidjJxsVz2kRNaX2KJABO2XTZWpavjjXXL6FyCO4fR11e2lA
         UOXES58LKv8WNfDrdt34w+ewgmeBJXF6KhZN0wf96+qQPg/RbscUWs456uvBGO6HIBqq
         dJYpPWl80BtGWQcG4JmKW1wUAVPozdh2JaQ4AYeXheviayfsHIz4WWeJw7yZ75RpAvpj
         2Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Usv0YpqwITC6Q2DMgjEFBZiPSS3xNqjj1oLd5uvBiN0=;
        fh=On0FlpeAXZW6i6EK2bPFR7t02H5LEFG7rvNLtIaW+OI=;
        b=FtYwGj1Dvrel9ZYnSgP742SCgSkpGMG4OkTqKthbePojJlCkzuG9xaSobaRBzVTgUO
         gwz0+QOmsM3VLPF0Tcup01QRNGHNelVc2bYHyglKK0XlljA8ZudVC3vLV8OpcLcW007n
         bXhfZ0HELeENsUL6M64nmpRCg8qV+6Oi2icwNUKjhzWEj22M3fdxJXWTEx1BGmNdq+hE
         ABTF6apJwhRxfBQFsXK3AJeCUopXf1VnBEwHDuAnVkh1gzQZE7rTwG75yZ2WCRaM8BeT
         dQ8Bz/bHb23eF37p056vCCm9IY8sA7JGFfiR4C3iS3q3F1YiwVqS22TnpFrygfgmGIsk
         3+Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780297637; x=1780902437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Usv0YpqwITC6Q2DMgjEFBZiPSS3xNqjj1oLd5uvBiN0=;
        b=UBiwol+RAcwIayu6+GuddVR9C/v6gDQ3eCI1HmUg7xjZoQlHzGTZZ3+8cCDP3OTBll
         U6In2XSwLmG0AltuS7bh8LInIG++o/SeJtro79y/J3Qf/lGfp4jPOw3ZZDNsn7Y0elxX
         Hx2VGRRvEpF9TCOgOaE0aSkYvetFIX4nKipbCacYDuUcD8Yl9RgDxECBAu42pi1HpmXw
         Z+02f3uZW6WMxkLN/enTmP4ntyYg6R9i56vZecpCJkbq+YaCoyGUDZlpvnoL41WnbfQK
         ZDFKyFd27uudMYKXnyybK+mr/RNOXeqlNkAogRFopZzq/Fwfz0QjNWa9TSUBYiaY2A+B
         trZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780297637; x=1780902437;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Usv0YpqwITC6Q2DMgjEFBZiPSS3xNqjj1oLd5uvBiN0=;
        b=eL7RwJOUUL+gNCxyNXsfCU5S/xluSIkTsdZcd9aB3sUVHsA38UyKm3JGTLswyWtiYi
         v1le/ifGwbzQ/hXy/Et3j3T0N/8CeOC8v9WnN3oDw+7wjonNkwSXsCCxqIFeKg7TXEaE
         0VHEfm/doPGQnuSivP3h+foOyNcGaVrE2MCo9hP23rUZXAoYOkFHemh5H7bkpm5cuJvl
         x9ZaaehCfh59weC27YL9AY+gCNcZNkv/TV3o5WcsfbDpO4jB2CB6Q/pmFOXbNwn+9aeo
         ECZ1bGsER1i9XlvuVwpYpQ5TlgCK/FIn5sVN8aRF1bo1qFvRQ0tuHTPSYMyt5iu8Eo4G
         j3Qw==
X-Gm-Message-State: AOJu0Yxe80Jct9GH1vH7ZzVkkSb63rrBUPYaQuoT3IYsmoytq4OmTons
	Eecp1DuhVsHbHc6MWRBgfLumqjdMH8zU0O6s2eydRZHrpa5ZyubJyXD+ad+IayErYYw3Vs2oEeW
	f5kzLaVBBeLdle2QlIDL2vMQ+f9t2QFU=
X-Gm-Gg: Acq92OHUBo3+B+A2DyEYsasyXnYcku5bHf6wcx55vGLsJdYowPQNRLVqrEu3hDM0K1T
	AxoFTjbV5qfQVv3MOS4lUS/qyf2HWYU7OAU4M1NqmzcSkYSJMH/XrKag2NXMYR8CUBHaC0RUjLp
	4BuNE9y6Ta5Exmz/i+3e+yAAz0xZD0gas4vBr217/+R9o8vpO3zjveQvfEua0dqGs9ejEhYKfCN
	Sq5DDqKbpMxhqJ4txvYVcP/PKMjwrj6WIU8kqI8dwN/uvhjQ18d5kJ4x+ZySVKilHQuzqz3X+MN
	3bES6Rq0w422MnY+EtxhsDzVcBP0cVQ=
X-Received: by 2002:a05:690c:c52e:b0:7dd:b0b4:409c with SMTP id
 00721157ae682-7e05c66b1admr89459607b3.25.1780297636889; Mon, 01 Jun 2026
 00:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Mon, 1 Jun 2026 15:07:05 +0800
X-Gm-Features: AVHnY4IMFidN8lpzFg9_xsnpfoUGNDTI532bY_MWtG1kpubnZso4tG0DqnureFw
Message-ID: <CAGp+u1YARE-sqwuNtbpG7E4TO-Nt1KQEeWiHn6pjoLz5kmt8HQ@mail.gmail.com>
Subject: [bug report] Potential atomicity bug in drivers/input/joydev.c,
 between joydev_0x_read() and joydev_ioctl_common()
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel maintainers,

My research-based static analyzer found a potential atomicity bug
within the 'drivers/input' subsystem, more specifically, in
'drivers/input/joydev.c'.

This potential issue is present as of git commit
eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.

Potential concurrent triggering executions:
T0:
joydev_0x_read
     --> spin_lock_irq(&input->event_lock);
     --> read from joydev->abs
     --> spin_unlock_irq(&input->event_lock);

T1:
joydev_ioctl_common
    --> case JSIOCSCORR:
    --> write to joydev->abs[i] (no unlocked)

The above trace is meant to demonstrate an illustrative example of the issue:
IMHO, in 'joydev_0x_read', the 'input->event_lock' is adopted to
serialize the read
accesses to joydev's fields like 'abs' and 'keypam' or input's fields
like 'input->key.
However, in either case, the write-side accesses to these fields are
not similarly
serialized.

Please kindly check at your convenience. Thank you for your time and
consideration.

Best regards,
Ginger
