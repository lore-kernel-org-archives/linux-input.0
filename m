Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22365224B13
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786856643; cv=none; b=NKs47XpXZZK6zM+ghOnEU6+kvEpqLN+XAa3Eej9U036KlMWyIhlYA9Oa09mn3RBkEeGt5BHNtAEBrD5lZUm/LFBfqKg9FNgvufOK/v3u18CHMrBbdbVO+26UhOBK6r0WHmLtHLwcRV4xNt6M8dxxxxTOVUyVrX2rIEZP4U7C6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786856643; c=relaxed/simple;
	bh=/JFqH62p31KSPNQlaB6xj7khgu6niNzrrobsJjq5VCA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RHjlsLb6pN6/+mjq6yY5RkOmlfSGHLe7/EAqPQYB5LKs/emUaMFwiSNs5a3YXOJHTKOAEAchmXIpTcKeKPymsy1gjAtIIF2R0P6x0UGCm03LBg1TFUkB0VSKgIg6JncRqGjCSPD0Oa/LU0mNmy/6tf9ljKe8JAyV+KWu69kfIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqlXUmVB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqlXUmVB"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1294312a12.0
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 22:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786856641; x=1787461441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7g5CP80UiMIRBFga685VLvP4+LJcpzfyF27b/rjUI4E=;
        b=rqlXUmVBldk01g5l4R9UTS5y5P/e9nvN/e36fZo4i102rkODrrYELQoKC64WEJblea
         g1V8/VdIJ5jmuyUC2ORZdfB4k2pbS7uO2pIH47wIiT6Eu2w+tpd3YVuM69tgqueSRtTO
         tI0EENQJTY6npO071Kvtd+KcpNTrSYU14KM9I8wsnubng+75GQr1c6Xp9pc0E92x9t2r
         rN3I91410VVKbXCTebYqCmL819ElU2hgymH4cudIw4k8sImgVnZuCyjQ8pCV75Q0imIB
         zJcObkhmM8msF9G+trYlrQ9/bCZfZFBRtReMqHSOkJj9nA4Zi/PofSTrjXlgfUIfRovt
         C8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786856641; x=1787461441;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7g5CP80UiMIRBFga685VLvP4+LJcpzfyF27b/rjUI4E=;
        b=djTfODBNzB1i8PxamoYZnSxp5dCbIlVwFFD2lq+2zkxzrZ5kf9T6+s/lzmUhUNl+6o
         btFwraFVBziJ+wFfUt5CZjjeCh7FHzNKvnRDRREDELB8z5JvqlCL+U8jiPyygpzRM6gr
         Y2LXvYcEpBQBrPIAcSSpO+wqslhc6XuVKs/zKPex/p3Anx87mrd5gMhmXc7ofPb8bxhL
         FsYz+Q2QDdvd4LWUZYtuX8FQzVvGo50WDx34QCs9WjnkJGMkqby86H/HVlM2D/jshJjI
         LsmW8pzfYGJNxBkmmHYDCWozY0TEXS9LsKJfvdLk80FcJesUkKdnf2ckJ8HmEReTSkCe
         5FbA==
X-Forwarded-Encrypted: i=1; AHgh+Roq+AYz5bDBrk/TCy5BUu0+1eX2SRNEkWg2Gc78BMh6G2xFmXpRxXe+VBlzJpSDDSPFVON7EUn2Judz6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHg6dFBKPcst7vbxAsSdnD4fKUVoHe8msS+tqMsBJXrbsRGis2
	tMxHFZ1B477wEsXSmbYTEGkXQ8sj3NBNE4tK7ooHPtbphY1VAkxgJ5HChBpT4w==
X-Gm-Gg: AR+sD10jVkmX5hajUei4Z+Dago8XfZ2XPEx1VLlID0FtB96Q9xArbhxY2CUKAJFNdzV
	c4cwegNnG1jB/9uYXPkHCno0rfmUBRbWjzTQTZCPjo7MW1hJ/dqP8NPrm28gYGweZ1YWNxs36hC
	DgpDEFJrRrr4wo2PGvhx/75kxLZ7dVnVP/l8T/092OsPbgbxzaH6hIcSKXXZyl0nGL+bp1TsVo6
	KHfR1/REHBl3Qo32zeINJFlcH2cp7b2vdt3jWCn6nRLnGPt3nFgkV6hitAw3E7rJBrbeEKnDI6k
	7U+1VN7ZXLFoPM/oNGwWNnCAJhrgoap9wcB4JeADD19nh6lqLBBki/rP0vnLO5YNCiz5LL1yPTU
	RPM64nYlkMw6NjhSnl0dwAhW4p7X8JtmsgyMbs7iVVeEY1x9XoxE0YJm0f4rTcVn5DjF5iCXQG+
	sYsCxQFJ36K/6iXYNqDDhrpmXZ4CiM6r5TYOaZR+jdogIPo89bc9sexntf3hiNXde7dNyd3d6Ui
	llrXADH1g7StBkjqzXxfDfE
X-Received: by 2002:a05:6a21:e8c:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3cc71a2518cmr17985995637.11.1786856641308;
        Sat, 15 Aug 2026 22:04:01 -0700 (PDT)
Received: from [10.1.1.24] (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2f787fsm21192044eec.20.2026.08.15.22.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 22:04:00 -0700 (PDT)
Subject: Re: [PATCH 1/5] m68k: Fix atari mouse movement
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260814031745.17140-1-schmitzmic@gmail.com>
 <20260814031745.17140-2-schmitzmic@gmail.com>
 <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
 <ef9e0128-6309-546a-715a-3e7eb476910e@gmail.com>
Cc: linux-m68k@vger.kernel.org, Miro Kropacek <miro.kropacek@gmail.com>,
 linux-input <linux-input@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8c7863da-299f-8c77-0727-fb438467a7ba@gmail.com>
Date: Sun, 16 Aug 2026 17:03:54 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ef9e0128-6309-546a-715a-3e7eb476910e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

Am 15.08.2026 um 11:15 schrieb Michael Schmitz:
>>> --- a/drivers/input/mouse/atarimouse.c
>>> +++ b/drivers/input/mouse/atarimouse.c
>>> @@ -70,9 +70,12 @@ static void atamouse_interrupt(char *buf)
>>
>> Alternative, you could change/restore the function's signature to take a
>> "signed char *".
>
> Agreed, but without a way to test this, I'd rather wait for Miro
> confirming that change also fixed the issue.

Still untested, but even though not 100% identical, this change 
(whitespace-damaged) produces functionally equivalent code:

diff --git a/arch/m68k/atari/atakeyb.c b/arch/m68k/atari/atakeyb.c
index 49a9a459bdf4..6e150f816c02 100644
--- a/arch/m68k/atari/atakeyb.c
+++ b/arch/m68k/atari/atakeyb.c
@@ -39,7 +39,7 @@ void (*atari_MIDI_interrupt_hook) (void);
  /* Hook for keyboard inputdev  driver */
  void (*atari_input_keyboard_interrupt_hook) (unsigned char, char);
  /* Hook for mouse inputdev  driver */
-void (*atari_input_mouse_interrupt_hook) (char *);
+void (*atari_input_mouse_interrupt_hook) (signed char *);
  EXPORT_SYMBOL(atari_input_keyboard_interrupt_hook);
  EXPORT_SYMBOL(atari_input_mouse_interrupt_hook);

diff --git a/arch/m68k/include/asm/atarikb.h 
b/arch/m68k/include/asm/atarikb.h
index 68f3622bf591..b2d9e7676324 100644
--- a/arch/m68k/include/asm/atarikb.h
+++ b/arch/m68k/include/asm/atarikb.h
@@ -37,7 +37,7 @@ extern void (*atari_MIDI_interrupt_hook) (void);
  /* Hook for keyboard inputdev  driver */
  extern void (*atari_input_keyboard_interrupt_hook) (unsigned char, char);
  /* Hook for mouse inputdev  driver */
-extern void (*atari_input_mouse_interrupt_hook) (char *);
+extern void (*atari_input_mouse_interrupt_hook) (signed char *);

  int atari_keyb_init(void);

diff --git a/drivers/input/mouse/atarimouse.c 
b/drivers/input/mouse/atarimouse.c
index 351aab69e905..e2801be8f371 100644
--- a/drivers/input/mouse/atarimouse.c
+++ b/drivers/input/mouse/atarimouse.c
@@ -60,7 +60,7 @@ extern int atari_mouse_buttons;

  static struct input_dev *atamouse_dev;

-static void atamouse_interrupt(char *buf)
+static void atamouse_interrupt(signed char *buf)
  {
         int buttons, dx, dy;

(no cast used in the Atari ikbd interrupt handler though ...).

I'll go with that one then ...

Cheers,

	Michael


> Cheers,
>
>     Michael
>
>>>         atari_mouse_buttons = buttons;
>>>  #endif
>>>
>>> -       /* only relative events get here */
>>> -       dx = buf[1];
>>> -       dy = buf[2];
>>> +       /* only relative events get here; the IKBD sends signed 8-bit
>>> +        * deltas, and the kernel builds with -funsigned-char since 6.2,
>>> +        * so an explicit signed cast is required
>>> +        */
>>> +       dx = (s8)buf[1];
>>> +       dy = (s8)buf[2];
>>>
>>>         input_report_rel(atamouse_dev, REL_X, dx);
>>>         input_report_rel(atamouse_dev, REL_Y, dy);
>>
>> Regardless:
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>> geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a
>> hacker. But
>> when I'm talking to journalists I just say "programmer" or something
>> like that.
>>                                 -- Linus Torvalds
>>
