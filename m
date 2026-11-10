Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316961;
	b=bKvXebaKP2a+ckZQml8I+YLLo87KlRfWUO/6n9/TOxRk2aCBUYFPCdw4UXGs875/LtSc
	 vNMOL3q5B+vaD9Z1HWo50T96ODTvsylTCm/ht23Hhp4kItnVahQUy6nlJoqulMxcTlhOn
	 oui8OhbHVToLTzsVo6oRCzpNSx1lqTrj3S/kpon/KQCnx0wKvf9EoG8HJqyBzT/emwjXa
	 18nmEb7dUlnKX5fpnsKITeJjRrSBb4JgGWCffN3JXkawIvytwtZsgnfDiM7XgS5w9Pj4Q
	 F27LbTwF1ZPTbpykWhY8PAZbS99PmHGqYYrj0n+qMoo/KgOXUm4rExRcObwV62qgHUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sHEx1YOYwVmS9mdP/h27UNxsg/xQGaKawL4tWGMHKBM=;
	b=j0o7pJ6o9dFYVgXSRU5+o05OuQqk3QeCzo0gSITEMyspPcXqm9EX6ca7RNxBGhTrCYHG
	 nRGwxNla+lZYNlLfTC2lIDSjvVHJNK/WxKFPQbT7Ps6b6EzVdukJrveyggg64bmWlF5Ig
	 edce6E6pJDg4eVtYPFPEhq9XP7gVrauDtfW1d+U9CfcTKWUihe7e2LQOb+JdaU5BrKsML
	 hrVlUdzzRfPUoEJkRcRHIh1xm/pPjeOoYKbInFB6eyGXB9xmWeLr50mXEiroNY+A5uNW0
	 TwX6ylhNOyKjvVjG/qkkf/vD3Cdv9IOKUNxrQorieLZ3IMZ+KX3LfYf2U8NuYZVc9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdU2lTBt;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10943606A7C8
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 13:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10943606A7C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdU2lTBt
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2761c69fbso2995104c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 05:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316960; x=1794921760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHEx1YOYwVmS9mdP/h27UNxsg/xQGaKawL4tWGMHKBM=;
        b=pdU2lTBt/tf9UQ0mMFIwo3Hjnf/Ybhh+iNkHOs+8ze76RxylLa15zXfaAM96YEMZKL
         UKfYpagdK5KjeIGNpS1N1uVSKj4e5k6c6bycJ3TmdvjPQP7AiehshG/Bf7vcMn6FegFk
         jQnMmakU1S5xbZ5l4X1CyDv/RxgRoLhZ4Vjlpf4qILu23xpQlN1X3im6nY95pvES9ate
         SU8l4rnIib2hkQj7K3RdyME8q1QPlJTHEkbWcx2EMtnaH/IQWrbmxb4+YHC2PlAcd2E4
         wk7M7SgkPcqaUbo0wtSkzGcUoBGiJIF+l5jeC9PZyd/51xTbgcjDqcvjYAU+PYWMgiu6
         G1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316960; x=1794921760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHEx1YOYwVmS9mdP/h27UNxsg/xQGaKawL4tWGMHKBM=;
        b=Q423OLH+LBLDqkHERJyt9jcY2aYKcPG10UhsK1qzJyLblhnHjDEt/cgFdQQU2UrmZM
         aq8MkdOTQiP77yp2h4QoyUWTS2XyeYQ3yx1Xi6T7UfoxPB0Mlc3qa+un0u1lUZCFmN4K
         OQFyEbw/UwS5gHxlb8WJdvQM3IdKMbJrbfxaGndZKnUPluFTSsNkGxX5QfyQa/0DeGn4
         AKCTFMcaFUi4xiVL6dFxVlao6Vkn7b3wFAfWCmIQ6EPCGe3vu+WCBb5pyayTME2EkVIA
         OzRk2IeZ5VENv05ohhRzM+NHyDL/kbucn2jHZNEQGle/0sYpxjyHNRw6CL348jh3I1d7
         Godg==
X-Forwarded-Encrypted: i=1; AL+hErESDcLul04BbCWR4SNua2+FxUrJ4BkqQlx4pksv5oGY3DjyzRfaCAQydNQHUsBWqWIHgui4c6OP0zgoxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9TYKCx1qDjj6Un//JG0apzf0HH0u2IIjYvAA+58p+HVEN80Ox7
	i0UqawWSByM1/JWlUrKrzPmF+ulH3f/YfnIXg6XY6Akh3Ad0f6ipJ+AL
X-Gm-Gg: AYBFou0ZkC5Tr2jCuGbRr1srSPvdCZm7i9fbdx1tnBC+cRz9dMV+6D8rQ+nzqz+zIG4
	2Hi+QKT4fZQiaLY2GXR6IVyQlleT30OHwf14UjR37r4Z0d+/Sc1jDlWVtL48drGld6N9+3VtJF0
	sX/gOgVFT6W2+wgOnMBkRlX3yKPXOMuAbu65Fs/0ZUt9dBGxIp0XvG/V36hXLJfWwXcodzVB41O
	xqByAhXYd5KM2kiJPgG+0q41tlrltQlrizxYQAtVg+qxerg+A/DIaVz0VenAiib28cfy4v/3VuT
	RoGX7b1N4bb79stu+2ztpPDGdI/5wN9MlPklomaZco+r2yRmZXGwk4KJ3V3s8WrE2K5Xmgnn2yx
	1kPfbBFyi24BZquRLsNgaaM+WhD3vbV+2QfalW9fxDuJKy6EF565e8qzoT4cJ9P/Nwsi1DUIBIV
	FpXuhps+FG6hPomP/GLKOnkGomEHBGsFoNrD/yHnYsrDRd6/V/JmyRw26Tdg//1qyhNM6M2Vpn2
	8EZg791ZTL6ao1M8E+UMfHlNY/QHow7mibLidYFAHMqfDxiIhc9/UVm58URaD6PUi2U1c+jNiF2
	Sa9qMaQCH9s4BCOptYc/E36K5jU=
X-Received: by 2002:a05:701b:4591:10b0:1b3:ba92:145a with SMTP id a92af1059eb24-1b3ba921484mr1380094c88.19.1794316959868;
        Tue, 10 Nov 2026 05:22:39 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b72ce0sm8213240c88.18.2026.11.10.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:22:39 -0800 (PST)
Date: Tue, 10 Nov 2026 21:22:36 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jingle Wu <jingle.wu@emc.com.tw>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vishnu Sankar <vishnuocv@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, 
	Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avMZOPd7qq4xR7EJ@sapienza>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avKBsi-E7IeUgsSY@google.com>

On Mon, Nov 09, 2026 at 06:36:15PM -0800, Dmitry Torokhov wrote:
> Hi Yuan,
>
> On Mon, Nov 02, 2026 at 09:08:36PM +0800, Yuan Yao wrote:
> > The new ELAN trackpoint variant id 7 is found on thinkpad
> > X14 Gen1 laptop(Product Name: 21XMA006CD), it's now
> > incorrectly probed as Generic or Logitech PS/2 mouse.
> >
> > Add ELAN variant id 7 to match the TP_READ_ID command
> > return value, probe the device as trackpoint correctly.
> >
> > BEFORE:
> > input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63
> >
> > AFTER:
> > psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware: 0xa1, buttons: 3/3
> > input: TPPS/2 Elan_variant7 TrackPoint as /devices/platform/i8042/serio1/input/input65
> >
> > Signed-off-by: Yuan Yao <yaoyuan0329os@gmail.com>
> > ---
> >  drivers/input/mouse/trackpoint.c | 2 ++
> >  drivers/input/mouse/trackpoint.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> > index 3bd8fdf56cd3..f46fc1665c96 100644
> > --- a/drivers/input/mouse/trackpoint.c
> > +++ b/drivers/input/mouse/trackpoint.c
> > @@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
> >  	[TP_VARIANT_NXP]		= "NXP",
> >  	[TP_VARIANT_JYT_SYNAPTICS]	= "JYT_Synaptics",
> >  	[TP_VARIANT_SYNAPTICS]		= "Synaptics",
> > +	[TP_VARIANT_ELAN_ID_7]		= "Elan_variant7"
>

Hi Dmitry,

> I wonder if we really need to say "Elan_variant7" or if we should simply
> say "Elan" here as well.

Thanks for your reply.

I'm fine to just "Elan" if it's ok to you. I just want to
highlight the device has id 7 from other ELAN devices which
has 3, so I give it "Elan_variant7".

>
> Jingle, is this your part? What is the difference from Elan trackpoint
> reporting 0x03 as its variant?
>
> Thanks.
>
> --
> Dmitry
