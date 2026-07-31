Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B54C97;
	Fri, 31 Jul 2026 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785462411; cv=none; b=irer2DDtbxrsfxz89aZuZl8LAneGJazZAwwtaif6giIv26NhCmwPvBdSCDqpd7pFDa6Rzp7mUV4pNLos7vCVZaG1wGcDFMmR7EZ8eSQd8E+OE+OOsVTj0MiZ93oRHOTiMKVwvwClig7/P1ipJnwtcQsRxbwv0Y2kgXx9v2YXx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785462411; c=relaxed/simple;
	bh=dL9QAb97yUFgHwW6kMYPCrFYvg/lVrVSVQ9ny6Cr5bY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:Mime-Version:
	 Content-Type; b=Tdd/14EZYmWM/4M0PfljFxrZq8ovyyXOxpU+gLhsvQQzIN01M4gd1adJdGjKnM9pqfavKpyKSFESgqqFj4BocYmGZcQWJv+v4zt6JCeW7ORX0AzywfGSVas4JtnntkAsCq312dGJOTqKanvoZVc1C0bPr7AwO4DAzec8wB3JVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MnVPv6cG; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MnVPv6cG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785462405;
	bh=dL9QAb97yUFgHwW6kMYPCrFYvg/lVrVSVQ9ny6Cr5bY=;
	h=Date:From:To:Cc:Subject:References;
	b=MnVPv6cGJznmQybyFpaghUdbCp4WK1pOsSJPZr/z85pYLznmekQ4eYEIPtG+pr2wZ
	 Rlhxf7DMZopzvlxbgmjs+z9+PbOj53/2tFbPc7DzMX+vQ5w3y0e60kEJEW/dAA/b9A
	 LxlbH6JpxBhZoxoLillUOyZMF0Vjwb43sZijZXTs=
Received: from PC-20201120SBOH ([183.205.156.133])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id BAB3408D; Fri, 31 Jul 2026 09:46:43 +0800
X-QQ-mid: xmsmtpt1785462403t1qvh7idy
Message-ID: <tencent_6754CC7275468D3928F24E966C0F6682CA09@qq.com>
X-QQ-XMAILINFO: OCJRm0Z9FmoLdvNEubqO3DEA9A3zkER5I3zCVS4LQObHH0LhfXpTrk8WQZKQSl
	 tUdmIwNjef5gKBFZJn8ykiFj7wLF+n7VpI43xNMrxG7pf8xllpGsMY7VLGFjkGc5N6teLvEqDNxO
	 +2SvVfC/qrpURk5lj6uXEKH9BH+ol4WFrpAimSA5NxDhgNP+OJxxMozNJMbwXOgBMIBtqd9gEGaP
	 kMBDwrtgAz8PHbGa1TlP2Sare9RhPlWpfjpFc/hR6Bo3O742i2QHK613nwMoEA390oqRzKrVgK00
	 dYQOikAp9neOWG3R/zgr524fMH8afy+GzeZd1tHT8Dt39yah8WTQ/qmNhDOpycDlVV+ELz5aVWeY
	 WQTO+jDEAB0roLSJKq7YmsXg3uhnO6QU6b7GWqOeQ6Re3+Ir3eEaoVjITK2Ufkq05cru7z4Q1dY8
	 VAGo8uIN4xt4vzU8UlqrP+NWVFFGHx/MORJNR2c9+S2yolSTW9167RVfoBz816SGPaDjJpoiGgQx
	 GzdjI/lYbj/ikXbHUkrh8xsR/O+p+eY5ytI4ZlbxAQrE7EIhypP8k4KLdE25LWXsqYxuaal+29BY
	 /F0O135dGHnFXl1kCzzSFgxLd5pUJ1aZksXykwpuD4Yvzc7AGsgoHgMYR2cKtOjpJM83FXBIv1od
	 Dul7iNS2lmRnnC6+TunmMfvPlC0EoHeOc6MTp0yZUq0/7k7gmqXdcU9KRasYVSOp8gpcJM5e0sMD
	 46nIgXbQmRfg+U3ZDGwRjzFq+hPhEH7n2S1wJv8WzrM0jXQwSF+itHCXCNI0Shp1Y7+py4MBkvrR
	 AYApboHtQdTKKS+h4/ScBDG8vv30NvZL76q/ckja9eh70sU32bP3TnGLKhZpuwWT5FlQmkBrIzuq
	 abI0uBXxJ4NReVSeP9+ryhyD93nm/MnMFKVruI31XCxQoLA2xokymffZvlNDw+p9lXtEktiDWafn
	 Qb9FnC4EGHbnAfxnttbVCmflWjp+QRtJYPF2SPFqgJweyysLbgOY4x0GBJrSteaFdKKhMgY7+p7Q
	 OFT7MLBjBeUsbvNmpfIboGyBvFgiskVj2bb1CZo4fXAlxB9kBl9pY6ymFhiLwQ1tTmK+p3FafpRS
	 S69z3mC/NFCiZ+k881U/niVRavicFpnqyPSP1g9SkDdcaj58I=
X-QQ-XMRINFO: NhdyCYpGN2QZgIk8Xr6nAodVymhHjOEfnQ==
Date: Fri, 31 Jul 2026 09:46:43 +0800
From: "grayhat@foxmail.com" <grayhat@foxmail.com>
To: "srinivas pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	gregkh <gregkh@linuxfoundation.org>, 
	"Zhang Lixu" <lixu.zhang@intel.com>
Cc: "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	linux-input <linux-input@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to MAX_HID_DEVICES
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>, 
	<e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>
X-Priority: 3
X-GUID: 9A92D098-8F04-436D-A951-1258AD5FF3AF
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-OQ-MSGID: <202607310946425901887@foxmail.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VGhhbmtzLCArTGl4dSBub3RlZC4KCkNvcnJlY3RlZCB0YWcgYmxvY2s6CgpUaGlzIHBhdGNoIHdh
cyBkcmFmdGVkIHdpdGggQUkgYXNzaXN0YW5jZS4KCkZpeGVzOiAwYjI4Y2I0YmNiMTcgKCJISUQ6
IGludGVsLWlzaC1oaWQ6IElTSCBISUQgY2xpZW50IGRyaXZlciIpCkNjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFNoZW4gWW9uZ2NoYW8gPGdyYXloYXRAZm94bWFpbC5j
b20+CkFzc2lzdGVkLWJ5OiBIZXJtZXM6a2ltaS1rMwoKTGV0IG1lIGtub3cgaWYgeW91IHdhbnQg
aXQgcmVzZW50IGFzIGEgcHJvcGVyIFtQQVRDSCB2Ml0uCgpUaGFua3MsClNoZW4gWW9uZ2NoYW8K
CgoKPitMaXh1CgoKCj4KCgoKPk9uIFRodSwgMjAyNi0wNy0zMCBhdCAyMDoyNSArMDgwMCwgU2hl
biBZb25nY2hhbyB3cm90ZToKCgoKPj4gVGhlIEhPU1RJRl9ETV9FTlVNX0RFVklDRVMgcmVzcG9u
c2UgaGFuZGxlciB0YWtlcyB0aGUgSElEIGRldmljZQoKCgo+PiBjb3VudCBmcm9tIHRoZSBmaXJz
dCBwYXlsb2FkIGJ5dGUgb2YgdGhlIElTSCBmaXJtd2FyZSByZXNwb25zZQoKCgo+PiAobWF4IDI1
NSkgYW5kIHN0b3JlcyBpdCBpbiBoaWRfZGV2X2NvdW50IHdpdGhvdXQgYW55IGJvdW5kcwoKCgo+
PiBjaGVjay7CoCBUaGlzIHZhbHVlIHByb3BhZ2F0ZXMgdG8gbnVtX2hpZF9kZXZpY2VzIGFuZCBp
cyB1c2VkIHRvCgoKCj4+IGluZGV4IGZpdmUgZml4ZWQtc2l6ZSBhcnJheXMgaW4gc3RydWN0IGlz
aHRwX2NsX2RhdGEKCgoKPj4gKE1BWF9ISURfREVWSUNFUyA9IDMyKTogcmVwb3J0X2Rlc2NyW10s
IHJlcG9ydF9kZXNjcl9zaXplW10sCgoKCj4+IGhpZF9zZW5zb3JfaHVic1tdLCBoaWRfZGVzY3Jb
XSwgYW5kIGhpZF9kZXNjcl9zaXplW10uCgoKCj4+IAoKCgo+PiBJZiB0aGUgZmlybXdhcmUgcmVw
b3J0cyBtb3JlIHRoYW4gMzIgZGV2aWNlcywgaGlkX2lzaHRwX2NsX2luaXQoKQoKCgo+PiB3cml0
ZXMgcGFzdCBhbGwgZml2ZSBhcnJheXMsIGNvcnJ1cHRpbmcgc3Vic2VxdWVudCBzdHJ1Y3QgZmll
bGRzCgoKCj4+IChpbmNsdWRpbmcgd29ya19zdHJ1Y3QgbWVtYmVycyB3aXRoIGVtYmVkZGVkIGZ1
bmN0aW9uIHBvaW50ZXJzKQoKCgo+PiBhbmQgcG90ZW50aWFsbHkgYWRqYWNlbnQgaGVhcCBvYmpl
Y3RzLgoKCgo+PiAKCgoKPj4gQ2xhbXAgaGlkX2Rldl9jb3VudCB0byBNQVhfSElEX0RFVklDRVMg
YXQgdGhlIHNpbmdsZSBwb2ludCB3aGVyZQoKCgo+PiBpdCBlbnRlcnMgdGhlIGRyaXZlciAocHJv
Y2Vzc19yZWN2LCBFTlVNX0RFVklDRVMgYnJhbmNoKSwgd2hpY2gKCgoKPj4gY292ZXJzIGJvdGgg
dGhlIHByb2JlIGFuZCB0aGUgcmVzZXQgcGF0aHMuCgoKCj4+IAoKCgo+PiBUaGlzIGlzIGEgZGF0
YS12YWxpZGF0aW9uIGhhcmRlbmluZyBmaXg6IHRoZSBJU0ggZmlybXdhcmUgaXMKCgoKPj4gd2l0
aGluIHRoZSBwbGF0Zm9ybSB0cnVzdCBib3VuZGFyeSAobG9hZGVkIHZpYSBDU01FKS4KCgoKPj4g
CgoKCj4+IFRoaXMgcGF0Y2ggd2FzIGRyYWZ0ZWQgd2l0aCBBSSBhc3Npc3RhbmNlOyB0aGUgdnVs
bmVyYWJpbGl0eQoKCgo+PiBhbmFseXNpcyBhbmQgc291cmNlLWxldmVsIHZlcmlmaWNhdGlvbiB3
ZXJlIGRvbmUgbWFudWFsbHkuCgoKCj4+IAoKCgo+PiBTaWduZWQtb2ZmLWJ5OiBTaGVuIFlvbmdj
aGFvIDxncmF5aGF0QGZveG1haWwuY29tPgoKCgo+PiBGaXhlczogMGIyOGNiNGJjYjE3ICgiSElE
OiBpbnRlbC1pc2gtaGlkOiBJU0ggSElEIGNsaWVudCBkcml2ZXIiKQoKCgo+PiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwoKCgo+CgoKCj5NaXNzaW5nCgoKCj4KCgoKPkFzc2lzdGVkLWJ5OiBB
R0VOVF9OQU1FOk1PREVMX1ZFUlNJT04gW1RPT0wxXSBbVE9PTDJdCgoKCj4KCgoKPgoKCgo+VGhh
bmtzLAoKCgo+U3Jpbml2YXMKCgoKPgoKCgo+PiAtLS0KCgoKPj4gwqBkcml2ZXJzL2hpZC9pbnRl
bC1pc2gtaGlkL2lzaHRwLWhpZC1jbGllbnQuYyB8IDIgKysKCgoKPj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgoKCj4+IAoKCgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQv
aW50ZWwtaXNoLWhpZC9pc2h0cC1oaWQtY2xpZW50LmMKCgoKPj4gYi9kcml2ZXJzL2hpZC9pbnRl
bC1pc2gtaGlkL2lzaHRwLWhpZC1jbGllbnQuYwoKCgo+PiBpbmRleCA2ZDY0MDA4Li5YWFhYWFhY
IDEwMDY0NAoKCgo+PiAtLS0gYS9kcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lzaHRwLWhpZC1j
bGllbnQuYwoKCgo+PiArKysgYi9kcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lzaHRwLWhpZC1j
bGllbnQuYwoKCgo+PiBAQCAtMTIzLDYgKzEyMyw4IEBAIHN0YXRpYyB2b2lkIHByb2Nlc3NfcmVj
dihzdHJ1Y3QgaXNodHBfY2wKCgoKPj4gKmhpZF9pc2h0cF9jbCwgdm9pZCAqcmVjdl9idWYsCgoK
Cj4+IMKgCQkJCWJyZWFrOwoKCgo+PiDCoAkJCX0KCgoKPj4gwqAJCQljbGllbnRfZGF0YS0+aGlk
X2Rldl9jb3VudCA9ICh1bnNpZ25lZAoKCgo+PiBpbnQpKnBheWxvYWQ7CgoKCj4+ICsJCQlpZiAo
Y2xpZW50X2RhdGEtPmhpZF9kZXZfY291bnQgPgoKCgo+PiBNQVhfSElEX0RFVklDRVMpCgoKCj4+
ICsJCQkJY2xpZW50X2RhdGEtPmhpZF9kZXZfY291bnQgPQoKCgo+PiBNQVhfSElEX0RFVklDRVM7
CgoKCj4+IMKgCQkJaWYgKCFjbGllbnRfZGF0YS0+aGlkX2RldmljZXMpCgoKCj4+IMKgCQkJCWNs
aWVudF9kYXRhLT5oaWRfZGV2aWNlcyA9CgoKCj4+IGRldm1fa2NhbGxvYygKCgoKPj4gwqAJCQkJ
CQljbF9kYXRhX3RvX2RldihjbGllbgoKCgo+PiB0X2RhdGEpLAoKCg==

