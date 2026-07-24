Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038734B682;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913275; cv=none; b=jN56WRBZVInYCylpRDFVLWyCKrbRufc6k48FoZF0PJJ91UOJ8ZEtzlyczVpn+WX1y0c5tQBwyGIAljA7gKF3ys+R5d+rSoYiA3xIW8nMGEbs+49FthhOKWm6pLzClDYSwd/6c4eZ6gE79/u4fuI0xiGf853MQ/NPY4gWQ1I76wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913275; c=relaxed/simple;
	bh=VLmbC918n56zU5M7ig+ixBQFXWMbfyQwjpWwHo+6GOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bmc1tKhL1FCWk1MxGamQaHIYt/QbOc8ptD2u0Gc97Fu5CXkrNxPWhDCBYT8KJX0NFxgr6pDhAzXE4uwl0vJSOaoYiSn3tDJK3CZqQWFp5RvsdAp1TvA8rvtjlstzr3ILi+g+sCi2axBbvcVqKSziBOpHo+sCHReAo0aC0LwupFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaeIIs93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaeIIs93"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DDA8C19425;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784913274;
	bh=VLmbC918n56zU5M7ig+ixBQFXWMbfyQwjpWwHo+6GOk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JaeIIs93PyeKnhpT9KwV+IUWpZlWHaM/PuF1ZwhBhLuLVd1mb4hDK/FBs8wZrnezv
	 2Er/FhCQ8z4SYNb2Laap0VhK7VnK8ORVsyWAqLyiejrld1HjbSIKIzE2YFK3mOsp9o
	 m1nfLjM1fD4JXOg8ZI+tOgtazae8R/gwOmVbq2/d5tSXConflsMFzBQTm9m3JWhbFh
	 7k430IctxhgpwC+hJSwew2/BD1L5wmzHSb/M3CYc3c6d57vfkFpHi2cn55D8uVxUQM
	 1Yx8his63KeC4fT15yl8nWesKZaPwvbsqQFf+5onDcnQ3s1sHoVXsNkHJh5xsLyWgt
	 FyfKbGV/rkTqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA8C531F9;
	Fri, 24 Jul 2026 17:14:34 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH 0/2] HID: iio: gyro: hid-sensor-gyro-3d: probe cleanup
Date: Fri, 24 Jul 2026 22:44:29 +0530
Message-Id: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWdY2oC/yXNQQ6DIBCF4auYWTuJpWCtV2m6sDDFMQQMFFNjv
 HupJm/zbf63QaLIlKCvNoi0cOLgCy51BXocvCVkUwyiEW1zExLLpuxWHNmgXWNAQwu6YFE78kO
 eUXadukoS6t4qKJk50pu/x8XjeTrl10T68+/Cvv8Ayi8fLoQAAAA=
X-Change-ID: 20260724-24-july-hid-gyro-dev-log-clenaup-488534e25965
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784913273; l=753;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=VLmbC918n56zU5M7ig+ixBQFXWMbfyQwjpWwHo+6GOk=;
 b=KcqKL2wXwE3y3Vm2P5JHnSR3tQP9UOLP7s6WOkdFmhb4Ah9nqWFVe6EzsBTYKO++vlbZi13Sv
 gUFEZWiaOSUDtFBZNfaRciSk0ZeUx0U4jYOco7QDFH3EPHj5CrNxqau
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

Hi all,

This series cleans up probe error handling in the hid-sensor-gyro-3d
driver by removing redundant dev_err() calls and replacing remaining
dev_err() with dev_err_probe() to simplify error handling.

Testing:
 - Compiled with W=1 for each patch in series

---
Sanjay Chitroda (2):
      iio: gyro: hid-sensor-gyro-3d: Remove redundant dev_err()
      iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe()

 drivers/iio/gyro/hid-sensor-gyro-3d.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)
---
base-commit: 36c12dbda81c284d72f3c64689461647497b643b
change-id: 20260724-24-july-hid-gyro-dev-log-clenaup-488534e25965

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


