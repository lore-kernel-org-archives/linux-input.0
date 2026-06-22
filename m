Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EB377ECE
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127040; cv=none; b=iJ+aS60PR8LSlMlCrVS4/IX4ULLUqUMfSyZjI4Q6Ik8XPiq2FqL/GQWwS5rK7VvAqFgh4MFx2u8zEoxDGnPvgiKXa5xNm6zHflAkqRAEY95JfTUU9tc3uuNuzjlm4Y2HasLKTRVqvgpXMHvw3xUQ0Hh+i1oYkpSNNU2IjniHtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127040; c=relaxed/simple;
	bh=OdjQRC++birAMLctxlAt8cenjlNXbhdqcm5X2MpFMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oW7Xh/i7WubeT8u6o96iuIED0ynpltlkD8N5eSMxgqQ3wIU3iB8gJs8hXIevi1Gfhn1x7engkWF3vDAxPwC4l1pcthZCzb5ZMKzIj+FyIE+mHtMFcKoXTlcLEJCmXjTZTn7Pn+X0YZsJoU/wFKSJ5XKhz9XS0rm4zxv82a9OP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOwpfiof; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOwpfiof"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37da8b5540bso371927a91.0
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782127038; x=1782731838; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nn0SV/Myi/SmTLmex/JU6syAwjiXRlsGobtAP8HaU4M=;
        b=EOwpfiofAVukjbqeOWIH0xY2umfU2QSSM5+uz6QcE9Po7If6QLL2MOrNRTCFOlW8fo
         y+6Fk5B/Uz043s1rtxTAve8WRspsE3EkfropI511gJIhhFFa6bI29zgk81ijXUhX4DaE
         2hDPkbU3DW+WHZ3M5/dpMa0CTK1DABwZlUpy2e2VKG8qU/zNIMc/N7XOr8mu2Q5CUNcL
         J9cJJyes4MnzP1KyLAI42ZVeEvVRQiSAuCuxjfgSuxWKsGMI/iGIDimiXVp6YfaRxoMj
         SXfCXbj31W3QLETnOhSQqOXJ3K1Pe2HPp5t5r/I0ceglErHa9P6ftO4E0pM5pLk35p6B
         8AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782127038; x=1782731838;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn0SV/Myi/SmTLmex/JU6syAwjiXRlsGobtAP8HaU4M=;
        b=Y/92zhRP0JTP6MqJV0k7wnTwd/Dd9bMZxBSI44SCT/50fZzNfzHCGsEoAZDs5vJK4t
         STa6oziVsnSQDasO6/u/b1vdQxrYCrOrSYpAT7hylzgWzvpbQ24+7y/MHmyn6YzGAQ3J
         ehC/Mm2Hr7YP67lQoUuAu9/P9f2DKIfZsdr0atm3/FKglpKMIUoOJI+e0+eITjIDq+B+
         uRAKJW7HGy1m9htLs3gtapnIZfL9xOORNmDCPvsCGjyYl43OGqBs4xBAHGt5ciUeaaLW
         5oo4bk0/JkkYtOp5Qkve041EQ7xcHEchqSD7fsvpLqaYoCHZ8FfwBkohjBna561qdLjS
         k2og==
X-Gm-Message-State: AOJu0Yw6lyOqzqzDjO8VCfE0mnDJGZCrqZDfXvwh+93Xs7Jw/4OnbRQH
	mJwA7tgb+vt3ZdKJ2Chb+w3Q5VN7WGvYVG4LhOD7lfc5wHiU+kHUiaxL
X-Gm-Gg: AfdE7cn0QVLI/Iu3D6ZDo6Ih8DIyDnZ4c7X15e1uEhqu1vcXKhdikrYNFkKJOU3BcUx
	0s4TBeDhYjShYPhZVlZZ1xLwH/Yp8zlj96Jk0zYXe9EBlmX2flwO+pD9nqmIHO3Kez4TtzuZoaj
	Tr1qKBefvL3hOp07VYW2vcWbR2RPG6XrjmBY50DoGZ3AcwZRwBTKckCRwBcQPrtHIh0bQluwB83
	VokRyYX90l8FpZsoMNnYFBw357clnkJyYDU3ThDPez+wT9qrPxT7yRIrZ4N26QYY8wwQu+I4w9x
	sdnXsQcwcVodV5M5qALiWC3SKjuQ0TZ3FsKR4CRN6T3UiThElFtMy/hNayJH3+fmYSm3ma9DSI8
	ZsmQG+ISuVYP1khNarzCNnzYz2e2EJljOWbNiOVx39IoFPBV1NaIPF6cNyzASjRqJlCApwcAsWZ
	cbkPEFsu25ev/dxOvL7fWrRD6BB0wTlIQ46GbrBw==
X-Received: by 2002:a17:90b:33c9:b0:36b:bb66:fbd0 with SMTP id 98e67ed59e1d1-37d160bcee0mr14258716a91.4.1782127038107;
        Mon, 22 Jun 2026 04:17:18 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f008779sm6568517a91.6.2026.06.22.04.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 04:17:17 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: HID: hid-goodix-spi: out of bounds read in goodix_hid_irq()
Date: Mon, 22 Jun 2026 19:17:13 +0800
Message-ID: <178212703386.2270604.12694603282649418418@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I think goodix_hid_irq() in drivers/hid/hid-goodix-spi.c can leak kernel
memory to a hidraw reader when a malicious touchscreen reports a large
package size. I would appreciate it if you could take a look.

The handler reads a coordinate event over SPI. It then passes a device
controlled length straight to hid_input_report().

	if (le16_to_cpu(pkg->size) < GOODIX_HID_PKG_LEN_SIZE) {
		dev_err(ts->dev, "invalid coordinate event package size, %d",
			le16_to_cpu(pkg->size));
		return IRQ_HANDLED;
	}
	hid_input_report(ts->hid, HID_INPUT_REPORT, pkg->data,
			 le16_to_cpu(pkg->size) - GOODIX_HID_PKG_LEN_SIZE, 1);

pkg->size is a __le16 from the device. The only check is a lower bound.
There is no upper bound. So pkg->size can be up to 65535, while pkg->data
only holds GOODIX_HID_COOR_DATA_LEN (82) bytes read into event_buf.

The length reaches hid_input_report(), which passes it as both the buffer
size and the report size.

	return __hid_input_report(hid, type, data, size, size, interrupt, ...);

Those two are equal, so the bsize < csize guard in hid_report_raw_event()
never fires. The device length then flows into the hidraw path.

	if (hid->claimed & HID_CLAIMED_HIDRAW)
		ret = hidraw_report_event(hid, data, size);

hidraw_report_event() does kmemdup(data, size) for each open reader. That
copies up to about 65 KB starting at pkg->data, far past the 82 valid bytes.
The bytes land in the buffer a hidraw client reads back. So it is an out of
bounds read of kernel slab memory handed to user space.

This needs a malicious or compromised Goodix SPI touchscreen and an open
/dev/hidraw node. The open node is common, since libinput and similar tools
keep one. It is not reachable from a VM or syzkaller, only from the SPI
device.

I reproduced the read on 7.1-rc7. I registered a HID device, opened a hidraw
reader, and called hid_input_report() with a small buffer and a large size.
The kmemdup copy faults.

  BUG: unable to handle page fault for address ... (in memcpy_orig)
  Call Trace:
   kmemdup_noprof
   hidraw_report_event
   hid_report_raw_event
   __hid_input_report

An upper bound on pkg->size before the call would close it. The driver
already has the lower bound. A matching upper bound against the bytes read
into event_buf would fit that check. The second hid_input_report() call
further down has the same shape.

Does this look like a real bug to you, and is an upper bound on pkg->size
the right fix? If so I am happy to send a proper patch with a Fixes tag and
Cc stable.

Thanks,
Maoyi
https://maoyixie.com/
