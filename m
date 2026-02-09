Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8077366560
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632073; cv=pass; b=WC/CrC/q0S7mzZSFbBk5S8MiTGlCGpfyXsgbZnyf/3SZUh3lXwG0INE4rlmzUQsoJGwqE6ZwOiZ1Bh/v5jJ1K3vTjrDhbGTPAZZ6HQnmNDcXGgNrq/+D6crSQBZAyMiFUrDSvwD9OdH7aUlmkc8NnIa8QxKITfsHv9Npo5dFKaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632073; c=relaxed/simple;
	bh=kClSk77qiTsJp9L+J6Iog6IbuS5PvFeW0j5zjPpnia0=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=Pifeb6QGA0Ahuf4qxsE6PmQF9DyGR60cnZAlih5/5DEgmk5kcrUAIPfiHo3ZStJy7PAiahukmRq5p/NWO2B122h7NcsMAkI6iykPLhlW8b2PGwHJ6PSV9UCTxlzcfdtQD5QozIR/JawhkefRwVm+xRrrrZUWetNBe2Hy9Em88H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zenjobsupport.com; spf=pass smtp.mailfrom=zenjobsupport.com; dkim=pass (2048-bit key) header.d=zenjobsupport.com header.i=@zenjobsupport.com header.b=jZhuhLvJ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zenjobsupport.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenjobsupport.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zenjobsupport.com header.i=@zenjobsupport.com header.b="jZhuhLvJ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649ddc91c05so490409d50.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770632071; cv=none;
        d=google.com; s=arc-20240605;
        b=FP+OuJ+XKnskLdgQxbisduca2wAVFYPyXr28LGnbMxWascJidQof3hMjFaedwXBrJT
         L7aw7JiM1uKhCjynLrnT0jAVzZq+F/rGlMpm8UHhkMbgrUqDQmjIIt4XKnUqIIB4EeYT
         7jaywSnKaKyDpSH5ZoHaNCLuTbGIIcNFRdvs95hgeJNdduwwUTefTy0PSpfGjEXogbAj
         TPYQfjLKQkIQ9qU+TqWrJA9qyps3QPsqtF+++trG0W3KlCm/oSsxaYn250nCVvEx5xfb
         kok/l63vUf7dk35CZJ5lMqviD2WPOrKYGwPPq43SB8Jgs7p+KZOhmusoY17Ta1dHXDWW
         QOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:dkim-signature;
        bh=YYv8eX38Hsj7FjS2XJwJVURAUdsLVeyRejiGjA4c6Z8=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=KRH2GrXaE/8u+O4B0cdP7I4NGNSbYoFoFus3L9c7NDKlX4LXEDpjLEZ7kuj3wXGx4b
         rh7fVGNPYi98Sd9Xm4nie6V4iep1BuNVHACM8n1vNxVD/IvCzC034bnk8t/jx+DyTFTl
         0qoHsH3f4xCAxwFAP1ZMCzndCK6OAd5HLTMNOEcSZlwT7qabAw1HwB2CZq0G+8hPk2Fq
         s+z0xvnEvEWfE523lnSXL1g0FqXqhk2F+BUNKPxU7pmAncIm+NKDd0pqux1Tm3LBsnH5
         K9ajaOHjLVAt6NhuK1kWxU7rOQ5MjWXItTF5XeARf9II9EdfSDxDro0vgHmAbzWd+cc9
         I6sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zenjobsupport.com; s=google; t=1770632071; x=1771236871; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYv8eX38Hsj7FjS2XJwJVURAUdsLVeyRejiGjA4c6Z8=;
        b=jZhuhLvJDoIkkybyKicCpI/tvOnsW6q7G1DoCAJGHpfE5aFe2G4Q/WA/KY/6W4pDI1
         X615xdpqJYyNOPozFDgnhSNNTpLuQ58Xukn9D/3JgTsDU/GNZe9USmeP3VtSwzm577em
         18ee/JxU5sRg9/b4Sr25y+Yw3VhMQnVqoQgxf67aH2j6pPp5ZzMC78ApHvfxweJ26GBH
         w+E3erw9X/SO9FcBFLA4xx9bbApbF0FgSnKhwbaQ4lH01y/5Mekr4hVtNX3JTsP3jlGH
         rh4INvpZEtckl5UYUb327Tm6iCKT+ui07JaKB/gLOsB6venEF7o/9Lj5jeGC8vN45iQR
         SKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632071; x=1771236871;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYv8eX38Hsj7FjS2XJwJVURAUdsLVeyRejiGjA4c6Z8=;
        b=Fwppr1qEMoTHWll3ZGMK5gD307sKrhmG0yFZWkgy6WAbDFb9n9qnDzR4gHdDtz3HQC
         k1/5eoauMufLZCzFxtDJqYyfCdBaP9JRi3TRUkAGa+aucaSjstkgJMSoEXRzb4uimM5c
         /BhlqW8fqurFao26baTzDEjAhxWiyt4GcqSPyzzFZWJq3YeY7VXVSdYuS4Er8kVw/3nK
         l7Fd2lTYns2oQ1s+5OZZqMlzcggSF5UXKRH2fdzy6TYx3bY/5Tpj/pRNt2OxCAaTuXol
         61x6rXvQzLvX6uqZOyCN3BGGHuJJihh0bZvt9fS1/gB9YoHSnO4/QZeBdaBvYgyChWYr
         75CQ==
X-Gm-Message-State: AOJu0YxLznhbTVBUENTT+A+ssbvs7erACvqUFnHziayDkkPGOXL1euUs
	mX6a0JC+dQjXQeu/+BcOoe+MRaXASGPTjacPG3M74w1CIOvpXgCrU/JmEHpAxzgnYgpHxN5vXIS
	2JBTr3+zrPyOfdEtMdThxzLQ63Ykp8LjerQwuqL9zaAc5eQQAkIWzqA==
X-Gm-Gg: AZuq6aKDhy0ErWpqDeZBeVQ7ymVDX9tY7MDmJaQunUy4cX7cYwLiMKuKMYZSb75CCdI
	YMiZQMRwjX/5w6HZptV7FsZ5Cwf8a4Dm0o6cbq7umpj0fpC5rv8duegbSakTLp5v5TLEfeLoodi
	WuGqavb6XsuZxnj/imL2/iP5ZLEnCxI3SjfNvJl/ys20YolFZb0naK8iEh81De+4zQ+34QXaJPZ
	qdFpVcd6S65TAXr/0P5Ky6kin72az0aJxTPao4TBVeMr1luoGJ3lIudSOmOZquGh/9MmUDxxNOd
	wzPzmtnh
X-Received: by 2002:a05:690e:d84:b0:649:d59f:dcca with SMTP id
 956f58d0204a3-649f219d385mr8494228d50.5.1770632071612; Mon, 09 Feb 2026
 02:14:31 -0800 (PST)
Received: from 457773911160 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 02:14:31 -0800
Received: from 457773911160 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 02:14:31 -0800
From: Philip Schiele <philip.schiele@zenjobsupport.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 02:14:31 -0800
X-Gm-Features: AZwV_Qh7xLLk6grrdbv5w95zmmP0NAgfXySal-Hi2oYHJqdblCotSJhjqIRZbHA
Message-ID: <CAEtsEQ4McTyQ7fzCW_yxmg19C5Tgg01ukQV4itr0imKppgkGQQ@mail.gmail.com>
Subject: =?UTF-8?Q?AW=3A_Data_Modul_Personalengp=C3=A4sse_l=C3=B6sen?=
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Betreff: AW: Data Modul Personalengp=C3=A4sse l=C3=B6sen

Sehr geehrtes Data Modul Team,

ich hatte Ihnen k=C3=BCrzlich bez=C3=BCglich flexibler Logistik-Aushilfen
geschrieben und vermute, dass meine Nachricht m=C3=B6glicherweise
untergegangen ist.

Wir bei Zenjob erm=C3=B6glichen es Unternehmen, Personalengp=C3=A4sse in de=
r
Logistik deutschlandweit innerhalb von 24 Stunden ohne Fixkosten zu
=C3=BCberbr=C3=BCcken.

Ich bin =C3=BCberzeugt, dass diese Flexibilit=C3=A4t f=C3=BCr Ihr Unternehm=
en
wertvoll sein k=C3=B6nnte.

Lassen Sie uns Ihre Personaldecke stabilisieren, starten Sie jetzt
ohne Fixkosten.

Beste Gr=C3=BC=C3=9Fe,
Philip

Philip  Schiele =E2=80=94 Sales Development Representative
ZENJOB
www.zenjob.com | +49302089860400
