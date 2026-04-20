Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E70399345
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705369; cv=none; b=N1FnGjKP5jyv0C19Onci/L410UW8iGyCFEpidK2mwh8AbmtCFi51g4w9ipMYuigEJLCuu23spyjvWlzXkS+7r9PuqGtv2OEp7S7UIqyjSfUYwCNH85kffE7lFH5q7DW+jkJ+LDnvA7FJssRX3/MVTEZP7LHGwk0yozdd+OFTn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705369; c=relaxed/simple;
	bh=c6qb3j5YwLcUinHxPe9QmKobKWtaBwlQxCDbpueIc0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNhwj3NjtC11gckKzQ5SGCed3WRcepj+69WfHN1Ys13ouIQt6PIuEhmU2OzlBDAjVN3tJ/R1hgoTWxw3N7ZPFYDD3iE3HwYo80yfP1jU1hUn/RqGtPkMLpVbul+QXdC85QUatoOdfE1kAm//l7m0qNc2WiCipyP9hzHGzTWqLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+qhPDYH; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+qhPDYH"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c7fb2e175so167789c88.0
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776705367; x=1777310167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8autXOz4+KZwRvZdblx2ysMt7DyheBXaGlu2LgBdpo=;
        b=e+qhPDYHW3wxgbM4f57nf8fhiIFW4l5Fd7yt3VzS7DeVci6xrjB8NhjXbMwpjTu/Tw
         8muF/oZLQBLqH098Wqg2ocTweWbMfLWpwqZ5TbBsKBWxtwvEN1HzBU10UNG+4Pm24PE/
         QoMsQ4iHqWsJYYnx75X0qRwbDkxBANqn+AyT29uws0cH1QU9AwlJLoKrRZSbZNMIRYih
         SL1DGv4FX0UuUslWfpqpDeSjvFTFLjiCoJiLpWIIFtb9JYxfynyqsBOjqK30LxnC27MB
         33DuF+QMjOicVYaWrr4IStw9NCUEcOuit2aYJf4hmRCSL50dXasLAhc85JvvfJjesgUG
         Zw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705367; x=1777310167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8autXOz4+KZwRvZdblx2ysMt7DyheBXaGlu2LgBdpo=;
        b=rrLdNpxKCAmMs5ES9ZS1a9oTa9W/vixy74mt/GEzFZFecuBBuP+o95YxxyOZ0U27zq
         mRxRvAhDC9Ydgy1P61CnspqOwSxd9l23WLAS0z3Fub77hwF0aMsEKrhHayFqjNk5SrMb
         qrXPujVkpYJDUAdNHgcrEFPkpF1WBcIcuxWz7gyBWtoP9kiygPXDx8lzxVjaGxJZ+dOl
         Z/QngK3BJYs7iRd0yu7VtUhbDe/j+KlWxt5WwdM0xKrvcFt2S6s2o82qE1KbQldZkA0D
         co7dzsoZHwARd1ajsRT48Qa656r9F6btU7iXdbnz1QIVnXI2wIhhmG5vPJQz7650ah4H
         z5ew==
X-Forwarded-Encrypted: i=1; AFNElJ9wpUqlHyq1m9rH4DoMyTo2qXveJhuQHczIGEh9tVDqLf7/2dUoocPj3PtzV11a/avkx9vsKNBNWgQ3Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rlj+Mxc6EjOBkCQgLHNDQBpKl0vLhZJaa0BQgkDyv7a7vgNA
	KCxUZpjLxOVCGSbU/I0m5oa8MwSgxgFRL7M1YmxG4/Cd2BfkipFAstRc
X-Gm-Gg: AeBDietbByfC4Oky6RrLjhH7IBKjZZuCdFAnbRUJprjFJs8+PUcZ+lerqjcwXFF1JeS
	RtcQLhJcVA7KsyERl1PhApiTrZVzaaKteQq05AoNE3PM39kMItUq0IJ2VFth60SHbdqenmLd0La
	EhXEW7Bi0p63U9WnIjH5HTrlv8hKEi7TnrIoYvxKCSLE5yYEc24vfJBLECns987/mEW0GrE0SpL
	ZqayuSeAzmHPDkWGQQ53fFZDCnS1qAZvVArKmuyyXyzC9F7jRNs0iQNatvGf3NZmI07cXjNs/1N
	PatkcryqJ7C+WUWonNES2H1WqvUNFSICENbZjeDXfQxd4ZHgE/QppCDaC34sZf/CktyxqlERVQH
	We/7r226pl015/X2ZoYbGoqgAslgYgkJN5lDV8CdG8+6yvbmUTcZ4hwvHBkp3qCW59ifEwhxE0F
	zcIVmXrVJuUZ2Bhk/wMtBdlcegYzbMrnIb7pCg0J28bwTDa1pnsqsi5xhFfBdiHyNQEHBMqrzGZ
	O0=
X-Received: by 2002:a05:7022:6627:b0:128:d362:31e8 with SMTP id a92af1059eb24-12c73f95c9bmr7706236c88.20.1776705367122;
        Mon, 20 Apr 2026 10:16:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1a4e:4965:5dff:cdee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e7025cf413sm9717145eec.15.2026.04.20.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:16:06 -0700 (PDT)
Date: Mon, 20 Apr 2026 10:16:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, geert@linux-m68k.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hvilleneuve@dimonoff.com, mkorpershoek@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, lee@kernel.org, alexander.sverdlin@gmail.com, 
	marek.vasut@gmail.com, akurz@blala.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <aeZe7XoDbOMqMG_c@google.com>
References: <20260312180304.3865850-1-hugo@hugovil.com>
 <20260312180304.3865850-5-hugo@hugovil.com>
 <aeWtDA7snjJmiF9K@google.com>
 <20260420110159.29ccb815eb584bca18a407ac@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420110159.29ccb815eb584bca18a407ac@hugovil.com>

On Mon, Apr 20, 2026 at 11:01:59AM -0400, Hugo Villeneuve wrote:
> I tested it on the real hardware and all is good.

Thank you for testing the changes.

> 
> So I imagine that it can still go into 7.1 since it is a new driver
> and not a modification of an existing one?

Yes, since this is a new driver I will include it in 7.1 pull request.

Thanks.

-- 
Dmitry
