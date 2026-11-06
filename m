Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969388;
	b=MCDBdXFTROPvxONB76gVdW4Zn62th/W3Y+DMYuKsNqw9/2N0tf9TRtPO4qYidsg2FLQV
	 kWJPCPj0OktRPq3Pu/raAaAA7IuzxHS3GGGrYHpMx+11lXBdnlfNp41uJilPom+twgnGH
	 tWb2F0XijNhXTdHoCXPUkSkcqPkqT2+LDdJf3jZU4MPR6q5bqNZni5oXcfaSOSBqe+5N3
	 tLjEZ7XmaFBPdrxAKg14JBL9qsqy2RC5QRiGUw0MXSNflF9LwRLqR1lV7TCZr16joyDqE
	 pCqvyCM90SUVHKFGLFU6eDwvavHhahGfS71Ur1U67nERri94GLyF9M9t3RE69v2XTfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969388;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qPhpf2p9MBpKx7W1eTbdSdi+i8GMw0zE6vGmAbKeBi8=;
	b=FO+pq12J17DJaVPk4adDssHxb3e6BfLkzw2DiM9L6I00r2f1Hci86DRaqnSKmG06pmSL
	 exM7d+JVh8MkqXICAJdJYY32Q2uBNQqlUL+e/+Q3B+UB6qKA4a9wMTI8/OhyD9e1JC/2R
	 O1jBk6VlIoUbXvf6t34cKT1Rlujp41c7t96CJg7MVsvlZuyrclpqJeFLThwdZMR5aFN4f
	 ovFyW2T0ygKwzNZgg7RKNG7rGtr5MFaZ34WOISnuKJj7VEuRuFPOovdzsPzqInBwnZyoq
	 VhpMT+3NMJz1QkEz8CFftxny7c/WSGE2Xi/Nri189Prv1m7p7v9CQM9M1V75i8cf3TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=e4CTlE6U;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49F606A329;
	Fri,  6 Nov 2026 12:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D49F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=e4CTlE6U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1793969386; x=1794228586;
	bh=qPhpf2p9MBpKx7W1eTbdSdi+i8GMw0zE6vGmAbKeBi8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e4CTlE6UIEFjDMVkIHybSKBQ+enJn2GNqVIn2Y5xuQP3PpbksfXwuAbLqILyuxRc8
	 fZW57YexBljANZH4snonrZTKAcaG1h1esDIqbd4VXPnvgxwF+Q4PVVAqyqZZUnU0jo
	 qv6n2c5xIFWJQ5/UwAUeoa/sKy153szezxROED/46yPROA1DNA0/edN13oINQBFA7a
	 4rWtu4O4HPx514uskG0G1kL9VNPFaS345uGKVT8nKzZ87x+2KAVl1ROFm64i3fCkrh
	 8Nsh6rJ+D+QoNgPBoZlkC45L6eewr8PPcNXSJ/L7Tk9P5NkjYF8i7A7gLsVRhYAdL5
	 /WOoxm/gVnYxA==
Date: Fri, 06 Nov 2026 12:49:43 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: sensor: custom: Set the owner of the misc file operations
Message-ID: <20261106124914.2892604-2-ca@modelmiser.com>
In-Reply-To: <20261106124914.2892604-1-ca@modelmiser.com>
References: <20261106124914.2892604-1-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: e90bc27ff54b1d55c1708261ebb21b58e7a5e218
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hid_sensor_custom_fops has no .owner, so an open file on the misc node
does not pin the module: with the node open, the module can be
unloaded, and the file's later release() calls into freed module text.

Set .owner to THIS_MODULE so misc_open()'s fops_get() takes a module
reference for each open file.

Found by review of the previous fix. Tested in QEMU with the driver
built as a module and the uhid reproducer holding the node open. Without
this change, rmmod succeeds and the later close() oopses in filp_flush()
on a page fault in the unloaded module. With it, rmmod fails while the
node is open, and succeeds after close() with no oops.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
 drivers/hid/hid-sensor-custom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custo=
m.c
index 47800efdaf..bee612eb1d 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -745,6 +745,7 @@ static __poll_t hid_sensor_custom_poll(struct file *fil=
e,
 }
=20
 static const struct file_operations hid_sensor_custom_fops =3D {
+=09.owner =3D THIS_MODULE,
 =09.open =3D  hid_sensor_custom_open,
 =09.read =3D  hid_sensor_custom_read,
 =09.release =3D hid_sensor_custom_release,
--=20
2.43.0


