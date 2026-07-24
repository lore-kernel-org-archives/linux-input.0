Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522253A6B82;
	Fri, 24 Jul 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914057; cv=none; b=CZbtKKJMoGzQZPtDwe/F8K63/+NZmcfdyLnpEXEO5M8bWfn3zY8vmrpT/PdxMHvNf9x4J5JNDdfQB35ZySFxit1INXWTssuTqI3k1ekJB0jM2ZeTsjXr9ke5Z9e9ROoz38Ve5mm/F6o8tj+gUK5GurkJCzCj5VlZGG23Hl1u3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914057; c=relaxed/simple;
	bh=Q8O0HRili88+kqRUmMRAKNjA4ogSwlUgyxWECroV3PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MgZ1mcmZKNrGS4diuIHvnnluhsq4MjAdaoEZ3auSsVFOH1F4Xk9ab7ASpVA+Ej4VnKTJ6nk5z+bIxgYo+Jd3x+DNOsv2CjxzfU7/9zzWgX93F7w75JORjCwTXpkhYcwnDpgTgcDaOu0vvFH8YsGRT2JYGUOy2kkKesOOIZ4FRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClhvHnX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClhvHnX4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF7DDC2BCB3;
	Fri, 24 Jul 2026 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784914056;
	bh=Q8O0HRili88+kqRUmMRAKNjA4ogSwlUgyxWECroV3PI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ClhvHnX4Dqtw2hVnF85MaugMbbs38if81o+sBzI90oq5ez7FMYCz6wr8RfkREIIDs
	 vAarryGOJTWIGY71NKsDoApeel8fIu5y57urHSEBBg0uapDYjJ4hqMa62Zsa5RotbH
	 ytPYou0PPK8kthe7h/uPWuHlfeRK31GAGZ8+v+4BAP70RO+VIbTNVCSUDf3piJVtgJ
	 bJzeIS85zoDP5DClaeo7D9bQgNAPutcIr0nNpLg4t+JyIgyY+c7gsFrD4JQyNgayMU
	 FuqDwaSaRzSUu+KeMacf0c+2eVa4PnNuIrBIf57R9sUVwaSi9/IupUlZgl6Tb/RBPm
	 wM3r03Zvlltmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA00C531FA;
	Fri, 24 Jul 2026 17:27:36 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] HID: iio: gyro: hid-sensor-gyro-3d: probe cleanup
Date: Fri, 24 Jul 2026 22:57:19 +0530
Message-Id: <20260724-24-july-hid-gyro-dev-log-clenaup-v2-0-01671b07b181@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHegY2oC/5WOTQ6DIBSEr2JY9zWI+NdV79G4QHxFDIoBJTXGu
 xftCZrM5ksm38xOPDqNnjySnTgM2ms7RWC3hMheTApBd5EJo6ygJeMQM6xmg153oDZnocMAxiq
 QBiexzsCrKs84srwuchI1s8O3/lwTr+bHfm0HlMvpPRu99ot12/UhpGfvj7mQAgUq64y1ZZlSL
 p5qFNrcpR1JcxzHF3IMN8XiAAAA
X-Change-ID: 20260724-24-july-hid-gyro-dev-log-clenaup-488534e25965
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784914055; l=995;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=Q8O0HRili88+kqRUmMRAKNjA4ogSwlUgyxWECroV3PI=;
 b=DON69jzEGDk/yDKaqYyepQG5hJe7y2h7PKCHt12aNSUSR0XjCWxinKxfZMuaqtduqVVw3UmAy
 RO2GvLyf2lYD1RG25+fAjUWr4fU7ENjBwyqJmHhD4Yi6wYNJaQlUGri
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
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com

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


