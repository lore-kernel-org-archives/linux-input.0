Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585933;
	b=E+paIsZdYlGpWqrH193P1mjFCTJsGZnzrcFuWLI+kcf43+CaSe7EWP6cXJddhZQbU87x
	 8rIDC5ZJFFHazRH3yTfTqYZLs6LloDzQf1P4VZAIo7Awx6DjQIvf+fX12hidhMMKZNudg
	 JxmayT7qrw1O9ti/ZmDTSr1OaO8BzB5iffEBHt4CmT3V+NSYToNj5W8Wqtz38YfqBVQL+
	 P/+giGykEjleDa5xStXJiJA1qUkh+2TKlwe32s2AGvjgPMRWmJViK8MnL2cMW1S/8uAVm
	 Ry1iGuBBeYwYq7A/lUAEv3emdsb3BDDZCPOL088rlj1vj0YOh4BLQpmIa3TIra0sgDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=eUCp7y4ZtvBDvMyeJy1tGSy1cHHuB1Vlu3Y40S35fBA=;
	b=2np2nprg3wG2M3f6pWcUUwczB3mytCDbHFGXYKpQIOnvKKFXd9ZdqEFHXsaHlJtw4PbL
	 CPIV+P2Gjbaom80ZHRKZfaaLMo3dUASmExd9HshH1rMTOvMQMseh2ZSouiFIN8bA3oh6w
	 2Cd0MgU82ejtGL/NYe4/BvmpjGBGmDPmzkUqQg7BhzZxJbJp2270mKnBINT8wbgBpV7GO
	 pC8a5HRH62ha1kAsQEVWBjJTrSaKwT8YBvunwtzZbo2YLxUHD288uBudUfILjxstIVdGL
	 K3Ohstz/b0BSNP/awoWc3gL1qBgsvL+C223GIq7RnV/5Cg37bctrVAtOr7o1FMyrxDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zf7OncZR;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0E606A889
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D0E606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zf7OncZR
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so1744679eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585933; x=1795190733; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUCp7y4ZtvBDvMyeJy1tGSy1cHHuB1Vlu3Y40S35fBA=;
        b=Zf7OncZRcIc8BLKThzw2qNc3gniEua31SWuTjcSV5mo7oSxUlOQvSGmIzu5ddm3Kek
         W9kWzAmIKry/bwwM5klYSIkSrghYyyAq2l1T3J7lKybH8yJ84m0rqNx9Xixx7PB8HHDS
         GcJRixMDtmzvZMxpX4c2NS1LDmDyKHgqogpNjUMrGuVHfqWNzLyH26F1JTcpVXYsRFo+
         Em+tIIFvtL16Oc3Z99TbvVfqGhqG9A9Za+dXQ4NKz/ynx1J0sfX1Gghy6YUN3regi6Xe
         yJ08w2FNAEbKUoT1BWKsr3OI7NF6NpE3GwLtS9y1SAG2K71t3rHt6V8pnHuBLKagCbge
         ZJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585933; x=1795190733;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eUCp7y4ZtvBDvMyeJy1tGSy1cHHuB1Vlu3Y40S35fBA=;
        b=rjSG0SW/z6ivOwhD6+sHrr2Greerv87X6kuOrxrT7MYHe+O64ELa9GlaJFxn9zejNO
         jKBlmV6QOgCXNMZ9xu1FhsqUXjFd4zMycL4NKiVblb+cb69foG/WBP4d2v5I5e53chTi
         Dqg0ft5usau62yxcmt2B6KOdcqNK8o0qWi4hz+/g+DOXYNk3GSs4hl8lEpoPIg2Ug2pQ
         TA6Aa8Kl0YxPfGv3DtH7kd8FhU2q1T6eXCD76UrXDDnRDn79+1DYh1d1ZuddzAJvrUSr
         sC4eAfLieE5gAD4A0cH2BnRTl6izA/lX6RMcLNOkBqisFB6yRjE/0o+ztnMArRGn/1bD
         Powg==
X-Forwarded-Encrypted: i=1; AL+hErG2bUX7S89q8/XH3N8zEmiDL+4PmqGdeOWiuNCLBYQfKGmn/RHt1pDG2WWvKSnJfKWRcBsqr4IqQn9xFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z99pZOXtkX3j6zcAzeuFHp5OdrSC3RjV3tzW+dNb9ItIj5E5NhI
	uv93skgXIiVf2pq+VYWRnnmTiTnVBXsK01uj3fWm/J/eARzleTzexm4p
X-Gm-Gg: AYBFou0L7Zi0TzKWXsxcnMxT/Yh7Nzuzj5tvBlk3ppdw/6qxTt7bZjkttAarb1wJeP0
	fQxIutBx5W/kAz1pADz6sXZDYhHdjygblJxnXaIrPaWcpHHy36B8SzlLHJ3rle2g4U5VWPefVWZ
	Xbb7WIBU+kfcTRSagFPYjpy/3tBziH3GCpJTyLsqs7dgucOKXZ3I3qVtBC4cYhxrKlRi8GasNAx
	BZMN8nM5bf8CSdOiXR9OReYLAnSrvgel5KPTLUYm60uV6I93iyAuFPlwfmpisnqFQPYD6txTYGb
	1X86XN5LmHa66EvrmG13UYYYhB9dDBIORmdIp5tmXDDBRt0uwtAbf1rZ85wOEsQpTiwWjEmhNtZ
	zDcys1/95O71CL1WqxmOPKu6vsluJ9G0HMITDP/p0KYjEl/ouTcmyJ/7X/3HsZfhsThIHI20wji
	JbdF1GDjy5z3vgmaYkDWWqNPtowuXhExFhhiKOp7xkCj/BFm6vAnSuXmuyueS09Vxij/1olqk0/
	QtCbfwB4lYY7rcC2d6TBC5xJUYlYB7L9AYwLRTqi2ATpWeRwdwcxxkudiVdqGAQcjXYElXSDUf0
	iCpnswpgJlJRvvqS9iu2Z+jK/mNQ1+iOrZbTMDH2AufLmboMPe5cnD+8S0ZrBAfqiVwB4A==
X-Received: by 2002:a05:693c:8806:10b0:370:121a:b2f with SMTP id 5a478bee46e88-37965f9dce1mr2544887eec.11.1794585932296;
        Fri, 13 Nov 2026 08:05:32 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm8743311eec.5.2026.11.13.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:05:30 -0800 (PST)
Date: Fri, 13 Nov 2026 08:05:30 -0800
Message-ID: <b51b774b36066fb9aea14fdcf192c3b1@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Green <n.grn@outlook.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [REPORT] synaptics_intertouch on ThinkPad T14 Gen 2 (LEN2072)
In-Reply-To: <CY8PR02MB9252B5E325192960631C286CE7AB2@CY8PR02MB9252.namprd02.prod.outlook.com>
References: <CY8PR02MB9252B5E325192960631C286CE7AB2@CY8PR02MB9252.namprd02.prod.outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Nick,

On Sat, Aug 29, 2026 at 08:44:23PM +0000, Nick Green wrote:
> Following up on my previous report regarding synaptics_intertouch on the ThinkPad T14 Gen 2 (PNP: LEN2072).
>
> After further daily-use testing, please DO NOT add LEN2072 to the smbus_pnp_ids whitelist.
>
> Key findings:
> 1. Under psmouse.synaptics_intertouch=1 (RMI4/SMBus), the touchpad exhibits intermittent tap-to-click failures during natural use.
> 2. Low-level event debugging via 'libinput measure touchpad-pressure' confirmed that missed taps produce zero evdev events at the kernel level—momentary tap interrupts are being dropped by the SMBus controller before reaching userspace, while continuous swiping and pointer motion transmit normally.

Dmitry Mikushin (CCed) recently tracked down a performance issue with
Synaptics TM3471 (LEN2072) over SMBus where rmi_f12 was reading the
entire 79-byte F12 data packet on every attention interrupt (requiring
three SMBus block reads and taking ~17.4 ms per frame, which capped the
report rate at ~43 Hz), even though only the first 32 bytes (Data1) are
used.

Could you please test his patch series (now in the input next branch)
that limits the F12 read to Data1 and enables SMBus for LEN2072, and
let us know if it resolves the missed taps on your T14 Gen 2:

https://lore.kernel.org/linux-input/20261026142648.2567233-1-dmitry@kernelgen.org/

Thanks.

-- 
Dmitry
