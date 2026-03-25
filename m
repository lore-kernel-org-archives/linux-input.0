Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBE232395
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447249; cv=none; b=csq/4q/PTUfcKlOUuypRnPjROWxgvs611RboD+QWMb0qo7DNCOq+CPbzXWnr8N++9O7D+5sbvWTW+dOmTYiaUkLQZSM3SfHEvJqT05MbynPfG6ZUQ8B7+oZWb1If3Xl7KTd20MEZuGclKchRsByEqm96SRLLrFSX8CdIFGF0i9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447249; c=relaxed/simple;
	bh=wD5djbrAZKzdxGofv+9B6Ni1wJjXvGlUbq4ztc73xmI=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=i1WfNACdj7XRz9S5+dtO80bizHNpLd/OxktbW3aXtFr3jEM/h1gySfQpVUzYhuS/pbW6BvPqjH8OzT68JgRnY1gwTVK3Sw0ow3pwiq7uPY2sP1xnxCYuXrrRWPRo1z5s5xKNYBsrgJ0VEWatspO49FWGpEh2Pktc7OiYpZJZ7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dFtThF1d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dFtThF1d"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b7ff8fe92so1482527f8f.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774447243; x=1775052043; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FKR0jLA7z/lusCicN782gS+wwmHb2gHV2cxgy5RPnyE=;
        b=dFtThF1dhXjw0Ebvb16PSd1ENr23RK8xYHKelwlT9yixZhS6ZRETMxfom4ldMZAS1U
         Pm2lyQTvVJflvAQfJV/7PP9Vd7Gyv2q6eVxohGjeyxt9MY7bl0cupgJ1+ucWMKOar3he
         aojbS8ghXJe1iFBAG4ULMGO0CnKkMoNAsq4XfzT97vsYd3Kpg/ytFawVqWgc35yrVIHO
         XEeCVxxQK5zZ9+Pq0rNX+yoKztsvZBnTkN2oJJD9NBZMnyaUJYbEjXS9rczrzR5LcGBs
         t8FOyIolqcN9xrNNvfchqUi1n9aoy4CuDLXHAAD4lVjtatZK5yfwMvLMg1zWnpOUBI8f
         vKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774447243; x=1775052043;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKR0jLA7z/lusCicN782gS+wwmHb2gHV2cxgy5RPnyE=;
        b=nuxy6TjWoyFsN2VIac6o7jM5DmRzHweHhlX59301fnJVg98UJ2D4HlNlahLPsdZmyE
         62tVe6//zBSfV9lWO7DfYvQ6LgFQJK59w4MUo+KjHkb/33pva/rzEiyJSRCVEjABYOd8
         hZL9HYU9Oqttr9U8TsM7BrZp8JXCzQdxtH54kv3evowEJ+DlmLXOf+sgTSwawZxD2FY4
         TvWOHKw+2XzLzBFbJjtG+4Ylre2CS20KZIy+lxHIXnC8L3UF/7poJOtvTq+P8gHoftxA
         S5Sxo8lTC++v0xkp02HrkwDvnF8+ddnM0jQfbiowsmqVt1KgGidcdUwnXvOFP8O+rAE2
         9mlg==
X-Gm-Message-State: AOJu0YxL66IEAryKAaAjhZqsBKFrHm96qzT0nETQk4O1wyeuqFJ2tWIz
	9O8Qnzj2yDzUF1O4RiQdVe69eQ93zllDqq/vmC+07VI0WJbElGL78QkM7/zFa03M4yORAdVZWD7
	4onmm
X-Gm-Gg: ATEYQzxCoCkjHDGP1Q0+jIfVu6stUQubOmMKrBO5tMVL383svPdj8fBX/Hnk41UNUqe
	+Up71OLiDBf/h628Aqh1iu/cSCmBCHJOAYMHwjkihnrTSvhn7xccfTzyVWkfYa9zJMuV2ZPKZFb
	pjq5zn/KMV6ZpsH9KAUW7voIBvxxyB24CLqBv/+WeeeAzixmPpGRF1vAfcTaZqQbEAmlwmpKdk6
	2jxQinfl11/t46FUv5B8ucnxGy6m3nNhKOe5b9U/jpP5lgvDKundacvmfVwkJQj4uJBZECrBWSW
	m0vsVzi/34qVY1+7j0PAzfMhp0nEBJjgXD4mGNTjuk9ZAeyoK6keJqt8EnC85LrE5c+IwYK6Sqo
	WIhIAAv6tqHqyeqXduR6YqQMRkX2Ufc0v8EwPMBPaBSTu9jb5HCfZHc9S1NWmhyi0idq5PY8VFn
	7MA4IT0JdOJpGEjRRnyK71Hly3FVP4sJQ73aOJx1ym09dD3FfmQAcvnsrY0tkZWrPnCXE=
X-Received: by 2002:a5d:64e4:0:b0:43b:62fa:e3f0 with SMTP id ffacd0b85a97d-43b88a412demr5193554f8f.48.1774447240632;
        Wed, 25 Mar 2026 07:00:40 -0700 (PDT)
Received: from ?IPV6:2001:a61:133b:9b01:43bc:b3f1:9314:a074? ([2001:a61:133b:9b01:43bc:b3f1:9314:a074])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919588e6sm26962f8f.16.2026.03.25.07.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 07:00:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1yEP53Q3CfXksYtD5PrZk6EE"
Message-ID: <59b2c482-06b4-48e6-addc-ba585b580006@suse.com>
Date: Wed, 25 Mar 2026 15:00:32 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Martin Kepplinger <martink@posteo.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: regarding runtime PM in pegasus_notetaker

This is a multi-part message in MIME format.
--------------1yEP53Q3CfXksYtD5PrZk6EE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the driver takes a PM reference in open(), yet it marks
the device busy in pegasus_irq(). These approaches contradict
each other. There is no point in marking a device as busy
while its PM count is elevated. It will not be runtime suspended
anyway.

Did you mean for the device to be subjected to runtime PM
while in use? If so, could you test the attached patch?

	Regards
		Oliver

--------------1yEP53Q3CfXksYtD5PrZk6EE
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hid-pegasus_notetaker-runtime-PM-while-open.patch"
Content-Disposition: attachment;
 filename="0001-hid-pegasus_notetaker-runtime-PM-while-open.patch"
Content-Transfer-Encoding: base64

RnJvbSA2MmU4ZmFmNTA5ZTJhZDQ2NGIzOWI2YmY3YmMzMjRkNmQ5M2M1MGQ1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgpEYXRlOiBXZWQsIDI1IE1hciAyMDI2IDE0OjU4OjMyICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gaGlkOiBwZWdhc3VzX25vdGV0YWtlcjogcnVudGltZSBQTSB3aGlsZSBvcGVuCgpUaGlz
IGltcGxlbWVudHMgcnVudGltZSBQTSB3aGlsZSB0aGUgZGV2aWNlIGlzIG9wZW4KYnkgZHJv
cHBpbmcgdGhlIHJlZmVyZW5jZSBpbiBvcGVuIGFuZCB1c2luZyByZW1vdGUKd2FrZXVwLgoK
U2lnbmVkLW9mZi1ieTogT2xpdmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KLS0tCiBk
cml2ZXJzL2lucHV0L3RhYmxldC9wZWdhc3VzX25vdGV0YWtlci5jIHwgMjUgKysrKysrKysr
KysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RhYmxldC9wZWdhc3Vz
X25vdGV0YWtlci5jIGIvZHJpdmVycy9pbnB1dC90YWJsZXQvcGVnYXN1c19ub3RldGFrZXIu
YwppbmRleCA0Y2UyMGJlZmM2NTcuLjNhODQ5M2VkNWU0NCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9pbnB1dC90YWJsZXQvcGVnYXN1c19ub3RldGFrZXIuYworKysgYi9kcml2ZXJzL2lucHV0
L3RhYmxldC9wZWdhc3VzX25vdGV0YWtlci5jCkBAIC0yMTEsMTAgKzIxMSwyMSBAQCBzdGF0
aWMgdm9pZCBwZWdhc3VzX2luaXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCXN0cnVj
dCBwZWdhc3VzICpwZWdhc3VzID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBwZWdhc3Vz
LCBpbml0KTsKIAlpbnQgZXJyb3I7CiAKKwllcnJvciA9IHVzYl9hdXRvcG1fZ2V0X2ludGVy
ZmFjZShwZWdhc3VzLT5pbnRmKTsKKwlpZiAoZXJyb3IpCisJCWdvdG8gYmFpbDsKIAllcnJv
ciA9IHBlZ2FzdXNfc2V0X21vZGUocGVnYXN1cywgUEVOX01PREVfWFksIE5PVEVUQUtFUl9M
RURfTU9VU0UpOwogCWlmIChlcnJvcikKLQkJZGV2X2VycigmcGVnYXN1cy0+dXNiZGV2LT5k
ZXYsICJwZWdhc3VzX3NldF9tb2RlIGVycm9yOiAlZFxuIiwKLQkJCWVycm9yKTsKKwkJZ290
byBiYWlsX3BtOworCisJdXNiX2F1dG9wbV9wdXRfaW50ZXJmYWNlKHBlZ2FzdXMtPmludGYp
OworCXJldHVybjsKKworYmFpbF9wbToKKwl1c2JfYXV0b3BtX3B1dF9pbnRlcmZhY2UocGVn
YXN1cy0+aW50Zik7CitiYWlsOgorCWRldl9lcnIoJnBlZ2FzdXMtPnVzYmRldi0+ZGV2LCAi
cGVnYXN1c19zZXRfbW9kZSBlcnJvcjogJWRcbiIsCisJCWVycm9yKTsKIH0KIAogc3RhdGlj
IGludCBfX3BlZ2FzdXNfb3BlbihzdHJ1Y3QgcGVnYXN1cyAqcGVnYXN1cykKQEAgLTI0OSwx
MiArMjYwLDEwIEBAIHN0YXRpYyBpbnQgcGVnYXN1c19vcGVuKHN0cnVjdCBpbnB1dF9kZXYg
KmRldikKIAkJcmV0dXJuIGVycm9yOwogCiAJZXJyb3IgPSBfX3BlZ2FzdXNfb3BlbihwZWdh
c3VzKTsKLQlpZiAoZXJyb3IpIHsKLQkJdXNiX2F1dG9wbV9wdXRfaW50ZXJmYWNlKHBlZ2Fz
dXMtPmludGYpOwotCQlyZXR1cm4gZXJyb3I7Ci0JfQorCXBlZ2FzdXMtPmludGYtPm5lZWRz
X3JlbW90ZV93YWtldXAgPSAxOworCXVzYl9hdXRvcG1fcHV0X2ludGVyZmFjZShwZWdhc3Vz
LT5pbnRmKTsKIAotCXJldHVybiAwOworCXJldHVybiBlcnJvcjsKIH0KIAogc3RhdGljIHZv
aWQgcGVnYXN1c19jbG9zZShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpCkBAIC0yNjcsOCArMjc2
LDYgQEAgc3RhdGljIHZvaWQgcGVnYXN1c19jbG9zZShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYp
CiAKIAkJcGVnYXN1cy0+aXNfb3BlbiA9IGZhbHNlOwogCX0KLQotCXVzYl9hdXRvcG1fcHV0
X2ludGVyZmFjZShwZWdhc3VzLT5pbnRmKTsKIH0KIAogc3RhdGljIGludCBwZWdhc3VzX3By
b2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAotLSAKMi41My4wCgo=

--------------1yEP53Q3CfXksYtD5PrZk6EE--
