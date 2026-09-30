Received: from outbound.st.icloud.com (st-2001i-snip4-11.eps.apple.com [57.103.76.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EB47127E
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799050; cv=none; b=gCMNX5hyx/6ZkdM7UvCPOIDBmhor3mRm0xbQAGk02IbplQ8i6KsAEKJl/7edVMugtKGkQyUw65EuVQA05PW6jZ/eAfCbJSRwLtr6QQTkOL52jlePog2UjNC9xIHFOTk82qP0Z+CR/kRlWos/2fBDIBhIb6z4P6woC3Eccl7d1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799050; c=relaxed/simple;
	bh=IbBDmu8yKjwGDDfuW5fb36L/iyffUzang3lZ1QrX23Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DQjMVp2WhQ6/ekEIMZwWN0g9mafOpxX6pKUUpcmxfnGiW+QrX2oE/V0b8HkWaPUSSlv+qSDKxXlbvh8IaDm8YQuz142KIiZkjO9Do00tSMZPoilv55hhCvf8JGP3wfij5MWrcyqqG8TWRNP/NTwmYiu7ORGxfAW7/hZF79y+RmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lcb.to.it; spf=pass smtp.mailfrom=lcb.to.it; dkim=pass (2048-bit key) header.d=lcb.to.it header.i=@lcb.to.it header.b=e84243bj; arc=none smtp.client-ip=57.103.76.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lcb.to.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lcb.to.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lcb.to.it header.i=@lcb.to.it header.b="e84243bj"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id EC8C81800120;
	Wed, 30 Sep 2026 20:10:44 +0000 (UTC)
X-ICL-RepId: 01a0f3f0-e0da-7afb-a1b7-380d2343b9b4
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhBBkMEWRxBCU0dXwVcEhVdRV4MRR9bHlZWQwxHDkAfeRRQDxkfXV5QDBMLU1ZeE1tWRwIZAkZQSxsOWRcDVxxWRVwYQwldBVccHR5DRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUFsIUF5NFx0EQ0tfGV1FDw4HCQdJDhoLQFJcUxQUTFUPVkZTQlsaHlhTWQdCXEtXC1UPATBVG1FDQwQcGU1GExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lcb.to.it; s=sig1; t=1790799047; x=1793391047; bh=+OPch1KwDEc0ucCy9Ue6atr70dhpjypjbN94qw7/q6Q=; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme; b=e84243bjpos62hK8rbYYc00DX+4HqhGvbSmWvb81pSPNMGMu5766R3s+VT9aPQonsANQmdnFCxOi1f1yG11pl+VtT7rAdE6Xu2qO1iIb1M+vJdNLmeHhIakVfSmm/K36SBuEGy39id0YNxWcjDdbRMVwgiQ2ut5XuT3JmldKrmfeT+6xnCvAEZISfaxwKVaImqFyl57Oe5/NlfdSgHybo9DkZnvnc1p4H0+NuBuMOVDmcZtmHqFz/SNPQPeZ5H3jrbEAv92cpy5/YEXdHXWNHW5YjeCnUaxU5pJDiQNZfzG9tLuehkEZUcSxoT12xWudp18HolvytkOfxhLaFRXa/A==
mail-alias-created-date: 1748381178872
Received: from [10.69.1.69] (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 3A1231800785;
	Wed, 30 Sep 2026 20:10:43 +0000 (UTC)
Message-ID: <c0b597b8-e7ad-4fba-a2bb-5d252e3dfbd3@lcb.to.it>
Date: Wed, 30 Sep 2026 22:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, it-IT
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>
From: Martino Papero <martino.papero@lcb.to.it>
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 15IWC11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _aqvkKRvFVCrqhf6EFTqWk9n5eOIjM3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MiBTYWx0ZWRfX2GaJn5bU8szo
 6/0291YZc9zTg8oXXESQwBjz/VPEkeGSS8b/EkJUCO/LE3Zyu9P4EWW/MAckQ/WFrBQXhBpxVQk
 USjY3g8veG+pBSYt4k0WSFlAyzL2+XiZw3Vx7TIjCmgaXI7sx2y2uYs+I7cDDJ1hVTTRdXrTPjs
 Ym73fVlgmjmixBKHaV6eQl1ZqqtsERIFCJFEZb8HUa1HbtKbZmiN8+lntkzN1bG1Ne/gqlckjsI
 nV4J96au3AnufmgwG/FivK+gUTJvVC1XvrUxhzHjslbE/1i1XVAhvmRnsIG3BHdhRQMe3WTNe6R
 z+ZXIHs31IdWX5uurDWbtgZZF//oGAVk47v5Xs5eRXuq1yApZRaLquulbAe2t4=
X-Authority-Info-Out: v=2.4 cv=Zrng6t7G c=1 sm=1 tr=0 ts=6abd6cc5
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=qxBrxa7OMxVuxdj_4mIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _aqvkKRvFVCrqhf6EFTqWk9n5eOIjM3w
X-JNJ: AAAAAAABOAKOG2qYJEFsQ/LpllXoqSzXPj1/CNOM8vMs+zCoqbFBXZyua2q6rgLE/yDKCUSNhHqzdc9ZuVDIeqAEdxdWenBAoH+I0qE4qBaSXxpbZd8/Gku3ynqIoBCurfBZp5VFjSDass5rRDSIkEnBpqBYA0bLi2sRkb/kjajOppbkyfMAax3gwG6LHDXL/CrYwh/vk+IOk1oE+WzmrAYsGRnTU5OOucoANqkiyqxEYgqnvGLM2zpZVYze5NJDExnGZIY8frDnDz1nFbzEoHERLjO2k8OVDTL9iJtb3fOMAIwNhD48CjKTBaJ2fhIUf0EQeDStDniCx95qqa6KJFmUYPmaiAFHBgKHeHoSREgZWtkuQ7eNy5x55WcJT3gmtSArLEWe0xbagwUPXaBj/lzV52eS0aoBla7HkfBhfwp01eHqQn5AsNbjOjPlFKtXIyCqoscVohu0kFL67f/K7CxxdqSmuQLfPEQ3W6ir5IDTa4rbrD/HLRZZW2YDz4I2O2eIjsMm6jPvvBHqelQ4ViH2/3u/ASPyk06rvRydgF88WsL4/DhwjhR2bB5qYCVKngn0M5q73Ijw2k42bpdKtn6TAA9WcD2RigfVf9pqM/U4NG7G4zFJrVrQ3YcPt7JwZbHc3WlnzivC/R6njkN3VVD6lr8sWk/WzltsaX3R3AMYzJjXywxWlz8rp3eNnPS25DDkfxrbgVDy9OW+phMo6LmRHQ6Wt5TSHh69W2UIRsCw6YyU8WR4qM/IgmLGpSC6/LZ34aFoLJ9j2y5nuvJIxeTuEdlNC7Um2OYNuJS/sB2p1YafECsYuGJ/OKyF4BLI3Wrf07GF27/HMKpiueZbl08b4w+CRKTy3yDi5jt6vGtnSh1TMwb2fu1t68IUif+PFF6leTCzKI9CpLnNi+51ilnKz7EOXjiVxaXnspGiTIPjzrAi3G+2UgB9WdqwH/5Y8Bze+y4gVJH2PCPeU6I0tFQg+/WX1x5
 oMNibaqUIroKNcXDnSk13Kj7mInfoMUHleFT2GR3txMsSSFDXWUOC73Yb0vxbGXf/oT6TilyzoegcOJWvNyxhoW2prNiObK82I/q9bNmlJCQt4QvUDhTs3VYKkm9ifAOXoIl1mAQxvJIDQfpJSG6fiYZ2XNhuP8yZqFvFGiQMZF4SLHobI7ChcmWbNUtetp85arak+dSv5NGFcUN+atwk5bMYGAz6FBrblO+XTHuGltZvRRpq3vD3WGxntpcVNNT90nIQqqr/0Yq0qg9AVTbseAscavBH2QijSIuQJ8c3

The internal keyboard on the Lenovo IdeaPad Slim 3 15IWC11 (83RR)
does not work correctly with the default i8042 settings. Using
i8042.nopnp=1 and i8042.dumbkbd=1 restores keyboard input, but prevents
the Caps Lock LED from working. Using i8042.nopnp=1 alone does not fix
the keyboard.

The laptop works correctly when atkbd_deactivate_fixup is used instead.
Add a DMI quirk for the 83RR to enable it.

This was tested without any i8042 command-line parameters. Keyboard
input and the Caps Lock LED work correctly, including after suspend
and resume and after a cold boot.

Link: https://lore.kernel.org/all/4f43465f-98ba-4722-8e29-03df20315369@kernel.org/
Signed-off-by: Martino Papero <martino.papero@lcb.to.it>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 93650c982..b5ee5697a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.55.0
