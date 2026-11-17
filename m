Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911269;
	b=VH98WD0Gt5byv/pG2HNPr1f/ejNKqzE9qusaC9Pq0A16PCe04fXEUSjUPWvaSSVAJs6P
	 gibXbjbORcTgOMHV6MOjtE/xtdYrgwthSrxOwYfsscu/kxNNph0kvRfe8AUGahChppUN5
	 rzg86BF+FuvdCa57J3n5ayVVkdsnBepS7EG2fBC1uHtg/HmXQ0EsqMNktlkig0xmt2Ts7
	 rWGIBBE4X6U7G4IoViY6oXnnqk48SJnDzSdkMfDEfluhCUHOTcL4xw5vzxWFjM2QhGfoS
	 3L4RSPao4M+e+SNj+EgFlBq5tUnIbEZawStjyRNx0CZOID1l7dBbllWnCmbY93YvSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911269;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=8PpWv2uT3TdmyJbXy2eBaUwZeVjz1Ym5v6xoZQUHc4U=;
	b=VbqD1+VTW9dndqoKt9l+nKjJ9K5oPs6t+pHkf0G99sBhKneDUTNTr/lW5ylK9P/1737v
	 7G/ZZjvgHLMtXJgFqj+cjfKgulE1iewgaumgNoyTmoRArvqaF9uUL08j5E5bXgxvDEng8
	 kTB1HErbyb5fjGPnL/hQHuTKXrGBUBQwl97vFJAg3cDlaDAYWyaQFGtRsIAOrwNwq0Dau
	 BKfB1kHGUiIssogRp4g/B+cjkAuIck6iu5p9aQ8GjSTDQHg9c3JeZCA/c7DEAih2MpCla
	 ghyR+zQisiulw/13mGCUkgpLXOeD56hs2SckF33IVEVa0VZp2UofEzjJyiKxkl+3/Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=QmElyeDc;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01A606A336;
	Tue, 17 Nov 2026 10:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F01A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=QmElyeDc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8PpWv2uT3TdmyJbXy2eBaUwZeVjz1Ym5v6xoZQUHc4U=; b=QmElyeDcb3qfoVBgJWkUOoTjCf
	Hakf+tlLeCc40Yv8nYB20wAUNCMMIn8DAMIucPZ6y6eQdgY2f6/Oupw7xO3h82HIg1tG8qHJX16zv
	CYOG6AQSqozWs36eUgW/8KXHUUwyiUeLbnPpNLYEPhl0gcDhKOJNxdkBEKKXuj1B5h2rbdzayotdC
	9NSKx0M6nNH3tbuyo3Uq6qA3MPf5feVv8K/ALDSGeJtpl8R+L2pKARgHxf37rqFADqve0exed50uw
	E7NUEldxEUZ7PGONT//365sXr9YAYtL4hAoCSxSXIMkxSquCPMV3pAeDNm/pFIvpjrPSVgLBSTAb/
	YHDMdDpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTGPg-000T45-11;
	Tue, 17 Nov 2026 10:27:44 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] HID: intel-thc-hid: quickspi, quicki2c: skip an empty read
Date: Tue, 17 Nov 2026 18:27:26 +0800
Message-ID: <20261117102726.271503-3-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117102726.271503-1-emfox@debian.org>
References: <20261117102726.271503-1-emfox@debian.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: emfox

A drain ends when the ring holds no frame, and thc_rxdma_read() reports
that as a successful read of zero bytes. Both handlers go by the buffer
instead of the length: quickspi hands the zero on and its own length check
then rejects the frame still left in the buffer, while quicki2c reads
pkt->len from the previous frame and sends that report again.

Tell the two cases apart by the length. A frame with an empty payload is
still a frame, and quicki2c needs that one for its reset ack.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 3 +++
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 29319b622..8e3f7f3f6 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -298,6 +298,9 @@ static int handle_input_report(struct quicki2c_device *qcdev)
 		if (ret)
 			return ret;
 
+		if (!report_len)
+			continue;
+
 		if (!pkt->len) {
 			if (qcdev->state == QUICKI2C_RESETING) {
 				qcdev->reset_ack = true;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index bf49d8ce5..812f743f6 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -331,6 +331,9 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 				goto end;
 			}
 
+			if (!input_len)
+				continue;
+
 			quickspi_handle_input_data(qsdev, input_len);
 		}
 	}
