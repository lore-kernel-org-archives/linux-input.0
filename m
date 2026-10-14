Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAE44C658
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013379; cv=pass; b=iR8aI/HS0eZgt+Y8PNsff1El/OA0qrG+i0/9WaLClkv0/hBG5X1jC1usl3k2b/os8b8R/KHkSVi/VBup4C2J/t5MJZrYBNkyn8dfIvn+kpd5WqR/59Cw2cH5o/Ccu2we4feHJZb5cYrlb9fSEN5PW5KIsEZhNuYDcUqpOW+80Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013379; c=relaxed/simple;
	bh=iefBJmYupKVJayKOqvQ87buV4ppZMJex7WihUR0osRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPS22GYFnt1i+O7SjeSSz8uWvuo5okTL4g2yQ/0JN7ea7tC24YfoFz/AjhTPUosZMHC1qOTxi4ANkVIMS7/G+2cF1AOr5BM0a93NPyQW+dDMjLWdH/l88HN8Jcgmn8mqupPuXeavKDOcaQjfFg8OD4nxrO9qpwK69ES1QHSpL54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYiMvfnz; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYiMvfnz"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533861a59b8so8610701cf.1
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 14:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792013377; cv=none;
        d=google.com; s=arc-20260327;
        b=Jjhlp7zVBNXDB/7+ohWB44OdRQX9MlUTYeG9q6fUWDW5BM28HNBqhSb1mnQWbc/gXB
         xwyJy/gO6nchcMPY/YuAl8Ent4MdZHeXgbE/Nlb+94iI5NChlKayQR077jdfGkA0zWvq
         a8DcdtO3SIXeB/wCSNn1OseW+hT2a7qt0ZWjksnTtvpACaFHMPNeCL4legZk/ePz9TUP
         SFSKb1KlX5cOBcDRkQEplI5EHfvOgwf2RmQdIvr4bZicyEXI3L0RIPf5ZElDUGaoN2AX
         JLu/TEm6tskRBNv6YgbNwNV/Vbl6cU1j5tQ86kgik+De2pvSUwVapxoOSFEFDxs/3JzV
         D4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YwgxusmBTG3+SD3/g0+kXEe8xsc6kMCtJNV8dtSIErM=;
        fh=hf1lAUjNvrc/Lsr4LVmGMBAX363M715U52gNhn5zP0U=;
        b=EOEZwOgs3cvJT0m7DvBDQtqQdymS6SXlr1oHVN6ijhxdx+tYyj9p3y7iFiQRkgpYQJ
         cHTcNf9RZ/LObtb8OALEHa9ZHC+iAF7plIVvEBp2LR0epJLlnAovY9xcfDcu3c97POLp
         Ovmy0ieJVtqejcwpks3IuSXEytxekZiDm31z/49NHIyqWZ9jOdxf66krFruutt/8ECfn
         7z/kgy3sv1gbCGEALGV8nwi3E/oZqAt1XfdQaKa+qAnaJv59Ly7ipRRPqNJ91yKS24An
         9WhWdlv5A3ctPXWJhYo0MwXrs6ZXsDxARDK//br4nlOsNaTai/4WyoSlw9k7qXRXViiF
         H3vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792013377; x=1792618177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YwgxusmBTG3+SD3/g0+kXEe8xsc6kMCtJNV8dtSIErM=;
        b=JYiMvfnzBMm0PJBMQgYJaKN3PNndQknU5uRJyxJxp770e5ALcIgfqyJmcKb4LDj7O2
         xqO0ueqKLijwjemP1KfuvVOZo0e6GLsR4+bn1NvmZqeYCC35k7D9tdltzZjT9bDLs2tC
         kQvkziF4biyejaVfJeB4oZ4bbjeuVDTKD449ebaf4jnrV1dA31PdJRTDgVfUx6hB3MHZ
         crLvxKt7ae+GUuz23nF9rFTTB9ht00EtJQTmMZ6fox25eDclrvMy6sqG9/Rm6svapNye
         xqJpIMoyGblHKjEPYeKkCX4d5JiWndzgAmXe6yURqcaqukAp6KfaVEhS5hlluwo0a5Ni
         qqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013377; x=1792618177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YwgxusmBTG3+SD3/g0+kXEe8xsc6kMCtJNV8dtSIErM=;
        b=MiwFJxr7J73x8DI8fHmfeX1SZIxFIub7y/RDXJl98OrSUMHqJkqYyKPgF1glSdiSzi
         VYl73h0hYEank2AWP3wu6/zT/JgIwy+0kQ6D6nnrKa8Smq3aOjRuuajN+MvCd41V6x5Z
         GNmpBsC0ztzq2Tax4TbyWBgANLH6y28lSF/m/5eIS0rOMTkeHAe6rJumTzg5+EDvUTcd
         FEJTfDjQx3hqOFbOJDkuHe2x8UdFs8/1ItrKUq2jsryQ/hOf34er3AZbmf46apI/qt3M
         25mhurSAuCNuMmbW/rFYXiY8szk5rrIAZcBc4QLWJMuB09uM8QwSlPQSzSbQ09Roqkr9
         L5ow==
X-Forwarded-Encrypted: i=1; AKwUvBwzKL5C1CBQg1Hieqy713QzEzQCKKydqgFpMojZ0JMtlYYwj4AJic574EqJZqtnUBxVrAgUekj5D78QVg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLcqsojePpEugu+tMPVuOk82BD8NbqY7SPdUFB8Upq2agiJtHym
	cznrckceSY+RRM+G1mxbql9pEZKjBMOIhwtJRBJd2yAJs6hUDbeFkRmYvT4ELRzhgBbchusUYJf
	rFDFEh+EeHnuJ3tYCd3qfxvT5H/EEmCs=
X-Gm-Gg: AYBFou1XLV/+hXRDQZLp3WFC8UvYy0E+qwDwMRfGSGe4UnaCB/Hh+66iKcAd/WeGwdN
	5uuLNnuRZPtFXyAgrn9y66dIBfbQhFlNKAQ4XLWOsJSZ+0P3x+0BCSer3wKXtcwtjVhGAV5+LPi
	PkAi3bQAxEW/Ec+odV+0feWBjHFrTcWoNwFS1hROgfGcKtnbtDK/Ljh89H8lvhvh0GzzetywIjz
	rcPe0XGFcit40OBPqx7GVbTX40qc1V9w/1Ry7HzbUtShFmpjKhofmZLolW+7Z+NSIXOglqArUht
	5z0XFzzAOsksZVMPVamK0gMz9XhIGt7eIXOZyelacr6kJlmqkq0J850=
X-Received: by 2002:a05:622a:598c:b0:535:84e3:ceef with SMTP id
 d75a77b69052e-5359fb86e08mr292010171cf.45.1792013376625; Wed, 14 Oct 2026
 14:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924020936.17612-1-matheus.aalmeida@inf.ufrgs.br> <1e4cd74d1d4598dcb22198724323cf00@inf.ufrgs.br>
In-Reply-To: <1e4cd74d1d4598dcb22198724323cf00@inf.ufrgs.br>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 14 Oct 2026 14:29:25 -0700
X-Gm-Features: AclHuK_EW-cvvhCm33wG1LwURzuAIYspTU3DOos0A_N6byRXCMb2FNUeb1-g6hI
Message-ID: <CANRwn3QfxSxVqGUjOuMhoEhuOHRz0ODdFqUU5wZQKuPNp7kG-Q@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: fix wacom_intuos_irq NULL pen_input deref
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:35=E2=80=AFPM Matheus Alves de Almeida
<matheus.aalmeida@inf.ufrgs.br> wrote:
>
> Em 2026-09-23 23:09, Matheus Alves de Almeida escreveu:
> > Currently, wacom_intuos_irq() passes the parent of wacom_wac's
> > pen_input to the dev_dbg() in the unknown report path. However,
> > pen_input can be NULL on interfaces without a pen, causing a
> > NULL pointer dereference.
> >
> > Get the HID device from the enclosing struct wacom and use hid_dbg()
> > instead.
> >
> > Fixes: eb71d1bb270e ("Input: wacom - use dev_xxx() instead of naked
> > printk()s
> > and dbg()s")
> > Reported-by: syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Db5a7cd83622c747977de
> > Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>
> Hi,
>
> Gentle ping on this. Has anyone been able to take a look at it yet?
>
> Matheus
>

Apologies for the delay... I've reviewed the patch and it looks good.
It does make me wonder about similar patterns elsewhere in the code
though (calling `dev_dbg(input->dev.parent, ...)` isn't unique to this
function). I'm happy to take this as a standalone fix for an observed
crash, but an audit of other log statements is still probably
reasonable.

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
