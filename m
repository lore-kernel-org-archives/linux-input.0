Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C340DFD5
	for <linux-input@vger.kernel.org>; Wed, 22 Apr 2026 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819856; cv=none; b=UQLjIghUNFWwn3wcFVccG4UAKNAotASaSocSgLQ/XjDkhZxdq74uUU3SN6oKMeOkXfdQKIOCp2s+R2FNJ5U1nua1LbbtIt2r3TOpCQgq8YOwg/5jL2Wv3KZKaIByCKieNuUsZXHHB9esfUZqlbBmF67afBEKxqe3I5aqtRlODck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819856; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ey32kpuORJ8neQHCvXjepH0Q8P31XlVxC7JbxBJPI3dxP40aRQ+BSq0qN283G0XrE90EmlC7RIF5b6UWniTUO19vzJOUarmfgyBqUgNaZBQ44mS2h33m2MJu+YxROf7WpwclVpYF2SIzgVYvtOK2nNXvOZm92W0Sm4b03zBmKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6946dfca922so4165761eaf.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 18:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776819854; x=1777424654;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=lmq9y655GAQ6X4U9tsiodKK09osqnfY5zXoUuoUuglukHMfzdlXwSUSS/H2fTZU3YX
         dJXlc+iAbhm83ko/73J9mSmXCtpJglskV4WUkmF8MEz5NG+G/w0hbonV0f5yQvWVHHTH
         A4m192j0uAMOAI+w4qMGVIiJsZbCV61Nur79RITRRUt2aSSjFnUhMMbmxj2nq5c+Uz0j
         X/sTsxZYdCEYY755jg/rTo+h56sMv+fdqDEkTBuUqw9H4P1vBHDDRwTJZEPbe2OEpl15
         fJUWSSOBb5KZY+hpn8oieXmsH6CGjR8hCaHN8BkZfVQQ/4uwEp6UBaUucNwY6Uw8z0qY
         u5Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8mIn9mKo74JIYDQoueGGp20BxEVdPM2V3rPvq1c990iuNOn8y57zYV3yaymjN4KOcE/nYJANoMN6Zrkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK//0SFM2ThKHe6h06YDehesuDmlEuZMwCpd4nP9vkk6C1CzWE
	lJJHLbku6BLke8aba+c2bIlzfSaCcWvwrpk8bjtWLfj62OEvuZa15AId4jnI0uLGv5vVQSIi8N/
	dYmJcUUvUa8kDNXbU41UZRjI78GAqrlGWer+4HFHLme73orWlv+p8veVMSFg=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d09:b0:694:95a4:6c9a with SMTP id
 006d021491bc7-69495a46f37mr3578792eaf.30.1776819854571; Tue, 21 Apr 2026
 18:04:14 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:04:14 -0700
In-Reply-To: <69727536.050a0220.706b.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e81e8e.a00a0220.17a17.001f.GAE@google.com>
Subject: Re: [moderation] KCSAN: data-race in evdev_pass_values / evdev_read (13)
From: syzbot <syzbot+1b327485934adf39955b@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, osama.abdelkader@gmail.com, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
