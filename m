Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205536;
	b=GErA3tU4wK8rtX3PFDcgcn2znMKfEaKthWCuvR/IE/0dkY614RMHu5CyoMPjla4XQjNB
	 bVplv4kvgJBdDnBagu02C4qWtKJnqo8AjwEX9UcNO/Lp0SeaRhMLZGUujXzya9/T0uFQp
	 jyUwAPffuvlQ5vgkOFEhdTxJO7VsXLLpXRAsMkPNGOxgLbvcEn39lwzu3QzQEqFmaWUO7
	 jKSiHGXvz+6yhgxJ/lc5N5Ply7xTG0K9xOtnIar2ivIXpBEyC5noEO9AF6fEAvRNKZT9o
	 /tNNavuo5ecrfuDUf99YEX+tFEycAE0kRT95+tb1ESKfXzO8PRDO7hESKeC03Lg6Zmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205536;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vxR0y8O6Yjfa9xBmupmiYjq0RBrrS/LkXi20mWxNVj4=;
	b=MqmSNkSECLaCK512kwn1Tyl3nRbFR7H20qWgH7kri25qeaWdhcX4SVFmiJAHQbYQPdtr
	 4qT0pwFBX/J52DetO92uaSZhWtt6JJCnkXPLF/wQaQCOceWISUlueAh2CRAZ8ZSYsmnSQ
	 2+MrAXhoz8xaML8L8shzq+FqAFJcwuogWrbN26qiCEsHRFkB6KjD72BRTm1HrW8Mn4pRS
	 bVJyOLdYHTcfX4t5R3shWL3hW35S3u/3PZcSUADdSKRkOkcLCfMrs+HvFn/lwoRau6EXz
	 HFs6FYPqfrTl4vwNDf86F3lJvTNkdqxPp9zbiqm2k+JlPoRPNKOn65OL9LeWjb67hyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLSKRX3B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE951606A31C;
	Mon,  9 Nov 2026 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLSKRX3B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F41D1F008A1;
	Mon,  9 Nov 2026 06:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794205535;
	bh=vxR0y8O6Yjfa9xBmupmiYjq0RBrrS/LkXi20mWxNVj4=;
	h=From:Date:Subject:To:Cc;
	b=mLSKRX3BsieLi4GLeZuPq0+ZHK9kVNOPWSfwixBMn4rpaVkA9YsE6GmciW2bwB/GS
	 jMhza4Hel1F/vyASKGubuDwP+evpOsrc42c52ET8aYW58TE+iULoJrwdd/xy8YfJ8N
	 vVHhWt2HxsHQ977KH8nX5W7vFaxJgDf3xYqCrtasrntgUjWJobvAVJfeJZA7nlfTs3
	 J/xwuPkpnRgIxT1U1chNy+FTjmyc+NUb8SvWstd4tbR4OcDpOaKn6V9BiiG7dJf/ue
	 RCJ/169I/OKMg0/NZSKGz8dvpkuRtJNXMuO3YG8OFfaIlonagAG1jnnis8WrBsuT1p
	 1AErDaT5zWuvw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 09 Nov 2026 01:25:26 -0500
Subject: [PATCH] Input: apm-power - Rename to apm-power-input
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBBG4auUWTuQpKLoVcTFtPnVEZqGSauF0
 rsbdfkt3lupwBSFzs1KhpcWHVOF3zXUPyTdwRqrKbhw8N6dWPLAeXzDWFOeJzYkGcASorSudXF
 /FKpxNtx0+Y0v17/L3D3RT98bbdsHPY5OwHoAAAA=
X-Change-ID: 20261109-apm-power-input-rename-a2da3030d47a
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Nicolas Schier <nsc@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Zm6n7DvPV/zt+FKqZ0sjzZv/v8rOmXG/Eq1yFEOyh8I=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFkf06P4DTnV9t09uXaJ3Ke8/TW6Tju3hRusifx3do2Z7
 aU1wbqbOkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBENGQZ/kqICBo7fTRZZ777
 w4NPJl9Pa0VflHazsZ69OyW15+r9djOG/4lb7zZZdBx9eVbQ4fqZ5YzrDniuiz2t2/D4wI3nwst
 E5/AAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When scripts/modules-check.sh is fixed to normalize the module's name
like name-fix-token does in scripts/Makefile.lib before checking that it
is unique [1], there is an error due to drivers/input/apm-power.ko and
drivers/power/supply/apm_power.ko having the same module name.

  error: the following would cause module name conflict:
    drivers/input/apm-power.ko
    drivers/power/supply/apm_power.ko

  $ modinfo drivers/input/apm-power.ko drivers/power/supply/apm_power.ko | grep name:
  filename:       drivers/input/apm-power.ko
  name:           apm_power
  filename:       drivers/power/supply/apm_power.ko
  name:           apm_power

Rename drivers/input/apm-power.c to apm-power-input.c to make the module
name unique and clear up the error.

Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/20261108225808.1809266-1-sashal@kernel.org/
Link: https://lore.kernel.org/20261103110411.11698-1-info@daylightlinux.ch/ [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
We would like to take [1] for 7.5 in kbuild-next, so we would appreciate
an ack to take this directly or a stable branch that we can pull in.
---
 drivers/input/Makefile                           | 2 +-
 drivers/input/{apm-power.c => apm-power-input.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 2cd6e1c9a778..842a7e4f7b50 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
 obj-$(CONFIG_INPUT_MISC)	+= misc/
 obj-$(CONFIG_INPUT_KUNIT_TEST)	+= tests/
 
-obj-$(CONFIG_INPUT_APMPOWER)	+= apm-power.o
+obj-$(CONFIG_INPUT_APMPOWER)	+= apm-power-input.o
 
 obj-$(CONFIG_RMI4_CORE)		+= rmi4/
diff --git a/drivers/input/apm-power.c b/drivers/input/apm-power-input.c
similarity index 100%
rename from drivers/input/apm-power.c
rename to drivers/input/apm-power-input.c

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261109-apm-power-input-rename-a2da3030d47a

Best regards,
--  
Cheers,
Nathan

