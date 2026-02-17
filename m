Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E782899
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771304911; cv=none; b=eVKDBGK+v1cHOEP8T14+Nr9URShFQ1a7ObRLQZ7QP6j2JJQiwVs9IBS/GrwnGQ0R3GM0KeC9LnIKXOKtyI3YW6BEuDWa2GUAFRpKFdAVZToh3RWSIOXAcRR6kIJWZ7zz5a250TYzfezEKI4CYEbdJd9v6fKK7vLUmNGZVKkvzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771304911; c=relaxed/simple;
	bh=3JD+c++hJT4qoKXobq1oq12iHVWseMDIgptOPVK5d20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7hJgCEqiLh256mrsF3PypIGuVhL6OWPEqbpkPcc5Qb6btmL2AivAuLLM5G+NPGvFqMppSZkeDoaSykYznSSnnQisSmC5KfZBzpqGUNoWmsJlDXaFNNaagKmQrOJc0U38/oHrFrS+03feBRO55zwJao7MTt46ZUAtlVVNrq7ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e59h7SDj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e59h7SDj"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb3fb47559so376049185a.1
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 21:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771304908; x=1771909708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JD+c++hJT4qoKXobq1oq12iHVWseMDIgptOPVK5d20=;
        b=e59h7SDjohWx+3pwYLCQo8GMYWqXMKZzegN347aHJblfgAnioG824aK2uhqXPJI+3y
         S3azd/PyVMS0IEv6ydqlbfO4R9Rvd89j8cUBJ/okSzSHmmm7JB3WDzhqhAZuEq/u7HDi
         K7qcUS8ehU2nS6YTQdLlzKJJLl9AhgnHEm1ReHAsjxsgn1tneKvVn/6IsLquiz47MwYR
         M6oJohsxukPwst6KrQgXoWQt5u1+hGR2VMCh3M9CtmNli6PM5zdgtavZFK3/LmVKueZ/
         kuXjrjXmZIiCsqKJb7rhR+FG5uJVuCsPgELAZClLEiXjuTPhjTXs5YzHmwXpXwwnYdzh
         xHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771304908; x=1771909708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3JD+c++hJT4qoKXobq1oq12iHVWseMDIgptOPVK5d20=;
        b=SLqViP4dMZi5bHafEl8dKFZnCrbQlsoUMnTxDJHok5WYKYTZYyf8HKIMetKcaB8Avc
         VlxoB7kEUJ75yfxVCThASRoCCh8U1RI0AruPpdiSQ108OEtVGIk2S08UZ9hbQVIaHeqi
         uKEJtYuP+RNO8te7gIp1cR90Sk9RdbS7Y4BbEChSX+XpTjM6uYy781SJAX7XSAxOB9vv
         pcZXA+xx34e6g9WM3NmnFWHJC9IsaSvgAONnWmd0AjMft2vYMSJZqPvK8UtvbUwCbPAJ
         L3CmkPEza8DAi6WbxLKLiK6q263+2Wz9UnILObFz04YCcrXOc3Z81en0glC4IyHJNSvH
         XRpA==
X-Forwarded-Encrypted: i=1; AJvYcCV61O72EBhKc2ewDA4R6c/Y6z1PEaWPiNFqwOEiuIf8QIsAMX9vgyok376/cSZONLwvQeqJHd8YV3mVRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfy+7Qav0zu9HiZidGtTlRkfM6JC/33L4NVATth4If/mnP626E
	Q8JfBburDu//LWAPsH8WFWM3TLIBvt3skkCDB10yTwSeG+oqYOhRFHyj
X-Gm-Gg: AZuq6aJ5EZY143p4HApZHlt5UWF9X7I17cwbP5mgWKcaEIp9rXJeACSiMITIpjaVre8
	Aq/pDRRSO/3dGWCefo7QLUWy8so+cx65YMxaH1u0kdqGbtmkURhopWS2Er/AG6IxP1l1VYzVYve
	FMTStgOAfIsXTk9vnyRJQOUmySnyQtGguVhzQwZWBV4izTuKOUNTLEsKm3SYjA8U6/pSkWekWgZ
	VRv4osQM/VkjFMbyhEl+nmURE2e7p+tHgCdlnKp5SDLHxg2x9+Aqq6hkLxjhnQbWrO+ByHx5sNx
	6j3Hf/J364uN7D+YLRgqLsbHoVIdUcuUuL/+ZYFAvC7g/5gnf++QHMpCzwYbr5wtL0/qrCjmMY2
	UP619Ra7YKX+FOOtDQS2BK6KjHYBEdC4SCsrvjFajIdRtBi/I/tCUMt4AwH1T2nkC9ueaLBhHei
	fAkeE+HtH/wSzr3cki2+4nO5gf6wpjmhI2/vQTu8UxaBrggY0xyhKKv/DQA0w5cw486rjQva4IQ
	r3Z7YYtGA==
X-Received: by 2002:a05:620a:254b:b0:897:56e7:6aa3 with SMTP id af79cd13be357-8cb4245c867mr1589901085a.56.1771304907830;
        Mon, 16 Feb 2026 21:08:27 -0800 (PST)
Received: from YAJAT (lnsm3-toronto63-142-117-56-201.internet.virginmobile.ca. [142.117.56.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cda8b1fsm156461506d6.37.2026.02.16.21.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:08:27 -0800 (PST)
From: Yajat Kumar <yajatapps3@gmail.com>
To: hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yajat Kumar <yajatapps3@gmail.com>
Subject: Re: [PATCH] touchscreen-dmi quirk for SUPI S10
Date: Tue, 17 Feb 2026 00:07:48 -0500
Message-ID: <20260217050755.16078-1-yajatapps3@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <0840e4ec-0b61-4e0d-9d67-d0eb2ab2d6a1@kernel.org>
References: <0840e4ec-0b61-4e0d-9d67-d0eb2ab2d6a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans,

Sorry for the threading issue — Gmail broke my previous reply. Reposting confirmation below.

I’ve tested the attached patch on the SUPI S10.

The touchscreen uses ACPI HID GDIX1001, so no change is needed there.
With the patch applied, the Y axis is no longer inverted and touch
input now matches the display orientation correctly.
You can add:

Tested-by: Yajat Kumar <yajatapps3@gmail.com>

Thanks for the quick fix and explanation.

Regards,
Yajat Kumar
