Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863973;
	b=kLk/9BeEI3fqc9JCULnQdpRiKlCS3ITWoSjJXNuuJham5ZMgT4agkwpmnww+RFWJJeEZ
	 lJFqB3UnYLUPPSX41yZNUtqcCiQuHVTuubr1BD2y8+UIEYj7+hwjGsj2S0doUMJU0zk5S
	 7OWVuYtxoUc94UbuP5yqesaVmM+MLlHFqG2srarpcvI8K7OcjMqps5xNnZ62m5fCfgbf+
	 lj7okCvfIlTCD41b2HPEOtsnWZmT7x+tP6Ucdcas3P5lxy8wrF9cNZHw20xQz9SqmZo2z
	 IanMo5qOGxdITsEtRAPf4gnSnruJmrM0Mkpaxzee+cBKxVRGP+ExdqMzBFXiwLKZCRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/lYnzqsbRzqdQw+FLS0AWp8+ipjJZfsZ/0h18RICSEA=;
	b=fEWNRm5T+7MGceM/U1nQTcLn6urn7P9uoqjVbGOVlesgDJRp7m1yHturlN90hwKSkh/5
	 pONzmIeQYH2jnTFiPD9YJLllrl5N1DoXcjWe7vpxKQaoyqh8nFv83haNEwxOdS6jGdLu3
	 MKqlZgOW7X377w/UnVbQodp1MUyi+j00HKdcaIQy4dX6plAf3+MQYZjPrjuF41ewmL3Ve
	 eGbiyoGNMC0z0RIos5E1mI8Egp6KlTYzEQpfAANJNtzFvI4GN5I5Y/dhm+ufOEdiydGrW
	 jQI4xwT1QmKCaXqWwwe46ApA40LSEYBWveSkRcMq3Ix0LPF6I/aVR/jAOs6amkLCHmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJPP0FUh;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FD606A324
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 11:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67FD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJPP0FUh
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38699cf08dfso11542088eec.1
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795863972; x=1796468772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lYnzqsbRzqdQw+FLS0AWp8+ipjJZfsZ/0h18RICSEA=;
        b=lJPP0FUh+aCSQ+r+h2HdavGGky3SMi9aeLMbcvFe44PrNiRp9ntz9abk+Do5Q1wu8P
         26SKlrUG10XjT2TMsLeHkKYzBrYCC92K2/qYHf1NyQfKALBEviD95Xcao0Ps1slgXnIU
         3hLzJvuhDF+FjFJgZzQUhVYjOggXDMjekm6DHx87lokpEn7NNK6D7o7m/5bwySJX8r0e
         Jdu4CLnaZaWxtI5BRTm2j8fsO5JX3jwr9CN9C24/pTr5+lVTWd84lk5IRPVZgbH/zrGh
         NZsDclD+myzZ7GwzhKA1HZlffDJXNRsEGzANQbmuiCU+RqiwAI+ExztOA2bim5ic8VHS
         SZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795863972; x=1796468772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lYnzqsbRzqdQw+FLS0AWp8+ipjJZfsZ/0h18RICSEA=;
        b=LcKsg13gvn12Lckw2sUvylW6PBItDHCP/8HFg6U3MsiUHlSV5l/p8CKf6RK8SN1276
         QiHxuG7ZhPbQ2tBeUTfgIxatB7YEFl56Yn4hbhXJyu6ecp2gG6CFtLWcE7h6B77nh2CA
         qAlxsNHwsJQcLQlfr/t+ktyjFQsiJEQ5hnBnAZeuc2axCo8I7KMdokeYSznprH1Uvn56
         zy0eonszYfDDIX92m/1+mvcK5FTRp38MsBKxhmgpy2hUlqPR+cLN+V1WYCs+xTYz10/0
         UtjKGUjgnvx7UM3it2Io+v4bo1JhfCKTGIPLKAcqJOrayGIYYSLlBwgF602IXWDMQDBy
         N6LQ==
X-Forwarded-Encrypted: i=1; AL+hErHkkVS1OwlWLRhtx2Zpk1kCHJk87K1PuhAyuqJxbx/VX/9iT8xML8g6eJPAA9i8m6h7CXZVIfWcihvY9A==@vger.kernel.org
X-Gm-Message-State: APuU4Z95WPderEvdT1/z6dldQkSdb6fVxXAaIf4Rh78oL2Z51yBmqYSG
	ZgGmEbX7kVqlxlWfTAyscDaTgn61VuCsy3n2Ul1hn/ccixb/ChmfQCZqzAkBCGfF
X-Gm-Gg: AZFdTZfu0wGQWENzbVFIpJ1+I6Lw8yz0+VqBLY1iyX8yOJEZX36wjzc/+Bogw6zaQ+F
	pt+CP3WJMXf003uUwJuE117DBZK9dNKjZFSDvvL5Troy54yreFuuI/F/eXimiwQn1Gk1KZ60rIW
	QFU2VdBN/RzJrFQ4+S1d1QD1+nFDOLbpY6aLuPCkLtJ9ks6/VUYk+NfyUI16qR0osVWpLj4LdtU
	+0muNXwL11FETuRVk5+9/LA/0WnJBd1TV4NTIgXGKjgDHjdEXPCjqkf+iij3OYyQ+sdAbTKRvlZ
	PFwDL5mz0xDs4qStXLmRcCAe4THoOvSou8MN/NC1U+UikeGSs2fV8sKaou2REx+fWDl0UcxiyqU
	UCUh9GuIdx/efhOUaFGpc7LlhqQ7tz157A+ZDmO1pDP5bRExZQdzuUuvRVsxhQtusdxATQb5pEf
	U7Bo6ET4NNd6zWpwHOdU6GmgUMQptSo2tWzzjRbfEzidPu2B0TMsXD94JsrduaaSoyGKIYoIuZ2
	L4cL7uHqCaXCp9m8Pmjw7hCfgkGXhulo0k4bHX5jTUaUCcOFOCFeIiTm/fMn5YaCSobeKPXqbYA
	E4pp82C25cnkYlhHdtVikGQBxPa7aHOMLaLzHFivyM0mtqQR5BKwps6VTNRF3a644e8ZU3+Plt3
	/yG30sZ0LIfBJzkr8QX4Yr/WXXZgspJbVGjdGZNXYmuvP1S21INBLxiTnqsOmMhLJUzt+YV6pso
	P50bkZUpCoKMLPeRuJ9BVfnxYSJgeDNdhL8jQeOTbBLwXrvw==
X-Received: by 2002:a05:7300:7c08:b0:384:3123:a0cb with SMTP id 5a478bee46e88-3856ff5b880mr42031310eec.27.1795863971908;
        Sat, 28 Nov 2026 03:06:11 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm40958970eec.17.2026.11.28.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:06:11 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: David Rheinsberg <david@readahead.eu>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: HID: uhid: NULL outq entry reached with head != tail
Date: Sat, 28 Nov 2026 11:04:04 +0000
Message-ID: <20261128110415.772810-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid.
No patch is attached; the exact failing interleaving is not yet captured, and
I am reporting the observed queue invariant and locking mismatch for owner
review.

Kernel: mainline 7.2.0-g66498c75b4f8 (arm64, KASAN)
File:   drivers/hid/uhid.c
Impact: NULL pointer read; kernel panic
Repro:  syzkaller race; independently observed on a Pixel 9 Pro

## Report

KASAN reported a NULL source read in uhid_char_read():

  BUG: KASAN: null-ptr-deref in uhid_char_read
  Read of size 4380 at address 0x0

On a Pixel 9 Pro, hardened usercopy caught the same condition:

  usercopy: Kernel memory exposure attempt detected from null address
            (offset 0, size 4380)!
  kernel BUG at mm/usercopy.c
   usercopy_abort
   __check_object_size
   uhid_char_read
   vfs_read

4380 is sizeof(struct uhid_event) on that kernel.

## Analysis

uhid_char_read() first decides the queue is nonempty and later copies the
tail entry:

  len = min(count, sizeof(**uhid->outq));
  if (copy_to_user(buffer, uhid->outq[uhid->tail], len))
          ...

The reports prove that uhid->outq[uhid->tail] was NULL while the head/tail
state allowed the read to proceed.  The trigger churns output-event
generation and reads while repeatedly creating and destroying uhid devices.

uhid_queue() publishes the slot and head under qlock.  The consumer updates
tail under qlock, but uhid_char_read() tests head against tail and
dereferences outq[tail] without holding qlock; it holds devlock instead.
Queue producers do not take devlock, so that mutex does not make the
slot/head publication atomic to the reader.  On arm64, the observed state is
consistent with the reader seeing the new head before the corresponding slot
value.

I have not captured that precise load/store interleaving, so I am not claiming
more than the demonstrated NULL slot plus the source-level locking mismatch.

The original KASAN report carried only the warning taint and no preceding
memory-corruption report.  The independent hardened-usercopy panic on a
shipping-derived kernel also reaches uhid_char_read directly.

## Upstream status

Rechecked against mainline, linux-next, HID maintainer branches, and lore
through 2026-11-28.  The invariant violation remains unpatched and I found no
matching submission.
