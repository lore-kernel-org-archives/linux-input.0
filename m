Received: from mail-qv2-f40.google.com (mail-qv2-f40.google.com [74.125.230.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD049C4A9
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162804; cv=pass; b=cPEmpW1RoaR7XBZDGvJx27jkOCFFxApV1Ljf1f4Nlu6iIPzFx8SCQfNzdV915I0B+eiAr1SbTy9ZQrJIPJyatEZy+V1YVgt1FppZIX0v2UVlfkx+0pbDssdSba+Dat1wQWBgsiHHTshM/CTIORGDFN1xPS1FYIRXwzm906XaX/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162804; c=relaxed/simple;
	bh=YKh7bVY6JYW2EMiYmIgo1vZA3LIPcnqfDJbY/5X+7R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBVv26WCD3lP7htOeaQUw0ZV/3aXp/VYJlRr657az2qCsa5Wca92oued5WkO554Yql2C/TgSmOwQFjR58/sRpELqiueZ/Ulk9Jum5FCPOnBqZAVmcRyaTVAqeZBpu7PznEF+DsO6jJWxPf3nt41I9aOxUOp1rXnYLISvoKpKrCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMZJ/bGw; arc=pass smtp.client-ip=74.125.230.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMZJ/bGw"
Received: by mail-qv2-f40.google.com with SMTP id 6a1803df08f44-90cdfe57a3bso6315736d6.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 04:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790162793; cv=none;
        d=google.com; s=arc-20260327;
        b=DZgRgG2AMvT41Oduq61DCh/MH2VFhAlt3bhYlkvH2pdMEj+XZ8zr01w9DAMWOsfSAb
         taub7TZRm8fPl8MwqKcImt3kovbeluopJKmnGjW6eQbMzXNFwDkwd2QrIHNRM4XdBtP+
         Tg0EU2Pay78MtWsMrGerGfNDzm3XuQ+HwfHzFYvV6hDma+V9FVzRMwRmMlvznx/XZNTX
         r8XZ6rfWo/r7RnE8e7V+1Z0+PqxZ1OJExI3BhoLxeYAhqrVRCWzxWAF6w+yIxDFwbwWZ
         A6YrEPYlMNsuMsLO4kslbbQckPrQrWTDY6iDKVsiWD1nHjqnCv3JdIbRY1fhB4gRNQWD
         HAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YKh7bVY6JYW2EMiYmIgo1vZA3LIPcnqfDJbY/5X+7R0=;
        fh=7Wy58EzVNX1vgXKfeaVgCofP1U8CpCD55091GFG9yzY=;
        b=dqEl33oQ+mjYZxo50lyPYzIaa4lsdM9Jjsz04yHZUjxD40IFcsSMD+1twOw0DmjNUn
         eEUt05dTmEA2/j61LmiISceehULi0XOsrHSaQnuEQh3W1eISCE5uOl21RC5Ecb18Hv+u
         q0FOprQC/zn7Ho6pKA73GtmZeCaqAzK7b3N6RqLc/fHYusn6sGDqDkvSQN6y/6QuEA4J
         v+Yh3qzss+JVBvPwlURhBYT0kj7qh3yMLIOryb/hqDW1IILF+8OtRay+moR31iq22BSN
         pWjIKcbxYVT0z7AG4i2MDUmUS5G4zanwpSK8dcZSeolGQjlRZwPPUUkebb3GMn01etTE
         DAEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162793; x=1790767593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKh7bVY6JYW2EMiYmIgo1vZA3LIPcnqfDJbY/5X+7R0=;
        b=mMZJ/bGwlaGzw39jjgqptO6RYAEw/q6NwZZ1jI5vyW6T/5bTg3uNUZVnwHFzt9M09b
         A/09Q1RDuuGjxTn8JvwJvQs8m2NHYykp4n4NxKkkxJKx6MBT4ydtqHLsLdlvc5QFOSI1
         5+I3ZhUjBJyUVW6khH1TkXzkGtqOF+4AMWij58GF2CnVUI2pfrt4oTLdCV5RUOSbSWf2
         KcgiLsTye59A9Z/etaJFNsatgWX1BLISjrOXuXkYuZYmUTPCOM7M6FpfTtbWPAc/xOPT
         zU91DcMsxbzQSMZmlp6OX/KvI9ZnTUdCQWLbRThZNu00G1IsvEyda9dfAe1m9NEg6yJO
         /V4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162793; x=1790767593;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKh7bVY6JYW2EMiYmIgo1vZA3LIPcnqfDJbY/5X+7R0=;
        b=LUveNyXIC5YiNhT1zTdfp3733WzI5ZOdal+gU/nfJzIYUWNNf0Kiwo8QsjSW6itm4f
         foN3tn7I+cKxXwLZ3aF8vH8dbAm5Jhj8JZvm9vFxI8QKFWhcmxrYTwC0XlOKuJzbYrNw
         oaVNIbYk4jaZkle0bIq8coUcYSuXyAea5qcVfx4oU3Jm70FCZld5MnObmS1/g5s9j4jb
         qrx9vKYj/Rg1b4YTXmAnazzNhkznvE758KQcnd6YxLlpZRVftmeMAV+E5gXmoWJAnUml
         LclUmT3GuvTBCQNL2WFpPe78KO1HGVdSGFE1B33TTDhvGtbVNjboieDvMF0Ng1XY6jNZ
         59cw==
X-Forwarded-Encrypted: i=1; AKwUvBzurZLLRAapLbZdSNs6YkgE9sdGa62w1ynuF+nrqIZIUdTuPo+2tnflS8B6yReryXdELAd1OF4iYdHMqQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m62+Sv/i4g29eF6HcXVnl/DKsYa2XbAsZjzDe9ILbRvFuy75Q6
	GVT1y3Ylojc08j09N+3qKKUI1tjw0JouWm6+IqA2BVZHN8rP4HQ3/aEZP57cONSfj7FZdtfbajc
	kp1o60EFeY+ExXFkXHAngqIDUEp7CmP1DLStRW/+hKIf1
X-Gm-Gg: AYBFou1KowPgFa/KuRKwO/rH8Ucz+wg3poTva3TZQ+mJSl+FdoCkOYTMrErkbiyrDo4
	7RAtb7iOfO19tNF43AmpbXgjdXfP8+UJVEv14I7hg9HKnJtuMT244c43ju9hcd2TDJZVfcLKV3Z
	Wj8/ZwU3xwB2doC9vVFajJGvlVkys/sg4I9qPuBXdLFH34CoVzUoowy1vOt9qgONdzQguzsuOm3
	+ifLf3eg6VxJI/BaF1r97gAzSFtoURXYoNZFseCRnUtshWaXUQxYhtLj69Lq/KH26X0Rj7I/rGN
	6OPvBl8128GKmNzQJdennGPuhrcATqancAU3U85xONX9+UrwCzElSwNU+w==
X-Received: by 2002:a05:6214:4b0e:b0:912:3c52:5e72 with SMTP id
 6a1803df08f44-9140c1b4422mr39057966d6.0.1790162792723; Wed, 23 Sep 2026
 04:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923105215.1633-1-anykey196@gmail.com> <20260923110236.CA7FB1F000FF@smtp.kernel.org>
In-Reply-To: <20260923110236.CA7FB1F000FF@smtp.kernel.org>
From: =?UTF-8?B?0JLQu9Cw0LQg0KHQktCd?= <anykey196@gmail.com>
Date: Wed, 23 Sep 2026 16:26:21 +0500
X-Gm-Features: AclHuK9metqHwgNkcVEJzrqMbgwYmoN8PIfNcC97UYtxIwR3y1ghSLpIZWCE-9k
Message-ID: <CANHPwAQh_47zOmej2yo-kGPV41xWXqgUbWTZ=zjhFNL-0wengA@mail.gmail.com>
Subject: Re: [PATCH] Input: axp20x-pek - add AXP313a support
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Thanks. Correct: the AXP313a register map ends at AXP313A_IRQ_STATE
(0x21), so AXP20X_PEK_KEY (0x36) is unreachable and the
startup/shutdown sysfs files would always fail with -EIO.

v2 no longer reuses axp20x_info. The AXP313a gets its own axp313a_info
with no start-up/shutdown times, and those two attributes are hidden
via an is_visible() callback, so they are simply not created for this
variant.

Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a).
