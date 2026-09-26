Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC03282F18
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441238; cv=none; b=JFt4WLbc3rBITOYuURxpalLJ3GGsnD6yYHCnPF+y7fFONDddy2M70SOdoksDkNvGW9rSw7rZ/u1q5wbkRfyqJa4GXjOpTeEz8pWXv1OlbGc6/7dbGW4EHwmvqFxp85fqbRaC8siwFSDMNhe9ZJbF9c1Ndcu2WfLp1XAWZCTzTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441238; c=relaxed/simple;
	bh=hOehcCNhImc9jZdVfFWI/hxODane0XmTkFAYGXms0qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poVqs2VuE+++I4RzmRjZS0ttReikfMKcO32obezPkpKwEvvdn4Z1NVKoEW4JJWU+ZxA3Fqo3eCgCUjbvDG1xMKRtT+dGCb3RU6YglF8rYVyMo1Wt0fFAg1NhzZjG3tO9sxpcPEcBSj50lckCkaIfetKUDdH3a7B9oGxn8YveA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM4swh8b; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM4swh8b"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c264788fd58so266123766b.1
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790441235; x=1791046035; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SE+G7WveymjpodiwGFWjGZD7a7Jf5IhVJZYgV2T6LVE=;
        b=EM4swh8benWfvaMnqm0Dl7zIklfK5ybtAjGsI6/mIWZCkbeRCvTjfyfdhcAyOPEF3e
         OOmvpb9YJ/M7yk8/mnJCtd/utASB1tDUnsHAfo1bFZfwz+OoyKiO0GExH6ERtpnlx3vo
         Pz0arxvo29JtE0Q5uFCCrd7+nGLMwNWLag7nfS2Q7VJ6m9ZeGLVh/iz4CKdjq2UqHy75
         qHLpgE9LUG3G0LQ6O0YqMMpQzA8KfLdZFM1G33vTjnndDPSCFK2jR8xhMLYVBB4U99ra
         MaVJHcjIWyPnmkao008GgaklJxMWjIL3M/EByROeTc0xSEEmoXDC4MjvDzC3Pa047DPn
         M+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790441235; x=1791046035;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SE+G7WveymjpodiwGFWjGZD7a7Jf5IhVJZYgV2T6LVE=;
        b=BbKGROQ2MhfVK88H1+14oL81hXkf2A0pyGFjiN/kqQh+WDddFMkc11XIh2a/2W3Ndk
         +rIC/0Myhnl9SQbBlEBb5ThrFby5505C7VtIGAc0j9QHRuUBmiSEDqQiei22ZR+zIvuw
         BjbrpdeGZn/nQj7UWmLU975JcGT44RtsLXe1FX2nTKjMbEdiBlz+5nNeo0QFkRZ/b8OF
         VFo2uZtZEhSFCzP3nsNTOLw/DUtHjVBJq1tvSglMk8fNcjKFSOZOpe+w6ktlwzrLnC73
         TmhJoN6QEkmBYEhymWySxH7m2VU4uUAwdGZHX0oIu/Ey4VD15wPeDtEXrE0GwVSPriJJ
         +HIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZQ48JTS1QxmkFHwZb1utppQDxiRMi/iaFmaM1BZCciavfbeUJDHNVKTsTf3Ghy9COtsAh4jrYasAFrg==@vger.kernel.org
X-Gm-Message-State: AFuF++la1R34oSfmjhYC/SzzCEUBZhPEENInkuaCOK3RaorxRHIDzwjS
	bxr1GXlun61DDGJu0DFU6QJYgqatRepVPvtsyukIQMn54RE/Rxnn7o74
X-Gm-Gg: AYBFou3I0Vknuqelz2ee9uGo8gRHIWpW6boLTCk405XRX9kQWTUUpi0JR/Fvx/QKa6G
	FGAOX1FWKvFi+pLer0LsMHkThwL6HUPjEpdoqMgFoaC4Y24cXYTKHXIe4PbqMSzcEoO/19eBi9F
	/btcl4/dt7GAa1//OlXDpuwP7BeLW2sM6drsqSNV7qMmNyom9Sj6yeMUFbyGMiW8KfxYZWsg6lS
	mhQDWwdQiYi7fd65/huBjLqcGoTkaJ3ggDWmhLxCQrk0r/Gl1IgS11GjIiwCUC5IHSnL1LpNwNP
	DCvdqOtxl05hDxOMbz6EabeVQuf2j7N1vciRR2ediWsDhi2tLzo271loIRkF2zl3IH1G7Gh8/Jx
	ZlP+/Ak2i95btmZjyEIofozq1ZzIiIk1TWbQ3hk2aMdqtIcE1RvxaHirFBHbvgG9PwaOWGK7Q2+
	jcXIEZ8DhfG0BEm4Y+k+7LVb8cngQZSVW1ts09ZahQMDYPgUzkTLLJnjjNI59Cxm3PdOK0I+4zO
	Mi8+VBqhaInUmhlVa3pS/kkgwvjUZ9Vh3mAxw0S4DOA
X-Received: by 2002:a17:907:7b9f:b0:c26:19de:9ad3 with SMTP id a640c23a62f3a-c2aea09c326mr440290666b.43.1790441235086;
        Sat, 26 Sep 2026 09:47:15 -0700 (PDT)
Received: from fedora.localnet (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3a0424sm66243966b.70.2026.09.26.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:47:13 -0700 (PDT)
From: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Filipe =?UTF-8?B?TGHDrW5z?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Sat, 26 Sep 2026 18:47:12 +0200
Message-ID: <fOP1GIoqSbWODEBBrJiNgQ@gmail.com>
In-Reply-To: <CMu0gKyHR4W8ebuetRNJGA@natalenko.name>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <n9DH6GE8RMS3_4u3nLY20A@gmail.com> <CMu0gKyHR4W8ebuetRNJGA@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 26 September 2026 14:24:46 Central European Summer Time Oleksandr 
Natalenko wrote:
> 
> Yes, there's a traffic.
> 
> One direction:
> 
> 0000  00 23 e7 90 c5 8d ff ff 43 01 83 03 01 00 2d 00   .#......C.....-.
> 0010  18 b9 b7 6a 00 00 00 00 f4 a3 0a 00 00 00 00 00   ...j............
> 0020  14 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00   ................
> 0030  01 00 00 00 00 00 00 00 04 02 00 00 00 00 00 00   ................
> 0040  11 02 13 00 00 01 00 29 02 02 00 00 00 00 00 00   .......)........
> 0050  00 00 00 00                                       ....
> 
> Opposite direction:
> 
> 0000  00 23 e7 90 c5 8d ff ff 43 01 83 03 01 00 2d 00   .#......C.....-.
> 0010  18 b9 b7 6a 00 00 00 00 e2 1d 0c 00 00 00 00 00   ...j............
> 0020  14 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00   ................
> 0030  01 00 00 00 00 00 00 00 04 02 00 00 00 00 00 00   ................
> 0040  11 02 13 00 ff ff 00 59 02 02 00 00 00 00 00 00   .......Y........
> 0050  00 00 00 00
> 

Perfect, thank you. It looks like expected, I think, so I think I can manage 
to get this to work with HID++ diversion too.

Cheers
Erik


