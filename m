Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794099031;
	b=MIs7/jeGAWvcv4qnWI6SVK5MK9SjdaxmGVKLdKixlZCtKfiyjRMLNZSN3Wdu6VLnqln/
	 KYMCBNFCjLuYzM4kBVvcJe/pjHAe2ya4HHVmsq5YZycTz5C228eTgiwM4PKsrtvagBsO/
	 qx2FBA2WPx/1OJb78EAU/1tDC4p5l7SCTK3geEnnzT8Owuv8xJ230ZgnCYVDMJqWJNj6o
	 KccefC31kmdGC+v/4p33ge5dgx3dxJqmqPomXFhibSqpnpN+brkiMK5OjeJ69UOSZpNnW
	 gLNH+NTtesPcx5tu7M+ajIPYt7+ZDFgANPCyp8me4BKL+kaLn1dpbCAH6TKlxjp0R9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794099031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=IgKH8Z1mL+DVQ1H4WNBQhYGDTfBDUYUJQ7trdSWqD3M=;
	b=UJvI0MvEDxMb7BHPnPX76V47mrKBjnOCQyfke5CvbuIb4hPC5EveFCsLQrYh3a53ZfSu
	 fK3carc7ZpOSPbCzo9zvvps1m7kZEjndYTVx4sucg3E3ckOelaa1mLzLbMj37hRyg+mej
	 55EW4mPABuEZtigtYtPaTT8QhI5HLvZYCW2TNkGHL4UGepDB7fq2Atbo7fXx1tm2rLmjt
	 4OIhn+2qQ590WYEYVfKfEnp93S8Qy/rwJFo0qZpIBxra31ZT4gQKpJjJeUzkxldfUNRNX
	 SLDj09E68TxqoiCSs9KCMV1iM8Je+Rpe2dV8M8ERh+nF/HmFIgrwXN84JpFAnRR6zEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OfFTR3/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1C606A326;
	Sun,  8 Nov 2026 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfFTR3/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5822E1F0089F;
	Sun,  8 Nov 2026 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794099030;
	bh=IgKH8Z1mL+DVQ1H4WNBQhYGDTfBDUYUJQ7trdSWqD3M=;
	h=From:To:Cc:Subject:Date;
	b=OfFTR3/vXG43mgWFpNDV7fGQpUgxlG83QntrPq/VplACnBW3CxMPC39ZXeQyW8mGa
	 tujpDzsdjXkMaEL7yFhzFkps8W1npIiN9nvK1r23NfLIxL1eIsqyjNObFOMu2DsUYw
	 uTtSXvkCJydp9i2rp01kfVrAOt7qdlcRn+8lpG3pukJy3B6HWWw9oqLeLoAVmU5KEQ
	 ywgu9Aj+gRylid3P6/qlt7e+ygrZyU5DGdHSwh8/FI3cccCcbycJGu1BXf9bFRAVhk
	 ATRpwuW3Dm/9mHA552KDEcIgOQNFciPl5hx8WR0JqMvlBwI1QVoHUhiotv50xJmsXH
	 5KhbUd8ep8Xqg==
From: Thorsten Blum <blum@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: amijoy - fix memory region leak on registration failure
Date: Sun,  8 Nov 2026 01:49:52 +0100
Message-ID: <20261108004952.394691-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=blum@kernel.org; h=from:subject; bh=rhvDwBj41iEjNWACt66355iyRXFmHoeThbk+YoRAYDM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnvjxu0mzW/NVN9uXGbyrzf/7/yHnF2FO+weXa2THBj0 ITCPb8fdpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBE2uMYGV5NW/mVudr6hN0e ju/57PrTpp/8LfLNPeputKfzpQtueQWMDCc5/PcLyGnFdy0We8f9dFX6l0m55dbyDmIrRHfVuCx +wgYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

If input_register_device() fails in amijoy_init(), release the memory
region for the current port before cleaning up the previously registered
ports.

Consolidate the error paths while at it.

Fixes: 127278ce2254 ("Input: joysticks - handle errors when registering input devices")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Consolidate the error paths (Dmitry)
- Drop cc stable (Dmitry)
- v1: https://lore.kernel.org/r/20261107160159.367919-2-blum@kernel.org/

 drivers/input/joystick/amijoy.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index 3752dc2a2086..03e5f924c678 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -98,13 +98,12 @@ static int __init amijoy_init(void)
 		amijoy_dev[i] = input_allocate_device();
 		if (!amijoy_dev[i]) {
 			err = -ENOMEM;
-			goto fail;
+			goto err_unregister;
 		}
 
 		if (!request_mem_region(CUSTOM_PHYSADDR + 10 + i * 2, 2, "amijoy [Denise]")) {
-			input_free_device(amijoy_dev[i]);
 			err = -EBUSY;
-			goto fail;
+			goto err_free_dev;
 		}
 
 		amijoy_dev[i]->name = "Amiga joystick";
@@ -127,14 +126,17 @@ static int __init amijoy_init(void)
 		}
 
 		err = input_register_device(amijoy_dev[i]);
-		if (err) {
-			input_free_device(amijoy_dev[i]);
-			goto fail;
-		}
+		if (err)
+			goto err_release_mem;
 	}
 	return 0;
 
- fail:	while (--i >= 0)
+err_release_mem:
+	release_mem_region(CUSTOM_PHYSADDR + 10 + i * 2, 2);
+err_free_dev:
+	input_free_device(amijoy_dev[i]);
+err_unregister:
+	while (--i >= 0)
 		if (amijoy[i]) {
 			input_unregister_device(amijoy_dev[i]);
 			release_mem_region(CUSTOM_PHYSADDR + 10 + i * 2, 2);
