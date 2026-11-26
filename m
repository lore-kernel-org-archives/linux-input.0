Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707569;
	b=jp/UnPJhNmkN9q/i4M+b5s7M3VRsFfIjxRLdmtv7SEDJrirNrP1rYp+CSSaCsz+FGwoI
	 BYVKEX6bUVtFPnTOgBVLLTJLXAgBwYbqKw8WzClM5bUT0/nm4A5AtOARPzfRA8S54HKM1
	 V1GAtWHLzwerk1RpPiaUnAc8f2jikbnJjjYxROrExvcKC2qOqvYK45Jn2Nwkwe9WGISyQ
	 leYivhb5v13PXpGjqBTW7x2G9aKA6FatuVtZvzGinFn14m+lGGnH6VT2KY5XuwlwCsOid
	 mugr8m2IG3yqjE43BeXHlJ+BRblKAXFU7du1NBPRlPgk4IZbliq082Y6MSVRVvRvBcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707569;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=80ZfvRgmQGXZrbKiFI6AkV9n6MdSmfVFDz7BTv5EoMs=;
	b=MBQlfK/Y/SW6gDSJhw+nmOcS7krbkUPfC1SLUEVtwTHmykd1QfGRjGlqcbUnAg3/+hY0
	 ldRyN9aVjamyZpDeD5zcq8zCvph+KMTiD98LxObsap2zlUoFpFUgawcgnZECZcIKFD+sy
	 t49d4O8sw/YVQVVamFgDQ3wPH0MYHzlXfWr2p4cR0kw7ZmTmXFV/7hsHqR6LSQMxV6xO/
	 vUkVZ9KPOeK3n5wBM7b7+XtGSe1HI7AnCvqMBzSVcEyOCQFhnZcl+w3XNDi/TZD3V8ttW
	 zR1tjiDZljZ9T4KkjylwADh6+5muacrH7l1OO990m+bVvPv/ynlHA9Cr8/zuLQn2MAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeweavers.com;
	spf=pass smtp.mailfrom=codeweavers.com;
	dkim=pass header.d=codeweavers.com header.i=@codeweavers.com header.a=rsa-sha256 header.s=fm2 header.b=OwfO0vsp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OehtClro;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F606A31C
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 15:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9604F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeweavers.com header.i=@codeweavers.com header.a=rsa-sha256 header.s=fm2 header.b=OwfO0vsp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OehtClro
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9566F14002FB
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 10:39:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Nov 2026 10:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codeweavers.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1795707567; x=1795793967; bh=80ZfvRgmQG
	XZrbKiFI6AkV9n6MdSmfVFDz7BTv5EoMs=; b=OwfO0vspzeyYxTh+egMdK/uYTo
	b9i6wPC1fNYTICfCN5ZGAK2guRu0Sa4OvclHbuxF11uX/IXU7DY2ns5Wky1aX7BV
	FM4mtcm42QWaoWEgd9UgbaFtovoSJtkNYPNENkLM3L5qhv5w0sn9wi5z+8I7IAzL
	OE9hEtQjxS2AV4cmcmag6Mz3EsgzVTV3X908l+vtG42NSg+qsLGTe1f200t2d3v7
	LN7DfDFZ9FS/ocEEG5v1ehofVo4Xty+dmg8PVqxHL4Z8WRPYioOG0YbuM+2C426h
	Hzdw6zzZx0HFwYcqiADCHchhSjtGu2bcflX1Lbqbl+FUE8jdbTiQUpWYvviw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795707567; x=1795793967; bh=80ZfvRgmQGXZrbKiFI6AkV9n6MdSmfVFDz7
	BTv5EoMs=; b=OehtClroyCSGBOLXklkVJ0JNfckPXE/uAlBG7WMgl+SfJvFpwpe
	p/mKlcUq+9dVJDWAyJPo7wzbO0Sa+8ioCi7rVgTGBGxvgUsZ9+JO67Asu9xok1pr
	8wqTU/51f8idNvPMzXEN9iisMPx/NxqBqnHR0MWiQcOwWnWXAjMoTw1+ZQkEc4mJ
	e1G001e8YXoIKj9mEQV3kGkX8ArQy9dmRRB0Cfpqbt67q7xoJbY82ai1KvvkVUgq
	E91GGQC8hAAK8Gg6JHWvXSLRxjL6kO3CM2zXZpHE7WpPS2BsqfbMedEMnWrspagW
	um9FtuYGZU3NlXcVscE8tTiMmSHwpKNw5Mw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=codeweavers.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795707567; d=codeweavers.com;
	mf=PG1icnVuaUBjb2Rld2VhdmVycy5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:Fpa0TKNu4pUbALewqYdLolnkxZenDd0cUuGfOcqKfirKRv7
	hZIc6jzp8r2F2TzbdQ3ycKraKLuNqFUbmtAHrAUoVl7wrX+VH9pADhDmCFKG2oKG
	CWH3gWYbERihP47mY84HGRNLwr2y9vZJX2UG4niq8xjvwtQTq0+G2xq1uExhzLgQ
	/oeeu+e4yHSO2dO2RQnIahmYoRyqN27yjAgMLCJ0dagGBww0B3AuNwnQ9RfpW7CL
	tHN/TogTJsjV5WBnlHyrZh+V+q4NnpWlq0rnFdegyePMaMNpos/6AMXDrO342BlS
	YVhJbmkCcASOINZnud5gpkbAFrGU62dBI5Vmdew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:bOGpqjm23eTeu3eJyZJrsbw68D227iP8GwMkmZNz6Rs=:CgD5S9mwIe4iji/3GIBtBdr9ppFM7A3hG6fQmtF/xZE=;
X-ME-Sender: <xms:r1IIa_QARl3U48vp9FfxExasyUkER93u-4Izn4sJlbbGejKVvtz9PA>
    <xme:r1IIa3xgyHfy0dIIHtLe-aNKJe1StsZmIQfi0iAg5j6SPRsb_1p_4sVfSp0xnSYy9
    VpSg7e_17sfYVch3378p9UXleicdJNMRrMfTFxNQBLR-uMUt2HyD_Hp>
X-ME-Received: <xmr:r1IIa52KOu_yVBxkedahRWn0j8tEbtf7WgT_cPqv3zRMKSH7n3efjVd7herY4bJE>
X-ME-Proxy-Cause: dmFkZTGWQaU07g/8+lFKFSFmrKnWPESN7A2nC3c6v6Kbh5skHaiW1rJoPeuwzz+ABVttRN
    yncAtrfNl2M3ShSPLOwEImRIN4BpC4CsSoepZ0EiXvwzLeInT+q18PtTEu4bAmlbUjgAhi
    tCKGEH5hNBfEsqEjC6c98LLsA+UQc+qt0bMR/+mtNqDG2KmW2+pXdmV7H3wg8qD84lNqYw
    LhsTCujHCV5+ivsleINhP5HH1A3yMV3QB9gGP/sw4Nh730tzgh/+z8tQw1DJ/4EbHQnBlT
    DBYKxYiyD2MctW02zgIdPPckcfhqC8UWV958/+7BJTSx6WPz7buBWsZLaMemoAxGoq1vq6
    qX86ijwWxFvjMd1hF56SIebiCDg0TODyn4PIUW8w0UCjrFoi0koIGU0hyvDDYUdv+Tys0A
    RgsL3+iGslMngvW1I+68DTbBoPd6o64dwlsGFO/DgV9fA165ceOqNqGlCsPlVKEf3pISvW
    dZ49g57/SmMYkbrRGq+oISSoHx6/KZu4oHuFTvC73HNOj6hqaogHyKRaEyMNMHenxNIUjG
    mVcrTiDgEhRgsrUIxsxTR/TL0+0wj9mY0bnQrQbqLEFJhhDMRMAtOczTnNFO7J6EvEvW9G
    VtFwSSIqjgHY5GYbPzsGD37JjpCgpAjEaV2YH25V4auQpZczFyUq0iBKH7jw
X-ME-Proxy: <xmx:r1IIa94gUjww9RlU4m3_ED5I7xU5FuOKydiBGkUmjAJq5DCp8-xGZw>
    <xmx:r1IIa0WoaPbbnyrWzoPpIcs4U4lajGqUYeI0H9XxiBUj8B8btVPqlA>
    <xmx:r1IIa0Dx7zX_Yc9oR9PksHy-99zdtl1AyZXTuiSfR4BP-DyDToMlCg>
    <xmx:r1IIa75L1PjZhO4SBrnSV88UftNptoSr75wlzQZrVY609i8iEDbJ5g>
    <xmx:r1IIa4hVR1HpzeoF6WdDFQHdE3qS0D64LU3HUiXM8tdHk9J9b-oCwg8x>
Feedback-ID: i09464b71:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 10:39:26 -0500 (EST)
From: Matteo Bruni <mbruni@codeweavers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Rheinsberg <david@readahead.eu>
Cc: linux-input@vger.kernel.org
Subject: [PATCH 1/2] HID: core: include product version in the uevent
Date: Thu, 26 Nov 2026 16:39:24 +0100
Message-ID: <20261126153925.9488-1-mbruni@codeweavers.com>
X-Mailer: git-send-email 2.53.0
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

Currently userspace can't really recover the device version for UHID
devices. Compared to e.g. a USB game controller, starting from the HID
device, one can recover the version from the PRODUCT uevent of the
parent USB node; there's no such parent for a UHID device.

This is going to be used by Wine, to be able to report the HID device
version for UHID devices. You can find the corresponding Wine patch at
https://gitlab.winehq.org/Mystral/wine/-/commit/5c2d90f7a4d13c92b10b5c4d82171d22951ea32b

Signed-off-by: Matteo Bruni <mbruni@codeweavers.com>
---
 drivers/hid/hid-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4a47deb9d..918db22e8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3004,6 +3004,10 @@ static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
 			return -ENOMEM;
 	}
 
+	if (add_uevent_var(env, "PRODUCT=%x/%x/%x/%x",
+			   hdev->bus, hdev->vendor, hdev->product, hdev->version))
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.53.0

