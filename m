Received: from outbound.st.icloud.com (st-2003a-snip4-11.eps.apple.com [57.103.77.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C83B4E81
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788805655; cv=none; b=hDzwzXFDHkT1uJXexm8JuWiHs8qdcoLz+MFV9sC26EmUeUL20qmI5+7kD5PSLPbq9dVu+L3oPjTQJIPFx4cx/13iHy/cRed+nlHwibH9D/f8TvXw9z9qwXbAJ1I1yifLE29hnCTuyJVjQgD3JLn7/oT2LjKQeAUxrR+ljzrFrss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788805655; c=relaxed/simple;
	bh=PteMFj+lnvStW5hOInhP4OQ6hIxJS6bH3hSFtUaY3GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLXnZ4n7WZ5Zv66pw+lzhs0E+3xmdhOPc0UcokenCGO8TbLxL34amn8JZKK9Fmwc9ZGT+NEd9fHjWGiClfx2GiOjaDVvQ2QxcHaAvip6pTEvLvqOoiBmrfOnkiF0GiWxgHWEYLsiFyxvOVJqS1hD1cNy8d84ucc15cR/JnMGFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vIaPu0pO; arc=none smtp.client-ip=57.103.77.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vIaPu0pO"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id 7DF02180051D;
	Mon, 07 Sep 2026 18:27:30 +0000 (UTC)
X-ICL-RepId: 01a07d20-1807-79dc-ba44-55b9756886d8
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhIC0MFWwBeC0wFQwZeB1BcHA4OXxlbAxcLXABaDkADeRFQAVgeVl5aF15NUQ8PGVoUXBhTRVEfVFhBDgpfEhhcFFxQWB5GElYNXQkZGEZeUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWWxNVF0YJGQhdHRkVWgkKVwBAC04DVAdcA0gLTwFeGVkFQABBC1waWh8TUQpaHhkYXR1UHUEedwJRHFYNV0NUBF9OGQxKHVJWWxNVF0YJ
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788805652; x=1791397652; bh=MmCwo1bB0Tzx3sxbGq6J9n7Fi/WoH0KJC3vD1qfkUXo=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=vIaPu0pObWTJl0sWZiyoJIEhuBeZG4rxk/t+FU5KS8Mh3tCXWfJ0hgwTVL2phUjRQaRL09baspzSFlYrwdU4OYdMShTdkjeRlgZ4PCQKiQNV4jcnWfoIPws6Bqr6AxsrW4vzUXp3O/dPc0PXWuCnoDFcaVNCn7RS/7tZElHhV6nPT6D1aJ1kSn0yhLAihWdHeroKP2YMUSo3OHm0jYtcv4GXBeyqpJZGEYreBt0XxDWk2xCYuBLrTuKG/2sa0oAMOAUBkTnfz1d7eEV9T4F2UD9jQ6RuozSzE113f1MbsmTuukyt1R/cNRCjGaUwvKhBlDfzvd1mIx5UL4QG4JD3XA==
mail-alias-created-date: 1424372741000
Received: from [192.168.0.64] (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id 7A10E1800514;
	Mon, 07 Sep 2026 18:27:29 +0000 (UTC)
From: Chris Sommers <chris.sommers@icloud.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Sommers <chris.sommers@icloud.com>
Subject: [PATCH] Input: i8042 - add quirk for Acer Aspire Go 15 AG15-42P
Date: Mon,  7 Sep 2026 11:27:23 -0700
Message-ID: <20260907182723.2709981-1-chris.sommers@icloud.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIwNSBTYWx0ZWRfXxhUI76z0Fm7q
 pahO7+OkqP9FMqhv4foav5O78u1g8d4U8evmu3kqEN6W7Veo1BGbDIf1ZlaAsEGtwwvftfp+J43
 HNaTppz/x34ixeiK+Ww3um7Os7U7u1IPNSTvnZQ4UEU86szMxABrM5xL5JlI673GvVwRia2IUSM
 MK1r0fT1lomnaPOTr0QGDrw27vrSTWJvg7ZZHu0nQ36CPz3BQ9Rmy4CYplY96rJsc8WlKBlbzZT
 610G3CDv+wvnLbQ/9ZEd1+Zh8nUXUW+7oj4kbpYi0t6w/Gdwe0REHcp3l4NHP1bDSIiuSFkvLz1
 iJXJPJi3uVrH6inLSf742BccR29RizJR2GIqr9OGXBDHv/L6s7bvaQ3oT2Qjsk=
X-Authority-Info-Out: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=6a9f0212
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=5amaBBAfSiYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=ZsV6aD_4eAcAsxee2fsA:9
X-Proofpoint-GUID: PAJZL7OsnuR3zqEveoHBSBLqyBLOPk4Y
X-Proofpoint-ORIG-GUID: PAJZL7OsnuR3zqEveoHBSBLqyBLOPk4Y
X-JNJ: AAAAAAAB0RWD2cqRU3hbvCTy+VJDPspdpEiUMsqh/Zqg1aOYh444yH3YiuGCTTy5c3m43Kb8/SqtPQIEczlTOgyAbawAkCn++mcs4C5nfDe7SFzuhuLNyM5v2qKXkjQeUSSH2XdBaR1saZWizhZY63T9k3l0RIFF2aCfM9ZqDqF/KfTbkXCJY6Z3kGAq9wJ6GoUjY6DiCjxh/3euVnvVG0buN58V2Pt6UYH9kt5e2vcarppI/xm9a9MwhXqOP7SsR14mhcdL9AjUkgW0mTEa8W0dvI1xyXU5UZXQPBrJqxje7fcOhFnS5wc/7HtgnoucgyZPLMjKWcNq4lNFRr+sNm9h7UcgoV9WGkSrKzo33zeP1ky46m1pbVHm3b6H0Gkbpbg7aAI1LOFpEEN2a4BMNGCY+GjqqNXg9aysjCawdAz+n+EctH2kAT7UEwodxtdDYWjCBky5E7GUnL7W6w9vGcmJWrnpJPJQEh7yvidJ+jktKlsZDi6ayRKE7+0Hh4GuzaS3/OA9MkORuJPBrtuAhNrxqbcYTlqHPpO2YUmSUePkQcxFZmVx4+K9YOcK8ySjHslPNqSD5wUkyomeEPFx7pzCIa1U0jyeIwM//Tu9DcnwK9vZsC+48IMWzDZID5/D20Y0A54gXjJyRtLxzxcRSQD6ukVh+0hsurZkph0XPjx9kjQsbKOVuvR8yI/NqXGHPeGfBrspufwpK1BlpwGB6yfYbFAcR3S+wZsa+M+qh+vUEp2gHfzX92qtnfskz+8j2l9t9uhMtn6mfWszSnfw4nMHLQpxmxYD+1vpVjoyX3Y8xxRaUSJqrdiQ4uLgUN26FXqeL1GD8zX6JtDOwBZ9Gjauwl3NsEJ8ETCMg/OnLAPQxUsKKUpv44BjiRzraSlSchxTwdGFNwbS01zNrx/vk8p1KabTANugCLnItwP5j53HtvIXy52oDXfR0tJHAzrqptqoi60IC8bfzAv5/sfPyQQbdS0ygEL
 kSgJk9t5SPuh6XqUNAOzWbPvqlmK8vM13PpwQvAv+0MJAGMn3evJapfcEmv4bRqYnWMIumo2K/rT0wur0wqvf13X0zB4rJ1wOV0MxkAkRfWCePkndriCk1ToUn/KbIIwsDgwSrlJzYOFO6inX3CASsXl+XjVghYHZPc6/mspHsqRvGAh1u13wsdPmbTvQlpcA0Qpva7X1sIentjSV1/Ki82LdhAbzTOeNU4FQUWWSYVEhme84qOTEka6tLR0QyAQDW7JOndobBa0k
X-Apple-Category-Label: MzQ4MjE3OTQ6JGNhdGVnb3J5JF9QZXJzb25hbCw=

On the Acer Aspire Go 15 (AG15-42P), the internal keyboard drops out
~5 seconds after boot on both Linux and Linux-LTS kernels. Keystrokes on
the built-in keyboard stop registering while the trackpad and external
keyboards remain functional.

Testing confirms that booting with the i8042.reset kernel parameter
resolves the issue and keeps the internal keyboard responsive.

Add SERIO_QUIRK_RESET_ALWAYS to i8042_dmi_quirk_table for the Acer
Aspire AG15-42P to automatically apply this quirk on boot.

Signed-off-by: Chris Sommers <chris.sommers@icloud.com>
---
 drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 9ecb0eed4..54eb36870 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -259,6 +259,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire AG15-42P"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
2.55.0


