Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204670;
	b=k+jl/1p4C9ZNXgSnPYebKp0Wf5fQH9vFLaS9Pt8eTYcUfQBsi1mpQIMKvIvAFa6k9IsK
	 PfvQIJy6j9fdfn+fNoCUkZN6473xBjv78ZxXCFCX8z1Fld1wFa/lWOeCkqnwqvI54oPA+
	 k5UBSXkh0WdK/1/rghq6YxUz2k5HCFFDbirftAsL829uX49XVLpUWLZCD6VjVjal0XGGk
	 vW805PRCmYONrsQZhtAIR2yeu7JLoRe+o0PvwNtoOG2Bdwk7TqSrHeMd9EcOiZ2z8AF+i
	 iZxiBYhjBTgXRm5TC4tx7ewIFiICFZjP1HEv9wYQyfvJ2FLtzDditMEQ9fUGI4lzz6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SHjqr5HyPYfvrMsyfIovF4S0TyQhn6m/GOYAgfH2pZs=;
	b=OaOtkSveJwnoo3ye8Ram21UPvg+IMevF2gWiKGQnH2x0nhArhHXgdt/NmKrh7lGjsDbu
	 0uys6eBospKSuOrB0Dc/xSz7fdMcw9kkTDTtldkI3iFtdoIcYXbQOlT8C7eudofTjGTHY
	 PVgN4VuEu2NvKxkfJyQ6z3feSXRyQVyWVlHK++NoaSvf97qSnEnONvIX6oNQ7bkuBUFuZ
	 10DZCGD+v8JJlDsSU1LaiQYZLnPMKVRXW5bJShSwz2rgppNJHAlDTOTjRexIHX4PED33w
	 M2zXcp6MWevuqnw51SWGFS3zV3sLGyvfP2ymYZXujJGDLWz2GpPWo4izde4H8mNp+ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q08c1eXv;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95F606A338
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A95F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q08c1eXv
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1073429eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204669; x=1794809469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHjqr5HyPYfvrMsyfIovF4S0TyQhn6m/GOYAgfH2pZs=;
        b=q08c1eXvQtmYgarguocZ7+LNJOMZe8a9nkncbRV01G4Bd6itebPqLXWs2rz9Z+aE4J
         mNYn91zQNXGndloIFG+FUOJdsHcBwfugOFQxt1IjXNiSJzDkaG7GB7uqWmt760hl2sEV
         xs3eBk/FxIq3qytUXlj2gB4mh91Tljvw1RLk2q/+W3y94BozIjvGhDesvMVe14/x6LOJ
         XKbQJAXYMWx+D1o1eHioZlvnzyjynWdZa3ds6AKKP59AioigfP/if+TYKROPzVU0THKf
         ++jH3GMYmkRR7Pxtkot1go1t0MhKFIDH1jn+ADwwTlH7BhJRO/azo+qOkDvLxYMAfYU8
         9ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204669; x=1794809469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHjqr5HyPYfvrMsyfIovF4S0TyQhn6m/GOYAgfH2pZs=;
        b=JDi2SYxrEo6gQJc2dciE9avRO29UGgvxV0w7mw8Dvogvi/x2dtM7rI3887PQiOzz80
         6qoQVJqq9Tr6zoZKUeML3yYq9414MvbioyUgOJ119BNasunvw7tdDKAGPCr29exvrp9c
         8OjPcXc5TfEqWTZ9Cj6T17kf44H7r2il8SJ+PD7FKY0jr7srz3842Vs+A8zSmu4LiTqz
         8v11NG7hUkr/f9XqAcL3ToZtirwMb9emFkDHJ2tJ/EeZNbORWvBG8/HVeaY1KWg73RXq
         4I8fslA8hQVjRb0jxuyCpldUFGK21lzXjThRSHtyKK+IkTP4nhckaotoYEmuHEKWC0VN
         SK2Q==
X-Forwarded-Encrypted: i=1; AL+hErEEYnDEc59mC7e9H3PPiZ5ctSJFwZ52MQdcdiIYCT0jpmUl/uPiio0tlte/Ktgi45UD0mShzf5yPoq13A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8PGI9PhbD+yqQtMSKX2J6PFpAbJCGceXZgFfh40J60EjKi+cD3
	3z7x7GPsyMb3kkS45Y+/iVJq8+bsIv2Z2O81vzU4+ewfTMhUVS3AChwF
X-Gm-Gg: AYBFou2QHSqBFl0fqwStlLgO36Mut84loR0TX+sQ8iqCuaEN1jlLOo+X96mg/z7+qPv
	V3FPrhDlxDt5f7XhSfUFeQV7Gdcj2a90Kv6V+ocRGS99II+rX0j4XGhf0eB+BVfWurPViIQ0sCi
	PiluVjOxJypb58n5cMtuUdSw2Hd1V2FwPEe+1oiflFVWyo46BsuJTYcvgOtoY6bH32Y1oncty30
	Y9mwXHfYjopCXCDJN2YiCJEICblA3tcFG/y1cW6clbI6lh065+rtCgfnSCS3BFuuafX6S8Qncjk
	Qid32nLy6jGR/hbzfQbwUrCWKjRdjJc70C60z4KSVyXKxIa6vmOxF2Ry0y8V+P0RQKqjzgr12D7
	DBaZxr1bg3016wpjGte5cAx/oSC5sVN3CLKdsqzFTj1EBFRefrpGRkTtg2j5w3MeTSVaHY+wkUh
	NrvoePO4N47/oIaAAnbCkATDOUSevDHouZv7xRLB/fnjigO/yhS79VsJOy7UHPVSwZijNAKtvRQ
	QmttuyzTJD0m53xrp9C/T2TmUkBRSZihxdI6B6ZvZxC/H82y69GnAwc9PaWJgcCid9o41HyYLDI
	2P2RqZm4FNgmQ82ydaADxNtbIAPMOsL9Q0UXtiQI0+IOgK2Y0yeNJUksBDl8fU9cgHdttK92wIz
	/AfZ3XIEKB07JZhJS
X-Received: by 2002:a05:7301:fd04:b0:36e:c07a:426f with SMTP id 5a478bee46e88-37257aa83eemr5915584eec.39.1794204668922;
        Sun, 08 Nov 2026 22:11:08 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:08 -0800 (PST)
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
Subject: [PATCH 01/18] HID: logitech-hidpp: fix G920 force-feedback initialization timeout
Date: Sun,  8 Nov 2026 22:10:45 -0800
Message-ID: <20261109061103.2887636-2-dmitry.torokhov@gmail.com>
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

Commit 544315e40172 ("HID: logitech-hidpp: move FF initialization to
.input_configured()") moved Logitech G920 force-feedback querying and
initialization into hidpp_input_configured(), which runs during
hid_connect(). Because hidpp_probe() calls hid_device_io_stop() across
hid_connect(), incoming HID++ responses from the device are blocked
and g920_get_config() times out with -ETIMEDOUT.

Temporarily re-enable HID device I/O around g920_get_config() in
hidpp_input_configured() so the hardware configuration queries receive
their replies during input setup.

Fixes: 544315e40172 ("HID: logitech-hidpp: move FF initialization to .input_configured()")
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Closes: https://lore.kernel.org/r/CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9646380febac..6b1f55483385 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4098,7 +4098,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 
-- 
2.56.0.506.g506a7eabc5-goog

