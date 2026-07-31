Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A737996C;
	Fri, 31 Jul 2026 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530061; cv=none; b=n4kUSWStUiJAlM4Lo5QgydLgRgVILcvvbduS3buqEkgMRxaG5HGMhyD9VM53kSUr1CJbnjb+TwUJsdWrZsRJhErTbO3ZeSkL3wRpUxe/BaKGn6gHdy0JKLA8U+8svl2/JCvBUwGTxgKxmNUYbT5GiRxsLJKGGZcx3Kl0dM03rqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530061; c=relaxed/simple;
	bh=4epTUOwQQZ+rFZbePVbmil++6zzCxjsEGEoTZaY1rIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImS9h/bxWUFhtpi7b2F7pI0y4DQHfSHlhiUX0Ax9IiNe2llkomAzNxCPrDjDStowKA4OnNNDBRdhLIw1jKwVvq1K2D+Qesk8g6mKBCwb9E/kNfhUNTNSAEhy+D8HZlBdeWqnuyn1tXEtCxyODkrBc5MiTGFHIkKvlKx5j3mC4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4UBi4PQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4UBi4PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87D58C2BCFC;
	Fri, 31 Jul 2026 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785530061;
	bh=4epTUOwQQZ+rFZbePVbmil++6zzCxjsEGEoTZaY1rIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G4UBi4PQIb4w76qRS59ehfbiZ/3RXmEsRdU0MJ+oWQsT8SDQ3fUoilEurhh4+onzX
	 AGM3kB5u6AAHoQR+Kssx93+9FoPRa7yBcBjCCH31nOJVarRsXqfsVEOwXum1XnmPPG
	 gZZnQh0r3FPIoGtD2yaJF8dGU95z1K+PeApVICNQ0sIkKWfyStQMMCgbVUaebSQAHd
	 vaeZmJ+TIfxKms39sZSPLaESuBOKcG4yKFcCSWBJMVQeqmcTfFyin4AtuLqZFeLcc+
	 sz0dSLjYTSCF/OufoODIFvb/IkbMoxd/aDT7evfWHF2umCcQejxZKfac90ZRab4Hqk
	 8rN7CZDivkOWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722EFC55178;
	Fri, 31 Jul 2026 20:34:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 31 Jul 2026 22:34:15 +0200
Subject: [PATCH v9 4/5] Input: synaptics-rmi4 - read product ID on
 aftermarket touch ICs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synaptics-rmi4-v9-4-f088c47af6c5@ixit.cz>
References: <20260731-synaptics-rmi4-v9-0-f088c47af6c5@ixit.cz>
In-Reply-To: <20260731-synaptics-rmi4-v9-0-f088c47af6c5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Marcus Ramberg <marcus@means.no>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=0ZX7YD1h+ukbpiEVF+1UBqpg30+ZDcn5w6CgQP4D90Y=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqbQbL9kDNHl04tATOlcEIr/yxofbkl7EcbhWZC
 ioxIdPepYWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCam0GywAKCRBgAj/E00kg
 ckW4D/9gv+UAdqO3cjHjyI42Qnbxm+nHT3tXwG6zreed2KxC07y1b89ZYsyryI/uRf+EkaVr3x2
 Tja5uaqQ2ZrjHMzdr/iFX5jyqnCTMW5xWbMDMt9sDxVBgYmmdpM4+Iircb2MJKJO5vyLgjrtlxM
 h/VZxMHYErvlh3VeUpGtDaXPl2Jwy5L1zzCgR9UJPbmkx7RmgEeAc8dqXMoOlerN2ZnNrN/eORp
 Z95j87dSWo4Fz1PaKRsoe8l6Lr63w6ntXm2UITi9DMugebNQumd0pRDSuMZ8vunvuIhxIjyRF2B
 esYugAxPXsDuhjMa5P5OQsp26gMkxJ2JR/ghD1FhseBM1WrdcOIyERkSIfWAPl3f8Luzu6gMIey
 b40Jh4kL8pIPdpeyUAxI+8gBL+6oEDv9cnFH+1CsIy5PNPsXNuF2TUbEX1eTm5QxkFPnVIPSWbu
 dwo+7DCxeF+Y4WCULHy9C+eYfPH0nMjiqDl3zTKlPCpLaSfTKGk17xemlwgbwV8+uBA5WDjMD9l
 R1jzZY1qK6WQcKmdQv1CmlMhSXLVJ2BSDM5+k9ZLfRbTSgrF+xxaTLu3XKEWI/68hlT5IY7NfLg
 EUgx77r55rVKjCSW/eplwfhL9V0pGRr4BtJrNjSMDQwrtI4z6BE8ihzKCuASeFEh1HJH1VtW6rd
 YRK81VdOcQuoVyA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Kaustabh Chakraborty <kauschluss@disroot.org>

Some replacement displays include third-party touch ICs which do not
report the product ID correctly unless we read directly from the
product ID register. Add a check and a fallback read to handle this.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_f01.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 47be64284b25e..2278e9b6a9207 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -245,16 +245,30 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
 				return ret;
 			}
 
 			props->firmware_id = queries[1] << 8 | queries[0];
 			props->firmware_id += queries[2] * 65536;
 		}
 	}
 
+	/*
+	 * Some aftermarket ICs put garbage into the product id field unless
+	 * we read directly from the product id register.
+	 */
+	if (props->product_id[0] < 0x20) {
+		ret = rmi_read_block(rmi_dev, query_base_addr + 11,
+				       props->product_id, RMI_PRODUCT_ID_LENGTH);
+		if (ret) {
+			dev_err(&rmi_dev->dev,
+				"Failed to read product id: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 const char *rmi_f01_get_product_ID(struct rmi_function *fn)
 {
 	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
 
 	return f01->properties.product_id;

-- 
2.53.0


