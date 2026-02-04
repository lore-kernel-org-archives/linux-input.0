Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DCB32B99F
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209936; cv=none; b=L54GVoEeGVdBaAGrmARs38GgPIOJpml/v6tXSrbE2oUsb/7uBCxl6aRfqOydmgHAM7JG0McXstjPpeaviswdWvLqwS6I/PzrCNMllGwS2MgFOqUhdSJ5KTqJvBbTjJuJ79IDk0t7xvBv4NoNrgl0PHLSXx0D+M0pLc1RU6ZN0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209936; c=relaxed/simple;
	bh=57Q0kwm92dVcG0YliZgGBglpxNiTeV8kAqLQA2O64e4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ru2N0a700D6quXqhfUIwAp944Nz7zSpJXjT0PCLe2jq1WpiYthwahWc0JGEd1YGdWeaTiXnbKB4jNRNWgyl8w2J2DmL/jj5sMfNBIl8sO/RdIjgV69RMtpReiAsPblp8nARCajBJt+qXPj+MSGVaRA8S927wqansPqF+ppZjrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuCMxX8R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuCMxX8R"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso1878635e9.0
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770209935; x=1770814735; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=57Q0kwm92dVcG0YliZgGBglpxNiTeV8kAqLQA2O64e4=;
        b=QuCMxX8RKYR+M/Jh/XF2wFy1LOGuzifnTqpzdg7sD6ibHC3881tM6giEoBh4NIkLMR
         RdCY//OcayqQOKvQWpXOSMLiZLqFwT/3ivlBgXX5i3GalwNrTqG20c/lhL48DlNNeNai
         4P2sp0vkEYUkM3WuI3O/lOfvqxw/RDSGAa74UDMlO3Huo6uAx7sjqIP2Hd/b/ClNtaUQ
         VfoH5abnWwm5YlTz4RMio+iLHBu2lY+PztK6sMy7uCxepZBjrcLiDDz9SZ92gPSv0Wpa
         SMYJtUV9Z8nsV9yL7srQs0K2J1iiVjRRFLf2293fDdSo0EALesy5JkqbWxBASFlrSY7C
         QAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209935; x=1770814735;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57Q0kwm92dVcG0YliZgGBglpxNiTeV8kAqLQA2O64e4=;
        b=ZZXuacei+wFBsiFJedeMlbIbUy2ne8miWgXUL29hFr359m8tgpKJEefGlzv3k2sYYo
         JnjXrwAtmuZTf5XA8S7YZFZr6MWS8KVSMD0aepkPGny5OqiYxy8IfCk+AQ/w1QhMOeE+
         MWLg/x5W2tTKPd5ZCI2DVPumNETJvjZ0dQoJge4E03EdnT+U6GCkeJ4e6UkRu2fNu/lD
         cU4zCORQ9+yvtw4YAFomtYcof0zTVVBx7kZx8zCq4VEkCnsL4bnbeA0wG9aBPOdGB/41
         3ztriVVJ0wpiYK3+yx4VZ0dQve53Y5h0zh0t0gmhDgZGKfg8I8bSU6cU/2w29SP9TJBO
         vebQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8LpEKMVUZORO5XxnlHOtMUrsZ/aQu0Qr5smhrLxnjasqIADThy55iktOKxKIbOeCRbvp3TvPKftPVfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQrqcCLrU6QEhPK4QVJtjDtW5eAuVpwjwIL43AaJJR5NAjkc5
	aQJdnrPsb00gSYfCn+SMvOz1aHERhAQVGoj5eyQ33JfHRF+IPflJS0Cx
X-Gm-Gg: AZuq6aLLv1fJrgAliFpqYA+2hx9JE71/PG+fGkIowALQBfey39BHly/03Vi7of88itw
	2YYx08jJ3TSwTO2VdIjBSc83cEHfJhLd13ee9rh+Bo9FDYheex2+Gwxc+CBXj5+/UtXqmQb50Sz
	rm7jcFx/+wFUbAdfZ79Ca+2Bk5tFk7ZJO1qGOFiDu3fbQ2+t+1P7xfOzBePY+B3WDtm2KfgRRfN
	3rlSv99DzYx187OYtyoM35Jfux1oJF+miJdK6yGJk4SzoVgM9sQa9hSoxmEnqmJMecpBjM5uzKC
	yDcVLl5KLLkyVZXNShpui3uF0ZkpO4z0gVEK9JZEC9b+EdAPs1sgD0kf5g5k52JL2PvmTusVkj8
	Lws+XNG/pHiORGYnDIPQbV2qVnI5uSuRVf28tlFAt7+fHU4siLPprPaTzkOzruoXJgtlzc37QaS
	IJoMMuzy6XMuti4G8fSavQQfzghi9ulNFDJqYsUcxPTPkHPyie5ooIjnDfoBHaVnGs2fd/Xfn2L
	pHQXA==
X-Received: by 2002:a05:600c:3e1b:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-4830e981f9cmr23205715e9.6.1770209934567;
        Wed, 04 Feb 2026 04:58:54 -0800 (PST)
Received: from ?IPv6:2a00:f41:4842:718a:3ac6:8cea:3b72:7d9d? ([2a00:f41:4842:718a:3ac6:8cea:3b72:7d9d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm19300975e9.19.2026.02.04.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:58:54 -0800 (PST)
Message-ID: <3aefbee8ca6159ef9dbc5356246eae266bb6382d.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: Fix condition effect bit clearing
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>, jikos@kernel.org, bentiss@kernel.org,
 	sashal@kernel.org
Cc: oleg@makarenk.ooo, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 04 Feb 2026 13:58:52 +0100
In-Reply-To: <618af8dc-7698-4335-9d0a-fc7ec36cce9f@kernel.org>
References: <20260203174241.2863219-1-tomasz.pakula.oficjalny@gmail.com>
	 <618af8dc-7698-4335-9d0a-fc7ec36cce9f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 12:58 +0100, Jiri Slaby wrote:
> You could use | directly in the if, perhaps with a comment.
>=20

That's actually pretty neat. Didn't think about it. Thanks!

Tomasz
