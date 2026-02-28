Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F12D7DFE;
	Sat, 28 Feb 2026 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250269; cv=none; b=sXmS/6D7EfbHds7q+YO2uIXkV4XirA++r7Jo1lgDUNBSZ3vPMBHg9vxbqjVlMLrH4gHKNthb2vWp59hBMdP1P+GR6Fv8CpOvefsVkSDOJ36LPEMNW/qmJN/1sqtZOX7Say03CZNCI/LcpL+wDSk0BckNp8dtjyDhkENOppZr4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250269; c=relaxed/simple;
	bh=muoiu7J2zxHtmSelAUmqdoreLJH4pgKgsHqmdLOWHNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XbQ7o/eA7QN/IJncbXAfJfZRHekpaLhoi9JagVpfSchueaYMMga/wOAqqgEBjmH7wpkzTjxJkVRMfSKAoK2be7v6d93gBLdaVKEisp51B/+12MLK8Jmc7T3zISHi8YaUfBp6kRSvR9YAXlFO/SC59bd1S8teriF82srfz3xA1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAHlQiXZKJpmRpLCQ--.15382S2;
	Sat, 28 Feb 2026 11:44:23 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: derekjohn.clark@gmail.com
Cc: mpearson-lenovo@squebb.ca,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] HID: hid-lenovo-go-s: Remove unneeded semicolon
Date: Sat, 28 Feb 2026 11:43:43 +0800
Message-Id: <20260228034343.286005-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHlQiXZKJpmRpLCQ--.15382S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWw18tFWfuFg_yoW3Xwb_uw
	12kwnrAw1Dt3Z2y3s5JrWFvr4Yvw4UXF4IgF1IvF43JasrZwsxXayI9rn8X345Zw4Uta48
	Gr1DKrZYkrs3KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUnbyZUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index cacc5bd5ed2b..d1eb067509f6 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1102,7 +1102,7 @@ static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 	default:
 		dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n",
 			ret);
-	};
+	}
 }
 
 #define LEGOS_DEVICE_ATTR_RW(_name, _attrname, _rtype, _group)                 \
-- 
2.25.1

