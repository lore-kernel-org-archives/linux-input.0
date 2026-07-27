Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B7175A60
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131607; cv=none; b=pVFN6vJ30i+x00pAPx3Dxu00HMREOpBF2LvHFpc3YbEhDU+COGN0bsfnPoXkhg47eSRenhZNhdfXgnlymTg6VQL6op8JMMcTIVoS/sSjT6FDJG41ACXpb4juO4rCIWitDy1CKPMI5bZYjnphK4LpNL8y/rDkXQ/ZbcTKJXvaTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131607; c=relaxed/simple;
	bh=3GPnECwUini/fW6UPtLPQ73isYYZIZv5Vl224arhez8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uReC2uw7DkgD/RUHSYzYvPQZI6iGKZcVzwaQl+sN0HgIm8edAG3WDSLZkv2jm5ExNe2k/GMBGNFL1KTVkch6uWkbHJot5h1f8+4f++G896cjRONJ8fr0Jvvrh2Pib/lpIXVXZYa/iY5Fc5o/dand4sfzdN6lLnDQAI+p67BOhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+JM/cQW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+JM/cQW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1243757a12.3
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785131605; x=1785736405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GtILubvuVEhDDQkeVMqZri30kt9R/z63vZzws5i+nR4=;
        b=c+JM/cQWqchLmWHc0GiJ1ofMsWNkQII/d/JsuwCkzjZeuS11XDIf96kyx5iUrMP49l
         YHH3waHIdlZeub0DV62uNzORHjaSKUpW+7/3xz4yAxarezCoSF+1snlOA7X9m447Tfko
         QfyZYk+pYLbyCwTO9vDTWalkrbqk5OqhxB7LwMFWZ6Oq5kRG2Y/bQ8HnHsPpe9sz+mXQ
         yDA5N0Iu1JN5/LjoHsHCd4Un1iHYbe7P9dJ17h9/VDSkqAQJPIMxVvWCSP1jrKPz6OPE
         Hyb3sK3Ty+jvMJpGtQrzGigzdkJhQBsbaxReZoBPlLp1Rgo5vLaXaWQyx31u6hAWmaIw
         /yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785131605; x=1785736405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtILubvuVEhDDQkeVMqZri30kt9R/z63vZzws5i+nR4=;
        b=JFupRahN3L1XIhFsz/ZSW2184XAjRz6rYyTQxGyKpO6KiaKGo2weP38mg5kR+yiByl
         dRqzOPqMZ1p7GL4LDk8jtLyrEFl3yVB2NtTTTfiiFvE+MXlpMe7mZYIkBeXPZ1r40n6Y
         qPgZ0iVMxUnJbnFDqwJfLKFu8ZVS59g+XghBTiJrS+v7lUfsBEsK1RhRbihTbc9wbhuK
         uSkEbOGzpHyC5Wg/pnYK+Rt4eO9CJE4DF64F+rW0CJIibjBhgi/MZL0GhRjExo47oF/1
         Ne/Mbpp3NRbvZST904H7xdrWUx99h7AbHSo834JIIQKZYvQiohoqQdC6FtoN6eMOuiYj
         mN8A==
X-Gm-Message-State: AOJu0Yz3nhm1nUXRT0C01dyhUeLBoMD9O5dcs4o//+Juy6lsK5FOhM1k
	5lK8F9gVtSCFh1OvcWS2n9LpJ9FYySiEcfFv/fFYRdGcWNGkNHD+r5up
X-Gm-Gg: AR+sD13WWUPx6V2t2TvNBRyYffrg/CG5IqpOADEjKIN4Awo3DsoJIrthCxcMtRhxQ9g
	ctMvO16l8g9rxqByAETrl9mjzKAoNO3xHYCXR643sXUn7ma22HqD9L62h9la0tVlo4iUEGtqpjL
	n57POAaVIDp432/UM5Qx0XnrmAh9R5+lkh1mg78DwAX4cgtlFSV9TyQRNSffqbvTnXJn+CmOycS
	vt3k9PYIR4RzyyfyuI9BMG8VP9DqqUatC4J1c8q7a6YSX+G8N/YMPtX6KBOnMmqNufgDtlIfBX2
	N+VJzKEYP8SmO7Gh3gb0qmCnVZFQ7HSHYW+MfXQNvYbCac/Fp21imDMQqKj0uU1gRVXq3Muydf7
	GZm8K45o2El+LO9chEAnxNgEUM68+Jdl8bx1nXpBGomyWOZBvhIYfTbJTKnXPLVPHwxH96cZXFx
	fvlHkv4IRcz/CjtVlGkN5ulnQp7d1/u1XEZLxvtiUWQYM=
X-Received: by 2002:a05:6a20:d4c:b0:3bf:5539:f8f with SMTP id adf61e73a8af0-3c67ddebb22mr6626802637.37.1785131605311;
        Sun, 26 Jul 2026 22:53:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm44638825eec.2.2026.07.26.22.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:53:21 -0700 (PDT)
Date: Sun, 26 Jul 2026 22:53:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH 1/4] Input: psmouse - fix use-after-free during protocol
 disconnect
Message-ID: <ambyOdepIOfn9KHH@google.com>
References: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
 <20260727053809.030801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727053809.030801F000E9@smtp.kernel.org>

On Mon, Jul 27, 2026 at 05:38:08AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch introduces an unbounded increment of `psmouse->pktcnt` leading to a heap buffer overflow in the `psmouse->packet` array when stray bytes are received during protocol disconnect.
> --

Fair, I'll fix this up.

Thanks.

-- 
Dmitry
