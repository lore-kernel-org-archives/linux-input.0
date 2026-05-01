Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81D25FA05
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 04:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610222; cv=none; b=C99V6slYBYxNeZkRh2OjDp26qwZECP7TH8GdRto1ClKUSyg3EZ8Y9H2XXjKK7iFPmQvaUF8lBNUpPUSwiXz0hk7qADpEHHl9ULaKzgPbkzGfCPjp0q6UNytChoU9fNS2Rj+GYAdqRBHGgwSns/wPs4X18Ig+PDc0AJVoOPnmv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610222; c=relaxed/simple;
	bh=913ye/g83lkkYef38DODQ/uhn9MD61lwDVoOJtX6FII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlwWUVJS1n4EXKVH/XQPN/bQW+x1A4YY/q/eGjbOqpvbTQBRHVTjT9ygO0woh7sL3e60YgxvW46r8/j2vfmUS5sbK+/OiNKdy2a3H/YajydtS83PvHygY/j1nAmYTCN/On3PApqlXX8TdNeXvdXdDwf6lDu29km9VDCLL/H386c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLKG5jqO; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLKG5jqO"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c19d23b19so2441389c88.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 21:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777610221; x=1778215021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8RRz5WwWYIZ7ZyAPO3Ne4YeXUo8kn5WyROJxu9bYPc=;
        b=oLKG5jqOuwp9XeHagTMbQqEblBIP6df+QDnybsN0nOwDfsEeBLs4iWkcqrqXLQNRy3
         sdfgTV2K+XYkba2gR4ItZ1TFDroXOeQmGpEBvDazgr65hmpG+TBAUhjzIESLy20rlV5R
         1WG2o5k2KlV9gqzbF2OqgJmyMY+3xeFv0aKaL7ESQmBnmobjLSaldWOqn8GLhOjstSAw
         /apzBljbz9JfN2+jSikRyOX0ZNCSOalpo1KcJouc1LZpzT+Epf2/13IRQQpNvDNW3Ua8
         BvrBnk+vXKMIM535QMJqLTgIfFHEgVpu1RkZimtZkFxjX54ytyvvpFQOkp+8I5LlLB30
         8pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777610221; x=1778215021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8RRz5WwWYIZ7ZyAPO3Ne4YeXUo8kn5WyROJxu9bYPc=;
        b=eZS06TYwgyEeJUYbp7rDlE/woGdGIB7Tyz+cnbcW8K6e2p7gHsPkwOrT4K2Wdyz8Ip
         q2EPWwwokxI/s0kBw6vZEOeXRCwMtu3TjMJMWK7HkOOZyrA/geEOYdl0Uj+2+jYqRkTd
         Pn1HiuM+39+06siMjheROOcaFoBjmm+2LMCCNLB7po/4iUi3VzEKWwFX/1gLdXPcbgeb
         AkXKiuAr9k6VD1KmXeE8XykY0ZoCfHq8nO353nVEfDoWyjmdGKim4WNJIJYw4PuuwTR6
         knWYEz7b2U4UX87QjC/fhSJhLY8EsvAErOPq8FhJfDO/cCT05/FZnYlGOmidg5WAKki/
         v/+Q==
X-Forwarded-Encrypted: i=1; AFNElJ84mu453ItlRHJMwd8nMCizRkPIYovfvxbpvQyjyTSIIno5+AdsuW6wYYrc1ckP7b2pwUzYgjHmt3MXSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNFQfbH3xXAIBFb2EBJ4P9FQJpMoqcM1AbFk+q9erFhZR1zZ3
	k9KTU7GEWc1NhnUrDWZZ4CWH0eg63mhIIwViqOo6xWjBMlreYbQB/3PvN5S+xA==
X-Gm-Gg: AeBDietOP9t4CXvgg1eBNBCI9nO0H4aJxlam5pLt5EAmKia8p3jzkA59I2kcZMwMNuy
	ozUjAMcSvIrs6mpGgPQhXwzQt+Qx1x26nQmOpLH/TrR18m26DLDef4BLIrD009bBpi+JeH5zgna
	UnwylXVN8eoaCFKUNoMH4AOgXLinKzZnFpyMtERN2uHh0hA6sQ6NcXj/q2zcvEPLHXn7TA8lkNP
	Ejt6/Do9lOZUOY5HhVlA8IIrAKY3lrduxaBOje/anPEKCiRghgPvdDFhItDsG6vb+qDK7Poy6G6
	m+CIMYvZEfNKjwgKcXxUm66d7S1NyRyTFOKg6VAb9XTlbwgXxiNCXGcZt6tVNPt2Koz/I/LTFrh
	AMBDY+YJ8O6cSfBx8LD4RFXbgKLdMqyQPyBc35ZDLZ778M+Ma8XzhBsDAWoUsqkM31GWJprOpq6
	85AwHDFDqB+6EkeeOfDfRu7LPhxhLJ9lyEyfaRnSBHJa+jkGBbKA4vu0SSkbx3I959daeerLIIL
	/w=
X-Received: by 2002:a05:7022:394:b0:12c:61fe:fb49 with SMTP id a92af1059eb24-12deac467ebmr2630916c88.6.1777610220521;
        Thu, 30 Apr 2026 21:37:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4372:f619:5d87:d4e4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df843f04esm1366156c88.13.2026.04.30.21.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 21:37:00 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:36:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: pcap_keys: remove unused driver
Message-ID: <afQt5iPgCcKmEwb2@google.com>
References: <20260430164326.2766500-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430164326.2766500-1-arnd@kernel.org>

On Thu, Apr 30, 2026 at 06:42:47PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Support for the ezx series of phones was removed in 2022, this
> driver is just dead code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

-- 
Dmitry
