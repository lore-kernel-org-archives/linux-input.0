Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752459;
	b=2UBvEul36mFWmTO/wFJrTNbby3rLHtxjEZEC7obnOFcilAMfnprwaqVC3RU7DVaVByS/
	 rp3dt3jEWmZGGzE6pJ8Vch2aJOwR6pvpyingvNNcuFXrvhsru+hD3cGm3y5lzmg28kvud
	 PGxopPjSPs5fnsH3a0sSj1QmcOmKvisM50W386fS+szl/IqcQsVnFd0QYXAjP1CoT4ecu
	 rDha+TAye1RZAiC1tiQ3m+VnfhhzGotZUeUoyAvsBj3E9tXrZ4CcfZcQ06WAqs5VSeWsE
	 05YjBvmLsdfP8nfkewXpuZkXmHazpwQSI8BRkhgNrpl82VkGjL7tUm2pSt8w/FGB5Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3LNMLZG0WtU6bZFty1R9UbhyQ1uglYcTb+8oJ3PlLqE=;
	b=T8bluLl82laUfjSxwC1KvvUaeefLg6rUexPX+Z3O55+KtVdcH/oMGFcAPsqYzkvPZ2Pf
	 Blmovke5XidayhbY8WmNzM26eN+Jgkz8pTB1TkwL7vP7YzCHxYzvmZmtTfgWCewvrkB6C
	 pfBrmA7Cg4RmgNpvkKNpN4AsewG0Mk1+qROr5SdSHgjP4RstMj+Eh3Nnu+6uiOOjyxkQF
	 eFJcCMeKW9v0U+4G0bYH/5c/jOETQVCt09+hIHvrgD3Az8JR3CsNe5CxuU8VEfWq7fW6m
	 FJYKRjBXm0aq3goNFnqZhli1GuuFjbxSgF+ghm4bkdm7hwnfKJM0JDEKaui8pkZ+IeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+TNvaP2;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B3606A31F
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 14:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 828B3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+TNvaP2
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so3796586e87.1
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794752458; x=1795357258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LNMLZG0WtU6bZFty1R9UbhyQ1uglYcTb+8oJ3PlLqE=;
        b=E+TNvaP2aTULQpOYzfaTF8l1UNGdtdZt7dd2EI8gK1OqsE9rSXfBiQdFdQc+kC0HXl
         5KV1BCUenbz12PP9QMtEu1RbPN05co1hxtwFFTEQAb1u+bE7tPJkyl7+ePH1qNqfJAUv
         nuKWlu6H6WflxVU19QDDxIFNDicHKiTTSPkWvuqqFg+gDKnUMLITsXclXBqVa+W/NggP
         KL5QAgObbj8i/5o5B6PoVdZ0FBuvUzyaJ6wM//BLjEBaRORMR9MVpg8dEqDUHivCWe2j
         dG2MrthtDSOA+WACG/rAOMJp5fXVX+ddhFRPtMeX2Ztv3MSszK/zHehDoErooHGK7R2k
         jIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794752458; x=1795357258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LNMLZG0WtU6bZFty1R9UbhyQ1uglYcTb+8oJ3PlLqE=;
        b=MFlE1Blo533Vphf6l3QkRR5tw9kHPvd+2um6H7lj+sfQ+cjAtP98cc9DI8OSgLkX6o
         w97s2TBi3FfA9hhKr4cadHtJ6kzq00EPM4PeguWVw2fKkDr2bSzxPEnuyCAZpvuasuMO
         SPyFiLWmuvO6bchYKQSV/Lpsxc3gemAmzlBqI3ylbKZDsG/OaINhXNGRcBelYiXq35OI
         Feo66O4yaoU3ryyLV9M3Xv47eQ0xsywteYHYYyjDLD37sJxgch/HtSCXezAeRztGiNLk
         LXH7M6jg1Ad+5YUtiXtRRls7Exp3QRMgmufox5IjoKdENIoZY4/N10jXkun+LDbxwq5j
         1sOg==
X-Gm-Message-State: APuU4Z9jbKgE0BG1deNrPmxRw0CfTYXOQacA0eBe4q1az3MMmT0F5guP
	r0bgxPlmop44GBX4s6yClfLDkFl2EwWkY+RnEma7pvCTgWYtQpNCTiYB
X-Gm-Gg: AYBFou20ieAzGFTWRv6sCtRkoISBiRsPn9I4etExew9b4fIiQRjfN1bYVYWNjL3r2OQ
	Vb+kSuV39M8+1GVnBM9Ym+H4QESlUUQ0oN36NONgCcWdbjeJBer9P3KAbwIpN90LP8cxzH92Pth
	eYqTtTRdGuL/Jaubv39ie/bMLKhFZL+2IlQiv9bX2Q3XVNX2dJIiLDkmZY8hlSplENEH0hz4hyH
	dnBbMs5dT46RL8dMb1D4pa8Onb4UBsuq/mtmq+HVRLSkarkStIfus6dXOGKAfVNOehsLPg8rTeB
	ie9IRmk8rICTvg767E0ceEQdkoxDlzmB65pjmLzVhSpfhMYpZDp4DgHAWHndIhkibivm/1ujp7F
	o1yp7Zw+sRfEwku+dkYfHRmJfYfe3b21UzQWZ/QvqOa4XgskudAHAXGNCZC6vjWWT4AdPpo7k2B
	bWv0GRdSvZDkCeNbuLnsAoBvaVLDHsFvp5tdios5ZQgQl/Qol1RuLJJus4n0MGQ5oICE89fc+vH
	xU7Jb/cwvTgwuOIGNzMrEyKtG96dLJgoiVoTS6qqDYcQP38Rnm31H/mGrIFtr8LxG8Gz3DHAQVY
	/Qv6lCXATxqeBr0drgsyeHG/TtS/vBOwf5DVf2tOgNRVnPVgNaKlsBjsRPMFglPTsIGQ+PZ11hg
	=
X-Received: by 2002:ac2:4f03:0:b0:5be:5199:1c11 with SMTP id 2adb3069b0e04-5c170b1ff3bmr2789388e87.60.1794752457363;
        Sun, 15 Nov 2026 06:20:57 -0800 (PST)
Received: from ahmad-HP-ZBook-17-G3 ([37.63.212.158])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1713339basm2424892e87.24.2026.11.15.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:20:55 -0800 (PST)
From: ahmad baghereslami <ahmad.b1995@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v3] Input: synaptics - support the touchpad LED on RMI function $30
Date: Sun, 15 Nov 2026 17:50:31 +0330
Message-ID: <20261115142031.349182-1-ahmad.b1995@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-214329@kernel.org>
References: <sashiko-outbox-214329@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 09:24:32 +0000, sashiko-bot@kernel.org wrote:
> led_trigger_set(led_cdev, NULL) calls led_set_brightness(led_cdev,
> LED_OFF), which invokes synaptics_rmi_led_set() and sets priv->rmi_led_on
> to false.  cancel_delayed_work_sync() then cancels the pending work before
> it can write to the touchpad, and the check on priv->rmi_led_on is false,
> so __synaptics_rmi_led_set(psmouse, false) is skipped and the hardware LED
> stays on.

Right. The same happens without a trigger when the brightness is set
to 0 just before an unbind: the work cannot take psmouse_mutex, so it
is cancelled before it reaches the touchpad.

v4 will turn the LED off in synaptics_rmi_led_unregister() whatever
rmi_led_on says, as synaptics_rmi_led_init() does. I will wait a few
days for other comments on v3 before sending it.

Thanks,
Ahmad
