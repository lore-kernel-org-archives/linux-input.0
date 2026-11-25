Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645088;
	b=fgzGTJDmIhb7w8cpZSwTSo74KFq1Hhx1C15rhOkK/OtzUkXmwF49flV9I/0b4nrMxNbl
	 POkcnFnQtEdtVPx/awt5hE8NPvAxwa/8+jawcjrVbWy5mw4ZyKLMlcV0duZQFU81BjZ/N
	 jJ4jrkeF52niZ+lalAOPbRgfj99feyr4zIaoQDxO3yzRVoG8/crBzIHuFLZMGNoWXKIPr
	 BNSbTgSsjOERvfiObqlXEztsGpxd/gRjEVfHBqgBuIc1/M5ClogLz5/yspK8bN6Ez0Q5B
	 pJQChOIP0geY7iCVIJNg/x7l1D81nhnuYhHH+sP+K6s2Kx7f+E26NdmNpweaaKMbLQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kKJiwYR+cu5mrPZf9A39ckCZmDdoMlP8HFoXJiTcA30=;
	b=kPKcXmZIGIfpk+0uFeDbEpZ2DQ6Mzf9wcNJSqX47LaUSGtiiKJlvvJf3O0VBKrW6cSin
	 IEYqq/Z11AXBHt8zx18LtHZfFUG1arU+VGHs2Xd75JPlomMiNmi9VhzsGEyHf8lcVdKcf
	 Z46JfZEQKdGmGGritlfpsZ0oLB5HEn6+tli/vVOXnMW3sMur9L28kV5pw21aF+ZQH3YvS
	 NFskaUgzo/21esNXAjV7/2XKxBIvjgV7fYBcjIWT67aC2aaz5fN2Cdxve1z0Rsz6/nrkK
	 Z1MUPKUW8rz8z93PBdubjawBce+VtCWNjmCrun0rNg1w/WJ3HLLvSPEZlcDFN1bbNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVY8mCqs;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E2606A33B
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 22:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E5E2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVY8mCqs
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38692f62b22so7636927eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795645088; x=1796249888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKJiwYR+cu5mrPZf9A39ckCZmDdoMlP8HFoXJiTcA30=;
        b=ZVY8mCqsBddZObOYIXIcss49XEgjhI0oEJgatBFM7cmxjhdOEXS0El9GvbTlT0WULY
         9i2iWLH1dX0WdE5V15u8Y4JibImKiTs2g5oByUP+osAHP7L/fWW+xEOrLbgycTHKuGYN
         FxCzpaN8287ZRGpFtnYy51KJ7IiSKqSMTab4JYPsyAQIjBNj3BJTCIYvSWKmN1OtGz0f
         GMaPnJELkgByGFo2IQNiPGsRHGwMAE22xqRkfijG4eMPE4GTi0lu/k4RzAqDjxeYPS98
         +TvkzDW9yo0zD66xDNH3QS9yE1fDmz6W/TAlYCxHkAkDWzR9Z96Cv+Y6AIwSODhHt6+/
         G00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645088; x=1796249888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kKJiwYR+cu5mrPZf9A39ckCZmDdoMlP8HFoXJiTcA30=;
        b=KRv4FnLlOpldM+AfqIhmWAbbOJ6U0qejytp9Tg8dykU9Aas8dsw38DJqdJAPUrwXqN
         I4jgOAyFuL2CXvYYOPWBgkfQSbb79awhApJ7HIM07MmQcQmyhoxY70dVMqPIMeyuC61R
         SD0dWQDAHWJBuBvIoF/aN3LIOTk3F33FKTcB2irk/KeQ/9IhuJKKBzb3Gc8ttUpR0Uis
         uv0GNYuOY20VJ4O9FhkGcZ7GXDRnjvYKRt0TMY2bmd5iESl8hemMFnR1uOyuy4lHhzfO
         3jOEs7kxriKmBjJZ8ZkY3SjeVKATvirSRZ9KbbMUdEhf2L1RsgIkY8bsCHlGW6OIaZCz
         OsKg==
X-Forwarded-Encrypted: i=1; AL+hErEWZw9ZKB5X92Pk7iTX2nrGZ8XwXAm0YyxYGGQn5IshNj3IqThRZhvdOB7dXFaRDKDlQDE2L1p6KQssaA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/juL3HLSqWTCaR25gG0F2d0IdsLLp7RiZqZP6Ze/kEA6fuX76F
	qL2HtmHLthoNoC81eVVO2ArRg5ZVXazKi44Tb1W+xJHdB8mdKQK4+lHi
X-Gm-Gg: AZFdTZdBm3BjbNzvhnxdNF2Y9kdfAPZYhSzxpj8aEAWCvqjy80DoiBHYJzZi4JA2MKf
	7hWjaQMdWXZkP1ng2ktDcJ1Bz7x5tvOpFj6xSagpUjXuRtZkTom3ELkjRwCJjOnl8YVQ/WspGZa
	dQDKU0TaC3zRT/cm9IAZKbjuz7qZ37zJKsDly6nDUxKovWStIYnNFFdc+iKWGH/DGgJP1rDT/qX
	qncVnUdlGfh4/DxXpKJyD/G4f8c7COHliU68fiqJ6I2jUKkwTwFwy0SKJjBbuPFJYxku5yHxNnQ
	di0LGOVx6noK8GIVmfHHmNtm/tfn8KBY8dNUL0XJqxG/QBTetDfjBzZa8WgfsJoA7oDvliX9fIf
	MUnCjWtuhonjgX3JsYAKdUNjsrOKWC8DqqgZxigzFi87X+Y9ASjb9DbvCK/XT8QKh6U/uu7krgn
	VEHNXN1ap8HO4tK3olL2bh02unuHwFOpygrROZK5JPgZPkJ0f3LQLzGPY3B1ngoqU+Uw8ObJEOJ
	1aLO3G0UCzBr/9K1hskJyW7JhWQ+P+dz82dxxRN8qZaRx6rHrMOPa+JFyay72yylxFz1pXE1PfV
	Ef4KAImMxIeo/z6CXtNu
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr18010876eec.39.1795645087464;
        Wed, 25 Nov 2026 14:18:07 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm69581357eec.5.2026.11.25.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:18:06 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 2/3] docs: ABI: hid-lenovo-go: Point one entry at the top-level attribute
Date: Wed, 25 Nov 2026 22:17:57 +0000
Message-ID: <20261125221758.2535044-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125221758.2535044-1-takano32@gmail.com>
References: <20261125221758.2535044-1-takano32@gmail.com>
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

The protocol_version entry at line 389 describes the internal MCU, but
its path carries a right_handle/ prefix, which is the group the
removable right controller lives in.  The entry at line 566 already
uses right_handle/protocol_version for that controller's own attribute,
so two entries claim the same file and abi_parser reports the symbol as
repeated.

The internal MCU attribute is not under a group directory.
LEGO_DEVICE_ATTR_RO() takes its fourth argument as the prefix of the
_show() callback, not as a sysfs group name, and mcu_attr_group has no
.name:

  LEGO_DEVICE_ATTR_RO(version_protocol_mcu, "protocol_version",
                      USB_MCU, version);

  static struct attribute *mcu_attrs[] = {
          ...
          &dev_attr_version_product_mcu.attr,
          &dev_attr_version_protocol_mcu.attr,
          NULL,
  };

  static const struct attribute_group mcu_attr_group = {
          .attrs = mcu_attrs,
  };

So the attribute appears directly under the HID device, beside
product_version, and the path loses the prefix.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
Changes in v2:
- The documents are fixed before the checker is added, so the tree
  does not gain warnings in the middle of the series.
- The internal MCU protocol_version entry points at the top-level
  attribute; v1 gave it the prefix of the removable controller's
  group, which made it name the same file as that entry.
- The checker keeps its warning for an entry without a file, counts
  lines rather than occurrences, and drops an unused loop key.

 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
index c8221373ef76..6ba874913c1e 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -386,7 +386,7 @@ Description:	This displays the product version of the internal MCU.
 
 		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
 
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/protocol_version
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/protocol_version
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
 Description:	This displays the protocol version of the internal MCU.
-- 
2.53.0

