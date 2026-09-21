Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041195187F1;
	Mon, 21 Sep 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033283; cv=none; b=Za4JtclkHgovrqO68sIIUB8fyc0R8SCCFkyH6uoD1l76MWEopeT/W6RPVWl0pwsefN5vlRpaMfIx0bGHnAkyxiSE05L4CV8UOi19Gg5upZqOkUndnjFFP6VEdMz4h8kqNazpAf+6GU8xUOPiIImZ4nqWI3UQ4QpVYs70cWIY/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033283; c=relaxed/simple;
	bh=v81Cu+Af/tGs/ZiQmlaILzEVYPSXrymG/mz28QbTvrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qs//quBQLVdCPab74zAQaBBTUTCDKG/N4K45iIkLQOjy/wKi1i+awYcHWA3xbWhRT6XzlW61kMoOml+BweBnE0WbDvLS1UK+bjG5eT0IRiUdsSQsVGnKbKDhEVQe6SychX71mgWrPUWLSFzOg52pMwpeUf4dDH+FeEHSxXZ3SEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyXCq6ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyXCq6ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E61F000FF;
	Mon, 21 Sep 2026 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033266;
	bh=CfmB5riLlyJfivf5Nw+LDN75eMlU5F5UgPf4xQdXkdo=;
	h=From:To:Cc:Subject:Date;
	b=EyXCq6ruXgg2y7stM239qZJzxCBoh88ibhhfWp2wpWTtoLuqmgeoWHvgKoGpxDCgD
	 fxUM5d8tDsMHDK5kB5QRCnKwUJiyQAYJPyrk9SR1BXEThU8yTZqaDUMocvG7H4t/LR
	 tIPfSSRmH72g26e6pVKCX5Nv8LKsNqGpoUuMdnMnC5F5DA3p+M4oeiHysiDRTCX8dO
	 aU0YxQ0KKXh851BOp+hzyCi8JQ58Y2ATLoPsWeQFqJc2Ni10xneVEz8OxXEC5gUTlD
	 SxdfiYByBLlNARLVGngfpbaCclf0WL1dA9p5KFWsQM+69W/KtA+muZEBElFtTdDJOb
	 u/l7MS5pG1dSQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: syna,rmi4: Allow incell supply
Date: Mon, 21 Sep 2026 18:27:38 -0500
Message-ID: <20260921232738.3135429-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sony Xperia Tama boards describe an incell-supply regulator on
Synaptics RMI4 touch controllers.

Add incell-supply to the converted binding so those existing
touchscreen nodes validate.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index fb4804ac3544..464c83ece418 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -56,6 +56,7 @@ properties:
 
   vdd-supply: true
   vio-supply: true
+  incell-supply: true
 
   rmi4-f01@1:
     type: object
-- 
2.53.0

