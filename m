Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881241E6DA
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648437; cv=none; b=rHmB1oKw+Lw8KCYMrvkHf5PkIkK20SStpjZZUwD4DPlaJK0WsSNeQFKdgIPHGuN6OG0RC4Ea9i1bIesjF7fC99sCiPoXTmybRxWAG/Bwze574wixDEQgDp9qmPZGytNBUiE/YWKg7/PAnIFi8WTJwaBIUqONBJ/Cgp/zgEv3zXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648437; c=relaxed/simple;
	bh=594mSRa0tVsaaM0m4Zz05Ycb1HMWNqxXdGycPZ2r0sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZnNKL0iJyCa8V8KgdA89pk2Uz6zZCZ8yusmOQ06geryXu+j+LX+4SVVy+IyxYn3LXZ+6eosONg1Y9EJNjuhs5qw2qrZ7O9+j2dk4FcjkjTBK7oY83Glod57MsJDNDIm+F0J7C395NjMWl7ZXqJJcydZey9JTuGGs0ea0BTYteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg0iYbPB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg0iYbPB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e347638adso260993a91.0
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648436; x=1787253236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PAg7NeC1TQ8qjNCzW1dA2C5rHDBwRoUGLDkSbMYNfSM=;
        b=Wg0iYbPBLNaL9Gxhdzt56yAACXCfrxFJj5BKWb4+5AqaWx7CNqeq5tkqirNMIj6KUP
         v4U85YnoCF3XQiI5Ih1ZNpqli/ksV7UQMv07wDDvEZHuIQgzKCesRyEZqgD3pBYC1iUD
         20X1oKceiOIj1qajWy3YzNXbGu5JJo1JBHEi/efFli52Dad1Hg2hFgymXBYnuvkHDRcd
         GU0R0cErAJXsTBB6lfoMmYK6LBKputLXZYvpXn1c8816gsC28cfrzwBSHm3XMtNAEd+d
         t2uwN7gGaCeM46+SqjZNOviuu1QaqMeanQl+BKoTH7uMzx//R+gJt2wZcJ0+9l/34++I
         p+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648436; x=1787253236;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAg7NeC1TQ8qjNCzW1dA2C5rHDBwRoUGLDkSbMYNfSM=;
        b=L21JJs4/TgQrshuQbZzdT8t96lZcN4eY4qMrgMHcXMfORcAUnauJCIRhHE3KYVgZne
         V4mjht9RbwNSU3XARfMdJeN1unu4gPaLIFPszSxwojXUD5qpzeblaukmhWecbEQghxmh
         BFS18ESIpPhJLyWoUT63aW7W4UoeYRptHXyOZQre16rWOziALvuzfyBAYfM15t19Q3Zn
         rpRWg3Kk4fGANp0CShwZXzZbLou5E9YugjDd32iQv/iitxK4vS9Q4whKcyh+i1jP4vh3
         R7vJq+JVGJ6ni/mZQXugLjmvDgwLXpZjh8OpMwJazjkU7iEo0enNg9eW/g+QPL/uK5y1
         cyFg==
X-Gm-Message-State: AOJu0YxbJwM8Sn8DZh/AzoJ4ERXqiE9DP1sEQDoA6TghE0WXcfZwBtJm
	ucX47GTHIziFy94P1IJNbrTcyeWgEUNQCVEeM8gvX/SmtsUY8Nu4o17Af8kynQ==
X-Gm-Gg: AR+sD12DMx5LnMoc26HQHWE03EMp4JzwfFS5HQmhVAPjhuv1Gfw2MMmQh+9QexCcIs/
	mbhGiBRgwZVAB2uS/QtAR/xcD3VWM7/kRJwvTDx6xuqZt5EldOATI0shE5hrJs9T/aanEN08i/6
	p+Go3SsASLrzSLZD8DJN6UeIHPxd0g7b0bnvgu4pJtjbe7O3H45Xm1soxpZn92vZscFWSz8q5dw
	LJh+e6ez/FWUuy2lXsIG/fHOZmNAh8kmGi2cN3F6n3LsR4+22knJUGw0U7eRFuTqFDaHrzdgU4K
	DgEZ7jh+knrVXg9ohL7kSyxn+LAjaJrzky6FkscBJZrnsc3GRjhZQPfq4PT8bHf+XWvfrP+GCyd
	2uwlYrRg2f0F0bRxrzLSyIE4OITWaov7/63G9JB6bCP73uG+5+1W6m6nQ4SRp8caz76t6ei0/qa
	lVv3UtC8n59gPljxgFDXr+d1d9cnIlr5DI4SdFKaNIIU7dMaRXq66TAoTBMrSVrbEntQFnGITUq
	3mULlfLHd6r217azCPy43hgEKsEmg==
X-Received: by 2002:a17:90b:5805:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-3933b90d562mr184091a91.16.1786648435953;
        Thu, 13 Aug 2026 12:13:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:85b8:2741:2d36:4d32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebfc39de5sm9873538eec.22.2026.08.13.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:13:55 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:13:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] Input: rmi4 - Use platform data instead of query,
 when available
Message-ID: <an4Xafaue2u4QT4Y@google.com>
References: <20260806-respect-x-y-mm-v2-1-e0681ed3d63c@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-respect-x-y-mm-v2-1-e0681ed3d63c@ixit.cz>

On Thu, Aug 06, 2026 at 07:17:46PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Platform data may define touchscreen-x-mm and touchscreen-y-mm, but
> these were quietly overridden by data provided by sensor.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thank you.

-- 
Dmitry
