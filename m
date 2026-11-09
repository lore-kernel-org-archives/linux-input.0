Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207796;
	b=djiLnJMhi4ho2OXLHE3ejQJ67Y3YlG9yjMimRGoQCPu9oapZuX5RY29ZE/DS0eUgpoN6
	 5/889epIoe3Q7G2TvtafU61032o8O2xGLpPXzwOljT8Pbo0QYRakzmo+1qu5pUvhbLLSl
	 e7HfZQhONW9/QyemfdHv4PUgj7GQwT0OVrG1BLaaKFWCkVdKzvhevVAEx4eKytxLGv7P7
	 nvfCsspgld110qF06QSnPZGaYiMI5qLhCByXRAmstaN126oAUzIkqlPAraqr6SCeRAsnB
	 CBqQaun1Uac/fQq65pITp6UzQx4/Rcy7W9AyVprTDExKtKbcuhL7c5rTeGYB0zTT+4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=GaJGr2yTrQT2eFazQKP8XrjlwhAwHTLm5YY2vkdP1M0=;
	b=JmyuBxaLuW/y8qAdcT15V880FjogXGFbrzKsfiTtGBoJ4FSKZ6rypln03Lh8ZyhRlPoH
	 B8bCHFsmQs/XvZTvIQZfqhL5V5QbaWtsAz7epH/uhfGTiolEIUw0COhIo7BGIQPNM6+ke
	 oxXA6NH/1dtXQNFLqsQgJBxL5xF2QLpRQAD/EKghPuU90ua61CuemvtxDhWa8ODnNF21K
	 wkD8SvafPvCrSMD9XvDHCj8I1CUZBwkm9MfYspbhglNS4vbzx6POGg/7JWRGc4+pYloY0
	 LcYdJnOcU1F85osWebzNaWJTdWo8YPY+iSqfuUMBjQoSW56LQWW2GC/70sThaxxdlpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tla8DPku;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F362606A322
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F362606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tla8DPku
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37198ed3727so791236eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207795; x=1794812595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GaJGr2yTrQT2eFazQKP8XrjlwhAwHTLm5YY2vkdP1M0=;
        b=Tla8DPkujakVDffreHx2/G9So/6RB58giX6uLuc1x+tXQ9czkFzFrsEnokVT7LPJxt
         ZepYuiBjUVdmO06H+AxozvJ1plnAm69+5YDfsYZmxg5kTwhSRyZZy9LgzC+LMSLkytHl
         vnUihKpB+jw7yXJDrwbkP98Q00KJXWEBJGICUL24I14xoAteSBwD6n/gOjExSpK307F1
         RJguP3hFZHHDWPABiz1NvOHMYt6nvFJSKPUrrBfC+SOMrDHczub+MyY9WeDvVKe2eN16
         VbzfswiNSZIRImSCTHC12YCey7r4XMKBexjW4MMu6KTqmUeNHYVs4B88viBdO+bJQ23V
         Bsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207795; x=1794812595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GaJGr2yTrQT2eFazQKP8XrjlwhAwHTLm5YY2vkdP1M0=;
        b=ubo26ntN/nPS6zFM6EC6drBPUa/fVl1BC6Yvgphl28cE3H5mNxo1Nkx+fYf8HDuqN8
         UeAwWUOnEEMwEufKJnDXvkeA7At3yW8UdWiwt9QKDYgVRWnniNv8vO5YBSS1/L/V4Y4R
         PLm1OGCp1o5K9zWBMcdiTIoGx1mDtYMXB3IGQdhhi3pYU3CqxWsrObUdyxkgwrCWh7Rg
         aGpGvTGoGOfHjxrG0xoCrB9dfSnxbK0FMh4JVX5rdMdNMEnbIJ9m09XEcqJryBjNif3s
         ReWWwosHt+aDnQGrXeg1CG6iQ0ucEgmBPpoSQ4ma0AJzR3RBISdtMYNs9Sn0olArTjiX
         XgRA==
X-Gm-Message-State: APuU4Z/z5TQirBJbOXHgfpNEuoGANoyZ30dnmItFVDaqn85GrjrBhnKI
	9Tw9PPOwTMM8geEg/Gn45K6IU5bukB0Zj/tUlHEyVBFFfqxQe2khPbCY
X-Gm-Gg: AYBFou3SwWWPJ+a14iADC+FBYkj64k8OptS0LPHDwV5GggP7c0uduNsw5R87dZhVL8A
	e3rxo/xPOYTO/tZ4epbuFFlK+loHZHguARAskHW2AEKAd8dQ4puS+d6kQ+SJ3RhuwqlV5HHYsIe
	VXGEqJroTSvnHv2tQheu9gkFovcDW2CPxiGemaatYIgGUBRGYAG6MbklldsCoau9/j3CK5T5hLY
	yJol2EU8o4XwcDzQkPLoeABkzUL9+ggU2aF55hJ2ezC++VQIxnv78WRkFLBBEvd6j8GmU5SLJId
	G2zsAfFZpB4It01lNEHcCL1QkW75k+GsWCjIGuJ48/1pMBsLyuTeBY1TVBxUSbpUAqgfGR6qF8P
	B3vldkhg/qh7kKzXznvanHGII56A3aed/s+lgd6+XuvL74LnAy4nQ/gsD8KC98dZ5AkMH6pHa8y
	0L7BNLGokU6IzHJR9RaQf6s3TIacVy0EPBJPz+lpfy1LVYQudyy6Rfc207KD9UEXdGxTZUzRLAm
	hRlfgLAX8zEj5tv3ZJOpElDlkH2oC4F3FRHz0ywNDpN29AtASiKV22FyjGe6s0jE4t1JHoPfkzX
	tXmWQMduY1XgGtY7JdhGBo5NzUWZ1XQ1RW98AZvttQZCjhgnluHOxDvUkKvPOoljuaSg
X-Received: by 2002:a05:7300:6da0:b0:361:a195:c46e with SMTP id 5a478bee46e88-370f427ff8amr14650949eec.1.1794207795205;
        Sun, 08 Nov 2026 23:03:15 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265efd2dcsm10574645eec.17.2026.11.08.23.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:03:14 -0800 (PST)
Date: Sun, 8 Nov 2026 23:03:11 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Juan Parrado =?utf-8?Q?Garc=C3=ADa?= <jparrado.1817@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] xpad.c: Add support to hyperkin xenon, hori taiko
 controller dx and 8bitdo pro controller.
Message-ID: <avFwGwoJ45RGvxRH@google.com>
References: <CAFkAFXod+xQ2o9SVGbKwg_pacnLrUYgzoVeQLcf4wQZN7JyUHg@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkAFXod+xQ2o9SVGbKwg_pacnLrUYgzoVeQLcf4wQZN7JyUHg@mail.gmail.com>

On Sat, Nov 07, 2026 at 04:47:07PM +0100, Juan Parrado García wrote:
> Add specific support to various controllers:
> - HORI Taiko Controller DX
> - 8BitDo M30 Wired Controller for Xbox
> - Hyperkin Xenon Controller
> 
> Signed-off-by: Juan Parrado <jparrado1817@gmail.com>
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 810e52782..be81990ce 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -259,6 +259,7 @@ static const struct xpad_device {
>   { 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch",
> MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
>   { 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X",
> 0, XTYPE_XBOXONE },
>   { 0x0f0d, 0x0152, "Hori Racing Wheel Overdrive for Xbox Series X",
> 0, XTYPE_XBOXONE },
> + { 0x0f0d, 0x01b1, "HORI Taiko Controller DX", 0, XTYPE_XBOX360 },
>   { 0x0f0d, 0x01b2, "HORI Taiko No Tatsujin Drum Controller",
> MAP_SHARE_BUTTON, XTYPE_XBOXONE },
>   { 0x0f30, 0x010b, "Philips Recoil", 0, XTYPE_XBOX },
>   { 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },

This all is line-wrapped.

Thanks.

-- 
Dmitry
