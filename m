Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731716;
	b=qhr3YCHZhBOC9TyXPg1iPfbxIjkpIkbCuM8wO4AXornT3FfI+GaQJPHqQG55yGfb9FLh
	 L8Bh45T019f+emkYr41WkglK/IuhHuC+0sgjfwdrUk1HY7qvER+oRx/18RcgDFiepruLM
	 qCsofCmLpO6zMaC+ZS3sHlu/Rz44Uh7kpdby7Bw/M3/vD+8adPMOxIjBQhAX3t01fXjXW
	 3WDbSHWbKkVTjVE0JjPawEZHDvfgqHvxCoyx0TqOkmTuV+WBEwziQVvLUbsdnS4CQ4mFy
	 4Z6ecQPEXBBTOctjbXU6IHhySwm0BbBGfMpTdp4gWV779QaVkNX4bLJt9kgo7LQqH2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rVx04nQQp43F0BLGoRm22B4ZLQ+gRcWyea+v+LTsIOo=;
	b=r3Se0GajCGM254eaHeiE5C5JHaaOx8i9O6K5C3RJff7puyGJSBnhQbFPmBBbztigj6rF
	 197oUyok9KShiWjFR5AICADcLfY2iisyF5QVKAyEUKjauaxkVreJbsMDwVgYm0cA6rBlG
	 7Q5xUgaU+N1UMTDrBOJsebHVXOqh/5iAbmhV20FP1uvT9HKY7bIhvpSj03ywWZdb5vV+p
	 SxQOAESJ0Y1jagJ2Is0dqo4Zu+SeI80DHh8qDXYfaP/D09qjXctnn/pD+jRGRNE1Uuw1d
	 ycBcY9a8nNGosemNFds7wWYfisN+SaJAkdigbdMFenr457G3fI7HTUY1Eb7IcV1xHdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gksX2kJz;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F30606A324
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 18:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29F30606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gksX2kJz
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so8386017eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 10:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731715; x=1794336515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVx04nQQp43F0BLGoRm22B4ZLQ+gRcWyea+v+LTsIOo=;
        b=gksX2kJzt4WpMxG7ycq/QnVtJb4eHLoRkE/cvLBxESFUHhkGtmfNp3JT+EjMy6Loa4
         v96mVRbnI+OiaK5t2tkp4pl+s3WpO0lPIWO1yIhz2rymTAUPexzZbpo6v8FcJznlpELt
         4W4CnMeVpFekpD66zu6dz7hOO7/H9aF0x+o0S+gVKm/HKJgbk3UR/i+xonSxU//JDNMU
         0EXuUyJ6NspUSOhrrnoz2ngaPt2DVfq11bGEpf61Qid5KBAfkaC1uUBT9FdfCvUX5aOA
         j3VkcNYrcUPEelV8CzisLkQtQzBQOfRQTo0DhHs7yxn9Da5STy7u6Q17WxwqjTldH3xH
         VeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731715; x=1794336515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVx04nQQp43F0BLGoRm22B4ZLQ+gRcWyea+v+LTsIOo=;
        b=ILkxW5kf4svMRzg19JO/A69ybrOFWKV4qpk0muA/czqs2diyJGuj52rr9IDK2OtxHT
         VraNG658A4j7MgUz6l7sbhXisAXILCdAC9S0W4R7l+fT1USQe1KMu1/KRhh4wc5Yxc/H
         8v82dMCNAUUHER8/Kth9tVmDmG1PCRt0/yoAAMlTzpcpmt5exb3AHb+AozBHzceMgD4E
         vQ6jpSrPavtkiPe0xzqQbQwbTGmk5dEQNDcTk7b5m0NuWmIkqKsenTtprWGOFoCmkRyM
         br2Nin4ug7Y1+zwmtdri5oNkEXIVR/KEOUOet6MOrbrGEyDqrhfn1Sk51tXnnrdWLEDY
         iyNg==
X-Gm-Message-State: APuU4Z/5pIfDmAe0z5V1STyOC4d5SUVzewjqBKYcvXc5cedXaQ3saOsV
	lCCMEOIVhDGqNdDud4V7yVsHtc692OEvhZAeBtJq3oAke0db2C1Ad0CDEqVHPA==
X-Gm-Gg: AYBFou3rwPicHI7sXICbqlPLovEjBZTnW4KU7P86uuFL3DdJ5fO/pfM+Q0IuNukRLP3
	GlotwOdcld6Sq/45zQdAE5k9nfgu2XWdkCy/+Xk9442hUNeYOBtfqbXLU+BFJBlCOotHu7fX2C7
	XPOSGUYJeNozu29xOb7BBLZ2CMosKfXDOZ1JKxS7Op/9mWOy8DQlnUTolW73iGQIa3XGxwbX3N6
	PtxXXlHFwGQvRquSX5zOBsQmAYKbxyJZpFEgeAj5CKXSi8Ch3PClbFDGRYk30n2nSdiX9P/+gzb
	K9Gy0h6FrDyYJwEpIziwxh6A1Oo3z1GBioB9oOlHrxwrzOJ76dFhRdHTgxE2F9zIe+tsX0o8jDt
	qoLpQco1YHUCvHhCifuzP1wjVZ9x3ZoutBTObwJwUppN1KbG7xBFIQ7F9k0ovunmPYvd96r0DlE
	bCh+sP94vNwKgYb6Hol5zSK46wnRSuOJvYPaW8WPe/SLKygNW4IbbcmYRFik3IlNI5OPjaXXya7
	gfvXNP2MCYuMA9SIv73AWyE+PtsSngX+UO5OUAvCnfdsITr1c9GgFmMSyHdf/6cBHtn0ReHboIu
	RdsV9eJbCpBNZlQgI5df2poNAGwePSiqPaBdywLbQFWut8XSWNyTUW14q9xSsvYfr2xK
X-Received: by 2002:a05:7301:db8a:b0:36a:279:c93f with SMTP id 5a478bee46e88-36a423fda77mr20499322eec.33.1793731715116;
        Tue, 03 Nov 2026 10:48:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b3b7esm11574eec.28.2026.11.03.10.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:48:34 -0800 (PST)
Date: Tue, 3 Nov 2026 10:48:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: clamp SMBus block reads to the caller's buffer
Message-ID: <auosSLHRu2mcuO6e@google.com>
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
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
In-Reply-To: <20261103131127.1585884-1-lui2012qwq@gmail.com>

Hi Chengyu,

On Tue, Nov 03, 2026 at 09:11:25PM +0800, Chengyu Liu wrote:
> i2c_smbus_read_block_data() has no length parameter: it copies the
> device-reported byte count (clamped to I2C_SMBUS_BLOCK_MAX by the
> core) into the caller's buffer, so callers must pass a full-size
> buffer.  An audit of all call sites found two input drivers passing
> smaller stack buffers:
> 
>  - rmi4: rmi_read_pdt_entry() reads PDT entries into a 6-byte stack
>    buffer during PDT scanning at probe time; a device reporting a
>    count of 32 overruns it by 26 bytes.
> 
>  - cyapa: cyapa_gen3_irq_handler() reads into a 27-byte struct
>    cyapa_reg_data on every touch interrupt; a count of 32 overruns it
>    by 5 bytes, in interrupt context.
> 
> In both cases the contents are controlled by the device.  Bounce the
> reads through a full-size buffer and clamp the copy to the requested
> length.

No, we should be using the new 4-argument variant of 
i2c_smbus_read_block_data() that I posted earlier.

Thanks.

-- 
Dmitry
