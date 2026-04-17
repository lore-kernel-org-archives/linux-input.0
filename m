Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76D32143F
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461082; cv=none; b=QUpWebbwzdwJC+p1kPHwz05uROEFXLtMESKGruSPobgVNXfchbqkWsMS6Ma5F0HqRbeX/SBPFwAkukisLzp+t+yEG7Ffez8/PK9Aj7tpjyILJhD1nZP/DbbGxJ+tYcbpAEHOOizhaN2YWjYUIEPhkLFdIzkiOfO2XdY0bzsLMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461082; c=relaxed/simple;
	bh=SfW3aKMNDF3itjmw5mDGazvjrO1+TlvAVfQgjmpgN1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5P1uf0z2Nm2Jf6egLGD+4Bx5h2jUcCdyxN1OwYnqXfNieB6Fqb3Pwruc2/pwTbvPkAU6Vl70CX+ZrL8NM7pz2vnDCP9p/IbtyJ1V3+oVWjCkFVuJ54saasGir3fwKFiZSAZYYZ000LginW8N0KTwFYR/JvrjmqGw2BKSGp4g9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1IFCL4I; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1IFCL4I"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c555f886dso1809045c88.0
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776461080; x=1777065880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YMgPDsRl1INUEuGfQBN2K0mpewlXYhHoJVyAhAldtE=;
        b=Y1IFCL4IL4YYYhrphm7z00mjd9GRO/KIC4Zyqew9QjkGR9AdjivC19iU7hDPS/XUDw
         /QmJLcQuajzICwfhzrnhFPo0p4SWL7BUi/yT42QAZH08D5kmEDel8OoC8clZZhtpIxL7
         TcGJEc6TIXn/mb1gcHcO2kY5IaHp0FURjEHznoKL1Bx9pC3on6g5JGHoUzwpYS5WTdih
         brKW/ke2xXPLjm1Zx5puJ9x6fkQCoVF/Eeoq33t6IOkESfMcvosY6viWozLhdX2YtpO2
         jP5GKMTgNuld+yQglT6QklnYun1nL732o7LhoYSulJK/vU7UbF12xZ906KkavsgdlxGb
         gHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776461080; x=1777065880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YMgPDsRl1INUEuGfQBN2K0mpewlXYhHoJVyAhAldtE=;
        b=bZ+sDAGTXnaCthAMtCGLYGOHyoBWAPTLYr7ajhLIqMs447KzoORUVQnuBkb1R2lk4m
         XJpMKwTC71dKkaZzc3Lrai3vd8WfdMxoChO1pxbHHZ9G2q15IWS81sdiDEjA8QYQFx7/
         nPM1fWBL6UpblhaYTj0+WxGIu7WN5vPM41/P1T+ltOVm00ZZM/CTMdy3aYnZptTU/K0J
         DswhBAsz5N+oYHxB7EQfDdYZiMC9tag/2rWI7LelflUPvl89Z+ycRyFF1AJlIbBUT/Hb
         +a6VDouv3x9OOFT47bb80iybUUlMcXr247JrJwY279pUjhzdtOrLAXwU0Kn8/5Glmi0D
         htzw==
X-Forwarded-Encrypted: i=1; AFNElJ8YBNmzYiyuG3Q2BS1SKc8N8abgXQQOMzUiYgGjCU1ntF0jnefILLuB8BJ/1WmRnZv3aaZmlIUOihU1wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAqnq3ByCHvgr8D7zPmy5dVcovjbTUV7AjE0FW2d8yRb+wNHh
	kenBsZmWF+tT2yAbbXzc9wVSIEP3dAIPbn5iIsILh5WqcYnexZGgfoUA
X-Gm-Gg: AeBDiet2dYPzJlADgBc/840wZJ2RZuRtAHmpI4YFUc0m2au1xV+JRyKNPJ/H/I7n2ST
	sW/15ykhs0N9gPTxRadqZn6Ak1/6IQP+DOxXmoGHXyKLbLes6AmvETn7gtRFisp8be15MFa0hon
	v0QjFCE+WOR8sUrhTmpu0fGXYYaOOcIup+8UFNvjbS/qGCHF57piwk247yQnJrXougm42ACrp2P
	dPuaXp8z4JHf1HJ8sztEmWCGmf8+AS0GmgN5lp3VoileAoQMsp30JaIaC9SonyckcEiS6mrzPfx
	CZtfedEL0gtW1giIWQJ9fGXzOYlQwdU/NN8z44lWk6LqZVjfcc8G9Ba78S4Vl2seu+WYMKT6XdS
	WotETuzzd6jyE5A5CSR0TlpVG3nJsSJfAMkFp5kOvGWGjajtiYcBdQAesXbCU1Are6wI7cEDH5D
	dnUc8/zTK517TrjAatjkj5epTbQFvLXNH72WvesFxItF8C61ScLnVVxk3U9icMz+xCfpiprK8=
X-Received: by 2002:a05:7022:60f:b0:124:abaa:7ff2 with SMTP id a92af1059eb24-12c73f9bc97mr2419280c88.24.1776461080143;
        Fri, 17 Apr 2026 14:24:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a3:a483:e585:b80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccd2564sm4053982eec.18.2026.04.17.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:24:39 -0700 (PDT)
Date: Fri, 17 Apr 2026 14:24:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <david@lechnology.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] input: misc: Add PixArt PAJ7620 gesture sensor
 driver
Message-ID: <aeKjPSy5c1yAz4Ge@google.com>
References: <20260417052527.62535-1-sainiharpreet29@yahoo.com>
 <20260417052527.62535-3-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417052527.62535-3-sainiharpreet29@yahoo.com>

Hi Harpreet,

On Fri, Apr 17, 2026 at 01:25:27AM -0400, Harpreet Saini wrote:
> This driver adds support for the PixArt PAJ7620 gesture sensor.
> It implements hand gesture recognition (up, down, left, right,
> etc.) and reports them as standard input key events. The driver
> includes power management support via Runtime PM.

Sashiko has identified a number of valid concerns, please address them.

Also consider:

- moving powering up and down the chip into open()/close() for input
  device
- getting keymap from device properties and allowing adjusting it from
  userspace vi EVIOCSKEYCODE
- no capitals in type names
- use 'error' instead of 'ret' for variables holding only error code
  or 0.

Thanks.

-- 
Dmitry
