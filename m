Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278228;
	b=4v1Jhh9BIgCTZIQK4aI0+qZ8WwQnO4QQFpLZlIxeizOFMQRyWY3DbR5jPiOTNpvF3xvL
	 t2S65pfev6JWsyaZD/DqPCjI9dnfCZDNZuQ9WSSvV5clbPB1kNoAFSv102kjLT567ybnX
	 M0HN94ep6gnpZGz8ajkrEJKstViMAXJYZ4O/G9kfNaxVGNRHQlY0aIffIG9jwRbhdtYU7
	 xSJsYwyHGSaBEub/Q4xPlwV9wNSZmMI0Qig8pXpqjCCjl+K/tPz/Nnrs/LvFXt7+Gfop6
	 kT83oC6ygpSNHKyCc4C37YRYTALvgRGIpap7xtDuYXvkRPNqd5NjFYUKGeiwFX3HH9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0u5+rYT3YoQNdVRNVHLrVHwDAgcFZg+rCZy8HXjrq9A=;
	b=DKhnNJ3XjrnLREWAqEoYbSzuEegxQLqIqUV/Kp8HYeG6uV8BCdUBhml2dFSfnkj2efaH
	 KEFL3NnBT0yxXRRh77YL2K0bqCZcRnbtgGVruLtIOU4r5SoEWGzgFxD3+Envqiu2C/hGT
	 a+NabrKMGnHg1oom+bdOrOvHx6xGdqtDfPof9W79GCsjYX46SE5WL8iBLptDcf879MET0
	 tY4BYfGVmKt7t7VWFT6Up5b3Q41ydQcH/aH1EjSk2bfRJUB1u8uF8Wc3/8HCdRIg3BU7d
	 3yniyaF4PjupzPsBDwyJ/7IDcyeF8kw282bdXbXrSRxMzMcdaUCo4tQ+bbeWK4eoJzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6dAaECO;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3862606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3862606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6dAaECO
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3720addb068so2574454eec.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278227; x=1794883027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0u5+rYT3YoQNdVRNVHLrVHwDAgcFZg+rCZy8HXjrq9A=;
        b=e6dAaECOn/6gjR2Epz2CWid96qChCp53Z4CgbtaMyQ+W+NwKINxO3pjQfAUo6NyRrL
         EN4eirkn3aLrUaoUa0D5mGHhuLF5P3fVJMs7Ds2d4RU1Tunyku8W7hKwmru4fjkjp9RK
         yFj646Kl2OvjWCjW7yxCwmbiexnul1G2rD1McGaBGz+zVgC4e+Z6wYhdzuQdcxViWGSp
         BqMVTh2Mw5VBtAH+IbP27510ujT3adz7DHBWYE7niju0zIjTmIAXW61UHbc7jLOXUIcz
         MntNYL6rNA25khniZsfSMhG1cxULTnAllpZBTXP+qzhuTT6JGalA3D1JLn8JDd2CExU0
         X3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278227; x=1794883027;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0u5+rYT3YoQNdVRNVHLrVHwDAgcFZg+rCZy8HXjrq9A=;
        b=ZSxVFN4sjAo7G+oG3T+9Hz1KF287oGdoJ+oKVa8FYwZbq66YdKJzwgrUJBfgFgPSMi
         DCjlrlUGvygyA7nZcg2YA88mi3wcuoltIGCVdeYCcBquNFP79FYFQAldTED+GQ/Rrdbt
         RmbqAnL13A/s1V1dN8P9c/Nl6+GbebV/ZsT/fPu6f+UuH1qio3KdGvhqGaM0WjEo68B8
         AeMkiu4Fh/AVXy3pS4F69v0aErMfVYSGI86LIjMYDFhEYVdPpQnsbCYS5vMsqUSJs62i
         yHAta4l8PtgECvx1XiihCMYBHSuhuO9c/S4rWC4J7LR+vKZyeHGOALUPxVJel1/VUsv5
         3gDw==
X-Gm-Message-State: APuU4Z8aGQkE/6ZaCB0jZmk8KrC/YU6NlqhrM1r2WKXQj30KOlXNB+bI
	f0ejaMOoIjxKGN3r9zTmPsirHiw2xi64fNOBrNSs9/N90knJjmQztMg6
X-Gm-Gg: AYBFou0JHXiPFUThi+WtsNsDtGF6HOL5en8gblecnD15HmZPulIDeHLSt45Vk0KTYqv
	cvatb502x5+EAHGkMeca1ym6ZzG2XUS5/JFQaMjYzTNUS0O4BHoCMg6uPy8HgVPhSvxxAH5/gvV
	tkSRJ9cQO9l1bGzUjCw6y6ni+9n48wUFb0t1iqSWPfvWWOTyKP12GMLVngszq2tWnrE4ZgTMyg+
	XWx024EXmRk1c5aHWd1WPR7r1O0OIlxE3i84ZjmkxXgTNM9D3PBDzAxg+nlWnlj9LljH/cNqhdh
	jWgY2M/f9BsZYc8c7xL/QpWs8VFUFRq0OgRbI3IxkIN/HEWZul9dUeMZkwg4MwiTJiGBp6qMPm5
	+snb5C5k9nqerc6XubY01EU0lT/ssli7pCF7fADE/fOMgJ3vpYrURIppsmVeJQK1MRBbMKNe7c5
	W8WsQ6NvVOfVPyI1jELFJWoyTzjxUeezxH7yxsjv13f9MW6Zwfy1vQnk6sWiBgldVtTuMWLe1NR
	91/8WTcTedWMJ6wnX4ERqwC37pclAGDJiFZx0qpNUkfSTuscET2ngQZXQB/CGwJVdmr1wJqBLbt
	sObwBVjJZtUDQarauZJ81nQvNOwJhiW1BgFCpkib+4vV+nVE5QRQ0XFYVLnbU1ZHGQQrDA==
X-Received: by 2002:a05:693c:4144:10b0:369:f05d:6c67 with SMTP id 5a478bee46e88-3751fb324aamr1768458eec.12.1794278226862;
        Mon, 09 Nov 2026 18:37:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:856b:460b:b522:14ec])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae63a6sm2617313eec.1.2026.11.09.18.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:37:05 -0800 (PST)
Date: Mon, 9 Nov 2026 18:37:03 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3] Input: applespi - validate ACPI property buffer length
Message-ID: <avKDS9x8NVLeizVP@google.com>
References: <20261029002227.2002174-1-tristmd@gmail.com>
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
In-Reply-To: <20261029002227.2002174-1-tristmd@gmail.com>

On Thu, Oct 29, 2026 at 12:22:27AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> applespi_get_spi_settings() reads three ACPI _DSD properties
> (spiCSDelay, resetA2RUsec, resetRecUsec) as u64 values from their
> buffer pointers without verifying that the buffer is at least 8
> bytes long.  If a firmware implementation provides a shorter buffer,
> the u64 dereference reads beyond the allocated object.
> 
> Add buffer length checks before each u64 dereference.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Applied, thank you.

-- 
Dmitry
