Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590121D3F5
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524689; cv=none; b=mA9US3x0hqWCaVXIUMqgVYzlI131IAESHG+Xc1X1UI/Ybd8sRgPYZMo0go0ZO1gqKYdZ3Drq0tYudzELMn8NOlZDKhCwLTfPAYMQKpz1YVRT3dbkB7Y5hPeD+g3mLVr7/M6RyNCQS5cg2QwUxAV9AnK1UybZDjxG8/IGr/PhCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524689; c=relaxed/simple;
	bh=eZxU94BUfQs1S7dhMiygcjoahDydNmQ3jqhq/dfwLLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmdC9lPUqsGKKGETO0LqHgG2t9WpZ866cURqPxxHSxYQU1nfbnzlv+44sgFvgaDXfNo0malHPp1ErPx7sS7HKp69tmxrQHEADqLGCEp/e6B4tVY3o2GbgLQ0jzoN46daAGEthc7fKw5oAS5ReY5GpEMsALvQ2Nb6m5sjmfZC7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhSsdYkA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhSsdYkA"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-caf45fc5202so6595905a12.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 22:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784524687; x=1785129487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGTPADoCRFsZWEQfK8/mF619wVil3KY9yAYms2+ACxs=;
        b=PhSsdYkAmoevjeo5nZ6deQtNiGiXpj+pNOL3TACgM3svOo+GNFEwOpQ2zoG26rkzPi
         tbSq8bZthhdN7tUEtQvlEm6EbMbhSN5foCNz6nbFZTXmQ2BeG5WtW0QXVVMJYUIagpQ+
         V8hm6jUmdadc3JCV8xLNaMJGhTJe+VbS1IWwGR63Amm/b25o3BWzwvTeuOuc1YyUYYZs
         YioYBsO9ijLskCCVEvmlxaC4JUuNzGln+/C8JzhwzRJ3pBuJOearm8tbvIXffbKAOELV
         ZOXXhmbvgCRY8b8D+fy7Pl4XG+1k9mA4meNhEBfgGaLa10saixIhMFVfrMJSIN9F31I6
         RCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784524687; x=1785129487;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGTPADoCRFsZWEQfK8/mF619wVil3KY9yAYms2+ACxs=;
        b=ev34GBKRrq7N7aeAYfddPa785wXXROleki8DzGyOSlEJU3mj38a3KzEcvPkqXHdIJE
         uM/Ai/173Yrfh47CRPpBf0ar7nUqrer0VnAC7GXc6xB2SIhawYqPQ33VEmiBXwIJCArS
         wKS+/VScsIakJOHprMlLgs9VRIUJRYtGiq+v4hwkW1HMCA4VwucWtvhqxpjg4+Md3KCe
         R94y61KfB7PcA/kv+k7A6IhhAI14ntK2hlPqOP09zMnrp2Rz3uyFBdXtUIpxoEx++RWf
         FUjx0nmFn/Q2B9gRJa5qXjD8FGuLJdYW9hgJBrHDelZWCex1LGKYZOGPl+liwq/PVl2g
         E6Pg==
X-Forwarded-Encrypted: i=1; AHgh+Rope4fL6zebrsHatBNC0BD05S9B0ybtUZyZ7LESHW1x+HOwGm+9IjbJNHuaYCtFW2NfOEgNVbz67IkZOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFEqs4sj09RrjUQMn5vW+cEL7rhjtjGBVNLe/hGD0NPGeUV0e
	MhuZcjVLk3Q8I/S0giNAObhHxoznt0ErgzKPDN2yzU8FwAuw5CZBHfH/
X-Gm-Gg: AfdE7cn1bPYEeDW5MQRn3ZE+3eZ52F/mUF6vCM/DSS0ER9YeppiZ+ftDE4tYhiF1qW7
	osN5rl4cDTM5q944xre6X0znenlkggAx/gKf5dJ8HqRW8lBzVqecFk119Z/TLEbGPO/v27VV7+S
	tpM03K8J1C8QEDE3TtXZ1qxF/WFYsvg0rChuFP3TKkQ7Hp8q3pHqVyD+W7Si3F2rKH0PSJVXedK
	jrF2z3q8UKa8u/oFkgKfOibA/Zln3xZ8RKgl1ciqJuM6y4F1LvifwNSTSMn5fW5QYVJ1jeg+iLL
	t7zJIZ/ZQT+BP/zUGtNU7dNQlfttJVVs13jnhApt13eMC+VU09B7oRiyaeeLtSrbyssvGKBBTQa
	brVeDBDnHpCRZxEWN8fYKah0+SN1b0jE94g3hR7E79Pzvd7vuUHKJEILAxnSNCcyjgjM2Qw6iBh
	jJKkpwgGT1CJgFQrK1yoEa8DlDdHVBhj/xKii1/7vP8I96czW0rXvcMA==
X-Received: by 2002:a05:6a21:485:b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3c3ad8b2dc2mr13455022637.35.1784524687434;
        Sun, 19 Jul 2026 22:18:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:345f:e51b:3d0c:4546])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcd9sm32727251eec.3.2026.07.19.22.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:18:06 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:18:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Linmao Li <lilinmao@kylinos.cn>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: byd - synchronize timer deletion before freeing
 private data
Message-ID: <al2hgrtDg3uSgbVR@google.com>
References: <20260720033030.1580891-1-lilinmao@kylinos.cn>
 <20260720034855.07D8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720034855.07D8C1F000E9@smtp.kernel.org>

On Mon, Jul 20, 2026 at 03:48:54AM +0000, sashiko-bot@kernel.org wrote:
> 
> Should this use timer_shutdown_sync() instead to permanently prevent the timer
> from being re-armed during teardown?

This is a good suggestion.

> 
> >  		kfree(psmouse->private);
> >  		psmouse->private = NULL;
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for an interrupt to trigger
> byd_process_byte() concurrently with or immediately after freeing this memory?

This has to be solved in psmouse core, I'll take a look.

Thanks.

-- 
Dmitry
