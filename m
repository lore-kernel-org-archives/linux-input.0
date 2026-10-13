Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB5566C7A;
	Tue, 13 Oct 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931513; cv=none; b=JUXCPbpY4c+4F/sD/AmCXenIp13c4t4gQo7e91iAN2cXbWqgkyds5LUWz5n+g5CfJnsmqL0IcXacsJgiRwrPioLEiyfo63Vsul9ZRfBbui7k5HiRbMDHnkoHrdM1QeBj/2OYaZsgC15mnahh+fjnm/ry9t+VzZtzIXifQlbFw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931513; c=relaxed/simple;
	bh=ivea5+cjpRT5P6CESkNzubxokJLNLiDBgIhZfOpgs0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YIyVSNmzD+f1V+tzgTg+A0h2ElpLNId+JglJGMe4XfFA9Jhgjue/SGI6AMmIXiYcbYIp3yxrLWkzWkn4telBNNvK3R1aFya4SOPtD2Qof089vhnyB7gPP4bkF8k1CCUzc9PIc/YfiAw3/wUuqWBJgpyD1qrhn/yG4IdDRQDwUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5wEen7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5wEen7T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1490C2BCF4;
	Tue, 13 Oct 2026 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791931512;
	bh=ivea5+cjpRT5P6CESkNzubxokJLNLiDBgIhZfOpgs0o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=F5wEen7TDIDIybcRWhIjE7HwebnsZUdV4W4euFCwt9G+gPE4SRyVc5+inOoE4fpbh
	 RxhTsbeRlXGlTQmJsYw4rRM5zwZNC0HQwqGJArqTyyinPKndOO6B70MXbIa2iaizzV
	 9Bj0t9nIBfp7m+Dmrkws+6SWNocxPfJT6Un1OdphJ5iEhbckk+ygskozb0BfFq+iW4
	 BdbveuwDxn6Yo2Sy+69kW4xmO+FpibVipwxJMG/RJvnnnomFvF4eZzWOSUew85HC0t
	 iArHvBBT2FKV9tbl7FZPiqxoj3cbBRkk+OZO+CZb/8oi9PadiBGUYZWJfSbtCORwp9
	 U5xeBx5OMtRXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5FCC6B12;
	Tue, 13 Oct 2026 22:45:12 +0000 (UTC)
From: Mizuno Miotsuki via B4 Relay <devnull+founder.crepuse.com@kernel.org>
Subject: [PATCH v5 0/3] Add Nsiway NS2009 resistive touchscreen support
Date: Wed, 14 Oct 2026 06:45:08 +0800
Message-Id: <20261014-review-self-ns2009-v4-20261013-v5-0-0851740cd939@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHW0zmoC/42OzQ6CMBCEX4X0bLUtP4In38NwoHUrNVpIF1BDe
 Hfbop697ezsfjMzQXAGkBySmTiYDJrOepFvEqLaxl6AmrPXRDBRcMZTGo7gQRFumloUjFV0yuj
 PLqpU66qUmcg18ZDegTbPGHCqV42jvIIaAjVcyAaBStdY1YbVyt9FfrQ+Id+E8NIaHDr3iqWnL
 KD/7udnRn0/KfieC1GKo3LQjwhb1d1JvSzLG8fTdWUTAQAA
X-Change-ID: 20261013-review-self-ns2009-v4-20261013-693ff98b425f
To: dmitry.torokhov@gmail.com
Cc: krzk+dt@kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, icenowy@aosc.io, conor+dt@kernel.org, 
 robh@kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=founder@crepuse.com; s=20261012; h=from:subject:message-id;
 bh=ivea5+cjpRT5P6CESkNzubxokJLNLiDBgIhZfOpgs0o=;
 b=owGbwMvMwCUmds2G2fVJ/hLG02pJDFnntpSZBTLWXW47Kes603z+nq9qDyqijjp2icstEYv1v
 SCi1nO9YyILgxgXg6WYIstsUfbyQ80rrs2d0GQHM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6BgzcHEKwFSLuDD8L34fVT1xjcoM8TP3CvOsr1z79qSi3Ij5ZeGde5NWb1yRPIvhv5tYOds
 vW4aW6icWzQ9YooRMHbc9k7Zn5rpT6SNxKTaHEQA=
X-Developer-Key: i=founder@crepuse.com; a=openpgp;
 fpr=9B150777C283A8D69D90823E16D63C0345E46FA4
X-Endpoint-Received: by B4 Relay for founder@crepuse.com/20261012 with
 auth_id=1166
X-Original-From: Mizuno Miotsuki <founder@crepuse.com>
Reply-To: founder@crepuse.com

Add the Nsiway vendor prefix, hardware binding and standalone polling
input driver for the NS2009.

Changes since v4:
- Remove the review-attribution sentence from the binding commit message.
- Add Conor Dooley's Reviewed-by to the binding. No code changes.

Changes since v3:
- Require vdd-supply following Conor Dooley's review; keep vref-supply
  optional, including for the 10-pin package without a VREF pin.
- Manage declared supplies over the input open/close lifecycle and retain
  an outstanding enable reference if disabling fails.
- Use a named I2C device-ID initializer following the bot review.
- Preserve Conor's Acked-by on the unchanged vendor-prefix patch.

Tested on UNIHIKER M10 V1.2 with the real vcc_io regulator: touch, release,
dragging, open/close and inhibit/uninhibit passed. Tests used a validation
module and a temporary live-DT supply property; the final DTB has not been
booted. s2idle resume passed; deep wake remains unresolved.

TSC2007 reuse was investigated, but polling and raw-contact handling still
need separate policy and TI hardware regression coverage is outstanding.

The board DTS is a separate Rockchip series depending on this binding and
the previously submitted common I2C2 enablement.

Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
---
Mizuno Miotsuki (3):
      dt-bindings: vendor-prefixes: add Nsiway
      dt-bindings: input: touchscreen: add Nsiway NS2009
      Input: add Nsiway NS2009 resistive touchscreen driver

 .../bindings/input/touchscreen/nsiway,ns2009.yaml  |  79 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ns2009.c                 | 230 +++++++++++++++++++++
 6 files changed, 329 insertions(+)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261013-review-self-ns2009-v4-20261013-693ff98b425f

Best regards,
--  
Mizuno Miotsuki <founder@crepuse.com>


