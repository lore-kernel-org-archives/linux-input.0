Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84520343D66;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669673; cv=none; b=HjWK0qq/LKJhvihyK5DqlKe/EWYu1f+xT7sQYAGDq9YzzKcbfEV8csgc+qJt2cftod8UGT/txAnmPUpJe2DpADC31WyRr7BVYeCn1CQp013EJE3gir9NZQmOtQG3iDc1amArziu1GEOCfhMCMkfsAqQwMxX3tde60PI2o6TkQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669673; c=relaxed/simple;
	bh=oBgPDt/LJlibW8Hgm1a/bsT5ObHlCxGW++DUgK9IrHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNrYhIEJzbfgckT9ARqxQRK9ZmKZelBgT2ufzzZkN0hXFPrCw2W8PskT7f+cYlLACrQKUBKYgRyc0E0Cb2c97B7ZB3GNGbUiCgiiaVgYzkT6xRKjS26KFd6jo9cXXQSaOyq+n7HLlU1a2+yiHHSC4br/ioZ+irXxOye7adwV22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI1tRRRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI1tRRRj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49DF9C2BC87;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669673;
	bh=oBgPDt/LJlibW8Hgm1a/bsT5ObHlCxGW++DUgK9IrHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bI1tRRRjurLyDDmxcZF9ZJrzIiiFFlSRw++7BWzrfFULpqcI1a4DbkRIDrc9+ZkoL
	 hInw3edG6GItZK5CjuY/4fIZl+aMgWF5L/KooSfSiLpIYksu9AHntjRmpOUEcHgEwO
	 /iOn2vM32vjeyNxo4fC+oebdZYu3flBJSeujE3SREM9eXNkC7kTmWH45NZ3OuDvSeV
	 c0QgmkuIGY3wpMcE8VmlZm+BbXiGaE/mzjhX0zZb94jXCQhebip3RP9XFCWYb7diD7
	 DO+hcL7zV3f6OMEwBfone1/FEUKtKKKNGYZvOJEe19F+BB/QcT4SBRN1JbltWC1Ybs
	 jEWATK8eb51PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625610F9964;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 08 Apr 2026 19:34:32 +0200
Subject: [PATCH 1/2] dt-bindings: input: syna,rmi4: Document
 syna,rmi4-s3706b
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-synaptics-rmi4-dt-v1-1-2d32bacce673@ixit.cz>
References: <20260408-synaptics-rmi4-dt-v1-0-2d32bacce673@ixit.cz>
In-Reply-To: <20260408-synaptics-rmi4-dt-v1-0-2d32bacce673@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=sEfAUOYzG1M4zvx/Xv8wME49V12PqhPhJ6Tk21Hc6yo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp1pGnRYv8b9NfVyUWQW1cq7zGcwvT6MzqyLu+D
 MpQNcOVFzGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCadaRpwAKCRBgAj/E00kg
 cugVEADQNlRqMzFq6OW5/JM4N9RqHX0ZZtmZav19w6y15C7iV1B5rzWB0cRDizNam5dbLvEkWQU
 OYtcZPm6H6wwa/GiyGoywpoc2XmGSNkIbVm0KrrmO4tDhkmNE3eI1HLi/Qxkk6tAcj6YTHhhO+u
 22jX0dUTq83XOKUqKTZ0W9dQMBGyQaW86SXRpzWOjKBJ5Z/oFySGanrrjys19Rh4M8b8V+uo0Cy
 XviUSumFYduu5Pzr9sXR6ol1ocrVbz7pAr8ZXZ1/YmNRJ09pMXh+/SMR6Ir+L8omFmGi8OcoWd1
 40MkFEfzdre19/UoLvzOAjF7owWe4xuOEMDCBrQ4tesa4XhrDceMmtF+nmw854tkcgZH08cyGpo
 HKxt/qO1Emq4D/vPpHs9ciJYKCggOvGZHgN9I90QFxHW5pLa1dWy6on0CvGpiA2pDyX0KH7rnRe
 k2SNrFxDRCIr/72zBTE5sOiTdtmy5F04IhHBL9kWQorbx0tswQwvTP8gbGZ9sTAQIno83D2+jHI
 KXYVVbT+3lO1HIpOPwO+sLqBJZrqFKpWx6I4x+QyFuyI830OncC4Rmk2n4CvrxjxqemIztjHUEc
 z4yVKphaJzavOoNZYOsEGymFsjjwi0Y2A5A+YaANVwH7Ig0iKja+cdxoRQoAL4L3tufdha+Vo4e
 5rZ212qBWw27SEA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Mostly irrelevant for authentic Synaptics touchscreens, but very important
for applying workarounds to cheap TS knockoffs.

These knockoffs work well with the downstream driver, and since the user
has no way to distinguish them, later in this patch set, we introduce
workarounds to ensure they function as well as possible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index 8685ef4481f4a..fb4804ac3544d 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -18,9 +18,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - syna,rmi4-i2c
-      - syna,rmi4-spi
+    oneOf:
+      - enum:
+          - syna,rmi4-i2c
+          - syna,rmi4-spi
+      - items:
+          - enum:
+              - syna,rmi4-s3706b  # OnePlus 6/6T
+          - const: syna,rmi4-i2c
 
   reg:
     maxItems: 1

-- 
2.53.0


