Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476299;
	b=NS1eGqH4KxIhQksVRHHrVJrLnD5en5ZDcQqyMemDuWPPs+Rl8Q0H+XzBJcXMbInYo8Ai
	 iLP/pt3tfyU+Pn/tXBaoy/L6natAbXVcyCej4eBjs4WUH6Yrdk3z/SwP9JrISw06gX4Cs
	 DnxcsIgczTrOpTI9yrG9ugyKY4Rw5tjoykz6ub+vNOuKeVXKhIElIC5/Mf99MGqGjz/kF
	 7vSui9GptB8qsFU++/bV1fIyA97xC85Is2PAqSot1/1d3vgkD/tLRh7Ts3Rl/UimxrbD6
	 h15dCSUdH1w8Wpzn9brR9uZr/ZndJVPibWdpjho7ow5jQ3kaY39nzcbusAEvgDlOKsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=MNWlDqY5Q61g7lNZmof1nMmtIa+WfJ4+kLyYstNyQbg=;
	b=j4La1wjYvf3Luz+DGabeu5csEEkVR7jxmASJKD1G5Sz4L7UC5Kl4mGBD1xw89vNwS+5i
	 f7E+lPrLb/stY9uBWnP05Zk/OHL4YUpAMflMWcpIxf40gfxYRwVgIpi85pfE+qYCWl2ta
	 Stsimzh5Gv+9nWQy/3I2b5qGVTm6eg4H+7zdzlwcoviLFE3ZO5of8eL6ZfpSWZQqbVCmV
	 h05/jaSUmdgfqBmnOdtQtteC7IEQb3NRDHGk19lykmA4D3foC6o8KLiEfGtEkIf/sUMTC
	 /vOPWB1E1C9OoFkFhUSfMgmrgKtd1pBW5jdF4+MMVi2PbCfChFR2G1YvFt+ALaA/N5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FCFoUZ1I;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE8606A322
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 23:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83AE8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FCFoUZ1I
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3ada81853so4469447c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476299; x=1796081099; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNWlDqY5Q61g7lNZmof1nMmtIa+WfJ4+kLyYstNyQbg=;
        b=FCFoUZ1ILO8vaha3i2gaLOGnQ0cPCpIpOsy+OhOPaN59AqTbktpis5YAZtoigI1ICd
         9210SWT0/i8f2fzZLoblQaxyuElg+u2GD6VBXH3ObBN+HPquGvhHgkfkFSIf/fEI38DX
         0CUySfBT89fOVzzll2Ta2UqDfy+9mXOPfSehdlDKeCE70OhhqkUHNnyvz6liU9fqtvoy
         Vxt/HExOP3KEr2oXGjKIHnbukt1nogWF/qEAubvlG0oBSfeUPs3TaZ//nASKcAGf93dL
         JbcgStiqrIKvjrFfOVeyw8VOlLM909KmM9uNiFS/QQPCFcACW/2pcgtmHqIATQiU6JWC
         tXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476299; x=1796081099;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MNWlDqY5Q61g7lNZmof1nMmtIa+WfJ4+kLyYstNyQbg=;
        b=PAVg35+Y3pn2IbEvb5SeHgWD3+Aq3YKnVotpEbrYTZBXEVgfoHxiS5UurfNE/fV0vE
         R8RzeY5Fz5kTzCWaJl713J6NosElVRUmwwK1A3yk9wyvyMEHpI5GmT/PTGgVMfJCBKr7
         IcTDm4T9WaeuZt/QQA0HO9WNbcLLX9aoYXXLv5SiXHVLCSWx5bbjOfnjKHzP767lzJXL
         uVehKgDkM/gEZJONQAN8knplviV/LRGIAAXlciK8fkLD4/CGUKlYonwxa/1rf/YPjD16
         9ok/JHrCrVmfcLSO5MhcQPIKtWJxWFOydjszJIhudvjY7dCppD03MFkeaKJXwA/cF5DT
         bCgA==
X-Gm-Message-State: APuU4Z9B9zItjhWyQLwZx25YkDJX48v9SlqIfcdgXKJpLm4QeIghCUoK
	lrJFWNC9+AzjSZTdxHO42N31IDrqPIIG99wGDbXiqwgg88m15sTQzkNB
X-Gm-Gg: AZFdTZfT0jh4CrjM4yIrg/fhQUuRu3VVo1mMB4AbGFhwlSbnWd+tZFEjupYxBysmrUE
	QYW4//WBjOAwIE1PcgST0IzsgRb64RkPIbR2NVTQgwP9jXgkLzz+ysOZrBhEDaltjVNn4fE7WOj
	g5jwdhGdWkWJGTKTuENXKgdv5MvJbM1Me1FAdwMhHwWLvD/ubvy/hfRjEh4zIsTDDnxQCZTFrVQ
	brQsIZGtyg00VK52bIMLHDwYigsVe7McA/uO6Zo1Jl6916VqDtpm/DB0LqIOmh/caxXOTUJffHm
	0TFLUr2G6PAoQLYrqJZ+IAvV7UBhuPNgQoie5Jqjwaoi5DxOQxEmeV5AFr9YewsBylQi97OdN9y
	5nqfRzcqgxC6PGjMtu44gUoxo93/EIVTbPWf7BjH+Ad+yir4Bus6U57VvYwvuxI7R1Vr+zOb7tO
	8zPwzzzRNOnNWTGQf/JjhJ1MRnA/2gF9BsFIhBthHqKGmFXlh6Yv4BVaJpmPJW5RWqAs8T8Asvt
	5MarE337rdfzz/ytiyDpeDiw1jtyra4dHnrQLMe/A0AUPN9cMJp1ec0aDVcWLmeyGsiseBeCMAa
	mIIMNTpwM0iD8DcPlVV5egYrd0O1gqt6wn2YQlG+vO3nw0hYuWEd3vQGu1/LJOjiir/8HOrcr6G
	Ahg9v+U5O9OwN1+E=
X-Received: by 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b5568b9e59mr16444195c88.24.1795476298544;
        Mon, 23 Nov 2026 15:24:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm34835125c88.13.2026.11.23.15.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:24:57 -0800 (PST)
Date: Mon, 23 Nov 2026 15:24:56 -0800
Message-ID: <a545ef5377ee473829c3780e94d107e5@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Input: goodix - sync the irq controller while starting firmware
In-Reply-To: <CAORyz2LNRfnvbCLe+49A5kAF4NSi0zuYdpd95+7=Hx=KQh0B1g@mail.gmail.com>
References: <20261020122712.526797-1-l.scorcia@gmail.com> <avZiZoGO4jXjIP7D@google.com> <CAORyz2LNRfnvbCLe+49A5kAF4NSi0zuYdpd95+7=Hx=KQh0B1g@mail.gmail.com>
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

Hi Luca,

On Mon, Nov 16, 2026 at 07:53:58PM +0100, Luca Leonardo Scorcia wrote:
> > There is call to goodix_int_sync() right after call to
> > goodix_start_firmware(). Is it still needed if we call it here? I think
> > the vendor drivers does not do it.
>
> Hi,
> unfortunately yes, it's needed right there on the Lenovo Tab E7.
> Without it, the REG_SW_WDT right after it fails with the error "Error
> reading 1 bytes from 0x8041: -6".
> The vendor sources for this device [1] show the call to
> goodix_int_sync exactly between the two interactions with the WDT
> register.
>
> Actually, in the same sources I see no trace of a second
> goodix_int_sync after firmware has loaded, so the existing call could
> be moved a little earlier instead of introducing a duplicated new one.
> I tested moving the existing call on my device and it works just as
> fine (basically, my patch + commenting out the existing call at the
> end of goodix_firmware_upload.
>
> Which vendor sources are you using for your reference?

Sorry for not being clear. I was looking at the same vendor driver you
linked to, and I was asking whether the second goodix_int_sync() at the
end of goodix_firmware_upload() was still needed once we call it inside
goodix_start_firmware(), since the vendor driver only does it once.

Since moving the call works on your device, please send a v2 that calls
goodix_int_sync() inside goodix_start_firmware() and removes the second
goodix_int_sync() call at the end of goodix_firmware_upload(). Also,
please change goodix_start_firmware() to take struct goodix_ts_data *ts
directly and use a local "struct i2c_client *client = ts->client;" temp
instead of going through i2c_get_clientdata().

Thanks.

-- 
Dmitry
