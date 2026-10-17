Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96929A9C3;
	Sat, 17 Oct 2026 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222756; cv=none; b=kTg1zHUj0pcu5Im45475Z/G035nxekc0Ry9jTSmrZJFzbuEgqx/mdWePnTsZz9eRJPqt5XlxN/ryw1vU0aR9fLA2f88+b7cf2BxoBGOGqAZacOuFXuAvWW0RpthH0BulFxQBgWK722n8PmXr6XrBsNpIrEDqPTNF8jUE5ygDCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222756; c=relaxed/simple;
	bh=kCh50A4XgR4WCC439DBS0FD12n4kxvOWmFcnmW9wsuk=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=f4wXLVnB3yv758r5QahRhoBHw6AoEU5A6DdL3w/uBAFz8TPxfPKDDhy/pwxI7gOYcD5rzyQKTjXwrkYKahJp3kGHgpC8GHOAs73GXbzZsB9392QgK9AmDyMJ+JJYIWV7sT3ognGVfB2El8357vkFhqljjG7E6qr7919brVwk7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R8TNAnnU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R8TNAnnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kCh50A4XgR4WCC439DBS0FD12n4kxvOWmFcnmW9wsuk=; b=R
	8TNAnnU/5CgnyHXPrvVvoJHcDpNPPWcNPRda2Td925NPovC/WixeSFg7PA8ecuUA
	ysvvSKZnG/8Br0+k3ozomU4AubXYt+5TmYXOOQxldhppJHWV7H8SJ9noq3y+dV1z
	eepynJBFVs9mZVUpm4Il6uMzczj4b5ORAUSTuBnDw0=
Date: Sat, 17 Oct 2026 15:39:05 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] HID: oxp: reject short input reports
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261017062347.3787437-1-yaojiale02@163.com>
References: <20261017062347.3787437-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvU8v4yWZZ+kdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHIN81j37oKcgyaxbRnU8F1g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2da71486.18d8.1a148ccd3b5.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgAnZygZJtNqKvxaAA--.133W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRkfWWrTJhko9QAA3J
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNyAxNDoyMzo0NywgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5veHBfaGlkX3Jhd19ldmVudCgpIGxvZ3MgYSBmdWxsIE9YUCBwYWNrZXQgYW5kIHRo
ZW4gZGlzcGF0Y2hlcyBpdCB0byBvbmUKPm9mIHR3byBwYXJzZXJzLiBCb3RoIHBhcnNlcnMgYWNj
ZXNzIGZpeGVkIG9mZnNldHMgYW5kIGNhc3QgdGhlIGlucHV0IHRvCj5maXhlZC1zaXplIHJlcG9y
dCBzdHJ1Y3R1cmVzIHdpdGhvdXQgY2hlY2tpbmcgdGhlIHJlY2VpdmVkIGxlbmd0aC4gQSBzaG9y
dAo+cmVwb3J0IGNhbiB0aGVyZWZvcmUgYmUgcmVhZCBiZXlvbmQgaXRzIHZhbGlkIGRhdGEuCj4K
PlJlamVjdCByZXBvcnRzIHNob3J0ZXIgdGhhbiB0aGUgZml4ZWQgT1hQIHBhY2tldCBzaXplIGJl
Zm9yZSBsb2dnaW5nIG9yCj5kaXNwYXRjaGluZyB0aGVtLgo+CgpGaXhlczogODQ5MTBjNDU5ZDY1
ICgiSElEOiBoaWQtb3hwOiBBZGQgT25lWFBsYXllciBjb25maWd1cmF0aW9uIGRyaXZlciIpCkZp
eGVzOiAyNTJjNGJmMWQ5MzEgKCJISUQ6IGhpZC1veHA6IEFkZCBTZWNvbmQgR2VuZXJhdGlvbiBS
R0IgQ29udHJvbCIpCgo+U2lnbmVkLW9mZi1ieTogSmlhbGUgWWFvIDx5YW9qaWFsZTAyQDE2My5j
b20+Cj4tLS0KPiBkcml2ZXJzL2hpZC9oaWQtb3hwLmMgfCAzICsrKwo+IDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1veHAuYyBi
L2RyaXZlcnMvaGlkL2hpZC1veHAuYwo+aW5kZXggMWU2OTFlYmMxMTk5Li5lMWUxYjk5ZTk4Nzgg
MTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2hpZC9oaWQtb3hwLmMKPisrKyBiL2RyaXZlcnMvaGlkL2hp
ZC1veHAuYwo+QEAgLTQzNSw2ICs0MzUsOSBAQCBzdGF0aWMgaW50IG94cF9oaWRfcmF3X2V2ZW50
KHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCBzdHJ1Y3QgaGlkX3JlcG9ydCAqcmVwb3J0LAo+IHsK
PiAJdTE2IHVwID0gZ2V0X3VzYWdlX3BhZ2UoaGRldik7Cj4gCj4rCWlmIChzaXplIDwgT1hQX1BB
Q0tFVF9TSVpFKQo+KwkJcmV0dXJuIDA7Cj4rCj4gCWRldl9kYmcoJmhkZXYtPmRldiwgInJhdyBl
dmVudCBkYXRhOiBbJSpwaF1cbiIsIE9YUF9QQUNLRVRfU0laRSwgZGF0YSk7Cj4gCj4gCXN3aXRj
aCAodXApIHsKPi0tIAo+Mi4zNC4xCg==
