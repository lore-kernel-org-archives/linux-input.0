Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759194;
	b=dmF/K25ajZdw0Gj3KFTWr63IV3vQj4fD7RLriHIPOXsPHoh00xB0ziNUej+OLM8N00xv
	 Gu9c/fMwvH2JfZD0K+MDX1BV1dar2ZHoOeQm/cLG5G2m4MHj0yC/jsV22mVSSo6NmX6yT
	 Klusg/UgG5SexGAtzQKplukn8r/zWjgT4VexYAO9/K6+pnv+oC2erZXuD7wmiaBOkU17i
	 So3n7QH1Gpnho5I9GFalFpq/4b1hVAWjeovyd56Zh6Tvzm1cOW8KbwURe1xUxJ7SjBSoP
	 K1QcqgoGxOw3RgEOKi0l/Xezhqg+lru42/8+MpobTD6W2EyP9WU/dQhjk+2MZQLQrSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zf8chmK4lYlJ/gNkcnvQsrfL5BsaQxeLGVbue6it71g=;
	b=P46ZrOnT8o40TfgdxMHYe0nFCvbCF9qLRo04vQJbn3AAk7yNBLed/H6gY0/7RSIlDF5U
	 ItdxA16H2z6ZkeIvqlZZfu3wrnU0UTyR2vMZYDFq0C6RmsTYfluqoA1AJL2+xZQXj2MBi
	 1Hvdg1rOsxmfnwcsjVksu83wJPm6TtVYS+oequFd75YvzyZU5w1w9YF386YfGzv4QGp+f
	 mbCBum+kwWOBakOQbNc5poOoZ0/mhJWwI2Hm/3FyhF7tnkb1UkBkCiaJMFih1QQVO2d+S
	 4GL+iWORlLft8v1u4iV7SLE2dVyituC3kbOtRB24qC1zH5mcJWZIBZa08+w/hJH+CxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdmC8yqS;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961D606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 02:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5961D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdmC8yqS
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so339497eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 18:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759193; x=1794363993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zf8chmK4lYlJ/gNkcnvQsrfL5BsaQxeLGVbue6it71g=;
        b=GdmC8yqSzAfFyseLZkRaMIA67KXc6CcQ2kk97I0FutswHdfmKvOEVcRaKrlIGGqS9r
         JjiEkO5zGhAGm0zYWviqNrnlXYVQ7aqPqAwJiS/rE9kglVBVz+eWpiMVCRWYbhxrCrFu
         vWEkO0yCNt4xi9tF4aDZMVxpNmmB0QJKERu9H7wu0PUhhlJWyndSnGrqH9v65qCl21DE
         Gz9+68YWYIGV2s6pQ/x7M5P5M8qo1Wo5XQz0r0XE5WoMotCCJOoeNLtvUDynT+6h66Eo
         q/9LsiszrGwUaixfx8P7CizSxTEMveDmK+MXN4sVqVGaT7nuC5QYSTtM1/hgihe9lQxe
         ibCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759193; x=1794363993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zf8chmK4lYlJ/gNkcnvQsrfL5BsaQxeLGVbue6it71g=;
        b=kbnAaJK4XXcYTWTToJR7PxFxaBHwBlQhXzEqeL5sSymt4LLulamqdagQ+VykBWGNtu
         4NlUFxr9HUvkQlYU3ZphamX//Xm505i5U4k6+7YPeNb48/hc3boQyLZOjEnfCTkrJq5p
         qSUu4bZg/fYeUp0dGc0VIt6JbVi1G9ru4KLHlmZA33cNV7I0abHXRyAO85xEuA5X3eqA
         fvL5kn9SeotAiYZ9VSp3Kqs0TqJnRbQMbt/4bJ6WGEpN6WInTYXQnxkc0sGZyvsXW33k
         GL7174CnHVrS2vAGtNKkIUJ64Pfb9+6cBskHnCFRAyhXN8X0ag/98xiBlgzYiNk2+Uj5
         L8cA==
X-Forwarded-Encrypted: i=1; AKwUvBy+LFKh19wxTZbz4shtUDm9yXs2R9LpxggiqhFCaVTQjKuqFruJIWy7ZnTWZ/Ow0Lk7ecxQ/R2VT4jVnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OtdUPXMD6Mmo0Zf7XEQ1p36gxmA7anTfqYE/KFMtvKTV+abem
	LgR9HfpePUqrI+QJKRxWBLy9lKXTYERR/9yqaK38myeumLQDU+eWWkIb
X-Gm-Gg: AYBFou31cnFw0eMlYjjZpS3+M2TKou2Ps3BE7CxTgie7nDJyXy5d8/nij/8wDhkLKV8
	2euWsbMFI6LVDKH3NRXP5I0tujSchvTIkgL8vIDiE450VTcI7hy0m+YfVNAF9HujFjmQOMVcXjm
	R04dzYsSV02OFleVLH8nob/UOEoC3ZvBPWO3jOqNHeY58yZdM+HTb6U8PrVmZoVRvuVcqRuhogU
	TyYunjuwm1zz4bZUG6SiBMrtkzNx6tWoPp7lLlP2v49dvIl15MmE+8RRX8zE0GztaT0ddspfWeY
	pZCSWNJ0z5LUGb5dvm0NnJnlcWBoCfORH8K5oqr7nxgTcSkCr+RXgCk082p/3JcLw3VaRtt6xZU
	T4mXmtwP5lK8d55e1i9zBmyKKzKpnB0RH70t2J5GVuAXYLFLrjxL/P1nqwcwABR84CpBL2AelPt
	xfNcVbLaekpsjBwP2xDUcChHPQ4likwSAHYR+5k4Va06fAhLTYEwaOiCR9GrSAw8f+WO5cxFkuh
	oCjSun9GUD5/U1uOEc/6WDoKvxPqVVZs2SAoR3mhKGI7OwNOXHsT1tdNoIAYTZajGMbNcw8XLIT
	zCQcROLIAkCifyxGLR2Dmnc+kLY7t8AzRwSdd0fGOYKpnE8rEMobtBcIQ5EdMsgZI9ae
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id 5a478bee46e88-36a6106506dmr15884374eec.16.1793759193308;
        Tue, 03 Nov 2026 18:26:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm2818065eec.24.2026.11.03.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:26:32 -0800 (PST)
Date: Tue, 3 Nov 2026 18:26:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ping Cheng <pinglinux@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] HID: wacom: Access shared touch input by
 rcu_dereference()
Message-ID: <auqXxlGTgwoAqmdL@google.com>
References: <20261104010108.21895-1-ping.cheng@wacom.com>
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
In-Reply-To: <20261104010108.21895-1-ping.cheng@wacom.com>

On Tue, Nov 03, 2026 at 06:01:08PM -0700, Ping Cheng wrote:
> Allow the __rcu-annotated wacom_wac->shared->touch_input to be accessed
> inside an RCU read-side critical section by using rcu_dereference().
> 
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610180015.KsRqmoTE-lkp@intel.com/
> Fixes: 9183319a5ba4 ("Input: wacom - Setup SW_MUTE_DEVICE according to the order of input registration")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
