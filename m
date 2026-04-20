Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7351A9FBD;
	Mon, 20 Apr 2026 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711593; cv=none; b=Iicx5MxhoJW5Liy+kjmByInzeWcz8EBSWosXXUgVp4b2D26Dy6iL1vheh9kzxev4sK/nBKDGfuc3zs2bmSDFHLeRpUukFm8uygNmsEiSgEHSl9xWqF2unx1zq1NF1J8HL9nmSatRu+qntBJrvK9e4kyNATeaXqVwroRbD4kltco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711593; c=relaxed/simple;
	bh=RayBv5nx3K4raKsrVqtPVxvwmG8ssP8xqReq8wZa68U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTgpFDgOIxz8CYzkIupSIGAJKRwHpvzRi4RG/Rzwge8LT+75tRFhzp1bvRonwqs+WxyCp2lEl1SB2uFzKH1+VREmAsiRH7eizbDVAjT0GodEKzvCWNq5hng4PAtKGIRnJ16rspMxUU2/y51KBpFFeaANpsvB7GM9Jw47bgQZBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AI96yaqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AI96yaqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DECC2BCB0;
	Mon, 20 Apr 2026 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776711592;
	bh=RayBv5nx3K4raKsrVqtPVxvwmG8ssP8xqReq8wZa68U=;
	h=From:To:Cc:Subject:Date:From;
	b=AI96yaqMjsBStY5PCINZt8uLUMZ5OFpHlECbBArwTYTO/V0Gzwf/X2g7nyzVxo6tg
	 PkvJW8s44kkuDPlmS9qBVxKg5ylZCIKTYxtPUgSWMu4cpmb4ukxgsKjhcaLiA3Zd+F
	 wvihrM3a4ZrzrnoJTIAp9tXy1Kz8O7XbjE5Ebpxw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 1/2] Input: synaptics-rmi4 - validate register descriptor structure against its declared size
Date: Mon, 20 Apr 2026 20:59:45 +0200
Message-ID: <2026042044-amuser-tantrum-73af@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=RayBv5nx3K4raKsrVqtPVxvwmG8ssP8xqReq8wZa68U=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnPyhecelab0OG0aNbRjU2M4m0nWG4mb//S/2i9xKmtl mu+zOyW64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ3EpnmO+qdTXNumblgq// b18Ljm6aZLr8mQ3DguOiuxJv8PEW3uxq2cv/qee389/dtQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

rmi_read_register_desc() trusts three independent device-supplied
quantities to be correct:
  - struct_size, taken from the presence-register header (up to 65535
    via buf[1]|buf[2]<<8 when buf[0]==0),
  - num_registers, the popcount of the presence bitmap (up to 255),
  - the per-register entries inside struct_buf, each a variable-length
    {reg_size, subpacket-continuation-bytes...} record.

But nothing checks that num_registers entries actually fit in
struct_size bytes, and nothing bounds the subpacket continuation chain,
which can cause two different types of overruns if left unchecked.

Fix this all up by properly checking the values every time and aborting
if anything is out of range.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_driver.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44db..9143f11e42a3 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -643,16 +643,24 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
-		int reg_size = struct_buf[offset];
+		int reg_size;
+
+		if (offset >= rdesc->struct_size)
+			goto malformed;
+		reg_size = struct_buf[offset];
 
 		++offset;
 		if (reg_size == 0) {
+			if (offset + 2 > rdesc->struct_size)
+				goto malformed;
 			reg_size = struct_buf[offset] |
 					(struct_buf[offset + 1] << 8);
 			offset += 2;
 		}
 
 		if (reg_size == 0) {
+			if (offset + 4 > rdesc->struct_size)
+				goto malformed;
 			reg_size = struct_buf[offset] |
 					(struct_buf[offset + 1] << 8) |
 					(struct_buf[offset + 2] << 16) |
@@ -666,6 +674,9 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		map_offset = 0;
 
 		do {
+			if (offset >= rdesc->struct_size ||
+			    map_offset >= RMI_REG_DESC_SUBPACKET_BITS)
+				goto malformed;
 			for (b = 0; b < 7; b++) {
 				if (struct_buf[offset] & (0x1 << b))
 					bitmap_set(item->subpacket_map,
@@ -688,6 +699,12 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 free_struct_buff:
 	kfree(struct_buf);
 	return ret;
+
+malformed:
+	dev_err(&d->dev,
+		"register descriptor structure does not match its declared size\n");
+	ret = -EIO;
+	goto free_struct_buff;
 }
 
 const struct rmi_register_desc_item *rmi_get_register_desc_item(
-- 
2.53.0

