Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2151AED5;
	Wed, 30 Sep 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784485; cv=none; b=PwKIBObHLMeJXU/nqlnh/VeHw+uKi0pBOU+NKgIaQigDWkOA4Gvui5fBDaYYmZVik/JRV0AoqUDP+7F9X+gpHw7/OV9F66mCI9ZA4Ac5FUwP/yzkZ3WyXX1Ji4GX8kR5pj2YiFgR/YIVztZe4d8lhNpe+wE0NcgU6WZwFMdQRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784485; c=relaxed/simple;
	bh=i/nl+2/ftfJQdEEeUWjYhOBTqNBkCsF47VtX9GXuLpU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rKmMf3qfnF2897TySIZqtYHVmqJgIULli0S7XJvBUnSI3bZJUFMxclc/+o0y9VJqQo+6122aU1SzynSrvZ+xVNfgjuezb6KqRRXGo2hVJIWH8huQgtU3p+fClOtUZ8sr8VWBzc0PwZDn5fzZEX81BF6e632nlc4czWtOGAljPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awBxrIP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awBxrIP8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F102C2BCB9;
	Wed, 30 Sep 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790784483;
	bh=i/nl+2/ftfJQdEEeUWjYhOBTqNBkCsF47VtX9GXuLpU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=awBxrIP8DylgwRMH9s3TR8kOY3JWTTopHXyXEU8F+3wMKE2bM4VuqfPpFzbdiC7gA
	 BMsrLUw/LOGf4fyG8U5tD86Yxiqn+GFTaxLR6WvPm9b9lRsTJBhBVrKUm97slldnIt
	 ASzmP3n6Le65PVb6j4JQRI89cQa+Qx78FLOi85DyFuodPEydvly7R7lbmAhgaYqUio
	 h5WYIm5NkOSX5Xd+OusWMpPhIMqXPh1TChoeGdphePIg0V2/DLpzt7vPAZsPFDGaWv
	 axr1dAYyza11GCHJr0fVYL+mZur2yJ5uOVIuc9Vo+qlHD8t5VYE0TYvdPk2roMRTr0
	 K0qMvutDmK7YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A514CA5FCB;
	Wed, 30 Sep 2026 16:08:03 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Subject: [PATCH 0/2] Input: Add Awinic AW8697 haptics driver
Date: Wed, 30 Sep 2026 18:08:02 +0200
Message-Id: <20260930-mainlining-v1-0-c303cbdb00c8@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDUp4vcqYtHWYIQhLSIRd1csv
 8V7Fzi0hA6q4AKLBzla2CMKAzCD4h4Ftd4QyziTZSLFrIgnYuJeSN0WOtepUZkBH6wWOzq/Wd3
 8drse0WzvAe77Ac557Q5uAAAA
X-Change-ID: 20260930-mainlining-0bd8b7b5ca6c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790784482; l=1161;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=i/nl+2/ftfJQdEEeUWjYhOBTqNBkCsF47VtX9GXuLpU=;
 b=A2JRVmR0dxoD+z/IKhCWstkdllfASWFoGHAeektW123uL5V2saBbgtQX1hcW5qqx+7+o2ratu
 YKRgU+bre0lAhy+oP2I45YabkFTsAOTsuc9KOIOQ8DTcTEz0HMVZjxQ
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me

This series adds a driver for the Awinic AW8697 LRA haptic driver IC.
It is the vibrator in the Xiaomi POCO F3.

The AW8697 is an older generation than the AW86927. The register map
is different, so it gets its own driver. The binding reuses
awinic,aw86927.yaml.

Tested on the phone: rumble at several strengths, 72 effects in a row,
stop on close, driver rebind and module reload.

Signed-off-by: Armandas Kvietkus <armandas.kvietkus@proton.me>
---
Armandas Kvietkus (2):
      dt-bindings: input: awinic,aw86927: Add Awinic AW8697
      Input: aw8697 - Add Awinic AW8697 haptics driver

 .../devicetree/bindings/input/awinic,aw86927.yaml  |   4 +-
 MAINTAINERS                                        |   6 +
 drivers/input/misc/Kconfig                         |  14 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw8697.c                        | 725 +++++++++++++++++++++
 5 files changed, 749 insertions(+), 1 deletion(-)
---
base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
change-id: 20260930-mainlining-0bd8b7b5ca6c

Best regards,
--  
Armandas Kvietkus <armandas.kvietkus@proton.me>


