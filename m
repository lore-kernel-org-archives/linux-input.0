Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC801F03DE
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467110; cv=none; b=TqympNggVEpIsb/HTuu8NiB4KpX0Jkgdxw7VNMNIVXHFKwQt4HkXULkUrVD9DZjLugr5MjVCEn3nfryNZC4P9k8/QzZSUuIN8vwrwoRneI4MBxm12bRHx3YjaKxtvhu00z5s5Bxt9cfaGgm68FNaytXyiOuQLSHkDMULlddnUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467110; c=relaxed/simple;
	bh=F9QxGb+ZfVgcJHFX8mISxsHXIkut9EDgrCdnNa4A1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUFG2B8sb73KYtgofoVDtZBMSq1+RLrbK5WtkrfI3WIoaZGCUCfXbXWP/TLjNApPOKDtWKZ40gETG20m15n3ci8sNEmR8qzWl1tDCIRpoSxVklc1KoyBZQYBVgqujiw90ED9POqSegbWIBGbi/LNnavaxr5VKqz08xH0G5791Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=sIs6VVOs; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="sIs6VVOs"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so2934574eec.0
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467107; x=1777071907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAqYIaH1weO9bB+PWrPJQqvGo4j6m5jVUTthaJm+Q+M=;
        b=sIs6VVOsvfCXkTpxzPTb+ZkzlFPtOEaRVHpOeoflwDmcKcpru3PRBOsxv1xUd0uHkY
         zsIndjhKv6JBYgLNrYKfcTzf8395K4CRN5b1aMLkf7lia3UEiULR3NC9RCsh7mOFwhuJ
         1tAG5pzrkCSrni+Ck9nsH+1YZw8kodS7793+J4G9iXknfn+lXs0+IDSqZacMehisFOSX
         5M/crdCZbSYv6H6hGp78aVQ93PWMDJStYpPv1elvbiNprPK3e8CARC9wTP2ZWs3BNW/x
         QG2xZHPtozLSl7HHFoSe72s1TEEWBL1/LVqhLBENVKRnrdaqD0teN3sunCurdQO3/YYN
         xxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467107; x=1777071907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAqYIaH1weO9bB+PWrPJQqvGo4j6m5jVUTthaJm+Q+M=;
        b=N6V0i/ChZQzRYzIe4YDei0BZ1Z8hEetxHcCCjmLDJJSKz3HF6G9ZATOvQ2JU7ufXsz
         CJ+fSgzyBTVp+PwtZJuQib/30qh9jnl6WfGsH5nlLeCf5QMbRAvpYTGjI69VyqcHopPS
         ozT/oPbDboxFKRu8j+BcizMHSy9+AGUMBsWrw5UiB3tSMqJW8hU14TxBNCr4k8Vvgzxs
         kf+z0JpUl8Z+iec2pPWOZKu8keBtD3qtRTiOeVyLDvzV87dTG2xEWBTcSVvEfqNh1MXl
         9HKery2lsjZtGSz2L3jUFtV2p15wV/b8xVbS399r00fEdgrNg6vjsEOuc3C6YmBxeLYZ
         VIKw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yq4Nm++DpxSlgw7u5dG/5R8nQpK38Dz3gzS/3IlNfBdJRKgz2QDlcXIChZLyW1j9ICPeSG5bDhRoErQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+cykc3h86EWgwDba8ygsrveuznHgPB6C92d4t5fbZqMSKZ/u
	OlEMWMLyjeTbhEBSMGrUCBwgpPnYw3GbltwZ25xiGot4wzRurT54ZweGX/2N1wvL17Y=
X-Gm-Gg: AeBDieultjascLWA+R5oeioltJtNjsTVbA0kgWP8JYYqTBMLubgs8JHWoQ8Akav8Mwv
	WMJJ4GzZ1OXAYzPxC9bN17ynuu9wVrut2vTIXjF5TBZzj9JnonxckZrUrv3kCnfdGVoZ2v7yyiE
	FnT43cdygPrz51ay0GDdi8/0O0xgo53Oeyj+q3bfXsxZyiKCQakT1UF8wcYlV9hvcL/kl36iS/5
	E52lT+ncx2hMr0sqsoXSx5cpomDilwNfypMCt3kSr5qB8l0EwYfw/04XEzG0wau2fFElxciJmJl
	jstxU3bpxL++3dBNqze03mFI5V3N45GayifVchI7+4fc0vesMSYX9w780JQhClDggnSZQUo9FfB
	/Og3NonC+R8GErwKm/VcBzT2X/8wFAmio+6XZIXz8XNBBoGMVcOuiXQWGpVjk7An4NJA/jrh5YA
	+3YR5MQ4wzEX5DLkBXyz/E3XjCmHkBA8xHpRPt9g==
X-Received: by 2002:a05:693c:3007:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-2e465293e13mr2531989eec.11.1776467107288;
        Fri, 17 Apr 2026 16:05:07 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:06 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 2/7] iio: accel: HID: Replace method accel_3d_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:45 -0300
Message-ID: <20260417225959.16688-3-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417225959.16688-1-natalia.andre@ime.usp.br>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method accel_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..75f93b52a926 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -119,17 +119,6 @@ static const struct iio_chan_spec gravity_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP),
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void accel_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int accel_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -307,7 +296,7 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 				&st->accel[CHANNEL_SCAN_INDEX_X + i]);
 		if (ret < 0)
 			break;
-		accel_3d_adjust_channel_bit_mask(channels,
+		hid_sensor_adjust_channel_bit_mask(channels,
 				CHANNEL_SCAN_INDEX_X + i,
 				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
 	}
-- 
2.51.0

