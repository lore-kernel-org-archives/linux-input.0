Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE23E3156;
	Mon, 15 Jun 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528339; cv=none; b=MWi8xmMZkMmz8GQd9DpqIguZzeHkSfZZVb/D1UpeZ12lMPVJbowjVt72Ljw7D8Nq1kgDgrwEe66Fe24a7CeJEE8UnLxxeLybpOd5DyUGr49wZwm579zfqV9XZEWQjH7EraI3bEId7JkWbu1FQuCFvpxia/hsqDWm5v6v5LARTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528339; c=relaxed/simple;
	bh=5vVpJFblsZuv/odTb4MtRaQxEN9F0jQwyyrhf5eLSEs=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=XbqajgGObKUtWz8w5uzF0Q0wpmPabFxZv32caTnUpKvGDLJEPxAH0COkqQtKZfSkXal9XMvnBHgHNTaWTLye68ruqR/j7y2CAhuWJscL0mDoc60B/6qfQ9cw3asD/v0tliI/J6DOFZA8nDdjXgGHXk6UeR4jqad6csV/Y3PIQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egmmoz+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egmmoz+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E781F000E9;
	Mon, 15 Jun 2026 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528338;
	bh=u/zIB7QNcMwjecPrSDQ32VcZbkBsWU6ddE1Rm0JCKwI=;
	h=Date:From:To:cc:Subject;
	b=Egmmoz+ss1DfN5dAN6VEOo3n5BGGntebGs3gh9oUKb1j72mORDaO05zMbOirCwwCd
	 ObhkoBmE21Y8GbwUh5rc0IBdHxaSZxthUKi1pMzlROYhuF8WgwqPZgFTnVyHimg9XE
	 V9T1kMCY4FhnykEfL+8ZY2nkKeeZwZFKjT4Mn5CpFKoTTXpJoyBRw1uxHyXtUrmaqq
	 FSag0RAtaD6/LLEyU2fddGJ035xRSbSnv7XZ52uA8B0TkNCNU3L5x/TmtcEHpJHKK2
	 5ozm9K3MxSDPg0I+p5EuUshZe7FC5+BwQPsbPtnrwSMdLyVMgP+voLn0dBFGcHIcyW
	 0juNrqTB5n6Yg==
Date: Mon, 15 Jun 2026 14:58:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: hidpp: fix potential UAF in hidpp_connect_event()
Message-ID: <qq420675-14n0-p23s-10oo-1n8113s2nq22@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Jiri Kosina <jkosina@suse.com>

If input_register_device() fails, we call input_free_device(), but keep
stale pointer to the old device in hidpp->input, which could potentially
lead to UAF. Fix that by resetting it to NULL before returning from
hidpp_connect_event().

Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---

v1->v2: set hidpp->input to NULL before freeing the device to avoid race 
as reported by Sashiko

 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ccbf28869a96..d8e86b6ccf37 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4295,6 +4295,7 @@ static void hidpp_connect_event(struct work_struct *work)
 
 	ret = input_register_device(input);
 	if (ret) {
+		hidpp->input = NULL;
 		input_free_device(input);
 		return;
 	}
-- 
Jiri Kosina
SUSE Labs

