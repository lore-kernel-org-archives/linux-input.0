Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCB44D031
	for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988470; cv=none; b=YoNZKIISNpSu5lXMWToP44pW/p+7enrJIGzwiAEAPKn6z/lazWAhMKTItSdLTkpXsrWAp0hny0KutRceWrF8gTD3kq8W7DjBVvOwSmAem2jJO8EXFupocSe275+G7S5cWDqCIF8wghLoucvQN1lAVLsgsZvsKUQfLC5X2kQZmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988470; c=relaxed/simple;
	bh=5xbUDk4BIVNzbUSiG4ZSvSzbg3Q3x8Qxpaiikoa1l9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4kh+dqEtd+9RNZ6GpsYyQkVolVUAuz9dDGnAS7B0Q4qu+Eoqfsh1w2K0H8zb6PfiJ1NKdxE1YLFuGnnEM+0EdhxsTLzNd/9LnriRy1psMIDH6Nt+/z5PrJzOwtL6nGkaj2PJoxtvsFOj48qh9H7c87IwqC+IYDu1YNSZL+KzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO04cooJ; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO04cooJ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1273349c56bso7745536c88.0
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774988469; x=1775593269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IoLdEkaYVMMJfnOPlEQZqGCsah8gjY4MsdTTmPZQbY=;
        b=AO04cooJNI1ZKoPxOcBT6in2spqAGZak9UCBK3a35NW0EPKKmokzsAwdb7jSADrYfm
         +dA23bKYyRFUnm3zf7S23EJMUI9CCFHslgXPNKE+1lh1wZ7xIr8njl52RVsss3yYFi7N
         sVFhoPqNKF49ukbGbb7m7joNyvx+pzPnPbtpuCYIsNL4DOWBCauhuuHyzxl55G5+ixqY
         QL2rQi05nhdDHR/hVdzYkOTCmmLyjRLRJ4IsuR/L1ovBT3V9M6GHNq2U9Sy1gTg7O1zo
         7BpDlXzPqauW1e2vJMRxIZ0Crc1rB89l+5TbWkwhJkxIqd4tVgOdcnYh2gyyb/aNzKh3
         LsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774988469; x=1775593269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IoLdEkaYVMMJfnOPlEQZqGCsah8gjY4MsdTTmPZQbY=;
        b=tTRV2LQ0IF7OEacmpBLFCSaqpIH6JpJIR4jcZO2C3laNKDtceJ0ac9AUc91UmPf0f5
         7GJdbvuksikZa2Nh2phj6cSpYQWbxvxetbh75WluhXZGiNonw0EfR51AuHd3Dlddq/OB
         fcw9+xolswUmcxKLFhy78ZNnczM0qySABReyiagtKevFauDMKerNHi0JTCoEHhdBP6Mm
         FshC/G46CNAGzzQSjzb7YwmJB6XgqRrP73r9oGdK+aE665yLSdtfBpOE08HDI+dQb6ST
         /ywSmdkcC192K2HOWjIanjajb/rAUKmkJGLD/v+frXRhZMSV7T+aIQHN+XTnGRPCfgOw
         TTJQ==
X-Gm-Message-State: AOJu0YyGT2Vv6q+rwIgZXY2YQ5VnE7VebHw92XW0lIsm2SarGzhvIa38
	pJ1+BaN2BpmYHN7jNd00X/yF0A0U1RGUXkohd0B/8AfrGddoQv5EOnQ6wFcy4A==
X-Gm-Gg: ATEYQzz9X5mxURYG9DU2LrAvUA6thprr7TFCcop6JTBiaVNc8EbtWWeqUGTCp6s2yxI
	P8LvBSVCE5HJCql6FuMRYGayUOeJ2NxaGzMooyEgKvkqUcumCH18NlIsowED4bTzdIFBjfQ4fkB
	XbjaIjTdm9XgsCKLco4YRObE6qWnKt9I6WKT5J6dL8pS6dZARJuMHSw7T/zVkTSQj9157J5nY8q
	YXIH6IT29ZgrUCuLBQb97QkzGN349NVfJjeVfKnF0Qm1ufE9rzF8M01RmiVURBLISYK6Ejnk7eA
	sWpG2dqv6U9AMcG78nIde9t3hrcfohuAExw+nXf0tnHrnyKBgatI2+CEDaUmsnjicyV9uhou7Qi
	oZQbmGquHs6vDJRMpSWT8CBz8L8YIFVoudpBJ3Isb1856exqV5sLhnfUfbCugSJD6739hdv2Xp0
	lgyYsxA/9wW6GecNehoBSEA92LDr4C/loWzlC0fpry+/+UTUj9+PTGzDGHpLVR0uMUgE1k5GoHZ
	2s=
X-Received: by 2002:a05:7022:48e:b0:128:bae0:e043 with SMTP id a92af1059eb24-12be650ede3mr442593c88.31.1774988468783;
        Tue, 31 Mar 2026 13:21:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1dbf:b0e0:8ad0:5a2e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c89135747csm2517097eec.12.2026.03.31.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:21:08 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:21:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Input: refactor USB endpoint lookups
Message-ID: <acwskOMBhv9yWkD7@google.com>
References: <20260330095948.1663141-1-johan@kernel.org>
 <acsNayeGbU6cRw3P@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acsNayeGbU6cRw3P@google.com>

On Mon, Mar 30, 2026 at 04:55:35PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 30, 2026 at 11:59:44AM +0200, Johan Hovold wrote:
> > Use the common USB helpers for looking up bulk and interrupt endpoints
> > instead of open coding.
> 
> Applied the lot, thank you.

Actually, dropped patch #4:

https://sashiko.dev/#/patchset/20260330095948.1663141-1-johan%40kernel.org

Thanks.

-- 
Dmitry
