Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.78.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504441;
	b=Zmgw1aaU60s3wSucUPtRFESfgbbSY/7SoAa/YN5HG3Iwx0cstSMHt+ZLPPkjf0ZsbM9j
	 +gQcv8pvCEvDhvrRRE7req/fC5VwI36OiWaKAeZq1bMf260MZDjuEbQ/4Pp50Sp6SqNJH
	 uqNf7o/DKPMUxRAFywcBR9YCwNNRqLTCvH/3gpJVbmbowOt1UiZ1CNdbO+w9RoQQ0cT35
	 shMTvDPfgkMFczWo2OmRU4qa0/gtJ6DkX9368TfjEffWC8YvN0qGT6IDS+g1W5HOnTyIC
	 S6HnCYj4zmOTg1kzGsC0ZLObpYC1AHbtCkoePu7rTVDeOjO541akYUDFFimUL+iEZPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504441;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Info-Out:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-JNJ;
	bh=8IUECNHiDajqPOe1RiRQKh2wtgaPAw0gQvNQT060lWU=;
	b=SGh/zL5xFupwCb1Fp+KxqfAZPYJX6km9Y7k4lk6U/cpJBzyP5MWZk0ibrYFx4rdeGFjz
	 p+MZRxrjc8RGz3uO5DXEWH4BXQ3DA1Sq9JbCSk/HKUk2vaDjkVVM8LFkiwn5DwPPZyWis
	 HbDIdqqZLx+l5HqWLHI3QqxzsE6oe7En/6LOWd73uPdxbEZ1VkN+wHaI+zNSVWr7w51zz
	 kZFgHArPMB91BTGws/g6vX9B19BNGLOc2CsXAzjo2UQR5Psvae9LFjJgv3n0D8GzMhy+J
	 BJ4oDR/tcWFe9VH36t1sOLadQ7H1IJ60tz6VyMlcFSCrIozBOQoY7ADTZAUvVO3m8zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tawheed.cc;
	spf=pass smtp.mailfrom=tawheed.cc;
	dkim=pass header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=otsYeCov;
	arc=none smtp.remote-ip=57.103.78.73
Received: from outbound.st.icloud.com (st-2002i-snip4-11.eps.apple.com [57.103.78.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08B606A883
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 17:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA08B606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tawheed.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tawheed.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=otsYeCov
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id 55D771802094;
	Thu, 12 Nov 2026 17:27:18 +0000 (UTC)
X-ICL-RepId: 01a1d0cc-b221-7caf-9aa9-6181f83a192c
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tawheed.cc; s=sig1; t=1794504440; x=1826040440; bh=8IUECNHiDajqPOe1RiRQKh2wtgaPAw0gQvNQT060lWU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=otsYeCovDa5jxn8NcGKbkPFgujg/FFyP8czTyszTQYWAY31lPFWyQ6092Zx/Msqh7fq2lpjUf3qieX/wzXN1A36KjMahu8bNzgshzLhscajISIoWOU4SqIsjPOOTrjRWtmLTihxSLl8aKHB7xmb+aXUqsQ1SV6Gz0D2dFCrzoxWw9DN539kHqgLdnzgyijBE8ArG+yHwdqjmowrFWjYwmwlQJL8fbC3FukGHTBBArbcts7ytc8ju5bARz6olIA2S5JG73dp6B7q7pg+bZMlL2ujx1yAtA2TicEDgWyEhtmbcQvT2KrbtC3kJru9+wGWAztiCEeNG0HhBD6Y9zL9oKg==
mail-alias-created-date: 1711150425226
Received: from DESKTOP-HUABEFD.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id 79142180481F;
	Thu, 12 Nov 2026 17:27:17 +0000 (UTC)
From: Tawheed Makhdoomi <_@tawheed.cc>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jingyuan Liang <jingyliang@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] HID: spi-hid-of: add the Surface Pro X touch digitizer
Date: Thu, 12 Nov 2026 12:26:41 -0500
Message-ID: <20261112172641.407-4-_@tawheed.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112172641.407-1-_@tawheed.cc>
References: <20261112172641.407-1-_@tawheed.cc>
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
X-Proofpoint-ORIG-GUID: WHA6shUJS5uPyMvVx3fsC9BzVDRn3B4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2OSBTYWx0ZWRfX7MqP4KUTSYdh
 neXD9ADPYiTKZsbt/c4ElWyfWBX91h4k23D6Fpj+OR17ZbI7S1AhIZL721iH8kTE3lunimenhJR
 0Ck7GvxMDSW4lSp9fIiKAaweENuuOYgUvgg8pm4spqh+o+Vwl7glbISOiL/qfdhfwWf49rBuz2D
 NWMSuWlRRnQNrlH+U9t2K5iJz2FSxHbrumkQOt0yuwqgRRq2ogeKy3+gGFPhpRYafVSJcAgozQ8
 a9gBn0jwWksU7Etkls0ohVo38SzkcwWIIrrg7NP34FxtImCUbd5lPMMfkdTT+Y90nEdtyFS/7JZ
 /zmYgVpC+UqZgB3+M3muMijBNDUU/br0CX9VHE9gFUBntoSBsb/eDOCuWyJHow=
X-Authority-Info-Out: v=2.4 cv=RfMFmFtv c=1 sm=1 tr=0 ts=6af5f6f6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kibvr5HLtuNvmma_iept:22
 a=FWZx5dj72HHvF9NkQXT7:22 a=HiKr9HWsZoCIc8ansSkA:9
X-Proofpoint-GUID: WHA6shUJS5uPyMvVx3fsC9BzVDRn3B4v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2OSBTYWx0ZWRfX2BPiqBx5VyUg
 dPtealoOF7nexe5+QVTMIQ1fiFFkzb2Nq+1yFXQgloM3CAim5SbKyrali2TaVEO9i75KZMrFrV5
 pmX4D36Cw7PnPl+yKkDpKAiLyvWPmPc=
X-JNJ: AAAAAAABHJXMpRV6V7hjkIaMrJ2X+2+76V4lb8b9FdqZBjKqwFt1UhV3MQue1eM5ZXrz9E
 gqgreBGscX82434RTIITVG44jZRrF6Sgrj49KqrcwQWc/bGnBYdhVOckHhU0gwhQnNZTSw
 d9sFkhQowgwjLyqmXSRUGdwvh+7Fb3rYwU1OFEj1x6rsFpF6xbLdXmpPkKRkb5rgExsZBw
 M511Gji1I5n5YQsZA5ITrGpMn960SHU6Q5Ui1DX0aa21Iy1FEcsv5EPtU3ivaYdBiZCbRD
 Ncgntt9+kUALiTfosMM1dlviGh7yG7AU34J+TqciI2P9+pE7Go4XDGt/5hSdH/ivifgB5a
 By6YIC1725fkYCh+uX+FyqJ6EouLH251u9NQu8n/0LEJsKsxSSiInCB7KClplz0Ux5XldD
 k8mRFqKJrIKSEIDEHzlLzzwnqk1/s680IOg8Au7XFGKGaOEMCXaBVw2JrDqLw9qo236880
 QghZVRohe078RStsQqrPhi6G0avkxZMn/AiqK/HoZUi8T+/D7b5aKxXV2XAJLjAAPef3zO
 mm/OK8CnsnX1hf993QbCMO5s2R1JlSuPS++X3FRHxrJAEtcKF67kzor6S5Plpb6MYjHQYs
 rVG2wMFwnFmVUWi08UBzErqsBzBTI6yZoqKcsPFLkqqkgkNLKteptYcTS+s2ltmaKKP4zS
 l+uwu81ctMK7S6278nht3eUHoNQTV0NjgB0oT6gjDtwunzpvn9+7efV4rtGN6cZgq/QQdM
 3wQZ0zoI02rzTS4DHWeIs1jbqz7Fw26lDIbqVYJwpWAIO8B/gpNrB/wZ0+WkVs8x+pvQ9x
 f2uGC9AOXwY=

The Surface Pro X digitizer speaks the pre-release HID over SPI protocol
revision. Both the input report header and body are read from 0x1000
with opcode 0x0b, and the device descriptor is requested from register 1
with opcode 0x02; the other registers come from the device descriptor.

Add match data for it, with the same timings as the G6 digitizer, under
the "microsoft,surface-pro-x-touch-digitizer" compatible and SPI device
ID.

Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
---
 drivers/hid/spi-hid/spi-hid-of.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
index 6de9affbe..429bf51ad 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -62,6 +62,24 @@ static const struct spi_hid_of_data microsoft_g6_data = {
 	.minimal_reset_delay_ms = 100,
 };
 
+/*
+ * The Surface Pro X digitizer implements the pre-release protocol revision.
+ * Input report header and body are both read from 0x1000, and the device
+ * descriptor is requested from register 1.
+ */
+static const struct spi_hid_of_data microsoft_surface_pro_x_data = {
+	.conf = {
+		.input_report_header_address = 0x1000,
+		.input_report_body_address = 0x1000,
+		.output_report_address = 0x1,
+		.read_opcode = 0x0b,
+		.write_opcode = 0x02,
+		.protocol = SPI_HID_PROTOCOL_V2,
+	},
+	.post_power_on_delay_ms = 10,
+	.minimal_reset_delay_ms = 100,
+};
+
 static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
 				      struct device *dev)
 {
@@ -181,12 +199,20 @@ static int spi_hid_of_probe(struct spi_device *spi)
 
 static const struct of_device_id spi_hid_of_match[] = {
 	{ .compatible = "microsoft,g6-touch-digitizer", .data = &microsoft_g6_data },
+	{
+		.compatible = "microsoft,surface-pro-x-touch-digitizer",
+		.data = &microsoft_surface_pro_x_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, spi_hid_of_match);
 
 static const struct spi_device_id spi_hid_of_id_table[] = {
 	{ .name = "g6-touch-digitizer", .driver_data = (kernel_ulong_t)&microsoft_g6_data },
+	{
+		.name = "surface-pro-x-touch-digitizer",
+		.driver_data = (kernel_ulong_t)&microsoft_surface_pro_x_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
-- 
2.43.0

