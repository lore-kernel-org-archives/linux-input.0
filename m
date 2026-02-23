Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F819C542
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818810; cv=none; b=ZjugdJVHNTwcYxjfgOUVCTE6BHL4ZjS5EQdjBEucmi0Q4E3N25gNc/bLoXJV5SfciHQbqq0nDSQgrofcdOs4g1X5VvkT/JDnZF7aKGLmrsKvbhF8OeP99p+zaiN72hIT0dlYDi32Oj/Q8g0P3b55LWndEh9cIb+FDkhAqr6O/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818810; c=relaxed/simple;
	bh=99k0wRp04QZuEO9fXdcWbJwodZXopiRgUMiZ1ERBnM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrOcny11m0hpA7YrnggbnaeuHQw57CoMI0QA2xolgKgU0FRQ6oz+R8GOKYaeT1wsuOfLbNqTpOkzrFrtsk+c7Qv48Y0LXpV6WHJno1a81ailjQgUS9Cv9evQJ8ESh9/5OWg47X7RAYfjP3Lr/Q1HldnBYz1k9Vxn3sHp7QGehfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMGDdSeI; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMGDdSeI"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-127423bea4bso3573314c88.0
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818808; x=1772423608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFRHPjtH5NiY1j5xZhyiqW0RcJ6SUI/jraZmcaCWJws=;
        b=WMGDdSeI4aU48OLVZY6w3PyB2Ulre7nFYFqRVEx3zeFDYh5AENr+XZ+Wk+Cu98Qq6Z
         XOrpAXT2zRIhw2fL4YDxtam7luHR311h9Vk/OSg5g3zSSb+WlqhXlAw3/hQSl7Ml0aer
         GE56eTW0mQqzlwWi60LbDRZaYBjX97xdHvbFdyfOC/lTheCeIgIS4IE8uYfYaTLVBzeC
         S2CGLB6Z/S82OoRQS15CuJWv/KRkOeoWDyCxry2+sei7v450ix78rIZonJ2JbGKgWKG1
         8M/3qVvagh/TVPmJXVIG7GadGB26RE4xF/ixzQkL6V8ajnQ90b/eQH8e3BsDQRWUV1u7
         GSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818808; x=1772423608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFRHPjtH5NiY1j5xZhyiqW0RcJ6SUI/jraZmcaCWJws=;
        b=NiMIaTuzzSInsAMCA6fSs5pWMCxmT3252Y8wqya+xvdkokHSI2gUQfsA9igJBZlIBs
         ybT16wE/JN5GsIoZcm+S9W950Tto/eCiaZlqDgvXFITH09ectbMKuwQcseIyGyPc17Wd
         k8NprZcX5huKoHoKAhyjFFFH701bjgkE/kCyiuPXt/dcQdPbTdvM6uI/aBvvtxW82LUW
         b25UgsOwF8A1jXb7KRz9Dmlapv1E5zzBvoVfQFacpokn2kMpCTdxsG1C1WUE2i9yqcfh
         vAh/7cvZYTuu088YzPAmWxH1yWMdVdaKStjA6qJX2nps5IXZlhEH/OafQC0lnQtyPpsB
         vFsg==
X-Gm-Message-State: AOJu0YwIAGWPNzUuKVAYJhnTUZJdNMqlzqmm2XyGQAhkNmpaOAvVt8qE
	3gesSU9ncy5cex4xH42RvWsdZa3CfOQYeLycROtd4X1oHWaTEffUHjfw
X-Gm-Gg: AZuq6aLDPR1PV0vYm6WHvNvF2pBfb0oxpMWi+04+JXYWAIU/qwLJ6d6ITJV2aziEsvf
	ODHh0lUYO3ZflTpqDc503kw1qXw63h6TpQcHU1sR6CKltRsxlUzVDD6HLwpB3mebBsN1/JjTow8
	qvpD3t0yqQ2xHXSQrumuMGlWgjlzYN2EQn9betMYvaWqCjJkjezq/YzmOlZYfPZdgziPLd2RM+W
	Dh2dSMEUVo+zfXtXI1DJGpSyYzik7C/kv+scCepvt6zN5eCbmrko+4ZtY3t1+OZMyQPZPB6iii9
	zly8mZ7CbPAakYo0TCtEI4gzIFtmesGk0XiulcTT4BpSAVydQvfDzeB4yBaDz5kOMCFb46kfSti
	E9GzMzMQC7KbPbZrCGNXd2SqOKZc2rg7Km+U6mjkljT1bXMaQo5q5vAQ34v5sFZ9CB5KfO9jOxk
	DSRqhUffBJ0icLfIa5wuMeDYYA4dChW2+tQ2EsyhsEFqivdyG/4POzHABJ0UVa6lI=
X-Received: by 2002:a05:7022:4189:b0:11a:fe6f:806a with SMTP id a92af1059eb24-1276ad1d204mr3071336c88.31.1771818808417;
        Sun, 22 Feb 2026 19:53:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af10481sm7198476c88.3.2026.02.22.19.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:53:27 -0800 (PST)
Date: Sun, 22 Feb 2026 19:53:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: adxl34x - Drop redundant error variable in
 adxl34x_i2c_probe
Message-ID: <aZvPHzdt0GM7VDaW@google.com>
References: <20260223000308.319335-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223000308.319335-1-thorsten.blum@linux.dev>

On Mon, Feb 23, 2026 at 01:03:04AM +0100, Thorsten Blum wrote:
> Inline i2c_check_functionality(), which really returns a bool and not an
> error code, and remove the local variable.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied, thank you.

-- 
Dmitry
