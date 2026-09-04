Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077294A440B
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534387; cv=none; b=IPFiTFNZ644QBrEQq91pDxQ4E+oNpAIIdyDiBedS5MAciDb6KKTMlN+ya9Mf4+Ca+IbKIzEp7A04T6RQ2axvaJcRE6APWjRoDl7MthXNYJ1TiFolTALkSm0gJ4zk2npqrRMPWktskTNSb84ih1elDkgRyvIiLpcYgt1kNGLziG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534387; c=relaxed/simple;
	bh=7gNCncRwcYB9lWmv5bcgCTAj/WG9KBrvFMQ3voJc5e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMYvz4lWE4ETZkDiLSLpLO+N+QluHRAP4t0xjQ3x8JNJHAaJd6kFK2Jar76vSmleuoVEm/4WF1CYiiW1YqZyIoslFcQcgthLL4bs2QjdnKUSFyBVqrMZ9Yh61tgnv93YLT6qepAlY+Nc902Op68H+Jrm9UsruVGCVKVm3n50zJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wz8eiQ2z; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wz8eiQ2z"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a600a1caf8so1803715a12.2
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788534380; x=1789139180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gNCncRwcYB9lWmv5bcgCTAj/WG9KBrvFMQ3voJc5e4=;
        b=Wz8eiQ2z1484J2c1rF0s1mwShxk+Y9bTSnU/VMDPn/iIJ1Hzsh8Tm2kqHd2oYgXUcb
         FtEL0CHtyWa6rHNHXNSvv45xaJtjEWXjrfuenAfct5ir3kGFG0dsibjjkIaMjziL8zaX
         av+ancBzzQCvP2GzHaeThJAUeWnZlWCrI3cE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534380; x=1789139180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gNCncRwcYB9lWmv5bcgCTAj/WG9KBrvFMQ3voJc5e4=;
        b=VL+kSkndSxQKa260FwrZlAEkG2Uu42MB0t+PQqTzbx3mHeI02W/NqajOMmVeTNPi/D
         ZsNffz89ekxUQMzFs4s7gtr4ipcPel6xlzHNtR01PKHh9Spwb+VhAGHHNLG/s8RtPUYc
         DxVC80WHQIu7cUsdBFMfuxhDlupS/qFd6U9U/8qgHKWMFVFZBa2xuSG5xvzcUvPY65Ff
         RhTp0nuCNyTRFvifum9FHOC3s5DMIv6AJXQOeNzVOTgna718kGXNBWlI0rcBEjCVOmMo
         MWDxD+faaykE8AFw55fykRtL0H7b2OVVzFeHIs4BjOJrWIBHEsAKuVOMUtxoCQj5vFqc
         NeMw==
X-Forwarded-Encrypted: i=1; AKwUvBwG52bP6M+TbTRezm3y9mOgsb61RpkiIrDeBSNQcnZM+6SONIGhG4H9ok1nSIL2EHS75aP7toO0YlFlGw==@vger.kernel.org
X-Gm-Message-State: AFuF++lukJTdCx7S/44+JLQ31juEw1mvARfl3sHYKrjHoPbFMj2XuYyH
	nJZrwZr4irIJlKEHY28j2HBvC7bvK8P6Yv1jJQsw9MOyUMPj8UpCHLUtiQS+xf3Nf4ARskZXhdD
	XIF0=
X-Gm-Gg: AYBFou00kpnuyrqDEDuntz48tzkwL6Xf6wtqlWKp5fd/ShYEKgnc6j2w5il9p+VQvK+
	9GscfzHK5yYx1WkWKbpMFc+Cw2lU24lGKaguemZn5KUB5se/1hIlxLykOjjpi3ivOLFwJzZsq8n
	z+9tkjL5YQqdB4damS+W38u5yNXadhRniNGrcgIFDC3+sN5RDGaM4Rq0FsMVwgFkB39kxRCM5t3
	ScYnND/LVx43GEXpwNeppu0HLRA5QCgjtAXN0dg3RiL+7jqFMl963RBGQixUFwrj9OHnKI3YWYC
	qP4hrOWlineiBHbIi9tF2a5IrisM97YHF4BG8fJUPwqnxPbC/YTwG760wd2n6pbcro5/NnrE7uC
	midVmYRF8f2O9GW1nTbnYVG5ftlQanWsuOYV8iK95Xp29kLwRN2IBA2T0FCEUl1YnC3Y63Z5/El
	Xpj8npkf+XHb5dueyVET6SCr7S8wJ0IiFPwJBv31KV8Z7K0K5yuzYmBb5SD1aqIKVqOGP0NTxvO
	KTsNZ7uxA9Dxdp+v2TW8L2pOB6MWDHqFhXD0fMb
X-Received: by 2002:a05:6402:21d5:b0:6a6:7249:41bb with SMTP id 4fb4d7f45d1cf-6a7e8d25d0cmr2379958a12.4.1788534379769;
        Fri, 04 Sep 2026 08:06:19 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e66eb790sm1456935a12.3.2026.09.04.08.06.08
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:06:11 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482ea739de2so747654f8f.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 08:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwHCxjfrVctZq7NBc5MYM4hy7MXS4e5w/wje3UFzBgdshOplSLREtcV6Ew/WRvJ84MpLuUtKQkyR1cHgQ==@vger.kernel.org
X-Received: by 2002:a05:6000:60e:b0:485:8c16:a355 with SMTP id
 ffacd0b85a97d-4858c16a6c2mr4328911f8f.45.1788534366728; Fri, 04 Sep 2026
 08:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904035009.4114363-1-justin.yeh@mediatek.com>
In-Reply-To: <20260904035009.4114363-1-justin.yeh@mediatek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 Sep 2026 08:05:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Us7FrQ2GYYSfm+freDNTWv8xd260kA2Z3B5jFzw5OBgw@mail.gmail.com>
X-Gm-Features: AcwNN1U5Q3Et8gbm1HfFEKvqA92RRKLIkp4skB9nrMClbBiYdjjt_11lut00YBI
Message-ID: <CAD=FV=Us7FrQ2GYYSfm+freDNTWv8xd260kA2Z3B5jFzw5OBgw@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Skip SET_POWER on shutdown for panel followers
To: Justin Yeh <justin.yeh@mediatek.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Maxime Ripard <mripard@kernel.org>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 3, 2026 at 8:50=E2=80=AFPM Justin Yeh <justin.yeh@mediatek.com>=
 wrote:
>
> When an i2c-hid device is a panel follower, drm_atomic_helper_shutdown()
> unprepares the panel before device_shutdown() gets around to the i2c
> client. The panel_unpreparing() callback already calls
> i2c_hid_core_suspend() with force_poweroff set, which sends
> SET_POWER(SLEEP) and then drops the device's regulators.
>
> So by the time i2c_hid_core_shutdown() runs, the controller is unpowered
> and can no longer complete a transfer. On MT8196 the SET_POWER(SLEEP)
> issued there burns the full i2c-mt65xx bus timeout before failing,
> adding two seconds to every reboot.

I don't think there is any guarantee here though, is there? In your
case the panel might have been powered off before
i2c_hid_core_shutdown(), but is there something that ensures that? I'm
not aware of it.

Would it be better to follow in the example of i2c_hid_core_remove()
and just remove ourselves as a panel follower? That would
automatically call the power-off functions if needed, right?

-Doug
