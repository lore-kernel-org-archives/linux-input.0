Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204690;
	b=4ql3kn1UW6/1JjNzt9Gxf+GKwoG8MsJSi015i6vpcsTgk9vGZFPyAMmtBBE4wFXd+kMh
	 K4Wv/DqgYgYdchktNfpTc9968SZ4drwmgF7qUP4n1DR8hEe3/dHBqDkJFjsXkOKLg+BIC
	 P2hH0T/TXdTFsfu7oO7rdnQ/1eMDCNMS8g2CgQ+85bN5kNA+ZMu/9Z1kC1kJXK5InekrI
	 OvfN0YfyJVjBKKK6c9Bi+KzKgUIuOmhMq+kIAR7Fb4HXrMV8eNVvbDNJXAQcyLfaPNFry
	 oKSXougXXJiqi/eNHEmgN8rVxB0kVBz8wiMSJxTMy96tUsVcbdw88uxguxEaDTbZXOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JkolMb8tFJSidUGyY2kChnqwpp2TCm0729AY/AotZ6o=;
	b=PYfFMySvjICuTW+XluXu3Y5PVc6KGULzQMavrsvH9FZyPAgC1k1frsx8ih8hv7COdRSK
	 TtBGAflmDroaSOHZ2j1j4qofBQS1Dwy3dfpctmcK18cmEgmQzU5DaO77/apL3uNc24S2H
	 S+w7yKm/hcBbLBf6QALH8KuOxWne2thFAvSHzTRUgbnjKsuIL1+GTviNYV5GrRIIBf2Ag
	 V0OboXEI/7zLl7jEeJdSWidtxURxkFsE/vZ45CqIwTlLZs5NJvsduX+PT9Ko7lGAfvqzC
	 hKEfV5AcW+Av/0ibpw2OPAAVfxXJouwV1cFFj8hWAPBN4xwVzO7MnKUoLqTVKQPbLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfplylRo;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B6606D81C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9B6606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfplylRo
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1073559eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204679; x=1794809479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JkolMb8tFJSidUGyY2kChnqwpp2TCm0729AY/AotZ6o=;
        b=OfplylRoXH6zxkHdL811mTnHG1rZdYJjL1UcZLThcV+XmWvQYL4ogoK/zr1hb9sGIo
         ceYnn4cXghVQFjG77gaIyVwaJUz8isqOcypuV6iWqxcvSpbqtMBCyJTsTl/3YCLr10pk
         DrST9Xfqhp7P1pdZUuplHwm7emcMy0r7CkTs3kJRFqmIb6Aj16anRW6AMlBIAqTaOyiN
         0hVnTtctIONIf0zDd/5DbeR4wDq12Y7NbW06FKYXagBs12se2OE4Mv6v2RgAu7lco0h1
         s8MPJmlfz9t1mMP+gQmRMegX1yq1ANlxvieenGqG9l+JcEyISzYlrzk7/8gxoQqjyN/C
         So8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204679; x=1794809479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JkolMb8tFJSidUGyY2kChnqwpp2TCm0729AY/AotZ6o=;
        b=Fa9KrLDiTEq7wUJg8tGPkCYfY9LxIGF6hSUQlOvRE/DUGlGOY4MhP0qTE4Qmu9in/a
         plvgidEgRz1w8a7c5QK1UW3fJ0rHXmD29IEVKJc9AHmq6zcvtUKUmXBPmR4VYF/Nukq3
         ZLWEK65MwCe4H4qcKyyhg0omosegEUZAsZ/8L3l1j47fqWJz/KDuMnjAjcg4UfV6mMkq
         jWSPK1XW0t05+LcOQMpa1YhAX1aLN7OH0bSTgCnAXibLxUTs2Bo2KydVSg6A2C9TL3MZ
         9CBn+bENNKzmEucKqlJEYcvDY0Ui/l5l5irddRgnikw7xumrbj9wEkxpEeVJGitysDj2
         GRWQ==
X-Forwarded-Encrypted: i=1; AL+hErFmXmEB0Ie6RGYgrtzE2hWQA6CMQZWP8JmB5Sm7BJOWJ3Jm+TBqX2QrS5GBl/4ehdYGV+sgnIRycpCiPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Oyuf+DFcCTE2w+CBqd0l8CFgcbH1rZnJCnjmvnVaj105uvORj
	iCSzbrNeZb1di2OtsYFKxsdHmrxS1a5GX1rf1QY8cCqLNETimNVH9lTu
X-Gm-Gg: AYBFou1qKTUdsbI/kaI4uCqm9pR58EmZmjLeI9237McF+tWKS8tpcvzHbKo8Gn61HHB
	sZlW0h1R0oVw0HR51QJoHv6kL+41BUxBlX9JHiNMbVRalJ8xMw6tPkKChfpFq4+WQ44iEgKm4PN
	cRmaXJgTgxeq/z5TXRCegjIRWR5Nb53gclCloL7WBVtBkRpJ9DFa7SBrP3FkWsQ488ESuOuv8BO
	M1vxkgNq9uONeWemyK1tbTauhOpyJbF9nw2AXKoBDdZqbxCDK7LGsWCE0srooB2493msLO9jg62
	mfE4C0fC3d1NEyC9n4Kpf/gr4C0Gz/fvKmC8iPjge5Li2x2wmAp13DID4eh2N974+eYBROoXrs4
	dC6TmRia9O6U/dG/lQ6ykXu+UkP6AIeV623Ju20CIGY6W6kPvKm8Z0hIB0fTqukj7RaZWkC2sBR
	x/hN25yE6TtjUNo2lcXCxGDBtj3WSxI+F6l+hzJ0DtA8A3Stpt6iW1LeE+ECxR5wsnEgWjVXgNt
	SIaRWdJgcmsfbJp2n/OSDNFQUs2TD8GosQTmJ92utU3zolQjS47PdOlFcRgi1LvLNH/HH2I2B3Z
	+llN8Ird6I4KxpqPUSdlMV6H+8QH9VxPitm5Oc8D8gEFxNdkmXFgczuLHDxUX+rTsc4T7218tgr
	v0gid8my00LGG5Lkp
X-Received: by 2002:a05:7300:268f:b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-37256bed4c7mr5983858eec.19.1794204678753;
        Sun, 08 Nov 2026 22:11:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:18 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 07/18] HID: logitech-hidpp: fix off-by-one in G920 force-feedback slot tracking
Date: Sun,  8 Nov 2026 22:10:51 -0800
Message-ID: <20261109061103.2887636-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Logitech G920 firmware reports 64 total 1-based hardware effect slots,
reserving one slot for the built-in autocenter spring while allocating
the remaining 63 user effects across 1-based slots 2 through 64. Because
the driver subtracts the reserved slot count upfront before sizing and
bounds-checking its slot mapping table, the 63rd concurrent user effect
is assigned hardware slot 64 and exceeds the stored limit, so its slot
mapping is never recorded or released and remains leaked in wheel memory
across device close and reopen.

Keep the full hardware slot count for table sizing, lookups, and slot
bounds checks, and withhold the reserved slot count only when creating
the input force-feedback device.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a1a69705338f..c4c878c9061b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2865,7 +2865,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
-	error = input_ff_create(dev, num_slots);
+	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
 
 	if (error) {
 		hid_err(dev, "Failed to create FF device!\n");
@@ -3480,7 +3480,7 @@ static int g920_get_config(struct hidpp_device *hidpp,
 		return -EPROTO;
 	}
 
-	data->num_effects = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
+	data->num_effects = response.fap.params[0];
 
 	/* reset all forces */
 	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,
-- 
2.56.0.506.g506a7eabc5-goog

