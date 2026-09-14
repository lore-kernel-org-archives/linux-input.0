Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B11E7660
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348873; cv=none; b=p51a/1Rhemi9iiItAvMqPUiDuzQslrELA/aLBSSVZNawI6Dym6GUo4VCt3vgjne5hhmwSaIRvlm413Rhj/iiG20x3ZBUnlCwk+7YFUQzVfn5IdMmM6YkGfL/rfWtu2N1lz7rJ0gpNSnRzwp5EV7jpUr40ozeG6jvrnxg9Vw2eRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348873; c=relaxed/simple;
	bh=p0TdEI9Odp+HHX8ZliRHfs3GoCnFdxCkjA3b83mrZts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMEw3GJgm1b/uiuypbLqNNbsXXWNSZocd84gYBVcxWCyE2jCTOJxfwjdTXYOTM89dbwfgx2C6ZwAGZUiRck58hKz1XORgqS50Ii0cP4trHn41Dix3R42zq6WXj6iiWiGmvNi7EpMHef4q87nrLjxU3j3Qo97eLSLytrf9hZhJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR1FIwaH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR1FIwaH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so2676795a91.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789348870; x=1789953670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Na/Qz2DkaG9+GH7sd5UZU98HUu9w7cEHSlbtgyG7FmU=;
        b=UR1FIwaHbQqvvGwhA7ZukWACEp8dyjAhz/4kqGJdsBWASse96+bzT1OXg+7BzDsK/7
         iwwt39m94tmCfXy9vAWe+d6AUWEbzaSQBiZ84uagSvCCx22Z7SzF597AZ7JbXxUEuUGb
         s/8Wn2PWp9TGNYBDFxUGsLaxtsH+zdoxRiTKLnLp1ERFvC3XyiKFB0aBhstgr2ACdyqf
         IUMtH0imgHEPr/ooQqjpAj2NR367NDwu8aEBF2q4znzEAVVL61f3biMAljBPUe45adwK
         aU6TW/xccIiXg+S+Lqgm+QYGsrfDRefyQcXzOy1H8lR1uZ2L/mCd79ObDOvI1XPYLNeK
         q5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348870; x=1789953670;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Na/Qz2DkaG9+GH7sd5UZU98HUu9w7cEHSlbtgyG7FmU=;
        b=DhGFqmDUPieuYtRYyN5oYN3aM8cKiG5SLpwwbRl6fy8b1rGSub1biKvfv4W6sDmC0g
         uMDZPZhEz7FQklZA4uE8R1z8b4CiWu9lnl9agPU2Q3L9G4iIiNT26hp4N3RwTC2Iy87L
         sjJUIO/lEjzQV/If016XQyBttLfm8XbMPk7DAjVGwpdclKnSPjqNXNo+hwKOBhaOwWgN
         hz03HaVX1DgXxEOZL/lwmuHKi8weCB7eUO9wcvKDIiNxtOrd+jpPZbb7Igcb6A9tmug/
         Lh0MUdwQ7WBLiiJa5mrceV4NYoYgJDUhvj0Mm1wmDD9ikB7rMcfVFBK01j2BBgdixzJY
         wODg==
X-Gm-Message-State: AFuF++l2t9wv1H4ufz66tpRl0BCIlCVoU0YeTc8L9Pp7CUBMR37poT97
	VgacClZsHVWXjjfPFwJiXtIvdA2wFyiKM+csgd4hzbHYQzZpcSG9A++6
X-Gm-Gg: AYBFou0GWa8EMiNTYgzhOzPpYS8ZyzPRUeXGLDdSfn9cYFGemEVvi2DNQ5++9o9BYk/
	vAT8DPXegczXkTwgwt0/cxAmXqx9tkgmzEYydXXvg4dojIJ5LzephWVZ4F8RLLEe2d6JGoO4I3Z
	S1k7T9yx9I0x5tRZMOCPLYI1oV3ExZdgCmaO/JRux3Bn2h7DXzX4eK4LVHnkF3doGkQUf6ZYL7X
	Z28K52kO4dl/3BnABuw7EfJs5MNBix96fq3oRwUV/4A6a0fwQ0I8VtscjUjH+GCxGH+44c0GYyK
	3un3hlOepsR8OhiCIJfnT0TVxCIArwO5PeEN6MLTLlKENi6989WtnnaEvK3Dk++YU3G7Pz7WPjP
	1nVF4gocanJCEzasYbCHTf1HLrFm/TV/dIizNrgntTACfbhTzmBLKnX0hGpao1qyH+Wj3dWvmXk
	2REDWrabz4hSRpO+WDGpTzObJzbBuIl5se6axOBxv+Aup9LhVQsHX6GEGB/ADK0Gm8RulgcpOLL
	IMMUGUxI3tnSTM5d/tb4jkBS25sRfTKkGNKhbdqhoRdSWqru64=
X-Received: by 2002:a17:90b:2f07:b0:39d:8b8c:3783 with SMTP id 98e67ed59e1d1-39dd54786acmr4925020a91.6.1789348870069;
        Sun, 13 Sep 2026 18:21:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba71cesm23055666c88.13.2026.09.13.18.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:21:09 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:21:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Erich Sartison <byt.es@mailbox.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Victrix Pro BFG Controller
Message-ID: <aqdL5wRZxLy60T-N@google.com>
References: <20260903103137.630170-1-byt.es@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903103137.630170-1-byt.es@mailbox.org>

On Thu, Sep 03, 2026 at 12:31:37PM +0200, Erich Sartison wrote:
> The controller doesn't currently work via USB-cable.
> 
> Signed-off-by: Erich Sartison <byt.es@mailbox.org>

Applied, thank you.

-- 
Dmitry
