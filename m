Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA453E2E5;
	Tue, 22 Sep 2026 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085810; cv=none; b=dnmOtHqneWNEPLVzJJN8eLV1zRBzjC38F0IW1dvhpybnNqxyhpPMLZWKHfDLSdde04WZXESSSMQKiztQVbC5Hc/wjiJUy5pCSdxbJ4ld8utfaCmhCE8qexuEAKotFeSFD6ZVJZ0TGwuz8g6aKhLbWCgz/wuoyOKhAqMNjwLUYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085810; c=relaxed/simple;
	bh=p+F2pCZjD2Q5OCPX9Nrh6mR4EwHRCs1f2sUij2R8RKA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dviqnROw7VYk7NULJfI3bDBM+uT+XQ31ENzWywW38KoWTDbaPCZT8OU+osz+NNosljGDx5Dn+tBLLeypTCsyIhnnhdTrMqf+SixmdsOqfhSJ/HV3epsp6uSI4VJv8v1Gl4atqKgwcwAuqaY7BTJHDUM6kHXDV6crViQ3ymlnnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Fm2iTm0Z; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Fm2iTm0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1790085794;
	bh=1QWozaUISlbIzcHa5uelZPP6HjqeEhsRseFpKK18mQI=;
	h=From:To:Cc:Subject:Date;
	b=Fm2iTm0ZwmZQVqZmVTdtNwrYkp2ZUftNhLb1O3tSoHQIEpfeC+wk9gbRfb899lKVU
	 xtVNzCtVq6x+w16+IBzYDteBplb9+a9SbQYW+/f3ONjlXWTokQAqffGVMqaxpzbLbt
	 crvesXwfyHzpS9hytpNsg0hniGj/OF2H6WJGn93Y=
Received: from ArchLinux ([240e:430:5a18:23e9:ffdb:17a9:949f:d535])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E8F96C19; Tue, 22 Sep 2026 21:58:15 +0800
X-QQ-mid: xmsmtpt1790085495t57q60qpp
Message-ID: <tencent_52E5A86D414441758B1DBAF6C4B8E8BE3F06@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3N1GoCB7xZbKLu1sj0lXaXyyx1Ueux5Jf9fnRupVDb+tdEgL3uUe
	 zkOyGzPDqcvXuHziNIfQ/PBa+Z/zGfCm+o/IGNobtX5y9NQeDhRRR29gAimO037yyJOlXbCEz2tQ
	 /5s5hJ147uUmMWZXMONlDRDIfH997wUJUatcvBsvjhUvEbXKnkBodUdV6bUl+8hD527egXQjujuY
	 xK5Yy4YNqmTdi/s2AcCNmaYdbzAP5eolX3FHNkd2/1/dKYQraSlCWmkrwHRZTxKT0AB9wVxjloWb
	 gg1wsYCEpiSdQZTggp6isJMEDeTFJpvwA3oWiP15AVzMYki0VljL1kVfTPVCJO7X/rmvZNhd8VNb
	 nZFxUOS4Mxetr6LF4TZjhCGXNWGyqUlV7dGsEDXnvP6k6a2mnOZRcuxdvy1oql79vHx2Pbz/f6LW
	 YNdiTOgLmVxKL8nxQJHalkBscv6Be5VrsCjaCdXWPbVdKf/T/9vfP82YTU7kYersAbaMLSpQiFKA
	 KljajegX5KrZS5DUf7OajqXmKV3V2F4dVBW8brCz2vn0GlWxb5UBhtLQg1UA6+nQgyehtnWVEwsr
	 re4iMJdQn0vJ3zxSclZpNebXDAw7JzI8khcMQM8pC4lQzKVcveLJkWeFmk5veEX29YG0ygEJqamQ
	 bjpTTP7dd3TPPP1FB4rQASKTsIjsL1WGrN2ofrPU+r4pQk6e4gzV+6ppecHH3dK5U3HHYcMaDpDT
	 oyZ0zDCAB1spoajLEOoRxt3iYUMw0c/qsuM9fLhRdEKl0jJt1qHbZ+j9g93aL4z2qZlU8ue2wnPy
	 qHQbflSWugOe7t8yP/u7Soau9Q0FVHktIk5XL+Uy2dp3v3q9akFxczTPh9hLYlqMNgzdURxfQrzD
	 xwjPml/9lVJXFyZCO3qjor2AsBCNlRqOhUbarwOkmbDtLwGkfypVZCdIyTQ1nr9/kwKS/CLDJLJo
	 cV7fsag4NgayepaUyPOPy3w6JUeDeH2ssqaFY0X9ofv6xEFmT6saG5++U/WPhZb3mP6wnNWRVs2n
	 9ZmVwduCT0iKxR5+aKyOQY+AggjDHn5hYI8Fk5c8pw0PTUTR1a
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Tao juncheng <mono268@foxmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Tao juncheng <mono268@foxmail.com>
Subject: [PATCH RESEND] Input: atkbd - skip deactivate for HONOR NWB-G's internal keyboard
Date: Tue, 22 Sep 2026 21:57:34 +0800
X-OQ-MSGID: <20260922135734.770240-1-mono268@foxmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal keyboard of the HONOR WIN Gaming H7 (NWB-G) stops working
after commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"). That
commit made the ATKBD_CMD_GETID-skip path, taken on modern portable
machines, fall through to atkbd_deactivate() and send
ATKBD_CMD_RESET_DIS (0xf5).

On the affected machine atkbd binds to serio0 without reporting an
error, but IRQ1 does not increment when keys are pressed and no
keystroke is ever delivered. With atkbd_skip_deactivate set through the
existing atkbd_deactivate_fixup callback the keyboard works normally,
matching the existing HONOR FMB-P, Lenovo 83QK and Xiaomi Book Pro 14
entries.

Add a DMI quirk entry for HONOR/NWB-G.

DMI: HONOR NWB-G/NWB-G-PCB, BIOS 1.10

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Cc: stable@kernel.org
Tested-by: Tao juncheng <mono268@foxmail.com>
Signed-off-by: Tao juncheng <mono268@foxmail.com>
---
Resend of <20260901140336.10568-1-tjc1437@gmail.com>; no comments
received in three weeks. No code change.

The address used for the original submission is no longer reachable, so
this resend is sent and signed off from mono268@foxmail.com.

 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c8ad55f26ea8..de8edab3cb0f 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1923,6 +1923,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* HONOR WIN Gaming H7 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "NWB-G"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.47.0

