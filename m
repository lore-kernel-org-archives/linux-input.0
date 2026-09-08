Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7432EEE86
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788843810; cv=pass; b=dCHlznxmCKD5ZSv4bsm9sPxLJm2xv+0Qw/9EkUInwWtnrFUt6oGin6YFMK2iIwqQJXrW1wS0RvCVNmRlvWFCxnuD1rb5Y61cBqN8VMxPTvGH6k9aFvqUITC4oc6WnGMaFN3FJicUJF+5ZID2tW8pH7OLZO1Hw9KxNgUqjnmEwS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788843810; c=relaxed/simple;
	bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOxZLhSfxyI0t8Ay9fAILOFkbXQfWjCuQUHSZTBRKAXaX6Xs6K1WqP+/5mmim8FY02oDmDJjx3u0AstQGBKVdqQD1crfE3Q59LKF+gt6sVmEJB4FcRr0ngN+Qe58YxMhkVo/ddU1D1BKFfLLSsYZ2xGicfmTLq9KUelPTZ7soIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MafPXygO; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MafPXygO"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309140a299so1157841cf.3
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 22:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788843808; cv=none;
        d=google.com; s=arc-20260327;
        b=s4FDKMwtNKT/RjatcX934MQIApiO6dpnTIWQdvzvsQsIfe2LUhGmuYHMx/fEZ+/d+f
         XUsw+MxOfWJqSc2DzasgkolDa6DfGj1F0h7xOP+D8lLjzKQV135Xq4Zbtir3ickQ3q0Z
         IzmJDtfSuk+R9SfBgfkCoJ76kfSsu9ox0bt5r7GCKVYHLmDLZ3HdaK/giK+Jfa1Lkqym
         wezTZ6tO1pcQW2GRu+EzHaeAKXe+eLSdDRaXfC+Og2xdTJzKjavLP+EwFATESjYBBVeI
         0IhjNv+L8s5+nMCIn4Jr2wHFB93Te7ZuB5qpWWZsHRuXZ1QsX1sL3gnt2mlXZkYJjEVw
         1nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
        fh=bQ5eoe3S8KVRnx3o12RO/HiGBTy4jZ57B9FL5hyt3Bo=;
        b=R9V4Xue0LeRSxNopWqxfgkWKHi2yFIEH2HFIGAnMcZLzjspnG6B2iLwCDBlykJ4KfQ
         /WdVPajark4Gf6Sgn5eQ3+QkHFFJo6irltxaWjJjNfZc0vosnTYGbyWfkt93pi/NVi9y
         j5oQ4AAkG5ttC3CJCnS9/MSygwxwNNywxWrxdenoV61rmqweNlNygYzDL7Gzi+vqE6bx
         x6VOOjzz/H6FA74E9aUUTsj6XoAWsUo4oXB5gu808lhtkOXDdr0NyQM0BaIYiNw+xSnM
         hEnMdVAYyOsH0pLIkPzRsKTqhd66OSD+XwLGVMzUOEU0itk8saYS1XFm6/opdBxjx5Ej
         9Jug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788843808; x=1789448608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
        b=MafPXygOggzgL6Cp43d4LlI8CyduSVRo85xvv3o/BBGszS5248f1ZyV7+1jHEtDDJb
         Cel3WGCgfQ1RDe+ue2IY6udd+HDA8k+w21ESK1go8dBRhC84HfOFTWyBXJlnEtwgjfyh
         YMmshhgoYgL5tjHwZDyj175121014PZgA0p1I/G3XcNOAB8G0HblmtfNWCMFchc2kIVf
         CENpPl4irCEIzZbXYsoy/QML4PPzY2wmoZutCjQifjxxOpY/V7zRhCw8DgcqwDaYevfI
         UaGyanNSXJSnMF/wIWDVfL0XeE0MVOXZZ4Le+comD97PEKwtwJ+OrGmjqHAgD0Z7c7SY
         Tt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843808; x=1789448608;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wHWLl+AY+6R9gF+WQK0aNUVqFTeT2mAxVsrGGjIIecU=;
        b=oenpcw90GCFOLhyPIrkO2dZrt3Vw/kaDfSKI72NGg/BdpP7Ksq/MP3Eb/dJDFSjhLH
         yx7h0+wbK/TZy2kIDih75lfI6BUh0LsM+yXTWcD4uJ4jtlGkNr6AwuxSBteqCxua/bXX
         TtrXfurrDx2u+zYUTSNi/oXeAxLi411SRJnKrDkLqb+bA0XWLEq2iarMc1XYfz1RFKyN
         aIcOSnaNtQK6wRq6pQUh0kt3kAqoNDnS5zJAZ8aEe/aG+vVM5JL2OsoFJ/zwuq8BPgsW
         jOeEBgsoS+Sab8Nbtyq0Pw/4HHOi8q1MSVA9eAzP5E4XM8GatCw9wr14yV8ynlUzcJi0
         3sXw==
X-Forwarded-Encrypted: i=1; AKwUvBzTZ6Q69YHbm38VUMzT5z6zYHwL/NBRfNVvbnSKZrx+Yx6xOEqtfBL+I64kFgdtr9j9T7BK4euwwTGZDA==@vger.kernel.org
X-Gm-Message-State: AFuF++k6JcLmQx+ojfdzrHTvm6zHGqwnPRhPpPTp5p1lZuA4G2T0z/ui
	1dy6EQcGDEtcMnsoqOcHd+LNWz83yBP60m7cEvLGnd9TbXDVq25MTH06gPEdkL1Tlik0FiamR6S
	LquuVs+ccwoN7yuYYXdtIFLrxILfa614=
X-Gm-Gg: AYBFou23VnPVIlhltxNM9ghrWoS93DNCmtoq7wv6hcM0AmlkgxxTkrkXxuvzSfnSAsn
	9M4qo5DZscAvJU6YNWTfgDelnf4sge5gRqqJGAvbOvrxS+cO2sLlUrbNPPfWGe/Fj+kzJN+hXGG
	iaKxdFPjT+XvhAwu5QfQLvUSwiAZBgnsuBC6MaExjWTYHG43nOk6o3g+x5DSSuoywB6PrWessyx
	Q8UrWIRPeoDw/D64Y/2oa6wbEGuLEelQI6YAvlTlrrD6EEfehoZJrSIyA+OoptmHw0T0jfmt6Ur
	QSUX54BXH5ue7B5MejD8xABxFcIGjX8qIKnbWuIgNdWyc0ST68tilBfxcHlF43WAsxPfR7TOD6o
	Iu+ydpnVO2K3pBJVB7A3ZpO100z0LEw==
X-Received: by 2002:a05:622a:148c:b0:50f:a53b:9d5 with SMTP id
 d75a77b69052e-53064575926mr179500891cf.2.1788843807729; Mon, 07 Sep 2026
 22:03:27 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 00:03:25 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 00:03:25 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: miguelgarciaroman8@gmail.com
In-Reply-To: <2026-09-07-daily-reply-0019-aiptek-6-1@kernel.org>
References: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com> <2026-09-07-daily-reply-0019-aiptek-6-1@kernel.org>
Date: Tue, 8 Sep 2026 00:03:25 -0500
X-Gm-Features: AcwNN1UHSRkRqX6Cchn0eyhtuQvh9SJQvknSWUvMUSQpGO_lX_JnVov7isf2EqQ
Message-ID: <CABKbRoJKpLe+mhv3VdTxdce+HDfVBggvJgAeCkJ+Us2Hi3QVXA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Input: aiptek - validate raw macro indices before
 updating state
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, dmitry.torokhov@gmail.com, 
	gregkh@linuxfoundation.org, pengpeng@iscas.ac.cn, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Signed-off-by, can you confirm your relationship to this submission (sending on
> Pengpeng's/Dmitry's behalf, or an independent resubmission)?

This is an independent submission for stable, not on their behalf.
Pengpeng is the author, with Dmitry's adjustment. I forwarded the upstream
patch unchanged and added my Signed-off-by as the stable submitter.

Thanks,
Miguel
