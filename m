Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426590;
	b=zRd0l6MqWLSroNlG9c5ZcGEp2niXw1N2XbdtrpiUAXBVoz62znszOqgWmlURa0H1j8Xm
	 vF9tgeeJH+IwOQbfnXiTzmgNCRwt0Y6QmUgjP5+KJmsjINfYr+6O7xXdhjxFrYfB7XD3O
	 wIu7CJ9IqTnx+QGYLZHi6EiLk6HgpWShZJzYZn6KI7vAj9KqJcQHiMaKcuOM8fAHiH6Dz
	 E32foQU1akiT9kZskaXBRjTBNaUEt9NZ5KFwauCZMtllqRjOjjtwDtAoe88rKLJgS4C38
	 qemCXYEcJmNw3U4avBdp82QX6jd7Qrr4mYLOTiw+n1z3gWwTkg7O7MgNrFJazAWPrtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tWMbiH1ZllDhFsIxq3gitmWeOGpdMedMJ/cafKoVRxA=;
	b=n82pZJHbSJvgCFlNCNzhkKrq0EedSEehKqy5NEiZlCnBTRuq/nUjgE0tfcChu4EtzS+j
	 GfSfP0Qqwos2YQUSAI3xH7QAW2XappKAqFxxmTsD2XIFNZNfH+7Iz0YJwEb/Y/5YoK+rA
	 x+U14O1gPmGKQGMRGnMvkrUMnjbxpETrQCZ4N7EQoaR4g/EymM1mUQ0Pz/NlnkFqi1NLl
	 +ay3yblaKZYVBmzdUhIbn2P8oitCkh6rlfSvPcACGqjyw056sN3BtDiGJagoDzWxaPLzN
	 p01Y0O7HgGmurA5ONgNumZ88U2yykMXM6VA6tRgER3P11rTJ3d6VOjldFIjbhLRPJPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h8/PDIaW";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBF606A330
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 19:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDBF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8/PDIaW
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37000e7234bso2405344eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794426589; x=1795031389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tWMbiH1ZllDhFsIxq3gitmWeOGpdMedMJ/cafKoVRxA=;
        b=h8/PDIaWUu8ThPkveSNyxPXEPaPbSPVST5uf1L8eH7xQ7GYbuf5zem5y+qootcADjt
         EKW+Wr3elTK5senXKwLPSAECFrHDjGFRcTlWXZ7E+NPII1+qF3U9qwLuW0t3n9rWb76Y
         rcV35B5vb15C3y9jSeYeV9EEsdVCCoIdqBXWyNMYdVHPMbHplUhudW0QSCJX+Ho0NbqP
         pHpYfMZ/HNb1qARWiMPmuIVvJFpZkdAJyXKoa+JfjjC4LYAPIOri5MvJUmqfCY9T4t8S
         qRW9dpgwFxxRZ4yKBxOEmsIsTfNihDJ+nmNABcHtUxoSPqq09aAt5GLCP1zLircee5sy
         +lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426589; x=1795031389;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWMbiH1ZllDhFsIxq3gitmWeOGpdMedMJ/cafKoVRxA=;
        b=a5eOwvup5QqljsCGivfZiZLTyuawR8gMRa8YdAEQJW9XHRa31LOh8nmzUgtMQNLkKU
         0ApQq+tx3OAToee4gVWQlVns46G8E2QVFGmaCXWtenc9ejpTE6V1tzHXgYp1/Ig27dzJ
         yHRY7aLm9Qlf4RkMTMaNpkFLXstM6+IwlztN/u6Jsv5CRt94tm3Nu0+q7C6qkCK886w1
         Zf3CmROro3l+P29hp5wx0aEXFBc5PWn40zU2bNyBiniWXbWwa/eCT4OhfwZg88Z8VVXT
         74ZcXzxVL+qrDXyA9OYQE1YnmmUGQlyITIkAIbPQtbuJIinJME3T2WsFi6uYky87/O3J
         I0Ag==
X-Forwarded-Encrypted: i=1; AL+hErG+tOhgPcwAfLw+svwxomrI8ksF6YFFO2Rw7cSHH+JKctYCJqlBQ6C9DJe9iXI3O54eGp4j1gxvtJ0NZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LPAMfGdqlt2N/kyMnM+OBHgfuReZPX6c9JO8oF+Sv0436reYX
	rQNKZ2dIVVTgf7X8EH93D4PiSk9JX2XEsIzuAwxzDXLHSTAH4nK/0M21ZCubyA==
X-Gm-Gg: AYBFou0841Fan8xBaQB+z3Lo89ccf+B0l9PGD8/4a2YoyirFQxuOs+HkYUZIRYsSW5u
	oTGpgDOkfSg5n5OCPkC+dyGjpAbVJClOsPVsi/pP9fwCNvzrYGyRr/PwlHuc5GQQibv6fOy6z2W
	IFLr7YlzUFY92VATN+4mDOVUFkXIG/loOCgtD1csxVQUcrnNYq9LcaTZUdAGs9VK5sy2JtfX2sL
	0c7QLvAbriraM2yaLo0Q7c9canvARe/69E4+b5UGUeHgl5GkiJW/q5gWrH/dCbqyLC8kCNtw8kl
	cDx5mCoqWrDT1Ydl2lDXFwbqvYuxwjpthMmUwpOkY1XuERHHAorQywAliUj+7pclmEU94Rn+mDW
	ZVYFpMS438R3/pBq9cB2tuyvpYyZ3M28NlEtidU6BBZnYGt692A3kuO7qS4Ujzu7ayWIKn9iRh4
	gBVMBtx4EBIA50KQl2og7x6blW7tjZjthVRu56NMrF+p1K9aU2jiRnBNWv43aCaPA3ykysFkCP4
	PH34OwLnkaN5UcpEha5LTwGk/oYV+9LC3BCizW+NgBGWrI6v7qhaq8HjUXYjxW2hVUyNu5vFHH0
	ZT21JzY4skVlEP9nylSrueDQMIWxAq+WnZxhdC1SMcikSLtph6GB4Od4UqYRvqN2D5EGQx8=
X-Received: by 2002:a05:693c:638e:10b0:375:dbeb:b363 with SMTP id 5a478bee46e88-37686d341eemr3916361eec.28.1794426588437;
        Wed, 11 Nov 2026 11:49:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3766146551asm10505501eec.1.2026.11.11.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:49:47 -0800 (PST)
Date: Wed, 11 Nov 2026 11:49:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Juan Parrado <jparrado.1817@gmail.com>
Cc: sashiko-bot@kernel.org, linux-input@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev, Juan Parrado <jparrado1817@gmail.com>
Subject: Re: [PATCH v3] [PATCH v3] xpad.c - Add support to Hori Real Arcade
 Pro 4
Message-ID: <avTG1Mkv0FLBGLPF@google.com>
References: <sashiko-outbox-204846@kernel.org>
 <20261109195830.22156-1-jparrado1817@gmail.com>
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
In-Reply-To: <20261109195830.22156-1-jparrado1817@gmail.com>

On Mon, Nov 09, 2026 at 08:58:30PM +0100, Juan Parrado wrote:
> The HORI Real Arcade Pro 4 in PC mode is currently recognized by xpad.c as
> a 'Generic X-Box pad' and works out of the box. However, this generic name
> does not match the actual device name, making it difficult for users to
> distinguish this controller when multiple devices are connected.
> 
> Tested on physical hardware. The proposed change works perfectly as is.
> The MAP_TRIGGERS_TO_BUTTONS parameter does not work here. Other arcade
> sticks use an identical configuration, such as the 'Street Fighter IV
> FightPad' and the 'Hori Real Arcade Pro.EX Premium VLX'.
> 
> Signed-off-by: Juan Parrado <jparrado.1817@gmail.com>

Applied, thank you.

-- 
Dmitry
