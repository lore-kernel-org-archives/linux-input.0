Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD23DCDB0
	for <linux-input@vger.kernel.org>; Mon,  5 Oct 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189204; cv=pass; b=Pqb3nYHHRXKCJa5fwpfVXduTHERiGL1+NHKnKFcg9HEOzCNWyTxrZx74OxdJbmZmrI//rV1WMvn32PF08kQCW5gaIUmXyIBILMBwbQiaWL9HkYC5e2erjAMprh4dzp0bdGnomqNZiAmWXkrWCTAnqIz0bBYNYmUmRL5br7DdMNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189204; c=relaxed/simple;
	bh=7OpHjYYd3PB+tmRRbURd4PAk8rNfrn0A4Xysku3w90k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OIXeVRIHqP4IOMky/fXulgXRmi6BvZuYRTS7k6qd2EeXpydPyCRrcCubBntkcoUGGh+M7N9ucMigUgmwaZu+6KLmHxKx/MEDFVhRkdssjqeugyh+5g8F/A9Oy+VX2tu/up+Zx2F8dGzg+hV0BBV5BXUcpHLzjizkXh3cOsOH938=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/yFsr/j; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/yFsr/j"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4f3f1adebb0so403532b6e.0
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2026 01:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791189201; cv=none;
        d=google.com; s=arc-20260327;
        b=Jm17XypwjW8cBQybDEx95AV0vrXit9tfljiv7DelNemMcw76u8mau2Efgnp3u+HCen
         qwd+GBQ7XuhRGdoHmFT+2PtWw+Sx/dj4hBmt4YQzVvRVAAUsMrIVs5u7madBETlgWm01
         M6qQ3IcUbK3JuEjKFRZaO/s2qlYkUmduMtOkxw8GfwL50+UQCKd1uf5OHSGq51o8OIoT
         rpDK35c2vc9cC8Rmxusgtas48qkoTUOyCIVLArKXllw24racTtz1N370TVJ0MPDXBNSV
         Pq0dF0Q8lCI/YoCB6zRYSEcnNUEaL00vq+TsB11yW8g8rB3EeqaD7hgRCdPaDwe3Zlaq
         McMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=7OpHjYYd3PB+tmRRbURd4PAk8rNfrn0A4Xysku3w90k=;
        fh=dmaDZcpvcewOVIFDhbt8vYwwInNgSMlvB5YvZU/wtUY=;
        b=Nx3pl5nACDIJgAl7tZWye/jbxJBgqrXmqtNLai2ZUtC3urznSaSeAn4Pngw9Qh7xnp
         stlXJOqzyU/4kGaSF9vrq8pvYnpG2md4P3CBZ2mbrlcS+BKH7hIvmaK/7IQf8qThzA0U
         BrhKZZ++3y/95zyTqsOHhQDZbvp+fAg7cjr0LXmm++3ODrubbSgsapqrWwyPX3fkeFZS
         sDlatBbHJHwPasqVqq2suyyRPjaDwQrkK6X25K2MMOdhgkb/8ZH3BpiUW3CWMgsKCjb9
         S+DDFi35Efxins63WvU0RCJSwJbuPbdWS+d7IFfLFOfGacpskB0lhDr7uI4XNBA5UuNh
         0p/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791189201; x=1791794001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OpHjYYd3PB+tmRRbURd4PAk8rNfrn0A4Xysku3w90k=;
        b=D/yFsr/jm6hlRTz34mSKg9MgJt1x1gOwTf5uZDkn9t5Uo8oW/rBF0RgzIf0WRsmty6
         qYJArWxErvik2bw74uDMNC5cWeCc08+LaEc7r2IDZx/LdyXucWAOaPBENsp3OmwRh+vd
         l1AAVKCgYDmCNtPOgv/QVqxE3eIQL/nB3cP5KmxI5NCRk3MOcSjju9bYk3Hs2XdxQyyo
         4bRpylqhEiLZUg0bQob8ycrChjPEowCVFWAAeZIUQfhGHfDTvgoRnLpdoldD0FtpwIM5
         4OB+7mTs6miNU8aPMQzU8eABksADBMjcM2h6vH7Sd+4S7iN1IXbWNzwa1TrKB/DagSK9
         gGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791189201; x=1791794001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7OpHjYYd3PB+tmRRbURd4PAk8rNfrn0A4Xysku3w90k=;
        b=C3v6/7Zkgn5aSq0RUX1c8LeUg1+Zuzq+b7pW+r+fbe6BgFYZ0nyzIjIM2+Ck+nQ6sG
         x97UPD+u8v/sGZ9TTQmR6/hKcGSGBSEGgTPhtjgsHweJYMKiNQANY0ZCzKojqpH6KG6M
         qgdje1ddy5Y/PnCWDB3SkAiqqwYzgmv5vg1gO8gb98Byu4Yx6joHtyf2ZmBW/HFSfFWU
         VqZIJ3+MX4MQrfh1+ko/FS3k789tCEEDIU5QgMHdSsGZETnjxBGGMY7AkOZ8tlzgT3Js
         quTHv1Iroy2PB6i0MjTMmQAFOoIKWtNPeIdi87rxeqJtuLReI+zDjMcBkzu0FfFVAIEn
         433w==
X-Gm-Message-State: AFuF++nYm3oG+fEsK8ig8zZ7/7SooQkKpdGCaEBHCSpXeGPzq83vGPMc
	9FDcj13dvKMh3Ae85p0DcEsob++3p/yEZdkpELqcs2wTl7AkDiEjC3xYu0smznyIA9U7t6HzRTw
	Lh9c31BmVcPRGjAQPSDZXzdTMObILEpyXIGai/NstRw==
X-Gm-Gg: AYBFou11m33LE2cT7J+0O1p45c1sjfzNB94MvreRLD+8zeKbJO9KdtmTyKGQ3V6hMvg
	vohgDTPZXgVdkM0vn2LA3HhY1zn9XDPuhQnC4mkOIC+o4KX4OOxt/g43DABPYlpj90M/ZteZNBf
	rBMTbpIRMcNSinczt5dujvbWy0jTYKFeYGWXQ/fVUw2ztt5vJVD740NjxfYHqbB7x5ZZvKL5b5/
	BrCeJRQCFQSQLdWQo2kZrrg+rminDPOFH96rlDnBb/uFY7jBlaAY3VXZ3VbORsV9V2Axpw27YnC
	gfBwleEIeSGabsZO9HJq0fXJseZKDXiGE8rR9H6wh1SHnn5+Tbb0MZFP/LTNjYnE811KdhfEArR
	xTROKIxmzrw==
X-Received: by 2002:a05:6808:198c:b0:4ef:b695:656 with SMTP id
 5614622812f47-4f67703fd75mr7093449b6e.9.1791189201612; Mon, 05 Oct 2026
 01:33:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 04:33:20 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 01:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 5 Oct 2026 04:33:20 -0400
X-Gm-Features: AclHuK_KEXkFWnVexHPHJhrLUAdip-8LLs2FHV9U3wc6Ym3haR_9Q6vHEUSpST8
Message-ID: <CANOyQmH4EU=6kb+d2ELL68FLj8yvtq8McHtUMWthQ3WUJQTuWQ@mail.gmail.com>
Subject: HID: picolcd: maintainer address in MAINTAINERS is bouncing
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Benjamin,

Resending as plain text; the previous copy was rejected by the mailing list=
.

When sending my picoLCD patch series on 28 September 2026,
"[PATCH 0/2] HID: picolcd: Fix output-request and framebuffer locking",
I received delivery failures for Bruno Pr=C3=A9mont's address,
bonbons@linux-vserver.org. A follow-up reply on the same day also bounced
for that recipient. The delivery notification says:

> The email account that you tried to reach does not exist.

This address is still listed under "PICOLCD HID DRIVER" in the mainline
MAINTAINERS file.

Does anyone know whether Bruno has an updated contact address, or whether
this is a known delivery issue? I'd like to make sure future picoLCD
patches reach the right people.

Thanks,
Aveline Noir
