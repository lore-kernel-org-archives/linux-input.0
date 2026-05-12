Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B181D5CC9
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549008; cv=none; b=NGYniGfny+xPQO1MH4NvoKhK1sAOvL9Hp3/MOcGb41QsKkqohlzX/6SoyeHwXd/1d7NaoNyKcKSgSSFrRQUquCSFiEz3XNCgTvU1qrla6kgjhbx187ef9+cydYzrPFd+0r7apt8wczVWqiqis0NrGagNvj5FekZNirgm3dymS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549008; c=relaxed/simple;
	bh=OVbT7GrjO4bw54kW6wWdnEsBmgKNZjPUqoLO1KwrOgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzblXxUjVgGGHodybtXENSGbJDodS6Cb35v86SRN3KNZOQCxWlmGiWQr+woHjkxas556EXCBgzQkrDXd7M7uzdAKHVO6Dlvl4L3P67bxGubb478VrIS1qiz9rV4JLloD0hn4cHIpU9HGDvAeHkPWhCHFAHLmHTC0A+94RSYR/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=eXfew3S5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="eXfew3S5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f33ae12f97so6064961eec.1
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549003; x=1779153803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWaS1RB5JDYayjocwxCsK8mCDmJHUShMMBNotDmrnWA=;
        b=eXfew3S5BQ3LZrSOxBKdmrBqwLaxgKODfVruqdWB+jobv2hEaGgwaU89DNouwpDobb
         cmGdbpbD7oZ6VK9h8sIbqa238vlkHhJhjKKzn49dkg786P9E6fCp1KcHu+w6Oz6BlFkE
         BdCHooY1Fqc2MVfYgd90VlCsnZ/uRPhlqmVT3YjeSMNAgKFh45gqRRP3m26Ffgf0DkRI
         YlzYSky6V+sWAmeEjY9kXaiwV2wu8X7WYFsXdayZor4NgkYY+RZzBeHZaJvypUKVnIWk
         ml2zOuNUfBBYrE0iijEQFEj3LvguFSO5wpokvU5zarOlqYk70v5tpMeu9d537Fw2ctLB
         Ui6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549003; x=1779153803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWaS1RB5JDYayjocwxCsK8mCDmJHUShMMBNotDmrnWA=;
        b=oRD+Q4sH1RxF7vqObZJS/8T8JUrpcBcrNQH/UEc0223vNWJ16avWLfkJbyn3+p37W0
         ozkgYX5Ya2l0VM5Hb6gafRWQkihcvcL3BprojYeii4I54v6y7FvOGdaZrFzOWvMIxVBB
         h6KKt37j79d5Rb2KNIhDExBynCTWHyioeMqC+hCbMXdh55vu5exBKkAIUY/bJ/YHm/Le
         Gbxqe0cWlb8bJpKFiKX/yV/MUE7lb5YV4ffWRnKqtbSUFJOV+b1vXprFDHfer33xNAO8
         MmUJJYiyxqUps28VnT52LHaoZYa0tajjig6cSWTusQyxC9QB+ubSet0V33B68CHNANht
         2r1w==
X-Forwarded-Encrypted: i=1; AFNElJ/RTh6J4uaGgCwHlw4QkxxvP4XXOxIDzkT2W2SIyuV7spHy9ISrM7SEfUx3Rq1tIt23pSW81QQtYdpvCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQZCTkkfIGmoanWsZYM1WmWFn98m2t2ZjUNd7pbOuNy6juhUn
	NIwUROvlQqT6fmbTvbUg+ywMCiefdws1QfzWIVs8RvC46lnpaVMc6iNM02M1ofhmJoI=
X-Gm-Gg: Acq92OEzSC7vl/ihrDv7WX+R669RX5MUsYMcViQQS/RyQLbbKV/zo66suDg9sSqQuDW
	s51xWY/EWF6oVHznh+s6pUVVuN3Xit0QAlOhyIj5ZbJyvqejd9Fs/Bml1Cg42KAjznHmHrBrFV7
	HtoeZyZJCvBO4IPduLtCEv6HhXSZqyvG7SgmfA0X14/iYUEFOc0ztXY3Cpawgr+5FH/9+jtVHUq
	zPPk46NRdE5njVRgh/JxZoKLz563ZDk0wV/u8KCusvdhsb/J/9tnJ3YxdERJgZ1YgCcXUlSZ95g
	gem9iYG1Xlibgepm5OAKjLEAoIxJKOpRdn0pdLMdmNwPaf05pl96+WNlWju+GQwTlQFvJ2dwNvZ
	GkmAaygzLsbMkDDMMMvqssLZF7BShgtkAmZmaFUM04DMx+tnw9CbzHWKP8Etd6eZSSqqTPWXtTd
	ind6O2GIywpk/uFmihJA702zWznVN8Ag==
X-Received: by 2002:a05:7300:bc0c:b0:2c5:ed1b:ca9 with SMTP id 5a478bee46e88-2f85bb72d01mr8468512eec.1.1778549003223;
        Mon, 11 May 2026 18:23:23 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:22 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type initialization
Date: Mon, 11 May 2026 22:16:16 -0300
Message-ID: <20260512012302.20883-1-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series refactors the HID sensor drivers to standardize the
initialization of the iio_chan_spec scan_type structure.
Direct initialization using compound literals was used.

This change improves code readability and ensures that all fields
of the scan_type structure are properly zero-initialized.
Additionally, for the hid-sensor-accel-3d driver, the channel
initialization loop was refactored to iterate directly over the
scan indices, eliminating redundant logic.

Natália Salvino André (6):
  iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
  iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
  iio: light: HID: hid-sensor-als: Refactor channel initialization
  iio: light: HID: hid-sensor-prox: Refactor channel initialization
  iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
    initialization
  iio: pressure: HID: hid-sensor-press: Refactor channel initialization

 drivers/iio/accel/hid-sensor-accel-3d.c       | 27 +++++++------------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 24 +++++++----------
 drivers/iio/light/hid-sensor-als.c            | 18 +++++--------
 drivers/iio/light/hid-sensor-prox.c           | 19 +++++--------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
 drivers/iio/pressure/hid-sensor-press.c       | 19 +++++--------
 6 files changed, 42 insertions(+), 85 deletions(-)

-- 
2.51.0

