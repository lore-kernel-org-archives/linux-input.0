Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082662D7398
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384861; cv=none; b=qdRQ/wPBwuichbN6/u9QEngG4hWKw9H9ctETuV3mbEWMS/Gv2F3WnizmMNbKkL6Uh/nJMNB6r1y7UVtMb6UIZ7t/GTiE5VsjaH71IWQerd/LbAocAufw1N+3uVUBnI0tDUatjR7ZnaQw9RMvkde9gtlWKoLWpdTgD4c4fmkd8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384861; c=relaxed/simple;
	bh=upNZa3t0W2Af8aUbICzQiCV1vQp/Hwy0fTwu/8O4BTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3H7nrx9HCQlIKYd+BrhmDTyEEQjyjjrubRtLjzP6QHZMePfOavFu5GtvAaT3ZjB4eTkHMsAuas8i1YWP42oPR5tVFsiRmV7KGuxnu+0M6u/TYgHUnQb2EUOHtOspvOn3Qwj2WJoNiFb7ioo83KpMwhLbcMlO0ZvvoviTNnId9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtMtt8LV; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtMtt8LV"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14373bcc010so1291943c88.1
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790384859; x=1790989659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZuMXzMudqgIHVV5MC4YBYyxnrbOVGK+M2cyTDyid7E=;
        b=PtMtt8LVpDdvMOBaSiSBQyCerRAXR8jAFeohyuYAKR6nlB2NKTphmGSI2opWT1ANor
         klb3FI721lLz3EAzunSyJUwP+Z7Y+QBCdXnraBj7Refn61ebNClpZzuKMOtLJxGa1zLJ
         basx01t5XzxwYhBla6zm5Kxwzez9cATMdPrGEkgHoYatWo4NRqOxEM3tJ/ZqpLAVyt+A
         4rHwoO5dvaBeETBLlQu4vxAm+wGs3E0iWk8bE9PVdjV8hhG7g5eGR4wp1nqpFI4qPNzk
         BKriwVD0K4rZGtT0RWECzqoXkulD2aOJAUnON6zbK7yJRPoDUaZI6Cn0BxcPz9tYJoWM
         dTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790384859; x=1790989659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZuMXzMudqgIHVV5MC4YBYyxnrbOVGK+M2cyTDyid7E=;
        b=uBGGZPfRZt8LyTC4D4xFsg9VWetiG94bInJ34JVnqjjXHvJwERYZX6D37/8zlYmmaW
         gg1pyjboP3/7IAaC4P5eQ2AwemxBzXy6LlnIgQOc2MSwu7HCM+G1JrgzFVR42SumF1el
         KMXmjng17Af7TKWkmbG7aHzZ+QbPnfTeOozYqTNMH09VkUTe1VAYvWAiLXgeb6MAgaTA
         gA02FlB4DtwivPWpmPXovnXmZEH8iNng4wvBFDcYm302HChsK/enlPhQ8opxFOcwlCP1
         7oT4HYyzdAbvusQmR4fKzBKZk2XZ6tz3b/A8TCVE/Nr7eFkZf6y03zpXvPu1Q2XBmtpk
         xIsQ==
X-Forwarded-Encrypted: i=1; AKwUvBytlN8uqIabZecvpX0JdXlbDQ+NxugEefvIk7szhFLeA67iTW8rkiLGlE6m5C4z61/pRscrRs/+aWWH7g==@vger.kernel.org
X-Gm-Message-State: AFuF++mpBzuBqg+Cq1H3V+jIZMiFJ/1J2gWoY1HKcCvJl3BsFcdTK69o
	xzkUcAe9ANAXW32DErpiO321zYoEcIM0TRvllJtFGKrSquHwmyLHlnkE
X-Gm-Gg: AYBFou0EodIs18jm+iIvCIBhVWGheczzY766tnuHn3NZRkJdebrK42wANlYnWyZFBd2
	GRaN7EkqoFa92JoD3W9UP8V0J05ZAT5pI0iVR+2khG1Ej6N+pSYbKfJhHBw8nbOgo8H2hcUvt8+
	6Oyytg3eXaNpiztU2KWCF3gF3jqtJlrWLIdexeSALeqfh+ysUgDeTjx8pPuThgDIIMC6LPpQUpX
	rjZtu7h4P/wjarMGjlQ6VzNO+V85err6dUckDEUOSsEPPI5Z65RShbdIiZEZANLSGogxsiXWQbH
	cbW8eQf4tzoc9IX5/KvsWMtQKg15aQWSrqadr5AN69ke2FbLqR0p6/9jPhN8cSRNVa/Q1QEWEHG
	e6utdPIzIKg6n98Ad44djHIhj+m3ZguhE5Di0CG097fdGkQdYPfWTeW9/MMdckOdllW5zAUHn1D
	ba+2HSDdhxYxcw1FoJ2QXwr2Eymt+g68Dv+ls+iexpiULRlL8O+5rHrn2zW4BGlmmPf4zTYoNDr
	gKYpfSxiVt+qw8NzLK1WQHtSory2buQGMEnQR0o
X-Received: by 2002:a05:701b:4589:b0:144:e246:a0d8 with SMTP id a92af1059eb24-146d0682969mr1639403c88.40.1790384858988;
        Fri, 25 Sep 2026 18:07:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c0ccsm8488992c88.4.2026.09.25.18.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:07:38 -0700 (PDT)
Date: Fri, 25 Sep 2026 18:07:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: input: Add AD7147 CapTouch schema
Message-ID: <arca0-sw5QCBrsdD@google.com>
References: <20260923191604.2213710-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923191604.2213710-1-robh@kernel.org>

On Wed, Sep 23, 2026 at 02:16:03PM -0500, Rob Herring (Arm) wrote:
> Add a schema for the Analog Devices AD7147 CapTouch controller used by
> the Microsoft Lumia 950 and Lumia 950 XL device trees. Document its I2C
> address, interrupt, and optional vcc supply.
> 
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
