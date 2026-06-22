Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A193750AC;
	Mon, 22 Jun 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782164646; cv=none; b=h3bkrbR7B3/cloS10oJaSyyxnHISLpWRn9Wgd9Dnm+pFMKzC7JXWeEAiz/n/ub6rViX0BgEhYlm2M+MCvvs7Dp99XgzOXtiLv0h7dGB5r0XwmP/Uvt5EYUuPUBaMtpAu2O4pAKSMauCwbjKtXmg103yu5VIw4iEvMQwONv9M1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782164646; c=relaxed/simple;
	bh=0i7NsvJ3jA04qpz1TZI0/VtC+WBq/0vU9ZBfvmUpSUE=;
	h=From:To:Cc:Subject:Message-ID:Date:Mime-Version:Content-Type; b=AjPt7uZeSpBxaYF8B00alOy7wInwOm0vqwi8cumWpUwjOm7Ey9W5S5sudubYCFL3AZ8tJ3JP7kmG5P1GzzD1vZBp/hFMZ+QkZf90aY+Pr8z7c8w2SWkiyyeNAUIcX3hx8wWBOH0EZiJs/ZURZKSrPZfrm/AMvm0iSq9894RXBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6jWCJlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3I8Kfpx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6jWCJlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3I8Kfpx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B669EC02D2;
	Mon, 22 Jun 2026 17:44:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 17:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1782164644; x=1782251044; bh=B1
	4Z/VgMNRVP9i/RCpFLBA9/L2ZsO8kQxmEnpn8ryJk=; b=f6jWCJlQ9fS4Idf18D
	olg6GNnEpLc1XkrDCljWWZNpY2ZiiUkn5SquaJKQgTwd6tscson4EbclbJ/5FLuK
	yo50t/3yl32uAjI7lVPatZgO3zgOsL/Pl7KV51Z1ebKC7PCE0xIA6eOyEclK41to
	erU0thNQlGzCFLFrwDvgWHRQmqImeCnE6FW4DSQm39OeSyASWuSKRjFjp3MmW7g0
	BgM1pjfjHkZQD+A828OpNbtL5Jg3AZwdNlBxVrmbRAFl3RzgljaEtjjl7yaPqCa1
	gHqf1Y8nGZ1zxVibvslEkXwwOi8WQY3sLkqZ0CDorD6qEas83cNQ3VPYU3mgkgnQ
	YPtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782164644; x=1782251044; bh=B14Z/VgMNRVP9i/RCpFLBA9/L2Zs
	O8kQxmEnpn8ryJk=; b=N3I8KfpxejGvDIzWlX9f61nQ/xJaNMBXn42743Oh/v4k
	UXEJZptnEfcUZcfORJ2F1uLYvKSBi1RsqE38Xq3z2hlMETXuAECvrqSp6zjxQ1Od
	8olfWMLejYhpUd2kYOR00LU8jzLy5V7kPsHpM7XsdXYlqZPrs5n0024W4OXjWwsV
	GhleMPt9xgrH9DAwpw8TP+BQ+Xxuody+A6cqjTFfVHECx7eKSpjJ80DLqKbRfYCd
	wNZW+bkHjcLKG++xq+2yhr8d5R0Y3sfK8/nNe8rZ85KOWdYAp4DNkt3bntaFvzYF
	DpLZjxS1uzIWu6uqV2mLTkU4cz/RXlHzSHN1OdWgMQ==
X-ME-Sender: <xms:pKw5atBkPZ4SIEu8Fslecnd9feRtVnAhoZ08Y447B-sbr4eeby8fNQ>
    <xme:pKw5ajRQQcFR9eyuvAAVYPz0HJmdgCRbigMcJffu6FMpZX1Gdq604qB5fBJ09WXG_
    DuUYGQf9bf7tNQ3C7bpGsQXLVCBBryo1bNEi9HHxq3aldbhLbAWSC4>
X-ME-Received: <xmr:pKw5arpZL2m00vg06bZCaVyt6TYiFudetrUhVqSfAFWkehx7XfWs5VLqtPnNJ7fqHV6SiLzY>
X-ME-Proxy-Cause: dmFkZTEkrwCn1+DA7UWkW3eaifkwJpeH7EUGMCwx2mBYmKU+SHex4pQVBVMH/6AXN56O5h
    fh048paaq/btQL4xE+rzIjKbqlaX0rLH+yjxmikvKM8pcUzEU40J37r9aayznnGt9uJQhH
    oeD9YynJRgGudxlA7eO6tNVBBhbWjlgWi5ZY0Z+1I9DRpURCcTU62CoEABYGYg3nK33+g6
    xg6mus/0CvOYxWUfZXq2uCRn3OQ++yH5y99Ft/L2m2oaPf8eO/XBJRRYvtjlFXvebmWoW7
    7+5cVQN0M8yVCKSeG0i9tUcUuTkunwK2+5r+HBSPKpOzUNtXedx/KFpT7GWqqUiTQHS1Rp
    nquESWBlSM+x9MIs7UT88aueWuSlsEYA8BKyPR2TH1rmW3pW+bVVHhS1fH5A+OyPqgtI4e
    WWJIGLI0gHMOqN6Y1Y3V8Ivsn30ACK5cEnlhdby9l/6wLzzkLOmlJgMK+xFBmpfOIRK3NC
    GAF9bdefp8ZkEWzyBNMDuOHhOm6dzRMk2W6QFyG8kHFC2cePSX7k3N124FhcqfDXF5am+V
    KGjAMLxyKOx2i9QXVc63xYSKlAPWEAgUJAf1yVzFdPbH3C7oc/A/h/MVhZyOwtSVpS2k/a
    njQjSsAgL0e1594+tJfK7EKC0gq3FAfFrhBzUyUjeOYxwX7vD8bghqnPxtRg
X-ME-Proxy: <xmx:pKw5alzRz2HVWM_vf7zUWuBrU7Tp_HCxYs29THMpsOI5a88y8I1ThQ>
    <xmx:pKw5agLWN5IEbbVBk6ySp19RyW8ECY8B11TE6KitNC5VWp2-vDNQ8Q>
    <xmx:pKw5anKrEtWMxD_s0p0ekvHS4CqDZabiZ5wMDqxcqHBd_CmPKaMbVA>
    <xmx:pKw5alt5_dV-0r25ouEhEZvCjPnQXrJ9prIIIi8SIn4SYCtN5O05dA>
    <xmx:pKw5an10Ml-N7z-kjaMUdbx-pfCBmQN-Qp11UOjHR7_e2-7aSasGG0pV>
Feedback-ID: ied394979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 17:44:03 -0400 (EDT)
From: Mark Alexander <marka@pobox.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Alexander <marka@pobox.com>
Subject: [PATCH] Input: synaptics - enable Synaptics InterTouch for ThinkPad
 X270
Message-ID: <1782164489-csup-4866@bionic.bloovis.com>
Date: Mon, 22 Jun 2026 14:44:03 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
Content-Transfer-Encoding: 7bit


On a ThinkPad X270, I see this in /var/log/messages:

Jun 20 07:28:11 x270 kernel: psmouse serio1: synaptics: Your touchpad (PNP: LEN2046 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.

Add LEN2046 to the SMB list to eliminate this warning.

Tested on a ThinkPad X270 with kernel 7.1.0 and Fedora 43.

Signed-off-by: Mark Alexander <marka@pobox.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c70502e240..0684e25b2a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -188,6 +188,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0411", /* L14 Gen 1 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
+	"LEN2046", /* X270  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2058", /* E490 */
-- 
2.54.0


-- 
Mark Alexander marka@pobox.com

