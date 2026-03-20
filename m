Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7233CD8C3;
	Fri, 20 Mar 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025085; cv=none; b=u6JMvQixEIvyoqGyT7iz83ycF6it/WKQaAl9ZMiGoYEYM2QmqXs3Bt+E8qtvo5gCUtSSSPQF2oBTFHL5qKuWeR27QeJNEZ8jma2ct6yA7NOuvK6kN3WDh8UpPaShYAl/FIpn6rtjiReW5K9vmK2pSQj/PDBb/Wn1tSs+y2VeRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025085; c=relaxed/simple;
	bh=oBgPDt/LJlibW8Hgm1a/bsT5ObHlCxGW++DUgK9IrHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXBtaKv99Y4D2OyAd72RSzQOsOmQxYRnFhB6U0FAWeuy4L8IVzeJDbZSL0Juu8ydPvYFktwFN1RzBm0Jz0I9NCumnjCWnjYIfAejZfzgVoCU9KezjG2PeJv5xp8SmqUekrqtIdBbruYeb+ehli9F/Vn0w0wx50sp7bS1IcEINeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmZFsZVI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmZFsZVI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4E2FC4CEF7;
	Fri, 20 Mar 2026 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025084;
	bh=oBgPDt/LJlibW8Hgm1a/bsT5ObHlCxGW++DUgK9IrHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XmZFsZVI+31jraRImDi6OMYMDGs3HACVonHW6gpFSwDKSRelODQp7FB0ixUoL3xnK
	 7QLu7beD+FYvXXDXndzhAp0Y6aDCxBjMQv5500XIcO6YxaDR85fAguEVgBtxr6mKfp
	 Trlytaj0Uh6Fo3P7coKTDwxB2uRlo+ABwRT8VJrl6iVWnXuCB/Nk0K3V2VbbKJHyi3
	 hsDNW5eg/m8uHhsB1wnvV76USrPGRucCvRptvrB+rTEpZXzKqrWj8rcgxKjQ4xDZMo
	 RiQhbTY1gRK0ArR+mby8Lu1NtCPA18ZNomqRtZ6Rv1uiDhaE8dEr6xY2yG/F87p67g
	 zCDFHxGCEn26w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36210987B0;
	Fri, 20 Mar 2026 16:44:44 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 20 Mar 2026 17:44:42 +0100
Subject: [PATCH v7 1/7] dt-bindings: input: syna,rmi4: Document
 syna,rmi4-s3706b
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-synaptics-rmi4-v7-1-379360de18d0@ixit.cz>
References: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
In-Reply-To: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Casey Connolly <casey.connolly@linaro.org>, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=sEfAUOYzG1M4zvx/Xv8wME49V12PqhPhJ6Tk21Hc6yo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpvXl6DQoVjnt6AUjpK6l5YSqeNhZzWp2I7/L/S
 gRrU92ruVuJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCab15egAKCRBgAj/E00kg
 cnlaD/9GRWZMPIKiTohJQYNue8Ey+/mhCM0p030duqBy4yVAV+yGqsT+DJuI/79njzgOVVfJ0nR
 87MSeH6uER7+Oco7eXBYx+izh2vaSkhUS9GYPftdMl6n1Me/bl344FtY/y5Z8CC3aiNsmrgdk/4
 yY9CkWYZYZk3hTEGeKv5Y+F/RWb2ge8LIpMjzU5OcdbGfKTzXFlYKRsepAxA9fdtQC+A9A7L0PL
 Dc0677JIuV5Wg918OCtKqkfcPWXcPyaUdBY5+fS2UEyymCL/b86MbkzPZpzIoLeM4phAF1MUBy+
 /HCG4KU15EckBLE5/Q9Y8m0BrzxcxKuE+TdVjDRwzPE22I9cJXNKXXxi/G2h6B/a+hft8ACRMJ3
 LU9qP4YD8SK1E1P97PNYl7ORnf2fDvmgMvhbaOthu6omZNAmvh7K1yHi4oWMfgg1NhCS5MGBmGT
 orZZrUYT7HMw6pX5LpsEN+2Zi2rQ3RAQjYD401A6aVO+NRI70gxA50c+VMOIJfNtctRxzIodhxH
 oIM2lo6J8LH21SQreek3IJhrZHutHgJe6LgcrTfGroi/5d1F5qC39lpORJ7dXyUS+9iswzzRJcW
 hh73xvCA/8FJIXGphU98uF+CqU9W8aUFUYgYrCzZyaptzTWxw23fIuZZ5CsMnyO2E4By6Xjhaoo
 6mfHIDH0TMXzboQ==
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


