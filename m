Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048F37C101
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302312; cv=none; b=QipJ6I0rxIpdzFx4qPbMH/y/ALEO1Tp0gvfIGgOzzkgpqv63OFzvq1n9WafqiPjF410K482a5STwjIJq51ZlHlHaEpM4dVpdwJuI4AYNEV8TcURD83mC/IWMx0N/o+KUQ+DBzkhV1GFveNvdRfSM1TjKLgeFrEKEVrhrTmFYIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302312; c=relaxed/simple;
	bh=Wnkib1E2u384UgEWXcPzg2hYCbMZ6a7ZFMUXtLgvneE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMn9XWp/qCp/LNJzHntkor+rwyN8uzKKswAhFVNZhKpJ3ki46SHFjSzhU31waMJ2SB77daTCVqzrg6vO7vZhch/Go3PSHcyF6ILPjJ6vve1sUwXKv61KgFLdoZYwx0Hy18mvhb/HZFyiXIvNmB87WIsCUVvjNCqzSB18klxnUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR/aKTEG; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR/aKTEG"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so749335eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302311; x=1774907111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/h4tr2q17t1lUBvV9OlzQxmbh8jKis6lrkgsTaCL36Y=;
        b=dR/aKTEGvNxuXdwZkNxfYrOCbFbtLatvNxGZ/wOCcXMtX/ffJ6KDvRFJUbavQaETDE
         FnxXTe7wSI7FPBVSkKmxPk3Lgy9kpheX5ax0P1a2aZ64tI+iT8VMN/pZyQJMdqHeq0Xz
         VUA8fMXmcf+ukAELMSp5T9I4VPfzRkHmqdJPo8liqKSXhnJ9EKHxX6Rvcp9bicz9pIHf
         vyrio6w2Q3k2sHYfct5tz2tBbQQ15phQ/n7vZnvPy2EG9rzoY8ICWdjozqQdbjVYZ4GN
         npEluUdlxiDC6XSVj9lYDrxD2ycW/OzoGI7wLjR1KPsxmVmmA3BS+t0uKZQC6yFq395v
         3w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302311; x=1774907111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h4tr2q17t1lUBvV9OlzQxmbh8jKis6lrkgsTaCL36Y=;
        b=obWZjgmumbqMtGJJ8y6zF4CwDUyZXYZjX2B7MYErfIIMR1/KyLpHT7B3PD0CT6FZ7v
         rjsel3gbeutludwe0PCpJyZpVbDWObmWWglgf2vUYtNXr2g6JZuGE5iyUEtr8KBN+Hyv
         q5+FmEi/DYR6G5rwJUWFJqU7hnhlaL6bPUZALNkjRdpzBcVvuIclAeKwQ2AKDv/95SuM
         GBor4D7iNygnloE6+rlfhPItC0UicYGPHfsCcblu3LnA13Th5LFlQ+EoJDaFfgCf2CyK
         wzFuwAKWGFbwp2wetPXEGsyuNz6ZC+4dY6e8pU0RnwZR9Bp9mbujpHFmQhblUUnxlZkh
         XcUw==
X-Forwarded-Encrypted: i=1; AJvYcCWy7xjyQjvtnSgDQD/6jROuQZwkankv5OemszEAES/HvCfzeh1WGANn745c288YbEEDYAXmR0vULRp3Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xemtQLW5KTxvz7PsL8W3TPDPASXeg7oNaZMD9EDfLFDVtZ2P
	MOCMis6m+4NBJdq3beJFQZcxfgPFM1jLzhPQIdp7wCJ9NRuu0DMEqak5mbFb46Kr
X-Gm-Gg: ATEYQzy2AgXZxrevhQWvRZkr26Y7upmXSuBO5kB1ye+lhEEGC4EW2TU473CneJoj7Zn
	igLBC81zuuGdmcjZ44Qn2BCh2Tz+iAslhKBtkF684zO9uIm/LatbrEuT//2sHlTomff05iFEY2J
	3HaWgWTpSeKQ7XiA+gGOStuxnyuuq6LBOYcrbDCIua1Ai92WzgRN+XA3j8bCKn783ESHb35W2pL
	9dwtKbt4EMZbrLfy+j0Af5zDKpRwJ34kbhbjsGRmybVvKOUguSR/nRJwAwPf20O6v1oI16XWhWs
	JYS1NA7Q2dp4Ej8LDTOrSV0h0r+iFtR/zq4yR7CvJk15g7elXAdUoqotSa5H+2AAFcqUcu93rVm
	JN/j7yEw+IXr+nFAzFpHqIY+Rr0HYS6r875c+rbHQ+oLxi1ngdK3QSKS/DKpuvQgKYx1uQAMcbZ
	A5QmNq0MWW8DIIf4YipV89kkbqFupkeGz9L52G8eJ5yUEHWpMbwvCPgyqHm2YIOM4+
X-Received: by 2002:a05:7300:fd15:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2c1095aa022mr5474091eec.8.1774302310697;
        Mon, 23 Mar 2026 14:45:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31ebd5sm13403172eec.27.2026.03.23.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:45:09 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:45:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: matrix-keymap: fix key board wording
Message-ID: <acG0CoKkM1S9HzLF@google.com>
References: <20260323140024.104475-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323140024.104475-1-hugo@hugovil.com>

On Mon, Mar 23, 2026 at 10:00:21AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The correct wording is keyboard, without a space.

The driver is often used for handling sets of keys or buttons, keypads,
etc, not full keyboards. So I am not sure if I can get fully behind this
statement.

Thanks.

-- 
Dmitry
