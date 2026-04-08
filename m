Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449F2494F0;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669673; cv=none; b=hzWxeB4QWESztnxXZwtH2sdFGffqvzwmIUoRpjhLWbldwwNnFNwJtba6RDOq0VFLTL+mjqHt6XQn3wPyfautIQ6EF6srANLrD2ZPNx5DpJ5TyTB4Q91kCuTTsSWsDPoZxgnVvhjKRAYPp5A9rcp3/wohBX2HaR7cxexxtPOmBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669673; c=relaxed/simple;
	bh=JzKGMSO1Qx98W099lIY3XmzWJxWoll9867PldA76mjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yld3Ed1liG/Ieb9RfutSqCAWl4GMOmEMI5Yvn7IeMlxoBnyhbWBF+4gQE8687CU3NPb5zuB/gRIlHL1CeqUJRe8N5DTbbRCBbS1eXkAqpQnzp19/hXvVYgNPm1fD3R/XNPyh8pjQ/yJtLA5o20Eim2W/G7F8LrMVNTW/pksh+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTpD6i1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTpD6i1d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 326E5C19421;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669673;
	bh=JzKGMSO1Qx98W099lIY3XmzWJxWoll9867PldA76mjU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JTpD6i1dFv1hzkJMCLmROA7toGOiYQ8KLSmTWWNO5OWmAGxM8fccIZnG2Fn73CSND
	 +dqr3y174BYm75bfLiJdwu06weHxEDGV859Z5xB1nwS9epIeFzHameyDOLBfMe2GHU
	 lc4qzepVqpd1AHLwlvCAl0cIO3qiVPykRByWIbYXqrjMR4vY1xlw3yv7ojhh+CNxPt
	 oWrQXWBXBFTr7ZBstisbP9NvT7/U6Q3sHGOX6xTCQdTUTbwRi0nroX3thop1Hw08fg
	 lBttZ1AAcMvWYh7gL85F6478lhiETdWtC5AtrcZDEJC88IIrIGZtzC25eFJMgnkPJH
	 rD0plpab466yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3CA10F9963;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/2] Introduce OnePlus 6/6T touchscreen compatible
Date: Wed, 08 Apr 2026 19:34:31 +0200
Message-Id: <20260408-synaptics-rmi4-dt-v1-0-2d32bacce673@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeR1mkC/x3MTQ5AMBBA4as0szZJi/i7ilhUO5iFko4IEXfXW
 H6L9x4QikwCnXog0snCW0gwmQK32DATsk+GXOeVLnWDcge7H+wE48ol+gMbS+NUmLrV3kHq9kg
 TX/+zH973A7nUXfhjAAAA
X-Change-ID: 20260408-synaptics-rmi4-dt-8aebf31790dc
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=JzKGMSO1Qx98W099lIY3XmzWJxWoll9867PldA76mjU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp1pGnAYMMzfmWVcCoSBFRXxcsIHcyzsFYYsnCw
 LV/rmkIDtiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCadaRpwAKCRBgAj/E00kg
 cmpSEACRduCxZQPGLcSjXukxyg+Is/ZozXUdsnX4cggpr/x5ZQRcu6UBppSw7dD/CtCepy4ieZ5
 3p33gqJs1q+bed23rLuPGo8aBqBZ1FzYaskzHqU8FSmGIHHDJK4jepK3QFbYG7s0QUK1yxhwNkB
 WydDiRnL/HUhjnVoQjI6NcIHZd0lo+8cy4rTnw3ZE8cRP0qFS6HyGtHjVDiu2bfDeUtifX3o+Dp
 qMMRMXs7rSec7ZwpkdH9ZICDCXql1y70IZ1b2Lm2zgDbKlWxsH1dyWw9CGJOAVoCW76LfJQ4VL3
 X1KR1W/nBNea/Je09+qXRHjEh8rzDVJLwIwU6xzO7HTll62bT1ldHrKOglQjCWHdDr98BXwWGFN
 eYu0/vlBcw2Rm7pEWBH/wTXKkzAiqB67gpDQW8VZ+DYXEOpkCXxQrdijSbBgzMU7ikVMdZXdG/E
 lA8qO5ez1v96CVaz7ysgA74aDcaVk2yXe3EPYUOa1hD4hr48ckFJ2c5cRrKEAT4yZIT+apWIhW3
 zBRylTDonCLUrAuV9b/hsIFA6s4GeQMnBhvXexaYJ0nFHrE0u9BvVl/O6XSGy1b1Llzx2/JIr2e
 rYZDcjJMAS1Cf9ozQ9uLnzV2UuTeIV7CIJscLWSkNceZMxT6QSwC7ujsbCBXm1WZ7VWqLRPLeBe
 63DkU6NxRswBFrg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

Mostly related to the
  https://codeberg.org/sdm845/linux/commits/branch/b4/synaptics-rmi4
series, but independent on other changes which I trying to upstream for
more than one year.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (2):
      dt-bindings: input: syna,rmi4: Document syna,rmi4-s3706b
      arm64: dts: qcom: sdm845-oneplus: Update compatible to include model

 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 11 ++++++++---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi    |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-synaptics-rmi4-dt-8aebf31790dc

Best regards,
-- 
David Heidelberg <david@ixit.cz>


