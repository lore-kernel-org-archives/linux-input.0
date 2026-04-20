Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FF1A9FBD;
	Mon, 20 Apr 2026 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711590; cv=none; b=ry8xuzWCi6SxCAC21Fdu/BMOFegq72eAlpU6vaXYNvCRR6h8TBL0YsmsLq7BB770dVflSuftX4YdkzU2GnlNjy9Jdfxpeu5qsDdxeDtIHGFezILa/7V28+sZJzZqeBHPXkay5eVS19Oj8wkvvDQuwX0zX6KSOQJi0j93rXKYMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711590; c=relaxed/simple;
	bh=J3NMr6092uvohqhv7FYHv5SZnsSVWIMfkeigwEDkSu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+rbycu5WtQJbvK5Acs7kbp3eNvbKc8OoGIXQ8h+YzIrXHnslhBy+iNHryZCIV/U/hprhrDV22CgtqQKrZiOzNa+1WXC3mhmObqhMWprPFSILDfwFRH7TSe7X48YDLe+rUzCV+TNTkih7/Q4lkHWbkOEMy3dlIYn8IYu7js+etg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mYqNHsVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mYqNHsVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841A4C19425;
	Mon, 20 Apr 2026 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776711590;
	bh=J3NMr6092uvohqhv7FYHv5SZnsSVWIMfkeigwEDkSu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYqNHsVXUJw7FVAhVGGPJcdrtT8/y9CwIJmTR80IgY0iL6iUNKgE4mjp65Y4orrK1
	 F0ptv2K5ZrkIvolqde1w6rrUQDeggzijf7VYu5+29t25szqCo+g9GG41jjb/ze5GpU
	 8+qFFpr2A3hm1hu8XicRkVv0wfhy7EZWRLZaAzIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 2/2] Input: synaptics-rmi4 - use u32 for reg_size to avoid sign extension into item->reg_size
Date: Mon, 20 Apr 2026 20:59:46 +0200
Message-ID: <2026042046-clad-aspect-e8f9@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042044-amuser-tantrum-73af@gregkh>
References: <2026042044-amuser-tantrum-73af@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=J3NMr6092uvohqhv7FYHv5SZnsSVWIMfkeigwEDkSu0=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnPyhdN3yHapnFw5db5BVzzJi97ap+9cuGUVyWCkuWK/ x7M7dX/2RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATSfVimMWsMe3djagJflfn 8W52eXZWWG5NylKGBVe1z339vNJj2o3ta2Y1HfW3rdLSaAMA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

rmi_read_register_desc() builds the 4-byte register size from device
bytes:

	reg_size = struct_buf[offset] |
		   (struct_buf[offset + 1] << 8) |
		   (struct_buf[offset + 2] << 16) |
		   (struct_buf[offset + 3] << 24);

struct_buf is u8 *, so each byte is promoted to int before the shift.  A
device that supplies a top byte with bit 7 set (e.g. 00 00 00 00 00 00
80 in struct_buf to reach the 4-byte path with offset+3 = 0x80) makes
(0x80 << 24) overflow into the int sign bit, and the OR result is
negative.  reg_size is then assigned to item->reg_size, which is
unsigned long, so the negative int sign-extends to a value near
ULONG_MAX.

After this, bad things happen when numbers start wrapping and buffers
are allocatged based on those numbers, and then accessed based on those
buffers assuming to be a sane size (bigger or smaller).

Fix this all up by just properly making reg_size be a u32.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: b43d2c1e9353 ("Input: synaptics-rmi4 - add support for F12")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 9143f11e42a3..801096c7235e 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -643,7 +643,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
-		int reg_size;
+		u32 reg_size;
 
 		if (offset >= rdesc->struct_size)
 			goto malformed;
-- 
2.53.0

