Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB83A9DB1
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019130; cv=none; b=boUcFpFfrgGh65m0WWX9IDagLjcqwRFMpx3tM2DL3nZuCqN5YoL2+BicI23BdoolvNBydubmzcEWzDVuBTQqLKI76DrPYStvHMFUEhso9B4B3eqvG/jX8orMFKyLg4bwa222EfcgyVEQFi0tKyHtwbfKzYT7QIiKE+klAPZc7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019130; c=relaxed/simple;
	bh=DlxL+7x1lp9tnfFTr4GsXM8J8UTaDQhZyuNIKR35QKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9b15OaHn7BvQ8v4TEEjhAfUSor1+lJ9PKvaza30IErVVf5mkMJWIejsH9//BFM55WAXsIK0J5o05Z8HzLoeIU5aPTSEnXr282OcZyX/Mh0Pj8jzWj8D6Hsz5I3qkPUjTH9YnYjbhPOkxzn7tTbnhfWP2TRUj9ONssB6PaaquEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfPF8gHi; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfPF8gHi"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d90ba1d807so41162785ad.3
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790019128; x=1790623928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YkVaGp7Cn0+pPyLCGLyICIBFgNNpQjfNjoyqplnwg8g=;
        b=AfPF8gHihqxKFvtNza2MGwCvpV6MbsDsDRIoNgNIeeSZr0dlfUr+1UeOlB6y0r7mC/
         rpUes6cMushi0H4WxkjcK/tiOQsKxQXKcjJvFdj2CEv6rAgkxLNvSyKYajFTeNlqdYMR
         jhKiwujTXvbeHgiU/Y9ZnuQr0MoLCUKjLWXX2cjEy0vsyrMHeTdbEXJd0IBpCgu2xMo/
         JbuzxKcoAk4Qzzs2RoXWTgfN07VMmY2wzk3AqAUIvdffWPQGD9nb6MxUAEnVjIud+QaE
         R2dHbz2xAvkONLCvYriwH7njZxfT1m/5YJmZyYKCfvfitj8mINm0eTYldaCLClzfO17j
         ilxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019128; x=1790623928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkVaGp7Cn0+pPyLCGLyICIBFgNNpQjfNjoyqplnwg8g=;
        b=lkkuoxWlDhZwUnYqD83oUQWfV7aGEB1Kvv3nCsvpHJby1KpF4LaJVuKJBjus0mfXWw
         tQ70TfNEa3icr2KR/PehBBDGF4aa49BtDtXrDZ16sh0X4JoX30/e9DN0NhtqMZA6Oegn
         LmsaDP0izg66N93OCF5tTbHuUU4Y8R68n40ItykwJeruCGDp/655Wkqr/I8wmalB5H12
         SKPbTeHD44sg4nFcQdXFn3JtYQbUfPlXR74eFWF+FHtZ6hTknsv7x59ct3v+7nY6aOZk
         BAKrp6xa91MrCDXxTe/tCVv7JJZ6bRq/wpQkBviaJN25Y7JOZitMP/rclB68vZbjPtk3
         WT/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxW6IldfSX96Fw0yvIY5nFWczJ602sJEi49EYJIlAMglqaZG6cVi23Mi8oxGDUWlbQ7wFkv7/zzXCa7pQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mcVlgneuBv423WjrIax4wuUJ4rX/MPAVAWsGVrBBAa/JiSxosh
	NqWNC+rZmVr9u0crev98OwyQZ4mPWLx8fejqeIjqpZrWxaS3e0uwNIKc
X-Gm-Gg: AYBFou0xeQyNU0ptENWnsGNtvpgoGVxHjswRFBMnGCydwHNvFbCm1f+M+7ZQARgBqXp
	HqKtdxYPEivUenxNMcSb+uAU6cQ4caEWXXhCnz/eJmVT/TkWGX7e8evCfD5/A/H5PTAGAmjhyyT
	aB7P6ObsB364fqiYV4TG9oc1HBsR3mhlakfnoign+WhRbG+5zru9SZpUKf3f8es8lS/wMrMAT4E
	WtlndFikvcucslQ7gz4Lc/OsY1Shbgke9CD44dc7zPgKSRT6eEEB7LXhtvTH1zVuwXv9UExy3TK
	KTLgUMbghN9+cg6QQX6BSzQzndyTKh/Zhz/qRiTpcBk0NeUm253apiAYSCOnJuGx8VBTl/DXmnc
	yeVp0XSUWPg73oFQjA6bDHhZmVXsdMOdy87QrcdtJYIYaIrrlC22w9VXjIYZpE400It//LOJqXF
	k5+ag2jw7lQKPUTrvjpfVhl5IG9gbO1oX1ZsSIxrzZ4/fQd62z1jU7RH4UzynzDQvccYXITSgko
	jL2Z2WXhpr3BIGzkdlBVLBw96UvS/UfSlf5Anmw
X-Received: by 2002:a17:903:4b28:b0:2dd:c100:a5da with SMTP id d9443c01a7336-2ddc100a676mr100940305ad.46.1790019127634;
        Mon, 21 Sep 2026 12:32:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e1a7:4f7b:11d4:34fa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ec60d1fsm126954eec.28.2026.09.21.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:32:07 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:32:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Artur Rojek <contact@artur-rojek.eu>, 
	Frank Li <Frank.Li@nxp.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: Use consistent indentation in the
 example
Message-ID: <arGGLo9vmxyJQlTo@google.com>
References: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>

On Sun, Sep 13, 2026 at 02:33:11PM +0200, Krzysztof Kozlowski wrote:
> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied, thank you.

-- 
Dmitry
