Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067E2EFDAF
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587349; cv=none; b=Sl1CSsobY22KICCJL33rzKFlD6R9IJeRD3qLG6SVzMMUdPrg3TwklmGPrpln2CbA+nFiAf7hesw7PF2wlHG02U7gYBHEjrHKHiZxuyq/Ew1aZr5/JKD2Os+1aTQLen7rBSe4XXNRD+cMQ6HCVY7o5u5sSZTTxzzPvnxVvf9V4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587349; c=relaxed/simple;
	bh=PeeBMfNOxGoRHrch1G6JN/zolUJ0LzZ1qX9BTjAD0eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODN+DtOKQRt0QUjWpY9iJwR2u3xWUkya8gnB9K1Tzcv2Vk7IXriiQUFfclrjUjo+A9+GM3gW+BUU/OnugabAQRYFiBnT3GAwBjBn7PVIOY6ldYbkQQtYVV7tiYFyJgUm+sy7RA0NEsi6P0rNybMPF7fhwqQYWdl2Fy7lxs/Yl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEm8In2R; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEm8In2R"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1270ac5d3efso6192552c88.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772587347; x=1773192147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Md/eHSW9RE9udsg1Dw2wEOYKRwqUSos1ZFTU/4oeWLk=;
        b=LEm8In2RAuwoaxxF0aXpbc4ckUDdep4ZHIArD1TLDru4kpTVa8XVP0V5V8s1aMQRov
         +x1OsVTBF4qf9NSJqXQ/7hKztbB4tZC9iH3W/pJ9ihbrZ5J0PKEt9c2KwZF3LlZwf5Us
         q8hBtmAFWK6HmGxvh4ZcBUzZAfuUgz1Jv8NbugUHVsY2tSDcoKJjQ5hss5Y6zLdHXRsc
         cwbd/nwV38vruJ8LEYMtRsHfCkV9NEJm+XcLB5GU7ixi+8+wcv+50bRtDamzKdAxYHr3
         587h/KG24XTaEQYJoDBGIy0ot1OT0nwSmg3BTSfgnoDgcOnxiBV0rtoiT8/iAq8E1pI6
         fhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772587347; x=1773192147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md/eHSW9RE9udsg1Dw2wEOYKRwqUSos1ZFTU/4oeWLk=;
        b=QXRGgjcfGzx9am35Dudsa0m3+NjFgGqMiRCxrJ/etNITuqdZyucoSlofre1KBevWng
         Nic6bIAsxG7FB+sn7tB5FCJvU9YdNMTGgFcagpOpXk/PjXHNmXPzpjJvBl96ICxV0GNW
         28ICvInOIERDeX6sVAkSKNmpbvnD5H3UJFmJnQI1axsn7/I+lG5vVFLrYrfI6dU2W/9p
         dJt2CrvY+ZxnGnUrFcYtAY7h4kRVhrhLvy1y+SyzBK7LVE2VVaZyFKYVvPlhcTVKBVuc
         UGMZ9jvuKwGyPgdTcmNTF91+rJet416QX1ZLUB8W9TzMmcnQZLgNim0CubBt4cvWtNFS
         mxIw==
X-Forwarded-Encrypted: i=1; AJvYcCX1eJQVfnd4G8/Ot7WqlSyFyCBmrwI8MYCf9o5oQ4tznrMUNRK9xzMgXN4E4Pnm6TSU60aJzQe8rtnwVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfGRvWkS6MukpJ3zO+KqrQ1+fzGOKS2LbfKtaVUHucXWWfh06
	L8TOp+wqEU44J8S3akzAgCQfpRPskbc9XxdX+nmfl3Blamma+WSK55+vtzedTw==
X-Gm-Gg: ATEYQzwgcHzTrYXAo6V5PRumn+NTFZ7N3Zn3LXoSFfRW5QduCSIox4amt9pQqtGB26V
	nmnCwAfAsWFfRuLUgdouSsY22cVy1t2Us+sxDB++U6VjSjmrfBjJlICzJS5HnTrC/G6pcjJ4QxZ
	4Z0AB9Z2QJbc2TdNPVFJdpvaNuv7q64WqFVX8POYJuU2R4rnywBjoWV6G8w3Iu7veKlm8Tk98di
	eV79x1K64dNRY3X4O6zvdWjg2UDBLphn6nIMA+LX+2/oJYtXZbKYULCnMHhPO5sAWajTUWm8cgt
	1mQKqCYvWXg9iYOngnpo1joARSMrRNBBT7vC3LH2ImfpsJp1ttlNyKckXddzZfCOFQ8K9NsOAC0
	22KhigOpBsR/7yY/v0IBtwieecpy7vTcMWPFriaQyUaa31qDcAgKJWaszCcKDY/gQ5EQMAQk76j
	0WAw1FfADsD9ze+UbQCfL4fY/Gjmuqfolaql9l8+HkHBA53789PZ/8Zz81d23hAJb+
X-Received: by 2002:a05:7022:689d:b0:127:337e:3304 with SMTP id a92af1059eb24-128b7077657mr98185c88.8.1772587346945;
        Tue, 03 Mar 2026 17:22:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm20971663c88.3.2026.03.03.17.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:22:26 -0800 (PST)
Date: Tue, 3 Mar 2026 17:22:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Nilton Perim Neto <niltonperimneto@gmail.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xpad: expose xinput capabilities via sysattr
Message-ID: <aaeI1p_Zd0v31-p1@google.com>
References: <20260304010345.1355896-2-sanjay.govind9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304010345.1355896-2-sanjay.govind9@gmail.com>

Hi Sanjay,

On Wed, Mar 04, 2026 at 02:03:43PM +1300, Sanjay Govind wrote:
> Fetch xinput capabilities for x360 wired and wireless
> and then expose them via the following attributes:
> 
> ATTRS{xpad/flags}=="3"
> ATTRS{xpad/gamepad_buttons}=="ffff"
> ATTRS{xpad/gamepad_lsx}=="0"
> ATTRS{xpad/gamepad_lsy}=="0"
> ATTRS{xpad/gamepad_lt}=="3f"
> ATTRS{xpad/gamepad_rsx}=="ffc0"
> ATTRS{xpad/gamepad_rsy}=="ffc0"
> ATTRS{xpad/gamepad_rt}=="ff"
> ATTRS{xpad/rumble_l}=="0"
> ATTRS{xpad/rumble_r}=="0"
> ATTRS{xpad/subtype}=="7"
> ATTRS{xpad/type}=="1"

My inclination is "No" as we have other ways to communicate this

Thanks.

-- 
Dmitry
