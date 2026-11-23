Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407423;
	b=YZAaOn215j67bhh1Crsj0jtpmXkLWZx4k4tuIZkWujqChzextWJoNiYvJhX/xYDvk6os
	 WoE7dLliAtXjsmQJ1doiYv4co62FGSPBKoiEohppJ+hTnfGdokSYHu7nBNkT2xbo4djbU
	 anMu8ysEvg+lFgWk4glTVSxOb0PAVWVUvbwj+nG6riXdhW9FihXHGIT7FmZbVd464fl4d
	 72+MHvzh9pPqe6bAUDtb8UwTKnwiashv4RskCfb2yAxp2gSVUvKq8QvZqjX5H032IunsL
	 GLdvEzDxj0k8vE/x9kbzFU08pFFbqGjolLdQ4Z8my1GgS4kcWpmnnRWhwVmyGClpUdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=YzRt0aFNigfIjuZzIG9Q1L3c5RdrENe2mSuQa2UuzMM=;
	b=t+M8hRCtl6fkdhzc0+0Jejg4bbmw3qyuzDAz9mezO5RJ06pprRvxcHem5iLjQ88Qc2Rv
	 cRG8G6mKAoG0IGvhJnSu31HAYK5LPARdXtLD/4tPPlr2sI7yjaBZvwfa6XACdYPxqXACO
	 yyobb26WyMa9uwi7cUcYE0iE9BUuctaevWEXi5MtcZH5TqxLVwIlng1qfRC14cEiyyCu8
	 9q6bLzg+SGUF5CHmpFVFeLyVRCZ/RXdfnRf7yZ8ODyDR6qQ8MZisP8eYKfhnqxRuoU7EE
	 lTOdqIFeLxqKX/kQqDNUAkUo8V/fW9kBdNgnD+pIEIEj5qU9fWO+SkzQ1ZOIBMeO64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pC2/5JIL";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC70606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC70606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC2/5JIL
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-382f4710a17so4910874eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407422; x=1796012222; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzRt0aFNigfIjuZzIG9Q1L3c5RdrENe2mSuQa2UuzMM=;
        b=pC2/5JILDWebNKIS7WN40P1R2+FeLvLjKLTsXNuBIfgFm0owzGiwJKpdD14U39sQOQ
         XuTPTSr0Ph0zRijincIqGnZi6Bjy6kn4hKD1fvqd5r0kS4vQcJbYyYbsnSrs5dvoDgGt
         iebo8pA1t8/TBtJtQivVLj/3OmYHOeLf2toFeUn2GC61WeAwnzt8wsES6gp+N0Npmyso
         7Jy03PsCWIYIdLO+XR8SNMB4KBos0yk+UCLcb/11dyssMoziSJE4uGm2ZwHu+PZ/F7a8
         2hHIvz92sdpvuvvFCBjBaxslbsZqE50x20YWSbIpGnYUv5dLq9xyOukpLFDW7Zu1q7l2
         aTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407422; x=1796012222;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YzRt0aFNigfIjuZzIG9Q1L3c5RdrENe2mSuQa2UuzMM=;
        b=YlY/U6oi97YsCRxJU+IKzSki1ITTVr/UjJddjTi2RYnzJ6tMqd5MT0ACdTAdFLJ8AB
         YnJEiVURFmfrWUgL2hoo/S4vnenDpxMuyUW5cTRCakehV3Zk/Lan7RqKosQaFBvhfTtp
         hNHnCt3fs8rUXWRGThyOH/MGB9DHsl8OBzLQNcBd7OvS4CGuctM2HbaOqpmJFHJNdJ8I
         9QPaJucQi8ZOkcy6DdZMu1kocO0pvwIFGQ9kz4ZBb25MC8xhyb46tzJUgxgA/kjdiFe9
         WYzVKXhD66ouc65kA2CCcfI3D2bGSQChqh1wnHenKXL4I+X2OxOjToal8tUwzz1EuXOF
         yP0w==
X-Gm-Message-State: APuU4Z/KJUBvcHyUJVyk31/MEKUCfSx7wDbbWzHxEcT/QWvimpG3BYeK
	QOQF8vmyV2xL4lacPEQPcGFjX6UeqWLNU2A6M6jorl8wjGdWK2N87+yulo3BtA==
X-Gm-Gg: AZFdTZdGMsmvFx1pvGP6VThiYT20pePm5bQOmBP3drG+/VnSLRZy2PQ6VSCZHZN6diK
	tAHDa4c6ees/D31MuSinoEmpsS4GlFoR5LY0QemIvg8/NASlotY4cOL1WkzR0UIgenqy6G2pnBv
	HrbHu7/G/FflIvDu4pYX1cioxDQPDWkGSXHYaSOxNdFPfGiGh1YQN3bLadtIyqKn/TyrTVYZ2NS
	IAD4I/1RvR2nkEZeVs0zzrc5oL36ejfN7KMmlvMUJ7AxMBgzoXemCUeax1ZYCBkDMsuc+UrO8YK
	sNcNVSnzh9Y/sGK9yIHvIW+mO/HKcCGQKGl/aKImPx8tmloQRsDiDiRQteaMDaLGAoPtUgabIHl
	e2Fv8FoTIwm4SH3CGBslJG4kLGnEPXIfP+UP60SiayeUeewS45TC/PDw8+V/oAg+BhVmp8zzHr+
	H1Fxwklp4h4cJmZXVlxuH9YB3M6aI+2/wThh1a551Ji/FIAbZfrc9VSROb54wVWzz0U+xOHjZcx
	uI7/ubCRCGrR2uAdx1NJOQLQT572/jeujfGA0idKYOqxkXrGBYJmSb+USp8FL8Lx5ywqWK70man
	EopUGw7MCXhiK2+30XVWHbEzmIS2LPGw6e5cAa9rrE3m9S1fPOp7x66KRfWo4vqEe90riQ==
X-Received: by 2002:a05:7301:1703:b0:386:319b:fb0f with SMTP id 5a478bee46e88-386319bfc98mr9614430eec.38.1795407422015;
        Sun, 22 Nov 2026 20:17:02 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm36065292eec.10.2026.11.22.20.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:17:01 -0800 (PST)
Date: Sun, 22 Nov 2026 20:17:00 -0800
Message-ID: <847ed9034c9869373a150d43d352b2b9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Auer <mick@yoxcu.de>
Cc: linux-input@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pm8941-pwrkey - report wakeup events
In-Reply-To: <20261121204112.847960-1-mick@yoxcu.de>
References: <20261121204112.847960-1-mick@yoxcu.de>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Michael,

On Sat, Nov 21, 2026 at 09:41:12PM +0100, Michael Auer wrote:
> The power key (and resin, with "wakeup-source") is a wakeup source, but
> the driver never reports a wakeup event. Its wakeup_count in
> /sys/class/wakeup stays 0 even after it woke the system, so user space
> cannot tell a key press from other wakeups. PowerDevil, for example,
> uses the wakeup counts to decide whether to turn the display on after
> resume.
>
> Report a wakeup event from the interrupt handler, as other power key
> drivers do.
>
> Signed-off-by: Michael Auer <mick@yoxcu.de>
...
> @@ -161,6 +161,9 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
>  		}
>  	}
>  
> +	/* Let user space see that the key woke the system */
> +	pm_wakeup_event(pwrkey->dev, 0);
> +
>  	err = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_RT_STS, &sts);
>  	if (err)
>  		return IRQ_HANDLED;

Could you please move pm_wakeup_event() below regmap_read() (after the
error check, or right before reporting the key event) so that we do not
report a wakeup event when reading the status register fails?

Thanks.

-- 
Dmitry
