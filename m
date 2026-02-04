Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815A31B812
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196384; cv=pass; b=aCGAdNDwZOQC7zaQyqc3dj0E/RYtbmdhPwp1PKnUlDzNkSauYFddh6uytsN1PTzq+iJl21/9kPwDeybuK/52/kzXbTIaQoIcwwTCqT8PPBEkBL12eDGWxoXPrmVayLTcuoN/rogNw3eDLD6jX8aMObrFY1VwaSotcPl5sbEPy8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196384; c=relaxed/simple;
	bh=+ES38Vz0QOI9KZqwvNTmLyR+U0TnwZBxdx2kpQtUlto=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=BjEp0tAVK1ccHrVOp1qM/vml9yIvf+JYATPQs9ePBPkVYAf2zriL8wrEGeQPqNy3Zaoxx/+Wx37SMSI17gNuGtlZ3wRwelAa+NmqLXLV3682o/W90ayu0yuEO2Vm0s6wIkoICWL/KIlc3+mXfPVOiGXWdgg4170QkccB2Nk7faA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zenjobsupport.com; spf=pass smtp.mailfrom=zenjobsupport.com; dkim=pass (2048-bit key) header.d=zenjobsupport.com header.i=@zenjobsupport.com header.b=Bw2xjakc; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zenjobsupport.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenjobsupport.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zenjobsupport.com header.i=@zenjobsupport.com header.b="Bw2xjakc"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649d589ab0fso237031d50.2
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 01:13:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770196383; cv=none;
        d=google.com; s=arc-20240605;
        b=Uzc1q+SN8Lhe0kb1SYXi/QDjxH47L1xv9tgqIQYVj8sJghYkLlWNFpnZJ8OE4MvkJH
         l+EWJQ3oU/bk5g7RHCCaftgFMX4dldpcfPt519azLjA9Xm9n1sfFTyPquLkxv/WjDgy4
         wvakHO0qX1SuK5z8mIQxB4faXYJ2FXTqkzyQtRhm6zXEyFNu9OYHdq1Vp1Nnn/gUKFMR
         ok8aISz349qobKrMPpfQ2SDe60O4UpFJFi+7oTuGuDHdlOYHaRxU6goutvhyheW0v/g3
         f7vJf41IQ0t5ykOEQhKOiV5HUJEoRH+9JkFJGxz3pzNUc+Fxxim/RF6z9VxYRutQ5UsD
         wSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:dkim-signature;
        bh=jvC61Sks9jz3fcuLUAkaIfJy2ccfcpsdQWgGQY3rrIs=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=Og90Hq+Yg13amsGnNMWdqZTQvLw4QWBsazeoiGDkP2TB0wf+Kj2L8ZNiQWfFYqMVD8
         FWIWUzi6/TCITgclPGI4IdC4o7Mb1VQqGWNmdPnmu+UBt33adakUSphxjDwxIAusjfXp
         K3OYybIvbHR87jDqmUtlgWavdSUprN6irnCSBSOYoJiVQ6L/X11Jo3yrCuDy6KcvwQUR
         WhkjVb1YZmQOb+sTTc9nU13diNAaC5qP0g65IBUhlonLutnXhsMPZ4QsMjruCiw6vZo2
         q5Iz/1p5gPVG+BJd3mkGSjl621rN2ncd+5gBMZSzZk8W/VxHvVWxogarGR4TKtwwE35J
         m/AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zenjobsupport.com; s=google; t=1770196383; x=1770801183; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvC61Sks9jz3fcuLUAkaIfJy2ccfcpsdQWgGQY3rrIs=;
        b=Bw2xjakc4dAHAeTr6ZgA+acdRnN63O7KN1bK/Q2lkhRImqVtSFZrrRDr2LqGdW9w+A
         Wgj6uA6jJGoWs9crB+p8B4MYRAMHx1V5eqSRSi2T40cWniLwABxFwe1s8OkiqbCYx3z+
         ohEJdkWxSFiRIWiVajB9Abwe5tE54cH4bVlnX9VK06n152ShEMwHM8N1BnMITFdBGRnc
         hF8WpI5TomytxSVLBrIRXXZxjfP8XY5kXnSAd0OeNZtJUSQRM3O0j962ySpxMwWSvGDr
         DZbdZ4YldI0NdG5bhu/B0id/FZYM8S7lYWOeLNjP58496OZsxnKd6rNCYNZwvmajmSl8
         nSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196383; x=1770801183;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvC61Sks9jz3fcuLUAkaIfJy2ccfcpsdQWgGQY3rrIs=;
        b=hew5YdaWQLuxRS6A8ucQYP5gdL/8EvucWYBwhPdNOotblQCHRnAQIfADV8QFzUpGcs
         hoeoEJvVb32WxFuoPjkvphbZBQOaycpt3DfW0Fxj99f1HUOYZg3yTI9eecuoct7Lc1hj
         it4HDPJF6ey46lpvJ8dClpf+edzKY0JdrFPiPyzw44zikxr72CEfl5SYHjcaouI/aZta
         ILO2q4LU/22f6Xd5gO7/HhUphrSSG7awx+kPVzI6LULMOSKO5KQeHENr7R5PLfXuZ7bY
         M8978cKWgL1HHxXxqsMwghIWdmq/JJ6Kx3KffgrtEskm0AToxY7I1X/cV7pJbddYCZjz
         NFrg==
X-Gm-Message-State: AOJu0YxWAWjhcY9IlumvofZI976T/3iO8yyq+tBPnSTQjsfj2PqhgeBk
	JsGN5MW/8G+xRU9fGAptlp0LMJR1igi89dlQHN6mEf1h//I3KduIeEkS1/3IQeCxOpvGLO5cGjV
	KBdpLv1jvtA7XpsKfXjnBDoCktvnHZsr+q9IeRlYptZTxbcrHpa3qbw==
X-Gm-Gg: AZuq6aLNstyR2W7k8j08MY0WkXphuIQYBxoF/Vx1Dsz69TVhQZwxfi4A/ckKhmA2Q9E
	KdLz3AzqTmw4XUeVAte/6JJHtmTB1RgiyrZT+2l43Xi1PyweCdqgeeFYFAVuFHFkjWogOZJ5sRN
	WHwIWnHajK106AjToP99mcN9QDKmaz4ftjqz1SmoavsV0joQ3qq7Xr+ueZuZmVHDxpmGLfz4rNq
	IPLIdBK6OqqJ/vGtlJalUHCHjJZK1iY0WPpr64Kz01/fUAUp2IJzTvCpi1qB5KodOaGvO6ksQ==
X-Received: by 2002:a05:690e:d41:b0:63f:b452:b659 with SMTP id
 956f58d0204a3-649db33589amr1847472d50.2.1770196382946; Wed, 04 Feb 2026
 01:13:02 -0800 (PST)
Received: from 457773911160 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 09:13:02 +0000
Received: from 457773911160 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 09:13:02 +0000
From: Philip Schiele <philip.schiele@zenjobsupport.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Feb 2026 09:13:02 +0000
X-Gm-Features: AZwV_Qgy_UAbfJVhq22Wg0hIpsK1aSRwUvqnAKFSNIKI3XEfWumDlcUVxKdHz1c
Message-ID: <CAEtsEQ7dfjEVznsCtRHcZWng3J-UEx6cEsvHfXKDFccnEiq46w@mail.gmail.com>
Subject: =?UTF-8?Q?Data_Modul_Personalengp=C3=A4sse_l=C3=B6sen?=
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sehr geehrtes Data Modul Team,

Ich habe gesehen, dass Sie bei DATA MODUL umfassende Dienstleistungen
von Design-in =C3=BCber Forschung & Entwicklung bis hin zu Qualifizierung
und Fertigung anbieten. Apropos Betriebsabl=C3=A4ufe: Pl=C3=B6tzliche
Personalausf=C3=A4lle k=C3=B6nnen in der Logistik schnell zu Engp=C3=A4ssen=
 f=C3=BChren.

Wir bei Zenjob stellen deutschlandweit flexible Logistik-Aushilfen
innerhalb von 24 Stunden bereit, ohne dass Fixkosten entstehen. Unsere
Besetzungsquote liegt bei =C3=BCber 90 Prozent.

So k=C3=B6nnen Sie bei unvorhergesehenen Ausf=C3=A4llen sofort reagieren un=
d
Ihre Betriebsabl=C3=A4ufe aufrechterhalten. Wir sind =C3=BCberzeugt, dass d=
iese
Flexibilit=C3=A4t f=C3=BCr Ihr Unternehmen wertvoll ist.

Buchen Sie noch heute und haben Sie Ihre Schicht in 24 Stunden besetzt.

Beste Gr=C3=BC=C3=9Fe,
Philip

Philip  Schiele =E2=80=94 Sales Development Representative
ZENJOB
www.zenjob.com | +49302089860400
