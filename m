Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822988;
	b=ATb1ugSORa1/3MDXB/xxTfWXQ6xonOoWD2IP+KEc158YiaTmZVj6/ouV7arfSK2pHzBM
	 l/CjNDysTHKKToGVJ8L8feFc1ilidneuSLfUre2NFbILg/pV7FL2f6W4/o1hLh38QD35/
	 qYSXAfVmY4sZ3aU/FMb2Vr6zseeQR57gHyGlarhJS/OY2NOPvBieSNkYrES5Rda4KvZys
	 jLAHXikLTI8O0YLRYBShpOHsq+4mglyKnAKcOP1fanjyOjeisrVjH38ZNF3G48cDCOMFf
	 popacsa/jO97VeXVPxtT+iNPhc4TnQw92q6Y73MO54FH9H8qU8mnaDYhW5WYoNiX++Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=7PJM4PbhJHpLhbWOLitVKtM/DyGHKxiR5hSKnNJAjXU=;
	b=1UzzjyfCvC15c0O0s++Nz+0pPdxJGuECKiuwnWVpdNhqF0QAfyQOn31Gqkxm/edUTgxD
	 8w9H/2qz7/VrLQdAr3ISXw+aId8HNMzLTBgoGbS3NBft1cj9cVFfl2yIf9O1rQ4k2yZqn
	 cuI0lFHAagIO/JJTnx3LUsxwgxUSHAQcATjttOGvXCfvJFhedDyAs4vJwliEOI/CVNTxT
	 zEuEiRYxiNxu0Ok1w/hvSxuYSrWevhqSB+WOUHR5HI8qCgZICpz8vQA0XlrpLNKZE5NZ/
	 eMCWwNsUFDXC4aVkE4YbTCthMuUdWijiW+MeL99np3GNdl3igMf3cBnJophK67qJa8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a45YS1Xc;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0064607C0AB
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 20:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0064607C0AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a45YS1Xc
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36d6765756fso1026022eec.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822986; x=1794427786; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7PJM4PbhJHpLhbWOLitVKtM/DyGHKxiR5hSKnNJAjXU=;
        b=a45YS1XcZYiSvN/+A0jIa3rWTLWJ/IzdfxjgeD9DUHE8RI1ig8G9b042/i5LxmkJrc
         ePRtaEVDBQbEPe4UjVMYQYg45+/fX8F4w+AdddwlOc1vZWjJc2e+TlVcthwliZBLx04M
         HCCnJttpgVSL6bzW8ECkMho1UciQkxFw8ZCWp6RM3b115fv7iSkWJkEG2Zak+k3oo3Yx
         IY4h/I2pbdrlJJJHsCQpUOSKHoH0t4WnR+oTm51TT9Cd8xyGn1zSXYVhfvaifLVH4rf0
         vdeRYsqcn3MqktNQR2vEcQk5FvZFlyS69S/a0oiE3bSsIqhADGPf2HrAwArqIKMOk9mS
         WqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822986; x=1794427786;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7PJM4PbhJHpLhbWOLitVKtM/DyGHKxiR5hSKnNJAjXU=;
        b=cpwGwGNQIW1GfDbCzqPcqPWAvj9VL4XhFDbXZS+UmQi1KaoaYd71pXiteSJawthzpe
         4V1U2mnSNDG//xpl0iQ2Z04gkAdx6AUjPw9+XCDem3XAO/H1scOIVxYys20oaVck0FSG
         J8Ix89eBSGGpNZH44DX/AzEEypmjNWVexINJG3B1C4YdHdYLVslgqcYQ33yAlpOLC3+t
         DRzDqUHIOumyVy1QZcM4+QCjgX/WbwVxG+kGUwz5Eoy4mZDNi0zUpg1Rlzx0filZL67r
         csjWDJeJZCW2r3i4VKlIK9q8ZUxiQ17rxNx6kikA1TMV0VVsdTjM1uQdtsjQedkkqIM+
         76+w==
X-Gm-Message-State: APuU4Z/+EozRPgSAWJEvgEZVSj4EnPyF7Zl90Vcni6mpnW9wroWVfYeR
	jKRz7iWsgMXFmY2LFOlHKz7oC1m4zKl2hJTNcE2MOQC7isZPmrThkyMm
X-Gm-Gg: AYBFou1+l5uTzE4838vgPbDrq3qEgnv7HPqOBIE3o9UZb0bQLcxNYB4FSma5UXJhR8s
	YXuMZhBN7QizKv5OUE30pvFSDReNCXH3anp/GpjDHB6ps0noIr4JydRz0TwKIqJ91kbcn7WVEjB
	i4q9hjo+Z6ueKamjDGk3tpuBE2iGIPHcHVXKgV82llEviwH6qs5TpXuSE+2yxgDZi/zZauu14j2
	sie9zvJvEndYFic/hRW1bN+aPfJlcJvnhgICB0gg2t4hJsnXQpYG1lt/Sb9wnP93RA7T5xNpZ+b
	jhBgVdxhuP7estxCe/+sVHSD/vXoET6HPR32G2nbR8IfeaVlCkrYFflKNQsWCyZeRnNz0i8JjQK
	BjjnBSP/F6n1vZ6xLIRqMCg8Q4OcEzUaWvcXHW8ddyJ5wz1iE6Ft5TWkBYTwXXf0I5QPrXR2pC9
	rnCsljTjNpAdvbGit5p2T8JdoqZ0eC9o5M+KL6iBHBrnvv105D/D+7sO1wxD+lhWaNhks3bJpXk
	6Hz48kT0Ko1PJWfMTbISbQKP6/2ONEWTEZuLpqTsuUgC4wp6nvn6A1UyXECtRqAfkOoVFC6kv7M
	cqMmLUca2XHkCxZJHFeMXHQ1q1vte4PKNERD5Jht01Ri5kW5qDJedHjwc0sa1/mK1P+8dw==
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr29667079c88.0.1793822985762;
        Wed, 04 Nov 2026 12:09:45 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:920a:44a8:6f02:232e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4706bsm12494370c88.15.2026.11.04.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:09:44 -0800 (PST)
Date: Wed, 04 Nov 2026 12:09:43 -0800
Message-ID: <14c52f5f176b8fc6aadaa31c9f4715c0@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa_gen3 - clamp the reported finger count to the array
In-Reply-To: <20261103084135.426629-8-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com> <20261103084135.426629-8-zhugl3@xiaopeng.com>
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

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:41:35PM +0800, Guanglei Zhu wrote:
> The finger count is taken from the top nibble of a status byte the
> trackpad firmware fills in, and used to walk the touch array:
>
> 	num_fingers = (data->finger_btn >> 4) & 0x0f;
> 	for (i = 0; i < num_fingers; i++) {
> 		const struct cyapa_touch *touch = &data->touches[i];
>
> The nibble allows up to fifteen fingers, but the array holds the
> five touches the chip is documented to report, so a firmware that
> counts beyond that makes the driver report coordinates read from
> the stack past the register block.
>
> Clamp the finger count to the size of the array.
>
> Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/mouse/cyapa_gen3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index fc3fb954523b..fda807a4c141 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -1149,7 +1149,8 @@ static int cyapa_gen3_event_process(struct cyapa *cyapa,
>  	int num_fingers;
>  	int i;
>  
> -	num_fingers = (data->finger_btn >> 4) & 0x0f;
> +	num_fingers = min((data->finger_btn >> 4) & 0x0f,
> +			  ARRAY_SIZE(data->touches));
>  	for (i = 0; i < num_fingers; i++) {
>  		const struct cyapa_touch *touch = &data->touches[i];
>  		/* Note: touch->id range is 1 to 15; slots are 0 to 14. */

If the packet reports more than 5 fingers (for example, if an I2C read
glitches and returns 0xff bytes, which would otherwise pass the bit
checks for OP_STATUS_SRC, CYAPA_DEV_NORMAL, and OP_DATA_VALID), the
packet is corrupted and we should not clamp the count and report 5 bogus
touches to userspace.

Instead, please reject packets reporting more than GEN3_MAX_FINGERS
with -EINVAL during the header validation in cyapa_gen3_irq_handler()
and cyapa_gen3_try_poll_handler() (or in cyapa_gen3_event_process()),
so the driver treats it as an invalid state and reinitializes the
device. While at it, please also use GEN3_MAX_FINGERS to size
data->touches[] in struct cyapa_reg_data, and either fix
GEN3_FINGER_NUM() to mask with 0x0f and use it, or drop the unused
macro.

Thanks.

-- 
Dmitry
