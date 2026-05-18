Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBF302742
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089535; cv=none; b=DV6OAGQ9/XDVH4cmeoDMdzUS7O3e3+LnxeWHjCr6IW7GDWsehqUUwAd5g7mCt8btOFIuM8wAWDtT8+UvsrzC2DbhHZdGmxSwEvFhSjMmnH47wgKKAd/nfeAp10rGMF+rHZ76xtCN9hrnfUBsrh1K7Z7KcOXMYjVaMD4YfP108V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089535; c=relaxed/simple;
	bh=itnAfD5lI75WoCA5V2Lw6o3uvx0+Wp+BLneLjuOhUZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxjb36giJcU7ZB9LiI7kYAnnuLbl+X4vkRkVGsPypeARPvrdCUyBJuiq6NsKO/pTulML1JAbokWR8372nIg7ukuXH7jlnkR/f2ygWh6QXb82AfoQV/qAOgETYiWPl9NgJqETfW6iEUQpnDmZRQ2wfxEhyChap0ZBauFnBEwKY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso499916a12.3
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 00:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089533; x=1779694333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zAX9hMXPiheaabgyT1lZXM8onJqkgfJ6l93xnHwfAq4=;
        b=h7+6hBWuLTwVrO/XXUpg8w0UMV3YbTUQrg2DrOHz2RiVAeFFHo5245clwQO3sSPVg3
         jMhjnR3lWph2aYmnfmMesaYhk6CsK2WyLfqElJ3GhkvuEvJttG9Bd000+7WVjK0Wsb9n
         A//VohOP/l2I72S9tpqnPjRxP3IIXdnyH5SckFYRlbt6t4K/R5S+PNRTDHPgJ2Lkuman
         vO7kXCwxSlt5mtHMYeBbscVfZ4lhXfgyID+Le0BopV/bnPxLIjxwQR6FR9Bn/CrPc2TM
         3uXvyJ9qxoYU9k6E3pLYfGySrnAsUPjExTWG+R0gLsrl9Bq+0cOMyE6YXmxXxO4GVbYW
         Q5cA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xo0LzgcbCF9qdpinUORgbbC36BNxRzmXIuzwjCbNZa2DGDTTjXmO4NkVHVkZVjl9ntYgFW2JJ9RbYSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76aZ+E/1OcQQiKfmyYXLX7cc8JPrBfDdVENME1YIu6134S5y9
	p8Ojy5J+MgDQIddgXMtfpwCu110O3LuS5MzVfMjNxAnb54DZpDau0VNVEcDnTXzE
X-Gm-Gg: Acq92OEYN3r55FBAyuMBiZYTy/+JN3UGIBSj+5hGnnst5LOXlmk2jEmLEfl6VcPbLfT
	KMMfO9huzTKOxiGADEhx6l6g6e6aVyn9A44M7yYO39h1e8iAM4m02oPmr/5p6HMKueTFSV8SRRl
	H6p3oUwakVU9kXOot5qIPKi0chTroTLHyydmhPd7ucExB3OKKrvP5++c+VJ+u3ydwFe6t3/EcNU
	CjVb1vRCAhgenkfWR2LH3sx/Xu4jxH0It+6ZQ9HVzD/6retOeBilzuiGsnrO7akRW67U2JNmvxu
	bkRWMFta7IUvcrecREWduJCJhtxuUxM2UQoVS2TMaXAWo562e2iunMZzfKyqYMh/Dv9LB5gClsS
	8eZhnr6AJUi314OisUh4mKmjszbT1iB1ZGRZkv1eaOVT8plFytQk7BrMHDlU4Ss4KV7b5rnNdVF
	J4M/Ulx4HY3NoXDHng0aPZ1xjd3VadRBEaSBapTX+SmIMBlyDxUTySO1vBAv8=
X-Received: by 2002:a05:6a20:a12b:b0:3a2:d0ed:f1f8 with SMTP id adf61e73a8af0-3b22ecf94damr13890992637.30.1779089533239;
        Mon, 18 May 2026 00:32:13 -0700 (PDT)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb123986sm13571607a12.32.2026.05.18.00.32.12
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 00:32:13 -0700 (PDT)
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-134ac81c445so7903413c88.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 00:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Zk/6gbhfYP16hpllOSgARUwObcMyvk5g+2lLB2d2Dknh93PpWanh44zSB0HyN/wPfqinWX+HxEhkhXQ==@vger.kernel.org
X-Received: by 2002:a05:6102:f83:b0:639:4bb7:c916 with SMTP id
 ada2fe7eead31-63a3cc0c2d3mr7561944137.3.1779089086695; Mon, 18 May 2026
 00:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 09:24:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGSBbQtKaoFej1Qm-SUgDenLMDF0psD9o07wyHKu8A+w@mail.gmail.com>
X-Gm-Features: AVHnY4KCtTIyMp1YT9qrsNOPXjoXEF7LJA_Isl-7-vM7CDKMV110o1b879bzndY
Message-ID: <CAMuHMdWGSBbQtKaoFej1Qm-SUgDenLMDF0psD9o07wyHKu8A+w@mail.gmail.com>
Subject: Re: [PATCH v1] Input: Use named initializers for arrays of i2c_device_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anshul Dalal <anshulusr@gmail.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Yassine Oudjana <y.oudjana@protonmail.com>, 
	Linus Walleij <linusw@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Support Opensource <support.opensource@diasemi.com>, Nick Dyer <nick@shmanahar.org>, 
	Hans de Goede <hansg@kernel.org>, Job Noorman <job@noorman.info>, 
	=?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Kees Cook <kees@kernel.org>, bui duc phuc <phucduc.bui@gmail.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Yauhen Kharuzhy <jekhor@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Minseong Kim <ii4gsp@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Josua Mayer <josua@solid-run.com>, 
	Michael Tretter <m.tretter@pengutronix.de>, Jeff LaBundy <jeff@labundy.com>, 
	Javier Carrasco <javier.carrasco@wolfvision.net>, David Heidelberg <david@ixit.cz>, 
	Petr Hodina <petr.hodina@protonmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Xichao Zhao <zhao.xichao@vivo.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Fri, 15 May 2026 at 18:48, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> My additional motivation for this effort is CHERI[1]. This is a hardware

Nice!

> extension that uses 128 bit pointers but unsigned long is still 64 bit.
> So with CHERI you cannot store pointers in unsigned long variables.

Good luck fixing all implicit assumptions about this in the kernel!
Also, good luck convincing people to use uintptr_t instead ;-)

https://lore.kernel.org/all/CAHk-=3Dwj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe=
7A1d-g@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
