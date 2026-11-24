Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505478;
	b=CoFL4aGo4r0+cL+6/wKp0ApGFBuSD6uLWF2vl6KRb4DOQU9vLAfxkK2bwIi4IuwV7kPZ
	 uTJGq0tSpmAFht1dxtq9TnJ3C28kQqiOvRprX543I/mOD7Ge/TH1jg/fRwYslvpRhShBo
	 juVYJp3VR2qkLmgnrAPQv2vzZcmEo4HGyb1lhL9sxjbH0TzVxV8yiYM00vcd0e9pzeCYc
	 SAc21J+9Ox8wQjo2ACJMS30LvFFqT05kAXzx3Q6sjAn5xv1Z7Uf7KmRs6fy+KNyPSyQwQ
	 RWByDgpKhLczeh9yXzdiFp6oZ7Ziaj5GjM/GWK18Etf1aj4l6yOAoakr+nRBNWM5oXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uz6sHl5m45qwME77LMFtXBdETR9+QDAW2tNZEQ1kciw=;
	b=EyI3WNP1sak1tQTSCtDItAuDsIVzedPY8l299i//8JEEuKey/p2+Um3O2s4YPgiYWT2n
	 +6EXoDUM7ku+u57g4eEyA/3FzygT1okRF2zpggEkYxOn2yEkBn6ctSFlk4hKPdib4vfuH
	 hYkO6F1WiIRq+weTuYCHkZQFZQT9KVVpgrhIdcVMfLzMdxvSXYoAoAuT+7dex4yGPDZH0
	 seL/Hlbju7NJDO2PnARhsrhjGIj3BbJRIIgJdqzjvfqqpOG658tuCbwJYxdVzs/6LU6iK
	 26XdN7TiwX7gw1iyBDodFUIrwtCl/aJ/33sDoPwVx2RvRR+JBBRGYTcSg4UslEU3JOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhoJPA3E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2D606A327
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 07:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F2D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhoJPA3E
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so3006884f8f.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 23:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505477; cv=none;
        d=google.com; s=arc-20260327;
        b=RRGPTqaWX6df7VA1tflKNX1a7hsofIdOlu84pQ2c+0SBdfQ6icnU4YiNbPvVw6CLLI
         d+lLTdWUZSHEZQprYizhqKVvNpYM5pBbpVwyzwFELDqWtoz4a41HJItK9dwgUCE/vl/6
         T4XwHHmBG7Jfj6E5QZbmYioRV7VM5wm4QKuYO+wt7hWMuic2GIdu7NXlIDWD03e2A6fs
         kaZYlVtHRC5rorgnvI3ePHgP0wGtsSLJZY3ujXvDZsUVdze/Scbi+dU0+T+ijkkPip+P
         QsX/lB4IvMD3kY9tOtaOdz1Q+tPHJzxTXIqwlYryF9MjGPXgIIqyS2K3z0k3hzoK8tru
         UIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=uz6sHl5m45qwME77LMFtXBdETR9+QDAW2tNZEQ1kciw=;
        fh=NqrwVRqizOVw8/JdPqbmjM/vLak3B2qh6giq69A0Zxc=;
        b=T/2B9uR3mFRUoZ0WeKi5uhoTbpW6vVZTHzdl90Qd1vt3x6UV9nKtjVBamKCxQmygb5
         J+3K0hE7D2bJEhAKdI74Nf+7NuR6IijZk1/EMG3qMfhFL0fvDoo4PNnHBRABsVdKJRfE
         fkd2WHvc1E362Z6sh2QTUuc9AZpXGytCFuFqboProqiXyAyvPAu80jy8XqbVFKraiLzG
         3+NPBklX9sb4MKVsppDlfweUujVsby2/iOwTGK85DIPB7ZI6dA77qxdW6dDhAInWMXoU
         gM2aqda4yKcK4kE9uyq9SGeRfHxm2Bu6P3K7K2VcPWbGd3on3b/wtv72YZqI53MajtFs
         p+Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795505477; x=1796110277; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uz6sHl5m45qwME77LMFtXBdETR9+QDAW2tNZEQ1kciw=;
        b=NhoJPA3E6yTbH+3xZbXP3wEewJBzBNu/b6BMBzA+qYdoTUY4uOYxRogVA3wpJICsfq
         3vFTCrb4Pcb7cC6xlpYWm6E94uUOWobTmfINqLCBlprEw4Oz3qwuDcROQDs0TWzZEZn2
         nyVIjelRhCudni2AXYeBn8ANtUolUPxyTpucslpgGXU16j2egPpM5/iFT8R+5g8Rqdn0
         zqNCrV1lYmMqIPAXN5BCeQTkfPl8DDloVtZUEY0GIlspoEU+83qvqSIuPvF+ZSk/UVnZ
         SDS17WVK0g4XLPY5D5DYc81wuQkXumA9fmugm5nVcQAGGwOwcJ1De/NUUF1tuMiiatoZ
         OwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505477; x=1796110277;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uz6sHl5m45qwME77LMFtXBdETR9+QDAW2tNZEQ1kciw=;
        b=CamGYffV/SJ1amOMZskiWoSaNsw6nmzzC0PcSKyomNvbLeCxqgPRCDtiaU+JRQ93XX
         wlP9W0mnU2cKCYqv0rpk/dc5YTTpff9YFegyAWIeK0qTGRgwj+AfL8YssWaI+9PRWMjb
         0LeFe9XqSgF5ugitQ84tbCtjI9YYstimWrAANx/UvuMN1Y4ljpIfbse03CajAhDyDA1g
         lqI6y/0pKt7enOGJNvCf4UKUgtleaH+4GxM3Gw8zOrzw/z/8410Jy4c5yvCvgaxEC7KF
         GeRdxvPonuAuWe1Q02CMmNF7TVLV59WCLVQjksrgcanFT2nMczpnNHno9vZN3BMZoPa3
         kYDA==
X-Forwarded-Encrypted: i=1; AL+hErFQTGb7cuLTReO2/7sqRTrnk/Q2qhbGn/gbD65R1d1v0lEpqFhIrbqVgDupVZwpigI+3VbjgfXZr46CFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xyEUK8M+HZsl4Ep7tcvY7RDow517Ijc9ryHl+EY9HBDkNkWKQ
	40ypeZfNRtlVVp713YeZFEWAE4pa/R95II+No9J2rQVbT+U07vLJboMmM8NkwqOfTQSmXOi7YXi
	cuHM++lZK6q/e3c5pOcrYhusZL7CdQn4=
X-Gm-Gg: AZFdTZdsZ5A8VxF55cMhoOEau24h5bZEFR0OPPg4sTjr4fp8GlxwnNzKgiTx2iUx0cM
	OOCWfBGJvJUT9dF77fZnO9Eaj9ew3toxiqHZAeWWnzu1PegaOv1UwpwB169Kj6BVh/fhF9fDOx4
	3dzmle8dnm7oREwHXDDR1HxkVwLPD/PzTcoeHKDOBuq/ha4uGQzCjc1ydG0jBu1CwzljtE0vFMX
	4JcmTrZQwlflLT8AiKhcXdoEbjcrECTi6BvhiYc2PQFroLCKN+b4rS2XOEjLdbYyaWlKck36W84
	AffOWEsUcdH5WQj68GHq8ZJG9bSc2OrOs7A8ywb0EtasIXEe2u6dTN3v3rH8ChK6WCi1NLN7kry
	ebixGy81OTo4OthgnB8MZXWifLCsmUGfkgbKhTxMDR3VMKzqXBG8WUXFVaOkYIsalEfw=
X-Received: by 2002:a05:6000:2903:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4aa5ab788d1mr35237170f8f.28.1795505476502; Mon, 23 Nov 2026
 23:31:16 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 23 Nov 2026 23:31:15 -0800
In-Reply-To: <4ab84021a5d175f5d3793e52fd818a21@gmail.com>
References: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
 <26ac42dd18a98c4928cbe7f6b6adb4b396be4c8e.1790612085.git.pooyan.azadparvar@gmail.com>
 <4ab84021a5d175f5d3793e52fd818a21@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Mon, 23 Nov 2026 23:31:15 -0800
X-Gm-Features: Aa3M54of9Ba4hHMKsZBUUvltNlowKvtouah2uS7DpaePdAivP70yFmQtUeYovYg
Message-ID: <CANC3H+L+hh5XaesFuUDSrFpWGxpfg23JV7oyh+q-TUYqWF8+hA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Input: raydium_i2c_ts - validate report parameters
To: dmitry.torokhov@gmail.com
Cc: u.kleine-koenig@baylibre.com, meatuni001@gmail.com, w1zardsec@proton.me, 
	robh@kernel.org, jeffrey.lin@rad-ic.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Thanks for applying the first patch and simplifying the validation checks.

I also appreciate your detailed review of patches 2 and 3. I'll rework
them into a single patch using a fixed-size buffer and look into the
boot_mode issue.

Best,
Pooyan

On Mon, 23 Nov 2026 20:42:43 -0800, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Pooyan,
>
> On Mon, Sep 28, 2026 at 06:26:16PM +0200, Pooyan Azad wrote:
> ...
> > + if (data_info.pkg_size < RM_PACKET_CRC_SIZE) {
> > + dev_err(&client->dev,
> > + "invalid report sizes: packet=%u contact=%u\n",
> > + data_info.pkg_size, data_info.tp_info_size);
> > + return -EINVAL;
> > + }
> > +
> > + report_size = data_info.pkg_size - RM_PACKET_CRC_SIZE;
> > + if (data_info.tp_info_size < RM_MIN_CONTACT_SIZE ||
> > + data_info.tp_info_size > report_size ||
> > + report_size / data_info.tp_info_size > RM_MAX_TOUCH_NUM) {
> > + dev_err(&client->dev,
> > + "invalid report sizes: packet=%u contact=%u\n",
> > + data_info.pkg_size, data_info.tp_info_size);
> > + return -EINVAL;
> > + }
>
> I folded these two checks and duplicate error messages using
> check_sub_overflow():
>
> if (check_sub_overflow(data_info.pkg_size, RM_PACKET_CRC_SIZE,
> &report_size) ||
> data_info.tp_info_size < RM_MIN_CONTACT_SIZE ||
> data_info.tp_info_size > report_size ||
> report_size / data_info.tp_info_size > RM_MAX_TOUCH_NUM) {
> dev_err(&client->dev,
> "invalid report sizes: packet=%u contact=%u\n",
> data_info.pkg_size, data_info.tp_info_size);
> return -EINVAL;
> }
>
> Applied the updated patch to for-linus.
>
> Thanks.
>
> --
> Dmitry
