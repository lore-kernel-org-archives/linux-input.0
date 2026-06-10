Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD933F58B
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071713; cv=none; b=ZVoq6ystF57pmubpEOtEou6w3NiCaLQR+2ewccKHtC/zzPinYeWErLDwbDlJjXAQ6sSPafSqQKVXP7OrtTUgLDroQRnBKXYS3lwNX/oiY+sMsoh4/vJmAjaZkCFqYZ3r2vSnxvfP/GIfQMOR6AEJnTRIn9e5oqG9SHth7RR475Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071713; c=relaxed/simple;
	bh=oY1V/sBFtMDTx1XAqnER9W6gxlJqUZdbRztaMPb2O+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsAFyvklCiqGAUR+/LEoA1Nadyb/t42CfxA42f4bNEN8ZWv2FbwN9ycSezvxle5EnGOCZnynLWqZYDksVu8Z7ZlamuWxp/cNwRMney2sBu7D1GxhXHAWU5ZEvvlRjPzN3vUpqoSPRH4zzgMm+QvffwzNE6oOZ62Chfj8BorAn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTHlhHMp; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTHlhHMp"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-307263ad0cbso8756907eec.0
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071711; x=1781676511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjirvn2KXnvQdyUKUhtMrVzcKRg1pU58txvCPcPguFE=;
        b=cTHlhHMpkKQaWglwT7Hik0liurHoUH7KTdGh5UzYccFG53WDYqve6A/g62r2J6yNOJ
         1BDzi2+JsNeyaIIuxalfa/K/oorGYaaL9WM6ltJzNG/51Y/cjKDLXuGqQJEE56AXvTKa
         5Hm2bmY+oV4atZb1ehVUTnT8gY1G9kN+v+eImxyRcEY3IU+h704KEL5uE8gOUuI7WBPw
         zPISRda6T2/K7ESTD7Gp/eilz/msvODIwb8WShDjMuzl/SF+VIRgJFtZ+/iwq+Kzp2iT
         UqHhK3WOzdjBEdTGYXxKLizb9cjiE97MVrQXCrtwRHUdpDyjryCAZh8SN/eu3NOVXboj
         6gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071711; x=1781676511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjirvn2KXnvQdyUKUhtMrVzcKRg1pU58txvCPcPguFE=;
        b=OSc2pG+Z6xYZ3bkDYjLJsAVVaG9yDbza5Py5AkEwtl02Anmai+TdrxHA6nbaJybIQK
         VdttaW3rGtrQb9wrhDNiA8pahy1AaCx1Bs8kZXhsWjxlt+9O9W8PTRaU+gc0wUffFSTE
         gQmQlQzul8T3rh4Rwl78XEv0i0DU0uSr+vc8OBJcYRex5XuWdS8qwMUkStae3B34vI9D
         t8Fp6pQnsVyOEYQoEPAu3qTkhcAHgm4mOK39mpIoEQ0Mwl70zCkc4WUzbnoHilMBPCef
         kv713PMfmYM5lQmPMSO2w493M8bFHg2q3ayb+d/00D1ltc07O4ka83pqP3WyD3ywKazg
         REZg==
X-Gm-Message-State: AOJu0YzveRXQwBUB3fQqWcg1HVXlI0TNES811l/omOAK07x6oqbPsT0R
	sDt0SlkCtIn8oCceu8JzYf403mi2YLw6IAPcsQPbIWFaVazx/LCH2lBE
X-Gm-Gg: Acq92OE4e1SQZSocT/4dVIaOUNPgjN9AAxbR50S6wR090N2yMe2BvJbsz2VPoWt8iQn
	/Tr4McZ8n2Pi1xt4xht9zul6JWF7UnuT8bo07cFV9VJUaRixOyT4dbP68MtFH9EcX6IB7TSyyP+
	waL+wPGhDuivDc7hfROtu49DoHn1Yfe8NtRAbCazdCnZce0srVaG3bpkJN3UesPM//QYoUWZFfs
	W11mzb/BY9hgmDgEhF6to4kbqtoLqXWXDdiT8j5zq2VS0DC6vcak6k5HfyXv39u3XMlr5pmf13W
	UWTQu2GoHqY0JHCE0vRFBYDuyT0b2Bykux3yYI3VqUYuLaCU70nbxjWAdPLE1riGZGF8FizLpU9
	k8+o+czxym4GCiTu+VKVt3KoEqZhqaPHk4G1E2x6T8Wbevf4k2t9WvSWB7MrPqojvWHOEKGO41M
	fL7pQKqAl1SJFNXvjXOldj1EzERGE0TT5Htr2fVGptcOVIIjUyRL5pb3DFdeSSGE9Uz+8eJdBr1
	sE=
X-Received: by 2002:a05:7300:5710:b0:307:34f9:cc9 with SMTP id 5a478bee46e88-3077ae88144mr13273344eec.2.1781071711029;
        Tue, 09 Jun 2026 23:08:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2bbf:a9b1:a73e:3f6f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm35755852eec.21.2026.06.09.23.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:08:30 -0700 (PDT)
Date: Tue, 9 Jun 2026 23:08:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] input: ipaq-micro-keys: simplify allocation
Message-ID: <aij_VyUJMJnAaxz7@google.com>
References: <20260609213532.25181-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609213532.25181-1-rosenp@gmail.com>

On Tue, Jun 09, 2026 at 02:35:32PM -0700, Rosen Penev wrote:
> Embed the keycode array in the struct to have a single allocation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied, thank you.

-- 
Dmitry
