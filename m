Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32833A6F8;
	Sun,  1 Mar 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387479; cv=none; b=uELrgMG1dIWKgzOMDVwIeToXgpeW3RmsmsNdsiKtWFfnNSAAf008X+4CwP99kVm1IOVG8vSju9nAk1CzJd05QTezyMynudiaJmBl5nqKv8A9tY5QQJpffKSArSRgwzPT7GDSjB++OxhEaadJPvjzTZ68zfpNXVv4iLdpjGwbVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387479; c=relaxed/simple;
	bh=yXe1hSSdOtlyyzWGYAthZ15x+5EOdyI3Idom8hqgEB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpHfYuRVcByYnR0bwAG4EORnEKkgCpYrz9UulUHXkQ/su87kZQB90Na5dbtdeKVcn0s3XZ4i1syKJFKbJI/rAxKTfEcRleRBDd62ImcRHUbCtZCGNI7v79aDF4CYnfZlSWLzmwsezWXfqr73cFNtBz6EutfP/08drh0uZ06sJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBGSLn4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBGSLn4X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B48CEC2BCB1;
	Sun,  1 Mar 2026 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387479;
	bh=yXe1hSSdOtlyyzWGYAthZ15x+5EOdyI3Idom8hqgEB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NBGSLn4Xu470ya2zenyjd62hwTHGHQZZxK9fhLkc7/xFzJWGY3TCd3zJ3U9mgBNSH
	 4thzI6vZlrCQd8QQCAMlz6Gjj5lkmMVKWfkESmEHTlHe92qHbGPc8KeejaKfvpArad
	 yyEqvlKC7Wmwl1pfGB3LkY/qSHTc7ctGivhGTqCepALLvkVb0qAOUFbMdNBYuRwWZi
	 Meb31ItmazvuU+cRoLHj6YBR0Dgz5z7oDuzzoLevLVUbhYUHbnGAA2csa7j6mgwCGq
	 Zl4lPPYru6xYTdDhliViWe1aS3ldImByTNrpnmPVuoFGYF+RwR/TguiW9XdfEwasfz
	 DqXlWWhp1gN6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF3FD0076;
	Sun,  1 Mar 2026 17:51:19 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 01 Mar 2026 18:51:20 +0100
Subject: [PATCH 06/10] dt-bindings: input: touchscreen: st,stmfts:
 Introduce reset GPIO
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-stmfts5-v1-6-22c458b9ac68@ixit.cz>
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
In-Reply-To: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=uZFVfrrOjw9/Zf+PjQe4vJuLBGGgUOJaBtRtnZBDj/E=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBppHyVjFgb3i+M6jMlXlM5TIrAbsCQX8E1F3tW4
 LGiF70vpT+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaaR8lQAKCRBgAj/E00kg
 cgHiD/0X/wHMPyxoaYtkjW4WcPvXUC08KdGlHTZKNyGoRqvDGSy8aiu2vev+LCPIk+LHsTW/Nri
 OO3T8Az2mcmKmZxF9MoBaLKMOU90J8WpI5zSt8tcb7x2BfoIhHD3ovLKWuXU5KDoTFwujc04tHs
 z7ky5WmzaSZVaBvZ5JyGtD1qqYkVeL8QrnlgeY96B98DsymS5UBCPyql8vYlfI1hndGzI+83wwP
 VTbJaqb5gNbkvdieepGW8ic3cBCrjjaBj8MzX0MwtyAX79Oq2ZwjQ/0OPZ0zSzO6eRktELfF7ay
 7AbX+lXzJ5cBsoGO6laAuOJVP5tz2vC0FyRC3vw69byINXZ8sMQ7FFhRGYefrYxoJOh1PDd6+KA
 Q+ijRhnrlg1G6BVpDPxthLSlQ1nzIyy6U4EzAODMMPZq77zeF5Zb2faqB/3wVilA1nQf0NdyGhn
 fpsx3Hftb9aHn+E4HCj4W1G9oVdAf/1tkHKF6DOvy6CXtfhiBGBFbbV5BFyNEy1mbsiElGuRf1d
 Q/WRSlwQ3rk97JWFdR+Nd4GgRhouRMzK+zCtFBdQ5HuX9sQGUVY7R9NM9XrdBR3ktQrddgLFM6O
 CNZUSAvtZAXsKPugwymImVkyTTQZdjW/d6ck7x+j6KP/E3EqNWT1tQiD+3HKkDqsYXm+TwkHSco
 uhZ4cQlRs8Ssvkg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

FTS may have associated reset GPIO, document it.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
index 12256ae7df90d..64c4f24ea3dd0 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
@@ -40,6 +40,10 @@ properties:
   vdd-supply:
     description: Power supply
 
+  reset-gpios:
+    description: Reset GPIO (active-low)
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.51.0


