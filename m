Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8743A1D02
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225706; cv=none; b=MHLzkGITVeWptPHczUOMIyxdl0UPzcUCtWbn0pBmRPYHa83D5aURvb4WibDdpakUFSpIvP7qonh/pfRdegNbcbro2VHFuGJfxHWHOeCMUenbY3waORxw82j+exe0SniUhW+LBO1FFTp5inyQRtVNkkixWdeofH6yiNrDSlkIpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225706; c=relaxed/simple;
	bh=DE8STg7I3Eb8mN4xOV6JAekN9N7QaYGIdD/CNfkfpV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWnC0j+ipWNhy4tNHdjiUBOQ1iaRVlVOw+Tmtxsjy0fNkQXhKyCQAL10nGYqoOQmHp76ft8xFRDjXXxwN8KeEnXegVMAkN7WWuu2rjOiTESXMFKyhMOMw0bTNRtUnJFUOtLXRh24l9NSOEU++XVBiKKT53P/tTO63OJKm61KLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C81lykdU; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C81lykdU"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649278a69c5so2241974d50.3
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225704; x=1772830504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulLsebSIV2p40P4IMqzfybXfTt5CRUe4kHCYP1SA7TM=;
        b=C81lykdUpccKCB0kMb8cx7UUqXU2qFWSrQe0+A1nCIY05Jwn4zvf6enSlNasJkBIJ2
         8UTA3J1SKXiIatmLSvZ8CkoAjYupNyYe2gpM/6yY9crPv7UYSLlQXyps6/uyQCbZnqfX
         nHFkmeMvG25Ag+jhiy+D3K+mZDAxvcFmj39UfyDkA6psJ/DLC3uoEbDtlxESt/aHRSle
         g/gUyuZRPiLHJYgoG7hGA2ai8HolgSAHjUSD9gIE9zOew5vULBpXpbadVjnKF1XW6Jl3
         3i91v/S0VZgQ0c7YgKzsIsKM6CHeAGjQqe3RO7yzeyFObfsnEGFwzZvBeJ+3ELNcsICz
         Oqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225704; x=1772830504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulLsebSIV2p40P4IMqzfybXfTt5CRUe4kHCYP1SA7TM=;
        b=KmKcS2XlAG5jBlBkNtfeRCi4YWXi+Twggwd3pdFyFIoumLajP1Uk7iz6W9/7AQRG94
         4HYsxu35QQ5V7PPbrND0A/qvU39BQNLJdjjBtIeRJz5RRJmUTemQD6NC9iCCZSg5yIOm
         t63z4pL+4UW46LatCMtffXta6/Zvz0r43DolGDZwUIAd/y4OyazTk3bYPlnhDqrV/B55
         kCYZFmNXVbZe38zJbf3ucON7Hk8+Xj7Uax3tRfmyLt8rMXe4EwUCwOh6poK0ClazhuE6
         EVJ+3KHmMEuV0dwq12bIqeJ+kbs4HT0yXOFe4N5OTELBlJKuplgufM6r0zIQiSS4Cgr8
         BqZw==
X-Forwarded-Encrypted: i=1; AJvYcCVdUnQvKWSx3JEJnzQMGSq5qO0OJap0Ytd+LcuT/4S5uYyBq9TolDQSZHDz1WwnjE8sy5m9GcmaxuSVgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FaYZGlQMh1oDCP4i8TPFQpnkR6B89J1O4vG29i7Migvum9nI
	RwJWhoO5hX17KcyiqxN+3rfR0fK+94E2e0HHcv2yuh/r/zPyJU4WVnek
X-Gm-Gg: ATEYQzwCjW4fVYv+bQ9dX9oqxP/Gi176odOxe3SoUAvXFiHY44+U0B7Z+UtTFUu0rTL
	WucEatIj0xH3qVdZSP0uYAICKkk1tUFMvcWdaa60o4jneSiBWmAnegNELQnv72KlwLX6CHbpmYd
	hl5TGpBZUUE5M/FKm4YZnB/Qycy0Fn3PqEhme/ooJBfMOnqaVuLuES7YEkDMeJUXhuPnrF785jP
	Ai4QSuVHUv+ZuEZwzpg5OokWmB/GFxDZ+7XoBPcyXe1CyWgrvVF250O8lgZ/xU6fml+4O9RSVJO
	9r9hJQY1Iawy0TQLt2ae3d9h/k5YP7M/TlITxl6ajNhl4C8xOPMH4YzpTkBwpcmVkFMPeC5+sr+
	L09JxunRJJiLpZnwzpGl2S1/5y7c2OHM4GQLd5PaJMUp9S4OpWfxf51u/z6mw9qSQkVv+l5IgV+
	fYZ2TjzC3HzAARkU71EDHUcZVmaXtDXQKrCUCYx6yrPAIDW9RWxvGYZKopj/iOcgGQSTod2tHfW
	p3BHHhENR8yh1awQPrwmJhD
X-Received: by 2002:a05:690e:4186:b0:64a:dafd:2102 with SMTP id 956f58d0204a3-64cc2085789mr3335219d50.19.1772225704258;
        Fri, 27 Feb 2026 12:55:04 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7571e00sm2805811d50.3.2026.02.27.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:55:04 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 0/3] HID: hid-lenovo-go-s: Multiple bug fixes
Date: Fri, 27 Feb 2026 14:54:41 -0600
Message-ID: <20260227205444.1083103-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are three simple bug fixes found with Smatch.

Ethan Tidmore (3):
  HID: hid-lenovo-go-s: Fix signedness bug
  HID: hid-lenovo-go-s: Remove impossible condition
  HID: hid-lenovo-go-s: Fix positive promotion bug

 drivers/hid/hid-lenovo-go-s.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.53.0

