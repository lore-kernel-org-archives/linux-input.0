Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4117A2E8
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365039; cv=none; b=CgtB0diLXgcY/mSizddIqlziEZFyFkYxEa61sU/mGBKeQ/YjVYQPKz/a3MvVxeC8ytEDtSC9TrPZRC9HTfuhxytpkxLQupy3YiWyPDPeDVbWcn5W1kqNGlzfRyFaXhlcgcFFqvvyyEjvloK1kPXPSnFV2QeJAF7m92TiI4Kq9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365039; c=relaxed/simple;
	bh=u/N/eBKUNL06Djr6KY714eJpprrmOgnX37Q9XcaSZkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaorwHtJuytiURWkkIbj1gN5O5aqP44Qe6s+UEtQUlgUqJFu24RtTiwdM6KoJy603vUz0UEdFS49OxthHpqOoDD3X5uTrKhevdwSm1WmFfLRRRC+1DRAt5/5+Ia/CLI7NSsGGzQ5LaGGubK+BkT9RK3M1H90kNQbV0McWMnbRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=LSZBOR3Q; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nQmTWI8r; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="LSZBOR3Q";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="nQmTWI8r"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=LSZBOR3QsxOO8JSifAVKJ3Fawv2tCIenr+6C16FMixyTg9ATf/NPp6ECTxa04rDnIUjuneBodeBpWowlCcY+u5op87C7Z5ffrtx+64kwzK+scV/9iXIYqwxNiP3Y7P14irRy6Zjfj83weJC22FrPChHtBErUpWbd/NIrjBYkmOQu08UWBIPUulSMxa+0tSMJO7QmVSiu4OI8LUwdRut8QpQgC7Th4FafnRhyIXrHR5TwYuNVH0mKFdjzNBzKmKHJE9LKfOdzRtdXiDxg+ikCk1TeyqsarC1GavrB8ULcHIJrdbDjsO4xlwgFy1ovkotrDfZp1JIYlA4JrfeeghaDVw==; s=purelymail1; d=rcpassos.me; v=1; bh=u/N/eBKUNL06Djr6KY714eJpprrmOgnX37Q9XcaSZkk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=nQmTWI8rdzSlTZFxoJ3T8henBKTK7q0LPjabsVzAnyFe8SOpiEtBCmAvKfk4UocHLE7ByxhhSuemAFH4XSSKqhqdkIda1q8EmG2S8+1n056xcKCZ0QpXCMYRzAVD3+nqO5Kfe2xMMn7+NRcOqATQoYeLfxF5jMRz6AGs4MTiFDgU60fc/inIo7TEIjAta+jRLm7rVYd5SwCLkhi9xMKwIML5ThFC0zlqa+mxTfWQB1ZmASC39jgVGEG1FiugKTj8uF4URXQwnttmhBJJZyjDkvGMGNIx2Co8fLgUOyw/0DhvKGXV/1tfP/5nhy1Cbj8Helmd6onOIn93o+fv3pCtqQ==; s=purelymail1; d=purelymail.com; v=1; bh=u/N/eBKUNL06Djr6KY714eJpprrmOgnX37Q9XcaSZkk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 287587098;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 02 Jun 2026 01:50:35 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: linux-input@vger.kernel.org,
	lcasmz54@gmail.com,
	bentiss@kernel.org
Cc: hadess@hadess.net,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sre@kernel.org,
	kernel@lists.ime.usp.br,
	Rafael Passos <rafael@rcpassos.me>
Subject: [PATCH] HID: Input: Add battery list cleanup in hidinput_disconnect()
Date: Mon,  1 Jun 2026 22:50:29 -0300
Message-ID: <20260602015029.2838058-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The batteries list (hdev->batteries) is not cleaned up during
hidinput_disconnect(), but struct hid_battery entries are allocated
with devm_kzalloc.
When a driver is unbound (e.g. during devicereprobe), devm frees those
entries while their list_head nodesremain dangling in hdev->batteries,
which persists across rebinds.

Fixes: 4a58ae85c3f9 ("HID: input: Add support for multiple batteries per de=
vice")
Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---

Hi, I hope there is time to land this in this cycle.
Tell me if I should make any changes.
I built and tested it againts the mainline.

Bug report link:
    https://lore.kernel.org/all/20260602011949.2825852-1-rafael@rcpassos.me=
/

 drivers/hid/hid-input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..95815e140fdf 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -2408,6 +2408,15 @@ EXPORT_SYMBOL_GPL(hidinput_connect);
 void hidinput_disconnect(struct hid_device *hid)
 {
 =09struct hid_input *hidinput, *next;
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+=09{
+=09=09struct hid_battery *bat, *tmp;
+
+=09=09list_for_each_entry_safe(bat, tmp, &hid->batteries, list) {
+=09=09=09list_del_init(&bat->list);
+=09=09}
+=09}
+#endif
=20
 =09list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 =09=09list_del(&hidinput->list);
--=20
2.53.0

