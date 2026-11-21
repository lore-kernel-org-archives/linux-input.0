Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795240984;
	b=1KQwnO8INUwP8f6oflGwpsTNBN1EfIOsIC+JvBDV/colHUmy2+NCmZx1n6yE0LdYAvWR
	 fVLj1EqT8/lr4RqhyjCS8xn75rRBOQ3OzbiyzhQVpphSCILtXfGpNyUq36twoEWdHhn3Z
	 XXBaiyyuGI7nU5ukukKTCBKHkoYnvadgq2MNJR+sSs6JFOUs888hoxBryLVzNB2v/iese
	 QHZl0wZ6xJf4oQomPMTh+4OfSKmzJzOEZGsnLBsbSEqrKZvPWhFvOqnFUFP/rjPXET1LO
	 9amm6rohUhqzk4w6fMd8Cx1i/yekKGNWzQQfqWD2mA7bprbzphyST3gRhcakHG3hPjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795240984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iZeJgZydctjHQNPaqc1a3Pj1B2Wsau9GN69Um9z9RXU=;
	b=V0UNeKwDE0aNTrUmzkGxSwMCoq1s8xFN60z27+EENMFIB/bHlBxYKI41Wc4J6SqEIqSH
	 EdrhnPcCiaARNApEIkIquhPQUnRAZwekz1ZzRZy6POhj8aTVcXzcf4mqOWafmya+EIqLL
	 5ejx+UKl4MnEnp0tED5hA1aP6L7C9KbLOfuUTlzsbZ4KW9vCvS5gftrQVkZ3/tRJCaRux
	 ZjSbdJz0Ru6sn9RlHU6z06FpbgdaDCXE9RGQ6hNEM3lVV0qcAyQtPYUp1xZhEJ3Zz0fvo
	 PNJvpj9/LuVxBeB0bDxgqo7HOLcOvQDlZ/dMG9rsz49BgwshpsYwswP31G2M7yt8tzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tU3Xrpc2;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496F606A68B
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 06:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1496F606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tU3Xrpc2
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38692f62b22so1767141eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 22:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795240983; x=1795845783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZeJgZydctjHQNPaqc1a3Pj1B2Wsau9GN69Um9z9RXU=;
        b=tU3Xrpc2LADNz5f7aWTNLpRvwQ/S9G5uLAp3npomNvo+t7Y4BfLZ/kEigevsB7WkYC
         gztEAJj8bvn/ZBg0SFLxAGC822obUtnaxOvWDwI5lfEUdn8+8j+Kzqywq6zQ8Uv1xR1z
         9vcKgvLUk1pY2fyWmHUY1+h/SOwaKUFFOYOQ4JLf/jKGNwPzmNXE2s9gijNwmN8ytvF0
         3omIwN9O/sZVP2gS4gQrwSjPXSJcr3oeORyNZP7hJeYGym8GNOVxLHeJM8g8RPw0oiLf
         eLM3TPSAoyoD8u5BDWZGmBnQp/WW9/hHtJDUAWOh9ntSpE9TUs8lY2c2nDF5EIsGmcGH
         4p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795240983; x=1795845783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZeJgZydctjHQNPaqc1a3Pj1B2Wsau9GN69Um9z9RXU=;
        b=bHGE0g0mVjSK4cIDqFFSp0/n2+N8M7v0NWC6QctpG5K4RwSo3zxVaHIRsyP1MSX84C
         E/SUG5LDN0RSumBtZ1hrg9FmIrOcLTiOT40DSUcp+IVsPggQJVvuBQqgvnmObiba38mo
         vITe6UhEvp7wkAmF5ngHbaSnpVKN4NHjMg+SNYzVeA7gxjkt4PEAbEDGcDPug6SP0mhc
         Uk67VlrPQg4kRtiEBzHg1/7doyAR3eS3GKQIQwPzE8eZfMBzbgW/gXtURCiOPVpEffPQ
         034vjI+MLuDqgQsyjmiXImWOXeEgWsEAmRYcOJPR+PcGVmgj6R82H/UyWJCuQPTZIVOp
         wTXg==
X-Gm-Message-State: APuU4Z9uhF4DBsPU1D2Ncy5leqpqLCCfxfcxsVvh8hKVRVl0HquujhVf
	UNqO/P1kWdGsgvTyn59fLD2wWbeAdtL/Nk2LZvO/WhyPYLFr5yZd8wmV
X-Gm-Gg: AZFdTZfluQgTqpGfg7gkOQFyDCnAzuxP1jnDhfWabPA5K9i8QbZTp1OWY4297jDB/WP
	ovG/aoDuJr6S9DRGC1BpGGagCedieRdsVjSbf7lkkaV2WEItYHI8SaD2glTC5+V40BAfaqX4YjK
	ikzFl5FYnIRA9xTmUbqwaL6+3qi+KKlHoYYIG+HnMrqeL6A3Lpaxnjh5GwflVzLOo+wX0TXhQW8
	6NdDYZkuzMeUS2NtqGodduKjMVfq6A1tLUTk47MgFQVGfGIaaoL4zIbx1CjXHrunubO23s3SFIw
	6c5IJZYSO8ZFSONNWgiYNIAP99RweiFOnCnJ/KKUDyNXxbjg/C06H4LnZRC/szOEyFvyhUdDfug
	QpXvBYATh7JeiikYRfA61I/+5H04DOEYvjyWleJNWLxiKINNFkG8qGUW+S7sFjTh0qQntpO94Rx
	GZdjUs14+yYUwm0o7enOOrTma09Vs/tfYlqPXVU9idTDAYWuZfl1FyqvtYQMSi6Uj/ATUSFAPjI
	Mo7SW/QhQbfUiHiuHVWEtopWe8VvfyOzqs3aJeEtQaueS3a46Ay6ioiGsORzMHM0RHhO7P/56Vw
	WmWkCOvI5hXalEsLP62chlttPCXfKCwYYB2jJPxCVDNGUWdBtZ9VNfxfWrQM+Pxhz8c=
X-Received: by 2002:a05:7300:8188:b0:382:61d0:f375 with SMTP id 5a478bee46e88-3856e63b050mr7522783eec.7.1795240982165;
        Fri, 20 Nov 2026 22:03:02 -0800 (PST)
Received: from eggarch ([2409:40c4:eb:2a8a:ac89:7bd3:9d62:35df])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm23226928eec.3.2026.11.20.22.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 22:03:01 -0800 (PST)
Date: Sat, 21 Nov 2026 11:32:54 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: synaptics - make InterTouch quirks table driven
Message-ID: <awEyv-5G0zfISfcJ@eggarch>
References: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
 <20261107020751.3959748-1-lovekeshsolanki00@gmail.com>
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
In-Reply-To: <20261107020751.3959748-1-lovekeshsolanki00@gmail.com>

Hey Dmitry,

Just following up on this patch, it moves the Intertouch quirk into a
dedicated table, to make it easier to exempt devices in the future.

Please let me know if there are any concerns or changes are needed.

Thanks,
Lovekesh
