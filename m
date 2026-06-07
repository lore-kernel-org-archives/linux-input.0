Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A4175A62
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780808721; cv=none; b=npVQf1G3/xJJRNpSb5Exz/FIjyvvPFX4xYxQitJQKIf69QmXjhCoRg7OsUxCCryrhjcf+srKiXTiNjrMK5lZE6XfVeCDpOlHzBaEQY+a+uDrd/BW+gO929xtplYpARa7x52jv2zfHPyZMgO/jRsM8AxxkhLdVRmK0GgkUswlyUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780808721; c=relaxed/simple;
	bh=qI0KxIO+bc8B+69S2f4O9lFUJu1pJEy9qvCa/gzPVvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=opuY8xR3fP7wp/QfhbZxUdTn2TmQfjulEdZcg93sm4CauyZD6LpqOFTMqXlbO2ADTR1lYfvDxQNWzM0E//uZzZBOEDhJ+eYFnanwLC9uJc0rgyqaYTw6feFfHPFfyWbiIcrZY32LPzgAI0FQmDURq2w0CKMyzmHY9IDROdwVVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUufj6cj; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUufj6cj"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-307631dbfedso7299936eec.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 22:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780808720; x=1781413520; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zceFH2gCudMO0zD9UBHFM7WELmud2OIi/fsRzPFSJ/4=;
        b=DUufj6cjM+OC9eeegBjF2+D/w/LcOuyTwD1wEe3pJbPVwxYeSQpUrijic9yAzGOJNY
         APGNMWA1excyCYDe1BHZ5uH6cNUnGDQd4u2nSW9mbNivuVdI6vU4XtBVwvWtGvK8iQdw
         oRAMagt2K9kdF/XJki+5xb58WTlGBKuF4miwhSt0RUgEljUcAXqa/6GVHnatpO4hriNA
         E5UvMks0jIAuYrL069Yg/RqYK05PmsY4JeePh7fCF/cZjdLyodSliTQcwbZx1IYJmkTv
         oCOiESzJV3koimafwwZEAKP5Q2q1vIZrxStmB1Ei5rN7yOtmSwXaF9Ca7Wlj5k222G6T
         Cs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780808720; x=1781413520;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zceFH2gCudMO0zD9UBHFM7WELmud2OIi/fsRzPFSJ/4=;
        b=fG5W2HNpaF9waKbI/V653W3r5COWGUngm42hj91pKJo+1PnB6dEDsGo8WRfxLobJ7d
         5R7NmlDRER2qVy5oaQRmMweKV3sbT1m4Usu/mli3g2MIZx2CugZViBkOR0NWDrC1UQ+U
         6KV24S+qWOQrdi3wQN3U9zN9Hcu4Ux9+lFPa0JuBC7bfb1oeTAZD2v8MRVBakBT7jszn
         8BW1pRUiQRPxNCYjHHScqV8seLuER6HgYSsUeoYQWMr0yoMMHY/6OuSwxHpF6m5EI4nD
         uG+tWXvg+PpwAfMJ6IXWPhqBxt8jTYaiy/Rb+wTt80452/Z+KZeSmU4ojRXyWfauwf5P
         urcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gRkwvK9wWLMeQM24roOIPAzMSl7XMGce7yUfvLLDFsL7gMyHmLRbQ+KLuQpcpnoTm8siLIiE2ir1byw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRDOsPQ6EVFe7oPcUD+5KGVhc3NsqFTxaTsBKzSQn/S3zHxDs
	HxdnSKBP0bDr8EQJ+xGe09/XLrfcHa4bNfLrgmkaEFrkl1CnWKw4M5c/
X-Gm-Gg: Acq92OHQLkK04MG8LoQ3fRZenTuEzXxxb+JCtZNqO7H2cbHKc7vt+BF6VxozeBvH9fZ
	AZl4vZ85XHYYcY67W0gHIvoTWV6jRzV0pAi6U3YTWuGffGgQcyFThPYxyvHRdhg9Uo9au/AE6UR
	1rXafcGeMo4D7xgKhY1wGkC+XYiH73GAHmEeyjd71D5vAQBX9AReIxq8WA6wzF0xu42dlVVs+2i
	T6Qi31tHgmPYN/UtUN5LaL9jPnT8HcagqqG/sDm4u8GYimS5CWgQuBD2foFcBAiteSng6UqFN+z
	WeHTTx+OGHNoygdGNJ1ucxvBEXcN7584ju5kecz9OykyhxHwfaDxTaJcmFl4f8fbtpubbVi6tUj
	dBHRgmQIatC3QBkN2qKXwOByjgoxm+HJw+RMouJCo/YWugewSoK2SOVgcbiPVlk4KigMc99h6Q+
	Lcb1pk0wHYeMD9I6Dv2KchfzaRZu8LnNWNTrt1ncQUbV4NEezsT9gWz+VXXBLh+gbhCKNmKDINZ
	Lb2LrMqyrI1SQ==
X-Received: by 2002:a05:7300:fb91:b0:2db:2089:460f with SMTP id 5a478bee46e88-3077b47a281mr5714239eec.19.1780808719532;
        Sat, 06 Jun 2026 22:05:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea89easm13428874eec.14.2026.06.06.22.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:05:19 -0700 (PDT)
Date: Sat, 6 Jun 2026 22:05:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.1-rc6
Message-ID: <aiT7-939zBREw3FG@google.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc6

to receive updates for the input subsystem. You will get:

- two quirks for atkbd to deal with laptops that can not handle
  "deactivate" command on the keyboard PS/2 port.

Changelog:
---------

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Zeyu WANG (1):
      Input: atkbd - add DMI quirk for Lenovo Yoga Air 14 (83QK)

Diffstat:
--------

 drivers/input/keyboard/atkbd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

Thanks.


-- 
Dmitry
