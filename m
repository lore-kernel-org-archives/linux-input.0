Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC63BF66E
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162505; cv=pass; b=bHRKX9tSTZhA222OMC7bbNUwxnS1uPJZOIYtrLEh8NiAhbSng/XiORPpg5vqaPrRJrBRx8mnEh8hgeQj6tJ5cd6ur3iHcCoAiWX1KCOkkkpXSyDsv2FFrkbweGrv8n0j+CNhqOCu/N4JqcUP/ctAdZ+FYDU8YXapCOR4syHt8K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162505; c=relaxed/simple;
	bh=2U/YHmnNSMXb4kAlU6UnBe9Ek70iIOR2VlkPsQRm5tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWFk3D7VwXNn9Dew6ZDn8yEyxmB0ZwdVWLPvNsL8SpDXKuxeK7Yuc52EGBZ97zfCbuhrxQBMjqrHxcguaF8G89YnqnKYBSwRK+yFVyxhQjFsoaaZIMel3Ce4DMjaa9sxl6HuhoMDpoD4veFuHdC3VfzaQFW9L9lMJprSSFZqtdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akWo6Vlr; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akWo6Vlr"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-46703fb602fso907415b6e.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 10:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162503; cv=none;
        d=google.com; s=arc-20240605;
        b=Me6VPjKzhoNk6+6zvnlNdEikPaGbm5EP2oUq3Zu6O4kAEKChIEip01h9aQsKExF+YT
         djrDQHxptOhLKupqEp7vKXDAFNEmBxhhQ2DNR5PJo3snVl4xWuTJFsKXTvM34aFBoZFt
         oUmD0twqIDkT4cJ85yEpgRKHypb/48RP7NmXU8lFifw/DurSV5wg5BuZwtODGBThi2Ng
         XvqaC1Wkja3EqcHaG2EgiHhHpzDvUaKVg88abiqhG+jR9sd7YD03ar+Q+4zFtQq1BFrC
         xKeNb1NwzEJD9yrJJv3YmYE11fYNy9RDvRsTf3lZbomPoZ/nXpYNZnnTQynXd53r436Z
         Jc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SGjIKYsVg8+/FngR4cBfWixXzW+UJX175bX4IGrA7TU=;
        fh=94j/QdI3VMo4wehU8E8r5TH0TIH68rDgdNs5tne0BjY=;
        b=aEepw168L7UPCWmAIpdDrsHI7/kVo8ZCEftVlJHm7QGHIvmC6qhfLjbEqOrVbwn4yW
         ShCBEUpy/4rJLpaGWeOI3vSOSCkRqFdMXCZhkIxWr1ixgpmE+GzlHfCED58120/BJPt6
         i8jtSaiHHXSE5gPNv8fq3CRLE296B6KyuLmeZH2zWKISQXF+abroVwA1qbdV/UtpCURf
         Si1KqiWNhZr0QKBIzqloLq2OtFWfuUo2A1KRSp5ZRnc6tzFQnr39ZZ7SVB0/rgiZyfQj
         KdzQ/YVU4x759wiyinVYKO4XfmVdDW6EQBlCcOox7RCcpKVdV8gh0zjddVb6kkKdy0w8
         l45Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162503; x=1773767303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGjIKYsVg8+/FngR4cBfWixXzW+UJX175bX4IGrA7TU=;
        b=akWo6Vlr4NXjvz5bBws3d9a85JYE9evL0eumw5OmUhbTB0w+esakD+2ZyOd5aIgnCX
         1gqYQFlfByH1Kw3+86WvB/Kh4vJMZG/qqVfCTY5HVKr21Q1cZirZaf7tNpan89oJM1eN
         0kaIqA3Qq5/1l+qFlWfzwwt3xursrG/ea1gjiVoMJJVJUF8V6YtnIMGu9gAkUySNQfAS
         TUw0Q8o7IoXeFhb7N/kz56S8i1VTqo/1AzGaS76e41Zuzl2m+qtc8tUP9TejW5KOLW0S
         W/ZyPfYrDKvxS5/rilgKaBk+rkX8NB/jO+0SPtFLwTb+/TPoQ4auOl9mC3vakF05bOCF
         n/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162503; x=1773767303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGjIKYsVg8+/FngR4cBfWixXzW+UJX175bX4IGrA7TU=;
        b=e/e35MhmGow9vufQ8aP2hcjRieir7zqlnPMWWEneEqtoiiArLGl1SIhjbgA0ze1jgH
         zpxhTbQGHzHb6mjB6d1pmxZW0Cxxlnr3Bkj/1ZPCh8JAtlqLN4U64WfpOKoyupKd/HTw
         /yntChHIKonNiiGwxWKlIhWW2fBcaAB9k0MqI/3COdVREftY0UMBPa+S3Pvj019I0Aa0
         srGkaIzz058/ZFRDL9W9Z7pqQLdmfP2NOYHdn3PsqEpFwRe0T5EKyz4Uf2RrykYtexLc
         X7iSzj2dXSbHWqz93DumDkZSg1wUY5dDvapThZaTqOBDhwwFNvsYYh4Exzw8osYFfkGb
         wWDg==
X-Gm-Message-State: AOJu0YylVsLAJscP+lKmhi8pqeF99TrRXHyWy4S22lzOQfbkjsuEQePn
	ePSyptI7Y4P78RyS8wMesPtGgaL7lDWnpGXcQciTIdgqlo0HS650+LV6xCEmvEcYO7ukTpZOvjX
	OQX2j0YwTShN3Hu7xC5tT4C35WA0Nzwwx8nZV7AI=
X-Gm-Gg: ATEYQzzEj7h7XQ4c0GbTFzP5HrGoRsImYUOUucGiVEki/u4j0BW78482ZvgcmNAzIwW
	EQQiHxWejghd1N8JbRjN5j8CSXj3euzZWsMVLCRNhfz+DnkDGaT0En2ikjNWfvEiGsyaKwX2Ou8
	qAl1EIu2dTA7AT1hnByk/AuAUekjNrhNvTTDtl4XofoHd96kRe9tISBwKN29DkHxx2xbH50Unud
	u+q0B/1UG0JJ17oQjCJPLf1bzYZc5uqd/YyV0Objl6sHDfecJBIssSN8bVILM9otfVl3a6lU7fq
	gefjmr8Q7NchGZfyXbIZncGJFBtnHYxCEQW8P6fo
X-Received: by 2002:a05:6808:1a01:b0:467:3f4:907d with SMTP id
 5614622812f47-46703f4faa0mr4092974b6e.56.1773162503370; Tue, 10 Mar 2026
 10:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
 <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
 <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com>
 <68d90523-33dc-451f-a825-72eaa1c4bcb8@leemhuis.info> <CANkKV91attPiZ4+6DQKcgG10apUbF6k5hs7aJBrfsnfc5jQCew@mail.gmail.com>
In-Reply-To: <CANkKV91attPiZ4+6DQKcgG10apUbF6k5hs7aJBrfsnfc5jQCew@mail.gmail.com>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Tue, 10 Mar 2026 18:08:12 +0100
X-Gm-Features: AaiRm53_m8RHubFk28jWl6i2BWsGSUZYGC84-yNOq9y5C3SysgD3CzDC2At4lhQ
Message-ID: <CANkKV93zUMy3333wpsqyMjxOKecMh8-hdABVaG8sVfnKusaE8g@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten and all,

I tested the issue on the latest mainline kernel release candidate 7.0-rc3:

1. Built and booted 7.0-rc3 without any additional patches:
   - The touchpad (LEN2073) still exhibits the same "lost sync" behaviour.

2. Applied a local patch adding LEN2073 to the Synaptics SMBus
whitelist in drivers/input/mouse/synaptics.c:
   - Rebuilt and booted the kernel with this patch.
   - Behaviour did not change; the touchpad still does not work properly.
   - The patch simply adds the LEN2073 PNP ID to the SMBus whitelist.
     Patch content (for reference):

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -191,6 +191,7 @@ static const char * const smbus_pnp_ids[] = {
  "LEN2054", /* E480 */
  "LEN2055", /* E580 */
  "LEN2068", /* T14 Gen 1 */
+ "LEN2073", /* T14 Gen 2 */
  "SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
  "SYN3003", /* HP EliteBook 850 G1 */
  "SYN3015", /* HP EliteBook 840 G2 */

Additional observations:
- psmouse is compiled as builtin.
- Verified both with and without the `psmouse.synaptics_intertouch=1`
boot parameter.
- I2C devices are visible under /sys/bus/i2c/devices/.
- dmesg output shows:

[    2.288744] psmouse serio1: synaptics: Touchpad model: 1, fw:
10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
id: 3471, fw id: 2909640
[    2.331172] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
[  252.979513] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  252.980606] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  252.981855] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  253.008752] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[  253.009947] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1

- The trackpoint was previously disabled in BIOS; after enabling it,
the touchpad behaves slightly better, but the "lost sync" issue
persists and PS/2 fallback is still active.

It seems that on this hardware, adding the device to the whitelist
alone does not enable proper I2C/SMBus operation, and the device does
not function as a Synaptics touchpad under Linux.


Best regards,
Mate
