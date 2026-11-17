Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912891;
	b=XFy5bqAwuDiyyTcms1XnSUUFSQilKlxoZM9SSkjdq+tXJ9m5sJDyBD8HXx4Rm+qaVhEY
	 WS53Zss0w2zGCt4EH4MjJYxTatpV7GOEB05rWqyGCCwov7H7ko0QwbDuVaaJVyJmmXbWG
	 +OTZK2goaAE83FZ3C/UIOZjQGudI4uMzEHOcSt9+KaNVzJl4BMFScyP5gJMV3CJf87Is1
	 orscwZqjMo/S1yhVr6UIG0Nj9VoWyr7jwRXO5qyp/tJcOORHEZygxwSfRq9lJAr2KgZOq
	 Bc8B+V6MBU4UKMw99VdE3LG+Ipic1lbnFKyPjjHTfibgbh5mdXPTeGX9rbnjbutks4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912891;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=1M0KPdlBzEysJTabEfAfKl0Wa/BD5eeg+++EV9jzJpI=;
	b=Zg9/hF8DsJswhaDOckWB86mlOYgSBfS017sts7KEWtnAT+hdJTrnZ5jcy8LUM4/06lI2
	 ucB3mgXG9yCpkW6xUwjRXvoeHJtYAXySUhaFm1f+8usIHnjWshcMt3JbDAB1M8+DjjvQh
	 /5OnGRp7nblXIF5AS5B5p1o4K1a656+PImAsxHJfnPGsWDTW5pe6H9im8hV5was3L5Fbp
	 Ujbt98j5E5nKV9PwpRzkNrgnnp0FjWbt1qR7brCW3kqU9M/ybcZ0C2SVZLMAQeFqs1r3A
	 NwRgadbsF31Sg9jbzwfs1F3vnWXc5CJ6iyVYUwUU65gDucMFEsZ76CgfOzBEDIJLp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=RRyxc0AF;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D20606A323;
	Tue, 17 Nov 2026 10:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D20606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=RRyxc0AF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1M0KPdlBzEysJTabEfAfKl0Wa/BD5eeg+++EV9jzJpI=; b=RRyxc0AFpiXm5gBaazQ853j9hl
	St3Ji7KrshgEsMh1KgvzVZLo57wPvks5FxUcAyWyLTX5m4sx1ojIv8ueOSgTDnQtn/7bkuhRruDYA
	Ht4GRjGCv1QHQVhYc8HOWT2wYazlaIJmMSl8A/igNqY2dJuLtL88T8jRJJwbhKAU8Cg3/5QPe/nbu
	+q7lIFeDFf4csUtWFkcbbM1bQWcm6WY0fuWN5ZL0RNvIBG93c9VmdmG+Lz/QISzG2K2cXxJ87p98w
	0nIs1PAsOFrFwRyT7JzckSDpZIdQIyJ3KD3piVSAW8YedHjWkmT+u4pnd6+v+emqdohQOOZAAQ5Nw
	eNbA0TRg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTGpq-000Tz9-0i;
	Tue, 17 Nov 2026 10:54:46 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] HID: intel-thc-hid: quickspi, quicki2c: skip an empty read
Date: Tue, 17 Nov 2026 18:54:27 +0800
Message-ID: <20261117105427.319242-3-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117105427.319242-1-emfox@debian.org>
References: <20261117105427.319242-1-emfox@debian.org>
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

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver")
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
