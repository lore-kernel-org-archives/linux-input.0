Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586B262FD0
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064572; cv=none; b=HfiVGbXoQBCRsex0C7nkeAc58QHzJluOOBOlXo2lsGAl+1361UxyJ2slTTZmbrU8eYyeIqzQszZ2ZcmfB99672o7FXzbzSNZPAfLc9r6p0Ccv8C/1TwM5eiOFijVqjcMvSquMViWCkEAqU8GsAJdq9b6BYIYpLVc5K45T4MtJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064572; c=relaxed/simple;
	bh=AweUXpMQM6uSMbnLjboQLcjyiZU50RtXcCJdALmuW3M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=h28/J4EGKYVKXhX1Cc6Pf4iCsRAXCBxbW+Q61cuXevDm0Eftnoe84KrJaua/sl6b37IeTl3RNdZwViXQRDqmXSnu6yggSdCSmXn0ozCdFjbhG60Mrg3gcqo7l29YcZ/Rn4zAnfsImEz2ktrhSPPNik5nVgRMSeW4b75FWsumnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Oy9KaC5S; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Oy9KaC5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1781064556; x=1781323756;
	bh=AweUXpMQM6uSMbnLjboQLcjyiZU50RtXcCJdALmuW3M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Oy9KaC5SiVYMafkd8vtkp62TpwGl+XmoS7psFqbv+f9fqa7EoHoATuQ8FrIGURfGA
	 3X3eJwv81ftJRZkJZdJgQjKnwY7sfgjaVOVIVa3sCCdb3bPETIsmT2fZkebu34ZNk3
	 XA7ZsX3LmbJ3zgC6jpjdRC+BzefoNaDuYfKqAspCjmE0ovQ5nqmn33Hb2BnVUOymi/
	 bSC/3o1zQFgllbCpNClkkhQ+I68uwnl0t6SMLDi9OzTWYKgnF2diOXTeSoSd8TwnQM
	 1J+TfEOUFw/4T4KioPc8ayAnUjeZ+0UpScnsP2gtz56XOiW6Sr/EEH+uvBvj6OtNll
	 /3jf6Ag+aeDeQ==
Date: Wed, 10 Jun 2026 04:09:12 +0000
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: TheDragonWhoAte <TheDragonWhoAte@protonmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: add quirk for IBM SK-8845 keyboard
Message-ID: <UL8kz0PEs3tCPPUaukHYg_M3ZVCyfNOrGj8zm1XeTIlX4EQ6Euw3kEa2NHqkqpfY4IiEiCz4ktDRoI-e1AKq-yvSUarSAL3_Af0pbWs-U8o=@protonmail.com>
Feedback-ID: 82532079:user:proton
X-Pm-Message-ID: 58e9e01a91de9a2dba118fa99e59782f2b7c837e
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_X4vCAvU9jRBPoDnOTZhavAAtVjsnpuKR8g1ekiWw9s"

--b1=_X4vCAvU9jRBPoDnOTZhavAAtVjsnpuKR8g1ekiWw9s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

HID: add quirk for IBM SK-8845 keyboard

The TrackPoint on the IBM SK-8845 (Synaptics 06cb:0009) sends corrupted
input events when bound to the synaptics_usb driver. Moving the stick
generates random BTN_LEFT/BTN_RIGHT/BTN_MIDDLE events instead of
REL_X/REL_Y movement.

Force the device to bind to hid-generic instead by setting
HID_QUIRK_IGNORE_SPECIAL_DRIVER.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221624

Note: This quirk disables two-finger scrolling on the touchpad. That's a tr=
ade-off, but without it the TrackPoint is completely unusable. The real fix=
 would be to make synaptics_usb handle this device properly, so both the to=
uchpad gestures and the TrackPoint work. That's beyond this patch.

Signed-off-by: TheDragonWhoAte <TheDragonWhoAte@protonmail.com>
--b1=_X4vCAvU9jRBPoDnOTZhavAAtVjsnpuKR8g1ekiWw9s
Content-Type: text/x-patch; name=0001-HID-add-quirk-for-IBM-SK-8845-keyboard.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-HID-add-quirk-for-IBM-SK-8845-keyboard.patch

RnJvbSAwYmMzOGQ3ZmFjNjVkYzA3ZjQ4ZTA3NDEzMDMyOTkyNGFkZjU3NDRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB0aGVkcmFnb253aG9hdGUgPHRoZWRyYWdvbndob2F0ZUBwcm90
b25tYWlsLmNvbT4KRGF0ZTogV2VkLCAxMCBKdW4gMjAyNiAwNjozODowMyArMDMwMApTdWJqZWN0
OiBbUEFUQ0hdIEhJRDogYWRkIHF1aXJrIGZvciBJQk0gU0stODg0NSBrZXlib2FyZApUbzogbGlu
dXgtaW5wdXRAdmdlci5rZXJuZWwub3JnCgpUaGUgVHJhY2tQb2ludCBvbiB0aGUgSUJNIFNLLTg4
NDUgKFN5bmFwdGljcyAwNmNiOjAwMDkpIHNlbmRzIGNvcnJ1cHRlZAppbnB1dCBldmVudHMgd2hl
biBib3VuZCB0byB0aGUgc3luYXB0aWNzX3VzYiBkcml2ZXIuIE1vdmluZyB0aGUgc3RpY2sKZ2Vu
ZXJhdGVzIHJhbmRvbSBCVE5fTEVGVC9CVE5fUklHSFQvQlROX01JRERMRSBldmVudHMgaW5zdGVh
ZCBvZgpSRUxfWC9SRUxfWSBtb3ZlbWVudC4KCkZvcmNlIHRoZSBkZXZpY2UgdG8gYmluZCB0byBo
aWQtZ2VuZXJpYyBpbnN0ZWFkIGJ5IHNldHRpbmcKSElEX1FVSVJLX0lHTk9SRV9TUEVDSUFMX0RS
SVZFUi4KCkxpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
MjIxNjI0CgpOb3RlOiBUaGlzIHF1aXJrIGRpc2FibGVzIHR3by1maW5nZXIgc2Nyb2xsaW5nIG9u
IHRoZSB0b3VjaHBhZC4gVGhhdCdzIGEgdHJhZGUtb2ZmLCBidXQgd2l0aG91dCBpdCB0aGUgVHJh
Y2tQb2ludCBpcyBjb21wbGV0ZWx5IHVudXNhYmxlLiBUaGUgcmVhbCBmaXggd291bGQgYmUgdG8g
bWFrZSBzeW5hcHRpY3NfdXNiIGhhbmRsZSB0aGlzIGRldmljZSBwcm9wZXJseSwgc28gYm90aCB0
aGUgdG91Y2hwYWQgZ2VzdHVyZXMgYW5kIHRoZSBUcmFja1BvaW50IHdvcmsuIFRoYXQncyBiZXlv
bmQgdGhpcyBwYXRjaC4KClNpZ25lZC1vZmYtYnk6IHRoZWRyYWdvbndob2F0ZSA8dGhlZHJhZ29u
d2hvYXRlQHByb3Rvbm1haWwuY29tPgotLS0KIGRyaXZlcnMvaGlkL2hpZC1xdWlya3MuYyB8IDEg
KwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9o
aWQvaGlkLXF1aXJrcy5jIGIvZHJpdmVycy9oaWQvaGlkLXF1aXJrcy5jCmluZGV4IDU3ZDhlZmRk
OS4uYzgzOTRiODk2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2hpZC9oaWQtcXVpcmtzLmMKKysrIGIv
ZHJpdmVycy9oaWQvaGlkLXF1aXJrcy5jCkBAIC0yMDMsNiArMjAzLDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBoaWRfZGV2aWNlX2lkIGhpZF9xdWlya3NbXSA9IHsKIAl7IEhJRF9VU0JfREVWSUNF
KFVTQl9WRU5ET1JfSURfU1lOQVBUSUNTLCBVU0JfREVWSUNFX0lEX1NZTkFQVElDU19UUF9WMTAz
KSwgSElEX1FVSVJLX05PX0lOSVRfUkVQT1JUUyB9LAogCXsgSElEX1VTQl9ERVZJQ0UoVVNCX1ZF
TkRPUl9JRF9TWU5BUFRJQ1MsIFVTQl9ERVZJQ0VfSURfU1lOQVBUSUNTX0RFTExfSzEyQSksIEhJ
RF9RVUlSS19OT19JTklUX1JFUE9SVFMgfSwKIAl7IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1Jf
SURfU1lOQVBUSUNTLCBVU0JfREVWSUNFX0lEX1NZTkFQVElDU19ERUxMX0sxNUEpLCBISURfUVVJ
UktfTk9fSU5JVF9SRVBPUlRTIH0sCisJeyBISURfVVNCX0RFVklDRShVU0JfVkVORE9SX0lEX1NZ
TkFQVElDUywgVVNCX0RFVklDRV9JRF9TWU5BUFRJQ1NfQ09NUF9UUCksIEhJRF9RVUlSS19JR05P
UkVfU1BFQ0lBTF9EUklWRVIgfSwKIAl7IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfVE9Q
TUFYLCBVU0JfREVWSUNFX0lEX1RPUE1BWF9DT0JSQVBBRCksIEhJRF9RVUlSS19CQURQQUQgfSwK
IAl7IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfVE9VQ0hQQUNLLCBVU0JfREVWSUNFX0lE
X1RPVUNIUEFDS19SVFMpLCBISURfUVVJUktfTVVMVElfSU5QVVQgfSwKIAl7IEhJRF9VU0JfREVW
SUNFKFVTQl9WRU5ET1JfSURfVFBWLCBVU0JfREVWSUNFX0lEX1RQVl9PUFRJQ0FMX1RPVUNIU0NS
RUVOXzg4ODIpLCBISURfUVVJUktfTk9HRVQgfSwKLS0gCjIuNTQuMAoK

--b1=_X4vCAvU9jRBPoDnOTZhavAAtVjsnpuKR8g1ekiWw9s--

