Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9C3955CE
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702524; cv=none; b=q5LqOAXQTBhEn9+8rvq/O0J60Q6t4ge4O4xPX9sczHG+HWO/gE+/8zGf12TILtISTBouscMbrERqT2r/R4t4FKuqyqn4OE846naeo0ymqkZDhHrUSVR6L+yP5FUGF8zwEX9za23+fFpck3a95MTfYPYvNQyxz4uHrXW0zRsZXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702524; c=relaxed/simple;
	bh=SUzO+Goy+cHMi7LxDDffOXrvlL47rvbUGF+iLVEkU4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwKxzHDW662gXbNUbHHf+1slByarg4T5hY8RZNhbPPceJXOxx3hi4ZHASnfLWY2sHVuyw0dQoSBNYDDyL06dMHhkQCLh9CIiBzu9mYxnW6DfQMFTDJpFGTjpGVjViZo5H3kK3TKtPMd8xM8FJ5CZxBT9MBFP5Jd20eZNvUYtYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMnjTHH5; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMnjTHH5"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-132830d8281so162945c88.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778702523; x=1779307323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ImgcLtFrpGQ9AHbrbrcH9nkVCHOcjM95JO8KGUOdcI=;
        b=LMnjTHH5WQw1dcLvVYhul6b5qLFD1Ydpu5aKl23MA3J9GMBMo5fpnIuKnwl1pY9eTa
         5JUmDeqCCT3v/E4CuGi2zsxsMidKRUdj6TM7Ath4KNyrJ2JnmE1sDEibkpBRHHbPPpTM
         6tvgMfECv8zgaQJbQDwO6a3FYZ+C+W6CvqJrJlFWVdSUIF2KVAN/DpKAHiM2jw1RYI10
         tBUdfzf+UDx5an2jldSEB1B5W63xEK0oTlxUZ+OoUaylxVdRKSMwoS7UVNgiTSXAoVWo
         oHw6KB4g9HCs6eH+hZVDgihb8aUThC6lguTE7vSxO0dBpYclwY4NnEfSigFugDsLLSdv
         LCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778702523; x=1779307323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ImgcLtFrpGQ9AHbrbrcH9nkVCHOcjM95JO8KGUOdcI=;
        b=oeFNILqdhILmFJ5ZfGrf1VaH8UIPD6hsHnrI81XkPd33zzM9+PP8w0/hbCZxVQmkIK
         13gnXAEuzCgjjsFVbJzMu2GWXfNV9gcu5bSIOcgm0BpSPtvYFv+jcqnffdXCKZpgDVaH
         Cw2c8HQ81ErLKnVKlrL6XulYjHLnBG+zwSlk/MVQuiK+g6DcX+tJJjViMiq31GBvigap
         CSeolMOr/mKJktGyas/mvJo0XdPBCcTKEAf0ZJkAxg4WGycavACoogcX1JlIirfLajbn
         Pyd8SXgcLbHdP+PlExPLIfJfrsOH/hjWRK+TUcLxxA7dvw0hIR0Pck326VZrFlNryH+O
         szjA==
X-Gm-Message-State: AOJu0YzuZZL830ac9BDLL04ViqYGFgbpnNlptKE3eeDLkC70vcpSV8EC
	btugPBQt2XAadBraML7Oe1P4SwTjmvWb4+0VCHJhSOknYMQb8GUql4vJw0c+UA==
X-Gm-Gg: Acq92OHQuDAHqJMVspydUV5xu/ZwRHLNOygczZ5Ls+oOMmxHyKMfaSq7YLmVImglDsK
	ZT2f9nfD2eOkfBaZ/D8Be3MT26sWLpmB19oLBn/+oOJERk281kQLQWsiSq5cmsLSj/9mGwc6c7n
	thv3Z4d01gZ3HZRC+QByj5/bZgbqDwLwleXXek/+VHPvLJ1cWFzLR/9WDAUoVTS1TTX4S/sFe5z
	cwpM5maeTPjC2UfzqEFhjz9GlRKfQpCfkraFBo13spKbs+Y1s423pRyOCYSCYRDf3Y8/cubtQdb
	ofm240M4xB97NyNWERX2OplI0/sHZ2ZlISQ5FwjzOGwwhuUqoy3roIFrLJAGJK/rGpyAoq1023i
	6VgJVRgPwCxITuGFLFYP/w9ZS0tomigfTYXtBFRGtixpFPn1Q3ha7ayOHvGLlkQtuiJBTZhK/w7
	oVFZUWFHjvuPNCvTZyKI2UvXZfocuqY22Yl0vfsKS9P8Qu3oVfEkMcq5rO1pA8sUBS8eHlFydv0
	Ik=
X-Received: by 2002:a05:7022:910:b0:12d:b6cb:bdc9 with SMTP id a92af1059eb24-1342ee3a35cmr3000459c88.9.1778702522527;
        Wed, 13 May 2026 13:02:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e25b:b38f:c027:f0cb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm666176c88.12.2026.05.13.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:02:01 -0700 (PDT)
Date: Wed, 13 May 2026 13:01:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] input/evdev: move kill_fasync() outside buffer_lock to
 fix SOFTIRQ deadlock
Message-ID: <agTXYr_fFGiJ7lAe@google.com>
References: <20260513115000.77ec5975@fangorn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513115000.77ec5975@fangorn>

Hi Rik,

On Wed, May 13, 2026 at 11:50:00AM -0400, Rik van Riel wrote:
> buffer_lock is a SOFTIRQ-safe spinlock. kill_fasync() acquires fa_lock
> (SOFTIRQ-unsafe), creating a potential SOFTIRQ-safe->SOFTIRQ-unsafe lock
> ordering violation that lockdep flags as a deadlock.
> 
> Fix by moving the kill_fasync() call to evdev_pass_values() after
> buffer_lock is released, alongside the existing wake_up_interruptible_poll().
> 
> The wakeup condition check is the same in __pass_event() and
> evdev_pass_values()

Does this really fix anything? This code is running holding
input->event_lock with IRQs off...

Thanks.

-- 
Dmitry
