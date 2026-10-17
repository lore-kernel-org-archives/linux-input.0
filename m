Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD235AC0C;
	Sat, 17 Oct 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222712; cv=none; b=n/RTd/HejHzn8EPvrOWHtcXY6rcfsGQygVvepKPLFRtSrF0dRx8fQ2XIdM2JZTbJCeYAQ/B4qZdlMZzZn4nKIRJCbc1q5ycub3Kf4egQ29bftNTMJWm+prX2GYKOUmoDpP2Mqv8PK7U9M2wHL8VSCH1Dcf77uSweHZY3t59+JPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222712; c=relaxed/simple;
	bh=Xe7GdrzxUayw3XxP5clmi+/H5DJcRs3cMDnz/zZgWVQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=J1IiWsTy9X4S6NMBgv8bdJEBiNMvZTtCvMdKFXR2aApmlTxPNIjpfSQQsydfAz3dClA9MCgZCY8NoB6ilEcQ6Oo424anC9i80YHdZsiANZvSvCfWLlR/svpvGIUjkKaChmC5iQ8Cn2OeKqbBJCEJcSM/ySSf10bpMXbKPruIZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fuYwV7Wa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fuYwV7Wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Xe7GdrzxUayw3XxP5clmi+/H5DJcRs3cMDnz/zZgWVQ=; b=f
	uYwV7WaU7iwp9asvEUPJGQXD/qGS6EQealMf7aVokS3jN1aLmXBkUihqftVD+ygW
	QOq+vrKk9Mljb+jjYSXo+BKg3K/495VJJC0SfIBf3LXNQJSy1JcK8lQ7S7NB5sba
	zGC7ywazzZHcndJ5al1+2cG1sSDg0AN8i5JyvVFlNc=
Date: Sat, 17 Oct 2026 15:38:20 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Ping Cheng" <ping.cheng@wacom.com>,
	"Jason Gerecke" <jason.gerecke@wacom.com>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] HID: wacom: reject short input reports
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261017061920.3781644-1-yaojiale02@163.com>
References: <20261017061920.3781644-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvU8r5iOdY+kdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHMDQb0mF+SHvXdYJ/bKT0hg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <400db63d.18c9.1a148cc2351.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgD3X3PsJdNqEvxaAA--.917W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQwUTmrTJewm2gAA3X
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNyAxNDoxOToxOSwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj53YWNvbV9yYXdfZXZlbnQoKSBwYXNzZXMgaW5jb21pbmcgcmVwb3J0cyB0byB0aGUg
cGVuIHNlcmlhbCBleHRyYWN0b3IgYW5kCj50aGUgZGV2aWNlLXNwZWNpZmljIElSUSBwYXJzZXJz
IGJlZm9yZSB0aGUgSElEIGNvcmUgdmFsaWRhdGVzIHRoZSBkZWNsYXJlZAo+cmVwb3J0IGxlbmd0
aC4gQSBzaG9ydCByZXBvcnQgY2FuIHRoZXJlZm9yZSBtYWtlIGVpdGhlciBjb25zdW1lciByZWFk
IHBhc3QKPnRoZSB2YWxpZCBpbnB1dCBkYXRhLgo+Cj5SZXF1aXJlIHRoZSBjb21wbGV0ZSByZXBv
cnQgZGVzY3JpYmVkIGJ5IHRoZSBISUQgcmVwb3J0IGRlc2NyaXB0b3IgYmVmb3JlCj5pbnZva2lu
ZyBlaXRoZXIgcGFyc2VyLgo+CgpGaXhlczogMjliNDczOTEzNGM3ICgiSW5wdXQ6IHdhY29tIC0g
c3dpdGNoIGZyb20gYW4gVVNCIGRyaXZlciB0byBhIEhJRCBkcml2ZXIiKQpGaXhlczogODM0MTcy
MDY0MjdiICgiSElEOiB3YWNvbTogUXVldWUgZXZlbnRzIHdpdGggbWlzc2luZyB0eXBlL3Nlcmlh
bCBkYXRhIGZvciBsYXRlciBwcm9jZXNzaW5nIikKCj5TaWduZWQtb2ZmLWJ5OiBKaWFsZSBZYW8g
PHlhb2ppYWxlMDJAMTYzLmNvbT4KPi0tLQo+IGRyaXZlcnMvaGlkL3dhY29tX3N5cy5jIHwgMyAr
KysKPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPmRpZmYgLS1naXQgYS9kcml2
ZXJzL2hpZC93YWNvbV9zeXMuYyBiL2RyaXZlcnMvaGlkL3dhY29tX3N5cy5jCj5pbmRleCA0MDc3
MGFmZmRiZGUuLjg1ZTk2NmU4MDAxMiAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvaGlkL3dhY29tX3N5
cy5jCj4rKysgYi9kcml2ZXJzL2hpZC93YWNvbV9zeXMuYwo+QEAgLTE3NSw2ICsxNzUsOSBAQCBz
dGF0aWMgaW50IHdhY29tX3Jhd19ldmVudChzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwgc3RydWN0
IGhpZF9yZXBvcnQgKnJlcG9ydCwKPiAJaWYgKHdhY29tLT53YWNvbV93YWMuZmVhdHVyZXMudHlw
ZSA9PSBCT09UTE9BREVSKQo+IAkJcmV0dXJuIDA7Cj4gCj4rCWlmIChzaXplIDwgaGlkX3JlcG9y
dF9sZW4ocmVwb3J0KSkKPisJCXJldHVybiAwOwo+Kwo+IAlpZiAod2Fjb21fd2FjX3Blbl9zZXJp
YWxfZW5mb3JjZShoZGV2LCByZXBvcnQsIHJhd19kYXRhLCBzaXplKSkKPiAJCXJldHVybiAtMTsK
PiAKPi0tIAo+Mi4zNC4xCg==
