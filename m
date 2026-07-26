Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5757625
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785028602; cv=none; b=pw/OZRETMcy++iGa7JbnrFYZ2Jz/9T/hGVwkmvQd7ovKjD9+RmDcoXtM+o9+E3ijOVYsTtUmCBxZydcYqj8rg5JJmsSjbkJqb3oIXzPsajsz5nhyPkg/UTEWHNe4lIlD16ijt4TQZ+0IlRnorcl9XQiqFjFJl4A53JY9/BOK4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785028602; c=relaxed/simple;
	bh=UPXij8IYyKVPvo8irU4ZItHRkeLkXGFpQz3crbjjeVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AprcnYW8M5NVcj4OwTZprxVxTcBWwX9Vkg/JPesGsH43NWXFZ+tEMIF0K/kEhVLUyPd6sDvvUGmL8vsgyuL18s1ZlYodSNcS+uIYQXoNL7GpqdS4XB5gVAjKYLzO+IkVhpyLowpgaiEKTt2vP84zCdiKVuNNxJCkGuUSiEejRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4AX8oaM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4AX8oaM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1805567a91.1
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 18:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785028600; x=1785633400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DnNF3zG04vHIFiehZsVh6bXsWm/e2gxI7V111Fkc4Zo=;
        b=r4AX8oaMOAoWp+Q2IgoJbKvHpgF2SOY6NcP1xhRp4SgZOjaO5HeE+vCT+rJt2Ckk2g
         bjJzxM5UzcYWsNsY6kBF4s4n+U7+uXD3OT68l/fPsbP033DWIP23QRoemaKq5R5//A+M
         NH9WMBLHBL0K2NrSi3MdslOr/5mN0GvrkPyE5UEUUqgw8HqH8m0DViPknhT8F1RpZBex
         HqKB07WrX5rfWAQxrlNlGMFtIZaereDaShFdEnT3igyR78vd6EaXL1m2gizJDLL6OYwd
         /RBIk/fHQ67MjrOh4SSH7bo13JgB/LjV5KULASDMBhyVeIKDOj+ZSrsfv3Un+VtMgX/9
         Y0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785028600; x=1785633400;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnNF3zG04vHIFiehZsVh6bXsWm/e2gxI7V111Fkc4Zo=;
        b=gEv1J4TW1bIsVyXWoLHAGVI6MO8u9JZjKK+mzzfwoVypkSzBCw8cwS8NYcUeWwR6Gw
         oV9QgrDRqRAyJdcfojg6/sJ+MK8lRT3FUlH9LzPHN+J+Y0paWQPsU3TOqz5TaOqNibq4
         6Z9uyfhGicHdlnGtVAPxc8skDNqGQYN+rVIdgQlLj4vKb4tGEgkmprHhXUzLNkM2Ix5L
         G8rPMUJSmgRMjjrMVws9YJFKOFknxu5xkJ0ytK+xBnzFdiQ3b0+MDVo4gLL4BeUix8T7
         wygI6kTJt7GLg8ZiI3H8DMjWmQJMXoLyoJPvuR0lwPk/WpBhmW8GsgoldfuD2YZho3/C
         QyNg==
X-Gm-Message-State: AOJu0YywhDD3w9FYioiGu8GJKN6rw0ifuyaJDo81jpldCqahNjs54MJU
	wo7gHZvnnpRnImIQcrf6mh0PvSylLElKE4W22TSgIlf24Anm7qRfcTmk
X-Gm-Gg: AR+sD13ySFvws0MQsamp0KvLk9qwlYIY+c+toZDefm0BCec1trpW/Z12jkJivDYMW4h
	lbWGUa4ODxua5rj0l8Z6XyO30kNVxkTPXCDEUifxV5aYIRdbyuuWhvxxUAM23jlvn6diU5FXihZ
	yFxorCVMUxvEr9K8n2YEQdjm2eT5Z2DahnkmQ8otEaYQzJ3W9k0JZ1pvy6WtzlL9AayhJ8lkpEt
	bO5+YqAeGr2zGqnUsbSTOpaFPkpM/LKCTshV3esMZeI7r7UFgiTnmWLRa4CyCgXzr3+4BIGjAeg
	VggBgprsYPiriOm9QjSHH+GnkqZOJTPPGSpbPRSTv58nDwPhfFL5QZHxNQyZZoMGHLeqCjk+YOx
	fXxGToEEeFo8BOvSdtiPwZCLurb7xTbuxpskMY20W/fMuvfw62fPYVo5MweAqXZzgmF9qr0rGXr
	qlt+ppOKZs/4TmT0SA3wNGzz6cNUFm+ygKnQC6Ai2IUQRQrYo3EZbGiw==
X-Received: by 2002:a17:90b:3bc3:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-38f292657edmr3452200a91.0.1785028600014;
        Sat, 25 Jul 2026 18:16:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e2c2:1f24:32d5:9d51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm11899050c88.8.2026.07.25.18.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:16:39 -0700 (PDT)
Date: Sat, 25 Jul 2026 18:16:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bivash Kumar Singh <bivashraj750@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: inexio: replace printk with dev_dbg and fix
 missing space
Message-ID: <amVf7v2vb6aA4YuQ@google.com>
References: <20260725130803.6763-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725130803.6763-1-bivashraj750@gmail.com>

On Sat, Jul 25, 2026 at 06:38:03PM +0530, Bivash Kumar Singh wrote:
> Replace printk(KERN_DEBUG) with dev_dbg() using the serio device,
> which is the correct logging style for driver code. Also fix missing
> space after comma in the function argument, and remove the redundant
> 'inexio.c:' filename prefix from the message.
> 
> Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>

Applied, thank you.

-- 
Dmitry
