Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591341;
	b=HSnNp/7OQ1+c6D0sawlgxI+JxI1wk73f3cHWhgTrAyv6jo/j+ZAZTR3wdSkl1JdUMriE
	 7pd31WZQZf3Vg5/UjbTDKcVOYg+noGNRcACRoE6f3ku6jNBZCFJxcDqWL0Qwbh0kfLpbG
	 jTTilu3ehY3woNWcNEEz9dneEtrCqjFRS0tp4/8Bz7OdieXx1kMDrgpmurP9E64PA2P1m
	 Ev4VHJSfQWa12QEv3zwuQte3vqgBcIgzyUI73Bj8nnmryFPjoqHfija1/jFYeH5SaxlBM
	 dYyv3LovOblq+FwVIHUJtaQKNRK8G+0B8jfhijULBWrIHEU+SbqkRV2ujdUjDbUoKNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=zfcmyiq+nRVD4Gw8rxfHm8nS2Ueyfoxb3FhyxGvekek=;
	b=LkEQVNgmSCWO3STrGJbA4MEwNL79VHEmAVj+2nUfNixKQ5rjaolXJNDu6xgpaTkZdZoz
	 nuXorV4D5ApazT08j0/GTvjaVnkUAy2paWFGRI0Ss2+Lpc5a7NdJuhcYwzriibr4j9Xj3
	 KaFrnsyMlcHVm/v3vBa8YYv/md7MZM3zwLNs7Q0QLNkrjENpHR3PFYqh6sukU83Ys2XYQ
	 aaxFWssW6GGsOq2OV9o5nN3p0C4FAOdygvrbC+broUhb7jzppL4qGeoKJDcSWs9jyTO/Q
	 THEe8ITlW5QvGCkdnAAbJ99D/nBPovI4hWP/s5GcGaOLHYYVWcs3UILsq4k1l/NHJ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="gaJW/l6v";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE5606A32C
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDCE5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gaJW/l6v
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso52836955e9.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591339; x=1796196139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfcmyiq+nRVD4Gw8rxfHm8nS2Ueyfoxb3FhyxGvekek=;
        b=gaJW/l6vSmRuBobAdkKGDwe7cEsHsWI47/VJzdmD/pJMKNw6R5O+m7PxgJQFU93K7E
         OVZQAn2JPTOIAbOqyZ1X6ISVStN2mm5ZdLf/8G+ldSovwqU94LoPdv1di36yOhfIIydD
         766NEZInyqIUXNTsilUjyakO6xM8NUaQR7LNCnzicCRvOTjnVbPp4T75k1uFrVsiFpx7
         wQJle5kMg1/OHtmrVnMLcyjgUIhOqhQLfRwSaEbfTnCKeusE4ZJbJk2ekgHWlBzhk3Py
         cjkJ1XNPMPCBriuQtGRXlhiF+RhYtAwo5V6GmUSb1BZHdEkqQtRANYOSILbj8+++xQDh
         Go/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591339; x=1796196139;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfcmyiq+nRVD4Gw8rxfHm8nS2Ueyfoxb3FhyxGvekek=;
        b=TmhxhD+Aq1bzgkoZ9b/kvEXeR9zUThl582oQTT/DjrwlYTgpRQBKXYuSUo4N6lPSqA
         Bs3+m7C8duq0CFbB56H8GLTgQyd0rwWpQ2d78echbYAjql9szxGJi5uPu7GZTpgVqdPV
         66bL+5Y6V3XbTXPXKlp1jbK6Hk/NuHu0njs4ZX+vUk3ylNFDeHvyLF2/wKBVfal2DJFE
         dX8+poj6dQbjXypXyC+lPo2NwrTPvAkiBLTf6eUSxXj3nQk1MNoB4S+YVgdlozFm8V7V
         gqsaGigW7f3DE1757jJDRVHQXDBNKmKBmlCgJ5IolT4ZXRzBVAl7wU/qObBZ63eM+zSQ
         8t5g==
X-Forwarded-Encrypted: i=1; AL+hErH317ZM7ro2n2hrb0Vd/9k+yYBGBQ0CzaZYSboYYOFp5dRnnBM+VIpYfr+3CwLEuBZ/aqZ9mM3htgJfDQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZTxka9OyAVtkDjcI4dX36QldXG/mGgCpavV+N6a8sGkK0Vq2q
	YuBNiSvfpsz2BfOGlFiNXieG1Xr8RkPdczeJtErxKOE48cIWww2bt86n4oxlX5J26mU=
X-Gm-Gg: AZFdTZekuwMSF2We/aug6RKdSW7rAJ11XMzgkwIOLL1+PruNGnndEX8sovjtNrTcPx8
	hM/TZ0aTDe20XpquSZXo0TLyrwZ3nWARmqWqtSE9Sw1sVsNP3IOmpigpLwRrs2HXg1C0xIGNAGG
	A1sYdbKJVwtScBlWJTaGh2ZNt25sw4bVqJv7HGYCVXY6bySaEAWQ/OgzqEF80Wr2a2+irGfDMt2
	QdwlAaLScKGk6SGmj6OkrbqKjUGHlYwzMwG7yatjWYmWmC1hPA53joLRXn12uiFQDxE8U8s7LEN
	LBFBiNfwI/S1qKKz/Kl4cRh1Ki51lcJl5mV6CpS/aKAoTzUINJbWJhlIqmwVyTYgtE1aAb16ZxJ
	/P/sdjWaGOvGqI/Vo+nFuoOdTMl/y1/UZRHtcu7hBH/igDBLpPKLehwEi7dcDkshhH6VMHWm/AK
	y3MPTMxipO4XHpokljfuSOJlFgw9oym9gMRH9Bp5JrOm/YsdU1OkBxKfjMMe3BQ5lZcyW6I/0WI
	DDjdT5wB970fOnQsrmUiJ8gvRiS8XrUkZNJIgHnzHem906ss+taHaSlqq/ggfkmiOj5vrCdH7Di
	IfgTYYbM3xeKqeDuAZot3zFHT++0MlGqUg==
X-Received: by 2002:a05:600c:1549:b0:4bb:6f45:2a77 with SMTP id 5b1f17b1804b1-4bb8880abf7mr327186815e9.11.1795591339161;
        Tue, 24 Nov 2026 23:22:19 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884865a2sm509382235e9.3.2026.11.24.23.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:18 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 5/9] HID: core: Make driver_data in hid_device_id a union
Date: Wed, 25 Nov 2026 08:21:37 +0100
Message-ID:  <15ea0b7b8bdbda0d19772b4d75a65131e1adf15e.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=QEFTzo2iU5KSQHdF8CX3tT8L9BSwZU/9ye4ZMlX548s=; b=owGbwMvMwMXY3/A7olbonx/jabUkhmy2ng5bn83r/94WCMo5cje93rHHpKNDi8UpPqYwf1fK1 fkGvis7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZiI0wIOhhZHMZbi++rBLUJ9 rnHOB01cdodLPy3fa6nzPuBmUJcMb6DuupoLVQ/cBMy5VJLK1pU5vND9uejDaw7zx2t3985eLR4 QlCC5ZotDGuvm8jxZG/nXTU6hprGh9b1ObldV496arTS95KvmuOerm/au7825S5df2LOE9XZq4f 19igVWrP+2Zb/8Yrjac6dgyd3dl6sfLTayiLTOOGh/yyZxYYWw4ooUd65jNmGWNybZmr+z+TQhx e7IacUgQ0l5Jg+P8w39obJR7U+CSvcrVPrX3O+6pVDEtrf1YZuipXmq7iXmux/+ZSXduav9fJ1F 9s17vGujXZWX7/6wwHGl7eVdEzwlTMsWT6pJtVQ47wsA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With that anonymous union usage of struct hid_device_id is nearly
identical; only initialisation using a list initializer doesn't work
(and there are none of these in the tree).

The upside is that drivers storing a pointer in driver_data can do so
with more type-safety. So usually a missing const is catched by the
compiler. Also less explicit casting is needed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/device-id/hid.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/device-id/hid.h b/include/linux/device-id/hid.h
index e865fc64bf94..e05a8974de4b 100644
--- a/include/linux/device-id/hid.h
+++ b/include/linux/device-id/hid.h
@@ -16,7 +16,10 @@ struct hid_device_id {
 	__u16 group;
 	__u32 vendor;
 	__u32 product;
-	kernel_ulong_t driver_data;
+	union {
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 #endif /* ifndef LINUX_DEVICE_ID_HID_H */
-- 
2.47.3

