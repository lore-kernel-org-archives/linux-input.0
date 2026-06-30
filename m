Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5983019A9;
	Tue, 30 Jun 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802371; cv=none; b=CSofjZdS+3xUryh/8zz8N/v4PvK4C0HZv5zoCWyeUzPUtR6MhZCuQP980lbRYNy3di+3Kj/IKHuinbrVhgpIiWT16jd+US/wh0X8+/ETY+tdx1SbQWnDNV2wy251eYs5jP/pq1J56y8Zmvz15X2U1Sl6ctRTgwgQ7EJBtGM0viw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802371; c=relaxed/simple;
	bh=paj0HLBqKdGMJFA5RuG7Xl77Zr61av6UWbuoxyY9MWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xw4m9AeNSZxYMga3Y8Q07Ppn9yekND/k+ueW7K9CikgpQs8G2PXF7kjbBPjGwi1RhgUe/Iej9tX9fUPRx1otBZ97VjYVu8dhEdw8ca/FZN220m5+7b2q5n87hZ0xCSpubZSv9pQc1lkX6XUQ5teGWbbJ8ouNOWjbPDMHas8rSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0006-HID-rmi-check-report-length-before-trimming-sentinel-bytes.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABHkcS9Z0NqfhQjFg--.8190S2;
	Tue, 30 Jun 2026 14:52:46 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] HID: rmi: check report length before trimming sentinel bytes
Date: Tue, 30 Jun 2026 14:52:45 +0800
Message-ID: <2026063007016439.1-ccfa108-0006-HID-rmi-check-report-length-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHkcS9Z0NqfhQjFg--.8190S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4kWry5uF1fZrWkur4rXwb_yoW3Cwc_Ww
	1a9rZrWr13CryIyr1UX34Ivr9aqa95ZF4xZas2vr13AasrZr1kXry8urn5XFyDWw1qgFyq
	kanrWry8ZrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

rmi_check_sanity() trims trailing 0xff sentinel bytes, but its loop
reads data[valid_size - 1] before checking that valid_size is non-zero.

Reverse the condition so the length is proved before the last byte is
inspected.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/hid/hid-rmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17f..2bd781f 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -365,7 +365,7 @@ static int rmi_check_sanity(struct hid_device *hdev, u8 *data, int size)
 	 * such reports here.
 	 */
 
-	while ((data[valid_size - 1] == 0xff) && valid_size > 0)
+	while (valid_size > 0 && data[valid_size - 1] == 0xff)
 		valid_size--;
 
 	return valid_size;

