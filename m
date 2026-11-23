Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795416165;
	b=g7btu5F4PpT1ILcwrXlkL38pVBh7EWOwxIqGL9S7Sanszd6DP+0F+RD74xtM0kMo3nA0
	 9UJfdkLVgDMTba/6uGqpe9qRnptBfx3oPTxcRbYtBVCw7j5zHUljZHiveLLs42uWKGjtR
	 EJrPy0RdeXo4NDVM0Y3D0Sh2h8kMBmjCSNqru8tHyP+i2SuZjB1jGS50C7XFTApyio0MY
	 Tp/vyaZUSioWOYXK+ngwrlZN5o8SBusEl+2WZ0oM/zEDpk9ImvNCDRlMG/+hK71eZpyMS
	 268Lahx9QQxOh1KlLxUh1D42XXlRmC2SPTUkKKE1XqwwsJzi53o4iW3BrywTukOamOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
	b=qn6so5/X9EAMWeW4mqYFkhiz/3icy4SmshQCZI6pb6AHyiQ7GlojlREQMW9x7NcUXMwN
	 IDoGYpexVdXmMrhZXO1H07Of3jsAYz6VYcCpxe3QtuU6sl3EgxYZZdDVZyH/kEMlqC64o
	 sAbhMj9vIfRcwl9Q7O/fJg84n/KuPnYRSQP1VFZKM5ulnZ6XGWBZaRIUplrt0yClS5CjP
	 L8OP6yuy78icoYO6wqDQaiIpHPXsPfMdnjHVPKB4WEm3YeKYoqJGLTIos0upSvZ030e6M
	 fmkTmBdV8FnqPgETaorS7xoeokQmgC9/Q7uqo1jVpapLBt7TL/UXQX1aiHpn20HBHMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ScVPpVXT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8ED606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC8ED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ScVPpVXT
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67da564d9f2so3843838d50.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:42:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795416164; cv=none;
        d=google.com; s=arc-20260327;
        b=H0F4S3Lm9xHaM9lLw+SVMoa2r2Z6UuUq+vNlOWF7PmHm52ddsfMQMTxDJp+Ldvur1+
         /PK6CeZDnOPRPnAJmVN8M+pktv0aIBl+dZVMzwWG/XfaIyvaYksiPqXSWJnSH+Vubwu5
         kExyRk+rWiAsFNJtAxPvWsfVsG5VZ8D6FIkRqnG8PX9FtyLBsIzCCwm628mTDaFDMkxr
         cwoh6PSVzpEumGAskY2N4FgGUYNVyvShlqT8KVhKZoJ58+sabZrCLTtP7qdFBQMxhPV+
         IRaRa4dvkP2HSg9uaip9SKyq1sJyzDZyeyyHiwp7+UE7UaXqtKeVbCNwz/+6YW+x0HPR
         TL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
        fh=HQ6TaVUugQt/T9mNhE1AJzC3P57ykBDNfQpp0iqnqgI=;
        b=jN78zdWpFLjXEHS6VpKDwuJbGi6a4rhKes84LJmGiIQ+1qlvXP5pziRJrVP0S0vgRJ
         C0Cwhfpb7lf5nvvXAgllm+4JxXpdMkwD1I76qxTV3YMyuNrWFoh29bN3zQTqlDXMpOrJ
         TFltLxC1Wb1EJRGkhOfD12nSMpTvJ6TPtOKxoegLwwP+B6gfW5C/bosO4Uw94i8V9kDF
         Hp9ReTYVMlkPJIRdsMocImXvOh4IwGb2Ru7KLx8t+3eSgJXb70bqlg1G94ylWy9Tk3y5
         SnSjLmNe3azmCD04Sahto/UEk+B0QSxTo9o32DCvT3OHj/S631Up41AVSw4CiQAmvZIf
         SVQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795416164; x=1796020964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
        b=ScVPpVXTZPlEkXMOVmOrpFrbcx18M4yy08hKdSrknGePgEsA0KYlK1JTjkk8liiJLi
         en8EFA/UOSUydUn7tdFUr0OTU53c8TrzHtfc7GJjHfLX4Ohd6yADP8zoasW3nR5u+PZq
         yi2p9rTbYLEFcbTnKsp7Phu5W6LA/kca/ozPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416164; x=1796020964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=naTtgcRj/MertQfpVKpr5lkSMEaf2WtEA0kcdQKCaus=;
        b=vUqk777ajLpmnOjK9qBIA5aHx7N79LmKS/lD4ociWSEZObU8hJ+7JEYP/s2z3IAa2N
         KBSVpMe+dV1dGomqXTF2X0UaqRkVm2v47iL754FAwLNFJ6H1Ho3Ztcu2692a+JVPBR4w
         jbzOAL4VhhtJ6GI5o3u+oMUGxwTgq6uwOntn8QYu3cSjKshutngAVD//HZIME3Cw07ql
         h4GnvSWtXmc5HjWqVa+IU7xwN1WEbpAin54rsGjGtVoclhyt8eDajy8EZlLSqacQFIHo
         eq22QhFGKA+oTMc4XQRIX3k/WcWu/4855uhcbE2MtaDlDjhVuyuFNYPT0q4RRE+RZbao
         QrBg==
X-Forwarded-Encrypted: i=1; AL+hErH2B+QMGpqisvfKxII13U4/ic5+mUGPQQ07Xb8WBemNZyplLtqG/s6fSSbghHpblllBt4eLvzZkjolBng==@vger.kernel.org
X-Gm-Message-State: APuU4Z8inFfCgyJQl+pb+Gk4Ca/9g/DlTUIadytPPXVlFZm1TX0VBNVa
	ZR06YN7fGhmTJoBgI3xM2a5En6qcBJStZfzL1o2zrpZg0DB7wAHV1rHfeFT9S1adIAF5TJUv93G
	S4mNp1OnENV532RNN8bKsjw0SkUhIBOWg3VDur+sa
X-Gm-Gg: AZFdTZd+q83NzOFrQLg/VgNiajpzm6Oax5G1EF2TC6cUaQUM9AMlVun9jvItVioJ3Y2
	Fa3S5DKLKYUYNYgQfdrusAuw0HDXiT9pkgr5/gpE9pp5Yd2OGrL3k8XsJW1aPycaSiFmHzZP4pR
	WUIKxdCEiDNdB67ZoTyacLfPR64Ujj5pNFPBR/gNh/P/HwLwclRJND4g/jLQMhnZJknBczZ17FB
	q5oC2aH6GLcz/BKOJ2F3p/r1UQqfvJXZ8BaR1rDQ719Yhrblr1QoaHbT+Wg1eqGwYcjwt9jdNWU
	LoQzMhkK5YtqFQvj85TWwT0mlgf3KCswgBj7taFL3XFdtfjRaLMSe+ylKmq1wFsWHyyuQA8sqEU
	ckpaKuN3Hqny36sIuOj7XnIPV3DhVVeRrlM6B4zImeWX5CwRDYIdORLykpQ22n03SzM4=
X-Received: by 2002:a05:690c:9c02:b0:8b2:bb94:8cb2 with SMTP id
 00721157ae682-8b5204ac257mr41593057b3.35.1795416164019; Sun, 22 Nov 2026
 22:42:44 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103043734.2179858-1-wenst@chromium.org> <20261103043734.2179858-5-wenst@chromium.org>
 <avLw2AiqcnO9Blun@shikoro>
In-Reply-To: <avLw2AiqcnO9Blun@shikoro>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 23 Nov 2026 14:42:31 +0800
X-Gm-Features: Aa3M54qFQQaP0XRNtPCyFnaJIa2pdaKUHFg7uIqYmbd3iYo_i21tDqRJOm5IHRA
Message-ID: <CAGXv+5F5hf_8U6j6tJ1WcS6gUCiA82ny+6DXPv12g=vUjwYUhw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] i2c: of-prober: skip post-power-on delay if
 powered on sufficiently long
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Tue, Nov 10, 2026 at 6:24=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Tue, Nov 03, 2026 at 12:37:28PM +0800, Chen-Yu Tsai wrote:
> > On some devices the I2C component is powered from an always-on power
> > rail, or the power rail has been left on by either POR defaults or
> > the bootloader. By the time the prober probes the device, the device
> > most certainly has finished initializing and can respond. There is no
> > need for the delay.
> >
> > In such designs, the system integrators tend to work around the delay
> > to avoid the boot time penalty by simply omitting it from the device
> > tree and the component prober. This is undesired, as the device tree
> > is not fully describing the hardware.
> >
> > Switch to the new regulator_enable_and_wait() function that makes sure
> > a certain amount of time has passed since the regulator supply was
> > actually enabled.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> @Andi: Chen-Yu is the maintainer of the of-prober, so I suggest these
> changes just go in together with this series.

For this series, you'll need to first merge in a tag from Mark's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
    tags/regulator-enable-wait

This tag provides the new regulator_enable_and_wait() function this patch
depends on.


Thanks
ChenYu
