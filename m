Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65302459DD
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623936; cv=none; b=PWdTeXkvMtwGn2AWxOF2DSKbb8rcV4cLkWNnUdcCpHTkgbtzqeFtVAbGvOWQajU2lbROqWbq3qPVa23j1N9Kxv5GepsSar0BmOIXm82hoQdkTIbS4MvPJ2b75kdXj4IVRDKHcQmVxeMoAaoOCzO+NFaZzGa/Lpr81SCtuRDN84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623936; c=relaxed/simple;
	bh=hPt1M2a0e+3ZAXOzl5YwUYXekAQ0Z9YQj0Eq/wQrYvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIB+eRwrRNVSA37FFaJDFywDyvqIMBxsZ4NdU5peBVWtnkqvZ4zXuxA8JZxJnQVD/PatDBQD8VbR8+RHmhq164f6wBFK7Igjf0M4X+YLTb6BoPwcxNL/WM5VOo/b2ZqWmnqE+ZTPi+zhWTrIF3geZ33CK8+CykY3TFXeJZOK1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfzwKg7J; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfzwKg7J"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso6076187c88.1
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775623933; x=1776228733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDgChiZxCMmKoaDNFzAxAMKQ9VnLkJ2lK6MWhC8hRc8=;
        b=QfzwKg7JOrz1voBmfbrvnpYR0qNdlV2+cutoKF6iQX9yxG9DWoaHKfsKkoVL4Mkheq
         RjEzOWiP2cDjkRg6Nlg8hJe20vmSMTSqYaknzSREnzEzhpf4SL6M6SyUe8GbqPJQIY1J
         /1Xh+TtkibW9UWdfYb3Trs9XTJR9sHCK2SqlldkR+hAFJJThHhaATUBFdGDhDh45ysao
         0T5oikJGvJ6KtV/yf+BeA6cUo6cv8PPrqAz0Ov2FRQL9hUWPZqEg9LfeRYNITxlURpRm
         0ZLGNw2FxF0IgGdCdv5BKHD7AWcFxpT/6gz0GaIuQn6VZCe1XgDroHHHIo4LG8lMRvWa
         1+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775623933; x=1776228733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDgChiZxCMmKoaDNFzAxAMKQ9VnLkJ2lK6MWhC8hRc8=;
        b=XYhGssk+72d/2tdq8bHSVPGGPUqA6VZs0jzlU75sKN6shhFvSjOTFDhFHl/GlA8F7N
         fRhd/VsgciiAyHrNN2gFz2W3O25h8TPxCaWAR8moHelYrffFhDYUnRzNKGAtslj1Nc5x
         qFL3bNl9y7UnE3gBEZ81iswMQrG3UHjhRXsdXVOR/5NkFRKjyvutsZnBXPaTx7PZmG9G
         DjiUVSr3ypgCRAqlpHZJpeYFIDl94IYdNA8SSlewuMMvgzarz70Rjsgtn59q14qMjBl+
         +8m0+oBBubZMn3geMhLBp5bkA5foV8VQpzmVwtBxx77hlTB+5NYSknVvEDUMGjTADNkp
         ojgw==
X-Forwarded-Encrypted: i=1; AJvYcCVF3353EINwSafYH+BEqNIWZxU2NySSovl9o8uSQsu6EvAvjbp9jwuYhtRbTPdz4wvSCcxwkBPQmkRNWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOIUKaS76na7IWYK7vnfXsXLfdrZJW8CrPBkiEptwQaMVq5Si
	ztfXpLtFRFJRrehWv8dw96SVzhY7Z7hPCibQGRXXzvEh56csxeauXv1l
X-Gm-Gg: AeBDiev6Oc1gx5f3slhMhEKcL364Jyft7dAJWVpZRkr7y0BE/KBJ5o+hNzi33BGFsLm
	0ir1QTKkydo0axnv6wR7euEWWyeQ/CAHqsv4sOgQIDYf4A28c9FvTYEWy57m5Nq9weVIbvWPY7D
	SsbPCRvp0eXBma12iv+epYGXDkmK/rneDUxyqlYodAtQubv2QQZ5MUEChy0a8c8pCp5LZqtwIW9
	lUqdMVaKCFXdZmh7/2b3ZW1Hyn4jSvuA1GBKQS81xaUWYOGozVwW+hctBBRP4v2uNJqvOLmqKGD
	YtvY1XgARwjaXmpeoy2WAPBvD/lC2/iUm/GFY8HwBHdzwJxw8wxEESeKefNyinaczG/XWmDxw+G
	jADMPu7d0y0j9Qdv4hnTf5iRHPRllD/d1WqTuM5WKQPHdY6HuiedCAnnyM8k/bNYWj/ONyerrWy
	HwyvYQKThv9RQTKuuTsEwacEZtrUkxeeCyY837z6UnNOTwfUaAfnPxjobP8rIE/S2J0tBeEt1zM
	5Y=
X-Received: by 2002:a05:7022:10d:b0:12a:796b:7cf1 with SMTP id a92af1059eb24-12bfb7458c4mr9659532c88.23.1775623933418;
        Tue, 07 Apr 2026 21:52:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4faa:4b67:d989:bce2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cae9e9esm19044914eec.23.2026.04.07.21.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:52:12 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:52:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
Message-ID: <adXe452989A6k2PJ@google.com>
References: <20260404083928.489966-3-sanjay.govind9@gmail.com>
 <adSJp5U47g1JnImj@google.com>
 <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
 <CALQgdA0UpJb7Lztkts3LrFtWrAP3V3CivFv3NKJDFg1VY_q_0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALQgdA0UpJb7Lztkts3LrFtWrAP3V3CivFv3NKJDFg1VY_q_0A@mail.gmail.com>

On Wed, Apr 08, 2026 at 07:22:08AM +1200, Sanjay Govind wrote:
> On Tue, Apr 7, 2026 at 4:46 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > Sashuko correctly identified issues areoud re-scheduling work that
> already completed, please see:
> 
> Is there a way to test a patch against sashiko without submitting it
> to the mailing list?

I think you'd have to spin up your own instance for that...

-- 
Dmitry
