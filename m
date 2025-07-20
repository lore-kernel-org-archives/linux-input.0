Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA52AD0F;
	Sun, 20 Jul 2025 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752988876; cv=none; b=pTsk3IjCdvHjg9vR2pyjQmrx2aKG3Caf1ooN2QiEYnFZzRYqHWmsmtzGxsn5E151hSJHoXd5Wspw7Of7+3ppq/JYm+BkYh/Fi1pdia3faYRjA1zVBbYsScw1TzxNtxz60wZM64+9DbQqEff6JnLC2f/XWlxig5BIRHGT0B/xVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752988876; c=relaxed/simple;
	bh=HGzzqhttBuHy7jJVC4/evAuQvPoyJdxCIS+/zXqhvao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+a44PRJKSq7GknWPfczBmlLEslU/anDOzbv46q9ouXE5/fUBtPwnskFw9ru+sFZvm2qHstPRou6Sih0pIPm+hGduhNA4QkZ2ftIfGuwXQ8oIWEXkP3Id10M2wCHmuLCU15Z81AEdsZojPyJ9/dz7OgKzknSLw39k6wLp7YRI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr3nUwDh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr3nUwDh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-236470b2dceso26527195ad.0;
        Sat, 19 Jul 2025 22:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752988874; x=1753593674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMGg4AkLKGPMTVfGVG5ofzNDTT615iQz+U6mvq38VhI=;
        b=kr3nUwDh6TU9mOe2p6MNf35yo9vnxwUyg8wrNPMVVfRiBdqBjDxm2tYKt8Qch7sFcL
         yu8vWcpkWPo4WmQZICRzBy3gcUR6ToqTh+aMKaUUirXNL6ui0rUzmdpxlzxZWv5SzzlL
         mBZ4OuakOTTMg1I6IiVlNl02PWU5phnpkLoqyfHt9wU+FNhT1NRrDiEPnRsn5deIAdkC
         BhwlDKzAO4M4YecVJBGACu990DlxWtjbv5SeRNjLL4Ci5xr6GncV64wGSqafFXw5isKg
         DeKCwr4lNqwiCH7wLWnmhKnRfo1cn3ITxCGsQluyW6XB+XK6MW8jHhgEa6SMPPR9euOw
         vjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752988874; x=1753593674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMGg4AkLKGPMTVfGVG5ofzNDTT615iQz+U6mvq38VhI=;
        b=kkjgOQ/IB0ZZah/o3EHWADHMTmjk5EY6PzIwitogIoP/lXuDNJaoRG9QhowiSRgYXw
         SH0YsYuYzRZjhCsDxrcAGNnACeEGcJMTNSXatLyGx6HSn757voqlxoXBcBGQrmA/1chf
         YlcIJ+YOrViyWNlslTIcKcRddgUZLuTU0YOtRPuUmMUMuT+5KwjS4mQWJqxHG+TLwxj/
         dlacSiEbZhCWSy1j7Ea67v0/H/con0kSsGABFIK8mDJOeg0wJRnvIkHp8XpryWN/SqGp
         w0FeCDFDYmZQmnQnBRaKrOsyq8Le4nbwPx8lwdwZPComQ83J8CHrU303H2Fvg0lKRDtH
         WwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYxIaBU5zMeEXn6nqvTfYGB3kd3ZXLLwrBrZm1sc2Ruvzc5EqJJoRDLRmqgeSvY6BGG/I0AjusDwheFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuedbzjATkqJ9DMP+AjwP5dz97XTm+488pa1VwQbtTIm4POjTh
	3mz5+3gDeTkPTBMJ2IYKxLDLrR04gbYwGbMGrnQm3NLDhFpJ3x200055
X-Gm-Gg: ASbGncthkMHswcH7Bqel8eMdlr9yRDVoS5pQNWT91wI6Z4saM0OZjQURIxrgePC1NwG
	WxY+rIhD7dv4b3RA2cvXtt2/Vaiyxkzg+JtS29Udhfo3hpLXy1dk5oDgFVCgUdHrhCQ+311kdEf
	n6AQrjSuX5cZQJBk9vY4/ZCvLLMxanaqFsDfVkFtGZx7Ee35l67wzpcL1kV6Z9uD3D/lQ1ETfIr
	o3kz1+7y7pw4VaeC0QMHlgJH4EglDd+rDDOXf/8oGnhSl7AYbnU6jiztY7UCkBgWeklHzNwKJfn
	B6ec2g+5qydtfuPE/h3HQ59juithUFzHjOd0IVBlYbHCMhRQCasZwVXljsNz85K5Tk2ENBIuevc
	6AbjoJ1qd4QoVlCKR/migWQs=
X-Google-Smtp-Source: AGHT+IEZbsdsJh8xom2c5btG/8m8lKMILb5pMA+Zy2UmMVWydyrlP4lJq9lp77cFtr/zo3/NFeEolw==
X-Received: by 2002:a17:902:f644:b0:235:f298:cbbd with SMTP id d9443c01a7336-23e256b84a3mr226821995ad.21.1752988873531;
        Sat, 19 Jul 2025 22:21:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3232:5bb8:d0ff:5d3c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1b8f89sm7883204a91.9.2025.07.19.22.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 22:21:12 -0700 (PDT)
Date: Sat, 19 Jul 2025 22:21:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.16-rc6
Message-ID: <uruhwvbzi2umwaqurp4scxx5ekqng66as7ffxatvckhcoxnafj@qizaztn42o4e>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.16-rc6

to receive updates for the input subsystem. You will get:

- just a small fixup to xpad driver correcting recent addition of Acer
  NGR200 controller

Changelog:
---------

Nilton Perim Neto (1):
      Input: xpad - set correct controller type for Acer NGR200

Diffstat:
--------

 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.


-- 
Dmitry
