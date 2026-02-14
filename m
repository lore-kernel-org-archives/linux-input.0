Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB77285C9D
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102853; cv=none; b=uc5moerq1ecin9U5WmQcKjQnYcF2Y05wdf8qelJ4XlzRUgVGndUU6dEV9EWeUDH/xO9bkztwJ8+S30Jkfn7XGwR7nA7LiLl8F1AKwFsFXBSaHTWWdLhQQUla1HWGtD1GM71SPtoX+u3/iLLFweNnEoHLLv1XW+DAzs+tlR2Gwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102853; c=relaxed/simple;
	bh=R+GDKBxHJ8ivRZ9xRlhbfMw9VAbVyebEmKoXSpw8y60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0U5u482Qz2F9ANBSuPWC+4OvhWog4rS8tygfhJkLXT7R42Y4I4OqL6sGT6uO1Ce+7NPQXrXLquG/+bqj+lJzprfy4zfjdsd2CIUyXOOt5jQKKMtPx8l6MQ7G9/dRKup0nOOj065k5Y7SFZJRqvgfSCHVgO6YQ0dyNrlfMs6WH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTi+Djk2; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTi+Djk2"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c307db9aso1101286a34.3
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771102851; x=1771707651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1h5TdfsaHf3o14xhxp5+kuRImMLBj24k72741uMsvLA=;
        b=dTi+Djk2sED1d/Fh2e0Sa0ARPMWC/HMw6wuCyZuYbQDmvjSEiP8hfWScuUAhhp1UYZ
         LtCb+SpIBiJvXmAMO/K1xTVrneHHEOcE3UfSiMyS1km5N2kve7qqIsDKWQg6wCoCuAbB
         Vrf4nd33SqMVM3YxWQ64mW5oO3SFfFGVgArDItnbRh9/0Q8A4+sOqZNQoaTREaJoA6eL
         MO/kT6aLuLy9T36o2a/byRITvDuEavdaT0KO8mIWOb2D7HoAj1xnVsXKdRC2sGnHrfcY
         V9unfGMKQAXKYmjAiE/FVPfd7AKZkqXHqfNASy5hPQIoeulipWHL9OIE4sibhvcQT/ue
         yu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771102851; x=1771707651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1h5TdfsaHf3o14xhxp5+kuRImMLBj24k72741uMsvLA=;
        b=P9zC7SsPMsgX+wTMwaXVcfHOXLA4uwBNJhrC++bg6rb7LI16EhDq/UpHcomnNX9NPz
         hGuBdlmTzBP7ESNVZqQisA6U/PiT9WRhIEPtLdbAXUgL8PtvBYWp03elqhj+20ujQxsd
         JwPvYn3kjoRtLL6jlh/CbEAGX8O8wJGHlb03WH8lr1uv/KRrSGC4mtlFMZuJ52X/+IZA
         p3SeROYuw+wHY4WO8/zWPUEo1N+rI+Gfkavp/lBHyl7BRn8GlVN+QPGiB9Kd2vmcFR6A
         q1au9iscnzjjhDl8y1sHJEwkaZuYw7jXZ3sTFSr5siD/Es7D5qKXtani/BgpJ3QknJx8
         L+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW354W77W+gcYib6IrivJhC+xQs1zk9xUiJ7ngiaYtWVx2dt9xLb2VIGONdd1kibYoS8qS4pCdfwvxQHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqiVXdrHbFEHuFVWgsNJh78jxxU3whYRXGnnmJpenblOYftAkt
	5WWjoaRysX0riws8OSpvGRGZtW4UBgwrXtm+cBMIWFiSR6oygh6zF2fpJPuJwq+fXM4=
X-Gm-Gg: AZuq6aKbwNMApVAQoVvPP+CUxuaPWQrQVZ+Th7/g6pavkbAnao325giSaJ89NKGMoWS
	HEGpaPTz/h2KP9R9/N8tSSXkyr/1esrCrei1N8yAQhQFYl+aTjCBXx8g0JMxboCarrl2b5+S5az
	A8pgIa8aJC9jgh3qHqqyKpVQObUaddpvl3YE3YrVMBEb5XLgUeq9Jd8Pl2rsP8df0T9lLvBLPzW
	L2hl/uew4Y1xyBrpYCuqGtA2Oh2Mdyh5XFYGAnWao7k8ofzovIqvnYEl4liqUIg9tVk+6JKpbqc
	agPDSr1K4Nonk2jwvDlH4G/Q5lTbk8inZiu7wWiPsH/HA+Mad1G4gu9V7kKHWmRX0d4MdUeUZkm
	5pDh92FRLkSw9M+9NPMfzkJXNoFoIq3ypJ+nM99L0tEsulxS0uzYKB2d4L5iaUyuiakVzUSelD6
	K+99tGQnErDziaezwNQFIee4vEWzwyyaViFhQj
X-Received: by 2002:a05:6830:640a:b0:7c7:5458:75f8 with SMTP id 46e09a7af769-7d4d0c32828mr2243774a34.29.1771102850690;
        Sat, 14 Feb 2026 13:00:50 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4da074c15sm1181680a34.15.2026.02.14.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:00:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Feb 2026 15:00:20 -0600
Subject: [PATCH 1/2] iio: add IIO_DECLARE_REPEATED_ELEMENT() macro
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-iio-fix-repeat-alignment-v1-1-47f01288c803@baylibre.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
In-Reply-To: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=R+GDKBxHJ8ivRZ9xRlhbfMw9VAbVyebEmKoXSpw8y60=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkOJzQSDBD9vP72HTDUJ6jFzPLuedxVXxcFXCa
 qONJJ+MvrmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZDicwAKCRDCzCAB/wGP
 wK/SCACJq/go6ywDx+yyaWqW73vW2C1C6TPsEUvWklyajKwGIeWJ8ZBhE3OZUZO/WNCgNldxRxi
 BpopXldOuIHgW5VXSe7uX48UYS4VnroDYOi4xmzo9V+oS4Ob47/cKROhuiusZuG80lSmTEhdyBh
 fMnpTmX2T3nvlHctnhpIf6PMQRhTIJb1gwh+xtJSwY3pYw3n/bTDX2We88gmOYrC6u+8pWctCcM
 e5baTTlOnfRkqLhCxBlShrBgaxyIkS4WIVNcAxmIJE/s4eNjbjCWUMTI72892c0DBOzYau+i07L
 TfOwxbL+Z8+eAwpXGZw3Kht2G9VeHcLQU+uZlw5oau+cOuEE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new IIO_DECLARE_REPEATED_ELEMENT() macro that is used to declare
the field in an IIO buffer struct that contains a repeated element.

There are only a few iio drivers that actually make use of the .repeat
feature of struct iio_scan_type. This has an implicit rule that the
element in the buffer must be aligned to the entire size of the repeated
element. This macro will make that requirement explicit.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/iio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 872ebdf0dd77..28b708166b9b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -816,6 +816,19 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
 #define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
 	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
 
+/**
+ * IIO_DECLARE_REPEATED_ELEMENT() - Declare a repeated element
+ * @type: element type of the repeated element
+ * @name: identifier name of the repeated element
+ * @repeat: number of times the element is repeated
+ *
+ * For special cases with repeated elements, like IIO_MOT_QUATERNION, a multi-
+ * word element is treated as a single element of a larger size in the buffer.
+ * As such, it requires alignment to the size of the entire repeated element.
+ */
+#define IIO_DECLARE_REPEATED_ELEMENT(type, name, repeat) \
+	type name[repeat] __aligned(sizeof(type) * repeat)
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0

