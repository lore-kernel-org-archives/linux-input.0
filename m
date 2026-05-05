Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0953D090C
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018080; cv=none; b=Tc/C9M7rSSrhHFXdN5Rhc8vQBjhiIAopEUb9aXrOtw5Yo1CBupDCvKdEYex6Ao+1VJTePXUj3JW7AWP/yxplih8gwS9oREAeBRSPmsBAcYcnPVhtYNdLcxn+AR+WZGtbbhqLVWxhHJe6P28wyy0LSJJcMMRVMBeI1rBdvbhkuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018080; c=relaxed/simple;
	bh=Z2huH/EQXujQCyF1M3eGhzyawOQuqd92ysZl/OTmGJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBjj5Z+4rEywAsFZ9jtzXmYypFEN+jyf49Slyp3qPy3UtccPoNDtb8722xrKU2nHIMU9/F+2k/Po+0Ok36D4jNGf5Ej1sGkq9NvE4FG+E1uTMqoHCB7RcmlEanB8JNnCXSMfZ6Jv9UdkH19TtvGQxKBi/Kaj8Vpt+CugFYJ6n28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/53vS+F; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/53vS+F"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so5965004eec.1
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778018078; x=1778622878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn2gN9TOXcgav3hEevfmLoUHUeCTTlNmOyy5YzrGBk4=;
        b=c/53vS+FeMcLQacVv+h31lhxPSmgVWLYmYQBYDZwgntoj7qetk3qnpz5cjCvXqbHiK
         rwkk3IQbWB/DJLvj5uvOQ+DS3cdYK2g4PpInEgIqwYYnQC2wfkxCjgWEGQN2qoxEDpit
         06u+7kMtPgoAzr1Y6UQWXYiZPGjmQeBALkrxTubNDKQn2nMLLfp0DFIcf5M5yWtS1r8/
         /1DraMhRP+9Mk9YpCrEWkAHDQ6VealkMENOo2W+hiOMeAl30BqioIDqlmm5JQxxYzDnq
         KtyKGCk0579DYyhRA2Bapvoqe1tXxYMsRMKxfOrWJziYwMXslRqsOXKpt8H23KqtEEhT
         o41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018078; x=1778622878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn2gN9TOXcgav3hEevfmLoUHUeCTTlNmOyy5YzrGBk4=;
        b=mObKdGzIeoknSLuJZeCKwYs8/1TetkiYZJ5a4UMYJVkznRIorhSYUnW+hqPQGzaL6W
         rCprypi4iDlm/7fBIIOdqnKvrM5rl5JXgmS/IZvmbaYdOggvuHrZlUsIWwU6qG/GtYJh
         hfm1xb3dqGjNffbwUNKX8W7p7NipRG8kO0B4KQ/GgsfEAs9EVMQEuYg2r0xezykjIKnw
         PZcvbrDIQcq/JSn0RrJoqNZj/jHb5wklUIoM17LiuO0EzDaoU9YI1fYeV7COaAkwcXDA
         2hyIJtuIVXa1Jk+OcS0HmUu4JoTm/Wn2vNtcTfEG92DiYQyMZI86kWwzx0dBFwn2hAwn
         LyBg==
X-Forwarded-Encrypted: i=1; AFNElJ9WT7/2K5EwW6BoiEbusaCmfnTd29K+5jirP5H4HrisYxEaQGI1Jp+YAJtcurKoLOVOYc3BAyiRfM+OTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkUEDMBC+DRsr5QaRENT3GafvFabCFjbZd0O+Jdh+v8tkKPc3
	jiUihyxh3MB2BtQeVmKzfkpSalHEYALefQEkHalbc3LOi1dQClhJ/n3C
X-Gm-Gg: AeBDiesEcWu2ZEBuQaf2/dk5QNLqqrxRaiF/zI/X//XyPx+GfCnIqqgBwzSuHk0ssJO
	oYarINdmNLiz8xLiSu8EZ/0+7euS9H25CBXR84cN+Z0ipXPJAEwAMOi9761oZCc4qVEzIAik3oN
	LIVwdp1cFo4ZbnS9agDH69kafnt8KgE4uup1e0fNU6BCDDAwCqXkzVFLgxN68y7t0B+80oj1jyu
	zvpEu+r/QXJXyYAJzxYd1MKrY8JNNgE/e4ApFBM3V5YlN3rwaB5ehalEztq4O41RXnkFW7XefC+
	+S86KRqmZI+AaRtJ5RJcfJJ9tnj0FgdHNSfGgQr7Tq5nWY4zK5BEiTEbzspNCC1UasoY137wL0T
	fvMD+7V9jdKpDR/yFOgYuwVZfCf8QodC+AWRDj6bc/CHyvNbdny7anf3qxGUSJriPGMuvDfb9Nt
	gJzKmKYbVHr++dHxPaKi5VV/VOUsGeLTVfnpFX1iDViACOw0QQuBRv16PdHdekuqZoeC4L5A5CT
	c4=
X-Received: by 2002:a05:693c:8110:b0:2d9:32c8:2b69 with SMTP id 5a478bee46e88-2f54a39074amr415753eec.28.1778018077853;
        Tue, 05 May 2026 14:54:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec763fsm722870eec.4.2026.05.05.14.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:54:37 -0700 (PDT)
Date: Tue, 5 May 2026 14:54:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 00/11] Input: support for STM FTS5
Message-ID: <afpmQKJilpgDqrpJ@google.com>
References: <20260409-stmfts5-v4-0-64fe62027db5@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-stmfts5-v4-0-64fe62027db5@ixit.cz>

On Thu, Apr 09, 2026 at 12:15:43AM +0200, David Heidelberg via B4 Relay wrote:
> Used on various phones. Minimal viable driver.
> 
> Includes device-tree enabling touchscreen on Pixel 3.
> 
> What is missing:
>  - switching between AP and SLPI mode (to be able to wake up phone by touch)
>  - firmware loading
>  - anything above basic touch
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied #1 through #8 (#5 with minor edits). 

Thanks.

-- 
Dmitry
