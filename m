Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208538;
	b=jQNJDvwjPury5yCSYI7U2yUUZdPVY8pctGhyDnABxLcPQ1no/G34Nj4ue29auHIXYX0Z
	 JxoV6NWTW0EAKpBeTDiIiPYaYz5o0GYlBYa9h8U81SG8aGNovOmdPJ++KQ0Oba/Ii1spT
	 odLfkPpoFJkA5pBY0u4dc25BdN0vZXI7yvtvfbC8T6hzPPWE9U47kvxmcQDOAPTFF0Pgp
	 JMmh+O3F5Dw13CB9ATahxCGOoQ+E2C14WpNdCC/3WfyYtzaTxoBQ+VY8D8fI1xbWsCcZH
	 MsrWWQy4iQ99VALZQi1dYChZGxhMMWomphfnptv5W/SSNlt/nVLRuBKk9KFqGKZYaQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IHDmqb3emIFmJ8fO9uRNFSu9XBh3Om7oI46gLrUcn6I=;
	b=Ca6ZQa68utidmHFZQPQs25WOGQKjbJVFmAGjWXsNsEhxcjd+iQXGsBwZgmZSI6qbp+GT
	 CpP8oVr+7fKxsD4FolKBadTEXqiBQC9VShxNiZKVkJKCGiK8m2/jt7LvBG38U1l2TnBe5
	 IMHeCoYj60syqVwJBdnmz/BQ/aqCnaictTI126No4RMGIEx8FYiPFi2JvdD2fkup1F6Ye
	 A16hwlI2eoyAx3DbSpY1u3I1hWl48VWisSBTqtZwQWh+av02cGR2DmDLajldgZSnkcfOm
	 jcJz7URJGjKQKJmbqZLzssuIB2pkwS07moysAhYyd9Nw7g2ewV1JQ0AD8mQF1kQV1+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w11j6Mdb;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E6606A322
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 947E6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w11j6Mdb
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1100843eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208537; x=1794813337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IHDmqb3emIFmJ8fO9uRNFSu9XBh3Om7oI46gLrUcn6I=;
        b=w11j6MdbsB4L+lfEhx9/QuPWJwJnoR1/635ejpDfK+LKom66v1X4DvzF2uzylOTZ3/
         Q9Dj95WkZTzj1PFghbcdCfk34yVFx93MMJxz6Fh9PQU2AnN3QRpI90c1HeaM2Cv6sZdy
         xBne9KiUAxZ9zou72Cnq5p5hXQgOrGnWF+hOz+swqgKABD2dQlZjeqQwhEaAFPH2TQH+
         lOiMp873AaypR3uky3pBLXoqP5rSu24uKD+dfdobZrN5JZcu5R5G5cAKOY6v8MJcA7uf
         JrcxMfecrYw4AhM5KcvnGA72DtPG75dQ+8Yk2j/IYMe5Sjmbvxv0MbDYcQJ6+wEX7rON
         4prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208537; x=1794813337;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IHDmqb3emIFmJ8fO9uRNFSu9XBh3Om7oI46gLrUcn6I=;
        b=wVGLIF3UoSewkSKdZG03n2GYzV19xBjZvux4tm25MiM6YwhwtUhacPRlf8vcqhLsjR
         YkrQ0/mmQ9Vz4HkgxVNk1ogvmTOoBPN5+AJKLe+r4d6ha0tbLTvxiL0jW3u5v1PUwt4o
         MkLgtbq8AR7Ic2YNwGES2I58D7D3sUVrNn+mXrQ9+AgPEw/CeyBQ4RIjyvdvt0m3yVlx
         PEgw5h/izi2HNU/hM5E8O2RN4OYpTrP5dDmHbesZf1ypkiBqAnXibN5g41t3bLtyYJSY
         LdYBzdNztl+nBvwWdNFLiKQ/a57XH4yNRefM0QVh8e/6LXSKXFz7JTKOMh3dA9FyhxvG
         1dCg==
X-Forwarded-Encrypted: i=1; AL+hErH8qTfuSP14GoFnDyWiyVaT/nRVlKpyNn+SBi4CU6pwUq1DyrqFtc2Wh6M9FUWatUOcgkudrwrlG98Prw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zH+frW4HZhZKspWRcDc23JH/9ntLIgG/Hk1QY4o68XbZajCFh
	H4EtvJx6G6aOGJR9wiQqFrNOcqCxIen7nn1/4Fr+aKCT5qFIJnLAbjmS
X-Gm-Gg: AYBFou0rVCz6OqzE5SWzDlrAYB98RZeAmvwBRkCNBkgAKoprobeNCgFZ0LXPmXIabMX
	blAcsMLwHMiXMZLAspY/3/CyldOshTgN57P8dpvu53VhpSzEpCfFBJyDaQt8vKKVX3QqzZL2Lff
	XQ+cPx0oXngOISLiKWR80vDodmFSjLlqJORd2RJM2FwA++J2ahH4jr2U5x0jKNHgh9LdsCBvRjc
	egO/bmGIKJidgZSm0qXQo81LCy2eRI04e14vEWyKdlNO4Hlvu0b8n0cPJ+Df7urqnVuCZIcQYtA
	Ic+9ri7vUp2bufv16T10D9b8GZPt6B/paXjn+rrq0f19If8+IMv7+yQliT/BaeoTfi0FqSQ/Vke
	fWHoqk5VBodKp9n5uodrMlj1LdjzNDuzg4YZYoEvaAs4vjo5hG35M43i6f3p6KsPR502xaJkbRk
	y0Rhy/7UAHF7/V96TDl+prEMGTvOaWJ3rbkaahspS1XKcgwgt1/+d7njklmKOttYTEpqfSm8rNS
	CuyDu8D/3f1r/GYPFIKSYgdmVxevsl7FJgL+aX8oVhcSj4XXLoL7uVhIKkgjmraH2vs6WPbGFjQ
	00+zENn9QxqVw8XHOj82G+LH3NOYwRJJUPs/RfARxa0OJ9pmBOTt9daaeVqMo2d4czfk
X-Received: by 2002:a05:7022:3c03:b0:147:a685:9125 with SMTP id a92af1059eb24-1b39fe30253mr4642534c88.2.1794208536573;
        Sun, 08 Nov 2026 23:15:36 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm14607158c88.1.2026.11.08.23.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:15:35 -0800 (PST)
Date: Sun, 8 Nov 2026 23:15:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: Hans de Goede <hansg@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
	fangxy@xiaopeng.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - reject a bak_ref length that cannot hold
 the checksum
Message-ID: <avFzEGl-xQxGqN9p@google.com>
References: <20261106075129.3106093-1-liuc63@xiaopeng.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106075129.3106093-1-liuc63@xiaopeng.com>

On Fri, Nov 06, 2026 at 03:51:29PM +0800, Liu Chao wrote:
> driver_num and sensor_num are taken from the touchscreen config.  A
> config with driver_num 1 and sensor_num 0 yields a bak_ref length of
> 0, for which devm_kzalloc() returns ZERO_SIZE_PTR.  That pointer
> passes the !ts->bak_ref check and the subsequent
> ts->bak_ref[ts->bak_ref_len - 1] = 1 writes before the allocation.
> 
> Reject a length that leaves no room for the trailing checksum before
> allocating, and skip saving a bak_ref that was never allocated.
> Without the second check a rejected length leaves bak_ref NULL while
> bak_ref_len still holds the bogus value, and goodix_save_bak_ref()
> then writes through the same index on suspend.
> 
> Fixes: 09182ed20c04 ("Input: goodix - add support for controllers without flash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
