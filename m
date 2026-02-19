Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407A33F8BC
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515827; cv=none; b=hpGXlMVnw6ICZAYYY7myglCQYM5WPLtIcZz/7FO/SX8SfCSfajiYm3N/4Ac2zbiZs056aiCl/2QIYnl8PG+B2FmHfLyJnBnmjcKt/WT6/786GoJ1x1kQpp2yLRZILIidte31UkakhQURmOq9wiCg0i2Ri1wbl0npJwJoJvQe9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515827; c=relaxed/simple;
	bh=nzPlGBZWCF9yeYjLabCnMDGzP0Cy9kD50BaatJTqHwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4GzEbcLSntwaL/2fiS9olFCf6SFDxjK4PC7lNV+QcHVtpjxCGYksFFg/gcimA/VsY1H7dkwoeqOJMTj/CCfou3Mixr4fmdjRNfoKukKoNoQpuFx6JZTFDSUAJxOpPui4ZxZd8ZXdSGUpyZ1ZfqgoCrc6P0HNSfCIkMz7g7+tEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5Z7ktjq; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5Z7ktjq"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837907ec88so17171735e9.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771515824; x=1772120624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQkcQ412VYYjl5d+2hc4YyIXE6A0slRRsKwOiMGJ4lA=;
        b=f5Z7ktjqnbXA5BdkuRlF3mTxc5Cqp/HRktFqeCP17tyvgev7LlTTTyfNGJl0xqV9vE
         uZonCM97VmC+ut5wLbLKTp1kGeUOExY8Q1Ro8YWFKhXxsL9lrEiSBAs+cEU3d7zj9pRB
         ws7YME/KVK+UeoKro1aeuULP5BZb5ey6vqq0mmJqYsthS1oocdSv3OvngeICTpbDqmIv
         NsUgK1iTCpLW5vqY33OVcDaidBy+4LwHIb2B/uQlJpRUA9AI92DXYJNvkF8gy06+pS1t
         eRxyMDJgRvNe5JbcV8FSaFQu/nGUxpfT6dOO8TtEein1HidACU0ONqk11th2kOrI5jux
         mlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771515824; x=1772120624;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQkcQ412VYYjl5d+2hc4YyIXE6A0slRRsKwOiMGJ4lA=;
        b=vX8QcnnOjZhIzwyicirnevEfnVENNu2GQN+0bEoqLoh5vY059aqglfaWGwky/XhaRR
         qgfQCI4NFA3gMQ++jT4sQS3ZngUCKtOJUDN7HiK04ZRL7s/6diDzJL6QzPvVgl1Mk2sj
         iG0Yj5/Vvu5YNCmNBLh6VnWrV7e3EJ0gCWaQgOiSRUAxlpMH5Z/cZdKZHtWr3f91DizZ
         Qz7PhYrf4Ke/uW8EScweaXIVzYcsvDNTyJAm2AuP2CfphAybO9/g37bi3gkGrkDqm88Z
         L1qkBp2lMuC232w44YqrawvBXZODnfYpcQ6pjZi0jn/0Jx3+R7TAtDWimdI1KGGs7hVg
         rXSw==
X-Gm-Message-State: AOJu0Yxou4GdwLTsgEe9cybcK7CwruZGyEp4U7yvOG8d5wnkRx+EH8gN
	kfZjbobY/gZcJNJzKiRlSds8X/tl/1zb3fh+HDWDcrj9wlblpXI/VpChE86rI/l5MdyidorQH4b
	y6lOG4A==
X-Received: from wmjq15.prod.google.com ([2002:a7b:ce8f:0:b0:480:4a03:7b63])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f44:b0:480:4b59:932e
 with SMTP id 5b1f17b1804b1-48373a0a0c2mr344104445e9.11.1771515824251; Thu, 19
 Feb 2026 07:43:44 -0800 (PST)
Date: Thu, 19 Feb 2026 16:43:35 +0100
In-Reply-To: <20260219154338.786625-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219154338.786625-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260219154338.786625-2-gnoack@google.com>
Subject: [PATCH v2 1/4] HID: Document memory allocation properties of report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The memory pointer returned by the report_fixup() hook does not get
freed by the caller.  Instead, report_fixup() must return (in return
value and *rsize) a memory buffer with at least the same lifetime as
the input buffer (defined by rdesc and original *rsize).

This is usually achieved using one of the following techniques:

* Returning a pointer and size to a sub-portion of the input buffer
* Returning a pointer to a static buffer
* Allocating a buffer with a devm_*() function,
  which will automatically get freed when the device is removed.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/linux/hid.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index dce862cafbbd..2990b9f94cb5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -836,6 +836,12 @@ struct hid_usage_id {
  * raw_event and event should return negative on error, any other value wi=
ll
  * pass the event on to .event() typically return 0 for success.
  *
+ * report_fixup must return a report descriptor pointer whose lifetime is =
at
+ * least that of the input rdesc.  This is usually done by mutating the in=
put
+ * rdesc and returning it or a sub-portion of it.  In case a new buffer is
+ * allocated and returned, the implementation of report_fixup is responsib=
le for
+ * freeing it later.
+ *
  * input_mapping shall return a negative value to completely ignore this u=
sage
  * (e.g. doubled or invalid usage), zero to continue with parsing of this
  * usage by generic code (no special handling needed) or positive to skip
--=20
2.53.0.371.g1d285c8824-goog

