Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C937F72C;
	Wed,  4 Mar 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612723; cv=none; b=CgzT82O2kKIrYTCEiGFpMn18ID2+RV2Yo5QwDk3DhjFpJBleMow2Nm7FX5KUqAbr2rcmA/GHcx3zqxMF4FIdxBO8oN8CF/7zxL6tOtaSwi2KdkQuDAIHPoanzzXOR26IB+g0xLE74OpVjJ0y0oenDsDmrRAhUL7ZYIFBlq77Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612723; c=relaxed/simple;
	bh=tRfAQymiBDbnrpKvWlOvqY1R2w8GkqKFHUhIf8yzyyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sLv8F3Mx2TnWrJbnqE2g5FJfKIBLCjk1jO0l0Q6nRhB9n177wRtbypSB99mvNoM9TtsdsmrWPlHOWA0no4jayRLt+fiz1T8KON7s7r4W6+VOdQNIp3iZ9889f0wiBHzD0uy543OYKz1L173B1LZ5pufc143VoooRg8LAN6TIyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8gRnPYq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8gRnPYq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6894C19423;
	Wed,  4 Mar 2026 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772612723;
	bh=tRfAQymiBDbnrpKvWlOvqY1R2w8GkqKFHUhIf8yzyyM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m8gRnPYqUdqjE1k+16q2ANpJtf7+6N+DC9pekID/wk6w1dMUWtQPEIPuw7kU4D2WD
	 VFWbCzyVHeGcE9p2Uw1GnJISA2bdjZjMQPfcFBQVkhoyytdzhdGy/S+MemlN7duZ5c
	 HiRCaIJq4wVhQCki6+e1WLC4+hnFK8gf9wWCic4y510iCx4EO/4Jl2X/GhT5JRaTLa
	 c8itogODNEBRUsHf4HZe1Ja6gVWOam5Yw9lUtJ7AN8zvpzaSlVJEAeEy7uQ1PDBz6z
	 71HKvy0UY6VMawrdv3qCpYo05QDYYs6H2Zytzi96OegYHq8mXOBL9oFc+/nTGIue59
	 Lb8UcpAj9VPww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0BEEB7EA3;
	Wed,  4 Mar 2026 08:25:22 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 09:25:22 +0100
Subject: [PATCH] HID: amd_sfh: don't log error when device discovery fails
 with -EOPNOTSUPP
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NwQ6CMBCE4Vche2aTWgWBVyEeUKayB9tmF40J4
 d0tHr/kz8xGBhUYDdVGio+YpFhwqit6LFN8gmUuJu98687uwtNrZgsL2ztnhRkj5ZjWgwxVdnc
 0fXft4AOorJQoyPf/MN72/QeiMwdTcQAAAA==
X-Change-ID: 20260304-amd-sfh-suppress-eopnotsupp-err-0be59878e2fe
To: Basavaraj Natikar <basavaraj.natikar@amd.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Casey Croy <ccroy@bugzilla.kernel.org>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772612722; l=1508;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=4RsL24BR3KXhRnuTa8542w9vrQQZj4qOROEMdTRsAhw=;
 b=KNkHhoRSJq6pNaZcnJnLrPyWCUyMPxgAv2XwlUKg0l9E9fRGsZBqLNE5zCgXTR23gvaVoMIR/
 nejdBdVT0y9DC06omOIDUIr3LqSF6+zyo/6KswvdIHuHEKyICYXQpdS
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

When sensor discovery fails on systems without AMD SFH sensors, the
code already emits a warning via dev_warn() in amd_sfh_hid_client_init().
The subsequent dev_err() in sfh_init_work() for the same -EOPNOTSUPP
return value is redundant and causes unnecessary alarm.

Suppress the dev_err() for -EOPNOTSUPP to avoid confusing users who
have no AMD SFH sensors.

Fixes: 2105e8e00da4 ("HID: amd_sfh: Improve boot time when SFH is available")
Reported-by: Casey Croy <ccroy@bugzilla.kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221099
Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1d9f955573aa..4b81cebdc335 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -413,7 +413,8 @@ static void sfh_init_work(struct work_struct *work)
 	rc = amd_sfh_hid_client_init(mp2);
 	if (rc) {
 		amd_sfh_clear_intr(mp2);
-		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
+		if (rc != -EOPNOTSUPP)
+			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
 		return;
 	}
 

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260304-amd-sfh-suppress-eopnotsupp-err-0be59878e2fe

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>


