Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F358385535
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362353; cv=none; b=C9WV8U40Yylld8T42yA94UImP+BZ1Ki0pOXhB4hmciLZzYvgQSjECzd4+1mozp1IUUU0oBjkE3xj/0M8LaOtMROP5bnd5VtML3vReR7F5wlQhIbJelsIgtyY1NIvDruqdLKSvYSltYqFCPfHg5lkAs3gk1WMns7Ax/hlNf0Rgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362353; c=relaxed/simple;
	bh=voK8DUdUCME69aJRZd2XCy1pqD6n8sAAC3J0y5qKdvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLL5tx01LCT6+oo2HYFpVPNumaQF6/6TVOlrz4hYG4zb29BUmx6IdcnmLlMFi8RiWW0L1VLp+AhCCiymIbUaOrOPbT+Z4usRob2NuDdl+RcgO2+CCNeem2OfUJZrcZpNFRcNOyXqH5cK/LAUf6oMY7Z1n1vTOTF0q67p4L+FbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GBDq9BK9; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GBDq9BK9"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dccda31d3eso819343a34.3
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778362350; x=1778967150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LD23X1TdnWGwFEDsUfZjC98+DXkwDueIkbKGnRdyHSU=;
        b=GBDq9BK9odyJJ75Yp2S9LNcZUnDOU8C5Da0IDiq6XB9uZvbj2V3JZjucX09YPLxHw4
         OCTmXHavGNUfE2HM1+RG2TIjM8zSOxVAcAVXDjTJox7NduJfLJXNHn0GdK7meXFy1+Hd
         +rVlHTh5p6PCYVnvULRZxADoa//bdxL0QUtb4r7eyv8qyZJju7J1iPiRwtarTCihhZ6J
         e2rmVlQWPnchcCgO0bxhW207ASOym3HjFL+TEIoZRkNHgMHm9vE0TG6nZvvlqdiv4Xg9
         nZuUqY+O/nlxLPQkA4S+gm3li8Sfi+y7uFT2xgVdMyDHTiNfts4GpmFg5w3qrSFOru08
         tc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778362350; x=1778967150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LD23X1TdnWGwFEDsUfZjC98+DXkwDueIkbKGnRdyHSU=;
        b=rhg3yNjjlJZdqYM0De8FfiOM259vozrTHGGvMXtC4MMfq/zqXw40eH9vWJ5drDUXa1
         DPMFXIY/N6XFPreBGdNepV19/cln4MjZQQeI45uMCdv+lMwcB7zwnJrOTRBuzgMGFWBE
         WUvsRUf0DPnR03t/nz2gI+3YCqbQnlAz2g5FWAa3Hnxcbkr7yMydDaLsiVA9WZaNWx2b
         kkWFrn+e5h6r6gSokK5Negz/aO8AWGez8+VprB1xugzPVlf2FJA8bP1aMSMufCKx1xx4
         wfr4f5n7maHtN+OUbPT6/fCqCh1UDiZuW0bbUfMqlNFq4h+SatLl3ga1dZtCgyHxG79z
         6uCg==
X-Forwarded-Encrypted: i=1; AFNElJ/SL1hEu/1NeJbyU5BzrDxsc/gKIIBqUro/9FvjpwcLRXlh5AhnBIesh1EjqPluZUjieuYJGKC7sZ9BhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZp3qBGc9YB+wauUG14q9aadMGz8v/+Enu21Dsj4TGS6Q3jlfA
	zaQEXajIDhPMEJGbjSfN2j78ZqAyfvKH98VOk1b7VlK7hzPMKizivFf/tOLjkwPunCw=
X-Gm-Gg: Acq92OHqYevDBY7l9Y/VX4wYBTQqZlHG7AWfpwcIXulnMdlBgI+apAGpwtvnFwsv+rl
	vNcCUOKAo2PP4msqOIpNg5Dbl6FsZ9BBWs+U3xPRZoRRg4wpdthaaVe1jeZiOn29xpe+Y724KSX
	kqfdJ2ybD1S7mvTylIFjpbe0fiZNsMJS4MBBdiR0jO1OMZQEu7i1miSGvIYxJNaYEegKJokOnxU
	M0xd56FxGnXSqD/kW35JH6A4HnAno40Mv2kANftlNIdz7OFGmQL+rImk5EGWtCPdv8Cv/wJKiT1
	TkCOilUeGDbwe/wmELROrQmcI7HmMM+ye8NBSIsH8IDuMLTHrdNKqdbq76qTqu1IJV/8IXWyoPM
	VTtfiQaJ4iM+MufdsiPxF1phcakq4KmlPrMUIAQT3ikvwzqfJb1r4VcJVLOOWolwNSZx2PrygkR
	q7OPpwtaf8ohIkFnRYhIQh3mHVl8QpLgzF0JjlE/93s0Y+mUhlzqcyfRnezoIsYpeeKbhKTRXmH
	w==
X-Received: by 2002:a05:6820:290f:b0:694:a362:e3ba with SMTP id 006d021491bc7-69b36d989bbmr2085922eaf.48.1778362350132;
        Sat, 09 May 2026 14:32:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435571099a4sm5184659fac.7.2026.05.09.14.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:32:29 -0700 (PDT)
Message-ID: <11f2d7f4-cd5e-46ab-b11c-249a30a53a07@baylibre.com>
Date: Sat, 9 May 2026 16:32:28 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] iio: hid-sensors: drop redundant iio_dev argument
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-2-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-2-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> hid_sensor_remove_trigger() uses struct hid_sensor_common to release
> resources acquired during trigger setup.
> 
> Earlier implementations required struct iio_dev to clean up buffers,
> but with the current code this argument is no longer used and is
> redundant.
> 
> Adapt to hid_sensor_remove_trigger() API change across all HID IIO
> drivers to match updated prototype.
> 
> Removing it simplifies the API and is a preparatory step toward
> converting the trigger handling to a devm-based API.

The subject and commit message don't make sense to me. It looks like
it is just removing an unused argument.

Code looks fine though.

