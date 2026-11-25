Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596654;
	b=ujAc5+FUG406Ft+mZa+nnRpagtmO0s0VMZaxVDNwvynsyNht/rUoctP4/PtMAfoL5IWa
	 qW9x/OhURO8+BpevUSZrw1vZpd9ZO1nJIdNhpubV9wNXUJfYevgXnIJYBi17ZIpKkjzDz
	 edLXg7R/Y0xGOz6sEH20MRcweYmOrpIGzmkUzqXFDXE1WSVtGCSlWriVIwos8pwgXtC4l
	 5SVpjh+6g62XY6ffdprmZNM8YvVd+1zRjFdsHEH0l6l4tLmQh05l7OCCBorXmylpLC9H3
	 QOseP1m+I7WKcoqxK7mXf0RosZz+VyTsS1y863m4aZDJcqp4xNwzPgEcE6XX8d98NWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596654;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID;
	bh=B0SJsFZV0a5wllgRfV5Waxxxpu1Y4+yXIRfE8JJlUf4=;
	b=Wdy2KFW46vR8NAIaBBcU/nf+zG7/REDUBtlCxWOJH1pQHJSomSCov40lqllYoNqBt9CR
	 cpDzK2FIq+I5FsMxfliOu2dAN0sh0jF6xFJKtuJZidrEHlbKpM+XN17ypqNNiHwwZsBlz
	 Y3np2bPIGLoug8WaGPXzpWUDSAod2qUyvKkn1FOMYxPIusxeMHraq+5OvoDxzCkAanemY
	 3tfxDTuyKIWnwdG0k4K/7vtl7ou8Zgy36UHt2E9ZCk3fYRBSVvOqNh0zarwyYRzXVO0ai
	 IkwnNZ+XFdyHNigRJioxy4sPYLYwjBme1KUplKRfVeGFVByj0dtGfSO9XPSZb9ROQvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tutamail.com;
	spf=pass smtp.mailfrom=tutamail.com;
	dkim=pass header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=yQ+aWTVR;
	arc=none smtp.remote-ip=185.205.69.213
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AF606A31E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 08:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E7AF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=yQ+aWTVR
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 876A01ABA4CBB
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 09:50:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1795596651;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=B0SJsFZV0a5wllgRfV5Waxxxpu1Y4+yXIRfE8JJlUf4=;
	b=yQ+aWTVRMeHc9QUN2mL+BkvDZWDA6tVpOj1TiUMiUKL6l6GkZjgRgj+WOIAHYaTI
	5xkf/EpN1i2DwxGPb5EIOG08NGCEM2ha1dyRdGZjbIkRVsETIUnflaOdmoJ3L8f1ieO
	goWdKzNI45zB9rSu/T5K/KQnvwm/9cYEi3vqphtvhdvNB/GtFSOEql2wnuoMTckVs3X
	ThMdZcZlC3U/QTZ87I6yYOgjBYSX/shdLdoxCP9PHSA0+tir2EQd3YkvFT4yPcimNhs
	kq9qS8i+IBPjCvtHXyJ1IPGiqD9MZl9nQgetPKzex/QyrsBmiQxSz0U504iQQJc7mro
	XjQI4kHKGg==
Date: Wed, 25 Nov 2026 09:50:51 +0100 (CET)
From: willowswaving@tutamail.com
To: Linux Input <linux-input@vger.kernel.org>
Cc: Jikos <jikos@kernel.org>, Bentiss <bentiss@kernel.org>
Message-ID: <P7GtZql--F-9@tutamail.com>
In-Reply-To: <P7GsBwf--R-9@tutamail.com>
References: <P46njqS--N-9@tutamail.com> <P4DHMrF--F-9@tutamail.com> <P5pmaU5--J-9@tutamail.com> <P5psz0r--F-9@tutamail.com> <P7GsBwf--R-9@tutamail.com>
Subject: Re: FWD: [RFC] HID: uclogic: Add support for Xencelabs Pen Display
 (28bd:520d) and request for switch-to-vendor-mode sequence
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
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 015fe4ab774a31809b4b05b8c610ead356bcc03e5c866e6007fd3e8866c7c0a22bb5af78b76e2b2d682867fe72df3c2e2eae226386f9c0a8fc7fe2cb63b896dd32:TurnOnPrivacy!:tutamail

Update: The manufacturer reflashed the firmware. The device PID is now chan=
ged to=C2=A028bd:520a. The hardware is working and is sending raw HID repor=
ts without needing any magic-byte switching.=C2=A0 It seems we just need to=
 add the 520a PID to hid-uclogic and provide the correct report descriptor =
mapping.

Below is the hexdump information for your reference:

Thanks again for taking your time and energy!!
Regards,
Willows
00000240  02 a0 d8 9f c2 85 00 00  00 00 00 00 47 38 43 35  |............G8=
C5|00000250  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |...........=
.....|00000260  02 a0 e1 9f 13 86 00 00  00 00 00 00 47 38 43 35  |........=
....G8C5|00000270  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.....=
...........|00000280  02 a0 e6 9f 34 86 00 00  00 00 00 00 47 38 43 35  |..=
..4.......G8C5|00000290  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
|................|000002a0  02 a0 fe 9f af 86 00 00  00 00 00 00 47 38 43 3=
5  |............G8C5|000002b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 0=
0 00  |................|000002c0  02 a0 1a a0 86 87 00 00  00 00 00 00 47 3=
8 43 35  |............G8C5|000002d0  00 00 00 00 00 00 00 00  00 00 00 00 0=
0 00 00 00  |................|000002e0  02 a0 23 a0 c1 87 00 00  00 00 00 0=
0 47 38 43 35  |..#.........G8C5|000002f0  00 00 00 00 00 00 00 00  00 00 0=
0 00 00 00 00 00  |................|00000300  02 a0 2d a0 f0 87 00 00  00 0=
0 00 00 47 38 43 35  |..-.........G8C5|00000310  00 00 00 00 00 00 00 00  0=
0 00 00 00 00 00 00 00  |................|00000320  02 a0 36 a0 59 88 00 00=
  00 00 00 00 47 38 43 35  |..6.Y.......G8C5|00000330  00 00 00 00 00 00 00=
 00  00 00 00 00 00 00 00 00  |................|00000340  02 a0 3b a0 7b 88=
 00 00  00 00 00 00 47 38 43 35  |..;.{.......G8C5|00000350  00 00 00 00 00=
 00 00 00  00 00 00 00 00 00 00 00  |................|00000360  02 a0 3f a0=
 a1 88 00 00  00 00 00 00 47 38 43 35  |..?.........G8C5|00000370  00 00 00=
 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000380  02 a0=
 44 a0 d0 88 00 00  00 00 00 00 47 38 43 35  |..D.........G8C5|00000390  00=
 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000003a0 =
 02 a0 3f a0 07 89 00 00  00 00 00 00 47 38 43 35  |..?.........G8C5|000003=
b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000=
003c0  02 a0 3b a0 28 89 00 00  00 00 00 00 47 38 43 35  |..;.(.......G8C5|=
000003d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|000003e0  02 a0 36 a0 53 89 00 00  00 00 00 00 47 38 43 35  |..6.S......=
.G8C5|000003f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |........=
........|00000400  02 a0 31 a0 74 89 00 00  00 00 00 00 47 38 43 35  |..1.t=
.......G8C5|00000410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..=
..............|00000420  02 a0 2d a0 9f 89 00 00  00 00 00 00 47 38 43 35  =
|..-.........G8C5|00000430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 0=
0  |................|00000440  02 a0 28 a0 b4 89 00 00  00 00 00 00 47 38 4=
3 35  |..(.........G8C5|00000450  00 00 00 00 00 00 00 00  00 00 00 00 00 0=
0 00 00  |................|00000460  02 a0 23 a0 e6 89 00 00  00 00 00 00 4=
7 38 43 35  |..#.........G8C5|00000470  00 00 00 00 00 00 00 00  00 00 00 0=
0 00 00 00 00  |................|00000480  02 a0 1e a0 0c 8a 00 00  00 00 0=
0 00 47 38 43 35  |............G8C5|00000490  00 00 00 00 00 00 00 00  00 0=
0 00 00 00 00 00 00  |................|000004a0  02 a0 1a a0 21 8a 00 00  0=
0 00 00 00 47 38 43 35  |....!.......G8C5|000004b0  00 00 00 00 00 00 00 00=
  00 00 00 00 00 00 00 00  |................|000004c0  02 a0 15 a0 3b 8a 00=
 00  00 00 00 00 47 38 43 35  |....;.......G8C5|000004d0  00 00 00 00 00 00=
 00 00  00 00 00 00 00 00 00 00  |................|000004e0  02 a0 10 a0 61=
 8a 00 00  00 00 00 00 47 38 43 35  |....a.......G8C5|000004f0  00 00 00 00=
 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000500  02 a0 15=
 a0 76 8a 00 00  00 00 00 00 47 38 43 35  |....v.......G8C5|00000510  00 00=
 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000520  02=
 a0 1a a0 83 8a 00 00  00 00 00 00 47 38 43 35  |............G8C5|00000530 =
 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000005=
40  02 a0 1e a0 8b 8a 00 00  00 00 00 00 47 38 43 35  |............G8C5|000=
00550  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|=
00000560  02 a0 23 a0 9c 8a 00 00  00 00 00 00 47 38 43 35  |..#.........G8=
C5|00000570  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |...........=
.....|00000580  02 a0 28 a0 b1 8a 00 00  00 00 00 00 47 38 43 35  |..(.....=
....G8C5|00000590  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.....=
...........|000005a0  02 a0 2d a0 b5 8a 00 00  00 00 00 00 47 38 43 35  |..=
-.........G8C5|000005b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
|................|000005c0  02 a0 31 a0 c2 8a 00 00  00 00 00 00 47 38 43 3=
5  |..1.........G8C5|000005d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 0=
0 00  |................|000005e0  02 a0 36 a0 d3 8a 00 00  00 00 00 00 47 3=
8 43 35  |..6.........G8C5|000005f0  00 00 00 00 00 00 00 00  00 00 00 00 0=
0 00 00 00  |................|00000600  02 a0 36 a0 d3 8a 00 00  00 00 00 0=
0 47 38 43 35  |..6.........G8C5|00000610  00 00 00 00 00 00 00 00  00 00 0=
0 00 00 00 00 00  |................|00000620  02 a0 36 a0 d3 8a 00 00  00 0=
0 00 00 47 38 43 35  |..6.........G8C5|00000630  00 00 00 00 00 00 00 00  0=
0 00 00 00 00 00 00 00  |................|00000640  02 a0 3f a0 e8 8a 00 00=
  00 00 00 00 47 38 43 35  |..?.........G8C5|00000650  00 00 00 00 00 00 00=
 00  00 00 00 00 00 00 00 00  |................|00000660  02 a0 3f a0 e8 8a=
 00 00  00 ff 00 00 47 38 43 35  |..?.........G8C5|00000670  00 00 00 00 00=
 00 00 00  00 00 00 00 00 00 00 00  |................|00000680  02 a0 3f a0=
 e8 8a 00 00  00 ff 00 00 47 38 43 35  |..?.........G8C5|00000690  00 00 00=
 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000006a0  02 a0=
 3f a0 e8 8a 00 00  00 ff 00 00 47 38 43 35  |..?.........G8C5|000006b0  00=
 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000006c0 =
 02 a0 3f a0 e8 8a 00 00  00 ff 00 00 47 38 43 35  |..?.........G8C5|000006=
d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000=
006e0  02 a0 4d a0 f9 8a 00 00  00 ff 00 00 47 38 43 35  |..M.........G8C5|=
000006f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|00000700  02 a0 4d a0 f9 8a 00 00  00 ff 00 00 47 38 43 35  |..M........=
.G8C5|00000710  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |........=
........|00000720  02 a0 5c a0 06 8b 00 00  00 ff 00 00 47 38 43 35  |..\..=
.......G8C5|00000730  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..=
..............|00000740  02 a0 65 a0 0e 8b 00 00  00 ff 00 00 47 38 43 35  =
|..e.........G8C5|00000750  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 0=
0  |................|00000760  02 a0 65 a0 0e 8b 00 00  00 fe 00 00 47 38 4=
3 35  |..e.........G8C5|00000770  00 00 00 00 00 00 00 00  00 00 00 00 00 0=
0 00 00  |................|00000780  02 a0 7c a0 1b 8b 00 00  00 fe 00 00 4=
7 38 43 35  |..|.........G8C5|00000790  00 00 00 00 00 00 00 00  00 00 00 0=
0 00 00 00 00  |................|000007a0  02 a0 94 a0 27 8b 00 00  00 fe 0=
0 00 47 38 43 35  |....'.......G8C5|000007b0  00 00 00 00 00 00 00 00  00 0=
0 00 00 00 00 00 00  |................|000007c0  02 a0 94 a0 27 8b 00 00  0=
0 fe 00 00 47 38 43 35  |....'.......G8C5|000007d0  00 00 00 00 00 00 00 00=
  00 00 00 00 00 00 00 00  |................|000007e0  02 a0 94 a0 27 8b 00=
 00  00 fe 00 00 47 38 43 35  |....'.......G8C5|000007f0  00 00 00 00 00 00=
 00 00  00 00 00 00 00 00 00 00  |................|00000800  02 a0 a7 a0 30=
 8b 00 00  00 fe 00 00 47 38 43 35  |....0.......G8C5|00000810  00 00 00 00=
 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000820  02 a0 c8=
 a0 38 8b 00 00  00 fe 00 00 47 38 43 35  |....8.......G8C5|00000830  00 00=
 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000840  02=
 a0 da a0 3c 8b 00 00  00 fe 00 00 47 38 43 35  |....<.......G8C5|00000850 =
 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000008=
60  02 a0 fb a0 38 8b 00 00  00 fe 00 00 47 38 43 35  |....8.......G8C5|000=
00870  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|=
00000880  02 a0 13 a1 34 8b 00 00  00 fe 00 00 47 38 43 35  |....4.......G8=
C5|00000890  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |...........=
.....|000008a0  02 a0 34 a1 2c 8b 00 00  00 fe 00 00 47 38 43 35  |..4.,...=
....G8C5|000008b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.....=
...........|000008c0  02 a0 67 a1 1f 8b 00 00  00 fe 00 00 47 38 43 35  |..=
g.........G8C5|000008d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  =
|................|000008e0  02 a0 7a a1 16 8b 00 00  00 fe 00 00 47 38 43 3=
5  |..z.........G8C5|000008f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 0=
0 00  |................|00000900  02 a0 b7 a1 fd 8a 00 00  00 fe 00 00 47 3=
8 43 35  |............G8C5|00000910  00 00 00 00 00 00 00 00  00 00 00 00 0=
0 00 00 00  |................|00000920  02 a0 e1 a1 e8 8a 00 00  00 fe 00 0=
0 47 38 43 35  |............G8C5|00000930  00 00 00 00 00 00 00 00  00 00 0=
0 00 00 00 00 00  |................|00000940  02 a0 23 a2 c2 8a 00 00  00 f=
e 00 00 47 38 43 35  |..#.........G8C5|00000950  00 00 00 00 00 00 00 00  0=
0 00 00 00 00 00 00 00  |................|00000960  02 a0 57 a2 a0 8a 00 00=
  00 fe 00 00 47 38 43 35  |..W.........G8C5|00000970  00 00 00 00 00 00 00=
 00  00 00 00 00 00 00 00 00  |................|00000980  02 a0 81 a2 83 8a=
 00 00  00 fe 00 00 47 38 43 35  |............G8C5|00000990  00 00 00 00 00=
 00 00 00  00 00 00 00 00 00 00 00  |................|000009a0  02 a0 be a2=
 54 8a 00 00  00 fe 00 00 47 38 43 35  |....T.......G8C5|000009b0  00 00 00=
 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000009c0  02 a0=
 da a2 3f 8a 00 00  00 fe 00 00 47 38 43 35  |....?.......G8C5|000009d0  00=
 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000009e0 =
 02 a0 1c a3 08 8a 00 00  00 fe 00 00 47 38 43 35  |............G8C5|000009=
f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|000=
00a00  02 a0 5e a3 cd 89 00 00  00 fe 00 00 47 38 43 35  |..^.........G8C5|=
00000a10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|00000a20  02 a0 a0 a3 92 89 00 00  00 fe 00 00 47 38 43 35  |...........=
.G8C5|00000a30  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |........=
........|00000a40  02 a0 d8 a3 5b 89 00 00  00 fe 00 00 47 38 43 35  |....[=
.......G8C5|00000a50  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..=
..............|00000a60  02 a0 15 a4 1c 89 00 00  00 fe 00 00 47 38 43 35  =
|............G8C5|00000a70  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 0=
0  |................|00000a80  02 a0 52 a4 d4 88 00 00  00 fe 00 00 47 38 4=
3 35  |..R.........G8C5|00000a90  00 00 00 00 00 00 00 00  00 00 00 00 00 0=
0 00 00  |................|00000aa0  02 a0 99 a4 7f 88 00 00  00 fe 00 00 4=
7 38 43 35  |............G8C5|00000ab0  00 00 00 00 00 00 00 00  00 00 00 0=
0 00 00 00 00  |................|00000ac0  02 a0 cc a4 44 88 00 00  00 fe 0=
0 00 47 38 43 35  |....D.......G8C5|00000ad0  00 00 00 00 00 00 00 00  00 0=
0 00 00 00 00 00 00  |................|00000ae0  02 a0 18 a5 e3 87 00 00  0=
0 fe 00 00 47 38 43 35  |............G8C5|00000af0  00 00 00 00 00 00 00 00=
  00 00 00 00 00 00 00 00  |................|00000b00  02 a0 55 a5 93 87 00=
 00  00 fe 00 00 47 38 43 35  |..U.........G8C5|00000b10  00 00 00 00 00 00=
 00 00  00 00 00 00 00 00 00 00  |................|00000b20  02 a0 a9 a5 18=
 87 00 00  00 fe 00 00 47 38 43 35  |............G8C5|00000b30  00 00 00 00=
 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000b40  02 a0 f4=
 a5 af 86 00 00  00 fe 00 00 47 38 43 35  |............G8C5|00000b50  00 00=
 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000b60  02=
 a0 36 a6 49 86 00 00  00 fe 00 00 47 38 43 35  |..6.I.......G8C5|00000b70 =
 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|00000b=
80  02 a0 81 a6 cb 85 00 00  00 fe 00 00 47 38 43 35  |............G8C5|000=
00b90  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|=
00000ba0  02 a0 e4 a6 3b 85 00 00  00 fe 00 00 47 38 43 35  |....;.......G8=
C5|00000bb0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |...........=
.....|00000bc0  02 a0 3d a7 b0 84 00 00  00 fe 00 00 47 38 43 35  |..=3D...=
......G8C5|00000bd0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |...=
.............|00000be0  02 a0 96 a7 1c 84 00 00  00 fe 00 00 47 38 43 35  |=
............G8C5|00000bf0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00=
  |................|00000c00  02 a0 d8 a7 aa 83 00 00  00 fe 00 00 47 38 43=
 35  |............G8C5|

>
>
> 2026/11/7 20:03 =E6=9D=A5=E8=87=AA willowswaving@tutamail.com:
>
>>
>>
>>> Subject: Re: [RFC] HID: uclogic: Add support for Xencelabs Pen Display =
(28bd:520d) and request for switch-to-vendor-mode sequence
>>>
>>> Hello,
>>>
>>>
>>> I am writing to send a friendly ping regarding the support for the Xenc=
elabs Pen Display (28bd:520d). I understand you are very busy, and I just w=
anted to check if there is any update or if there is any additional informa=
tion I can provide to help move this forward.
>>>
>>>
>>> The device is still available for testing. I would be happy to try any =
patches or collect further USB traces if needed.
>>>
>>>
>>> Thank you for your time.
>>>
>>>
>>> Best regards,
>>>
>>> Willows
>>>
>>> 2026/10/18 17:13 =E6=9D=A5=E8=87=AA willowswaving@tutamail.com:
>>>
>>>>> Hello,
>>>>>
>>>>> I would like to report a missing device support in the hid-uclogic
>>>>> driver, and ask for guidance on how to properly add it.
>>>>>
>>>>> Device information
>>>>> ------------------
>>>>> =C2=A0 Name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xencelabs Pen Displa=
y
>>>>> =C2=A0 Vendor ID:=C2=A0 0x28bd (Hanvon Ugee / XP-Pen)
>>>>> =C2=A0 Product ID: 0x520d
>>>>> =C2=A0 Firmware:=C2=A0=C2=A0 20250121(230322)
>>>>> =C2=A0 Model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UG902_LPH2412_P10
>>>>>
>>>>> Problem
>>>>> -------
>>>>> The device is not handled by hid-uclogic. With hid-generic, the devic=
e
>>>>> is registered only as a mouse and no pen events (ABS_X, ABS_Y,
>>>>> ABS_PRESSURE, ABS_TILT) are reported to userspace.
>>>>>
>>>>> When I add the device ID to hid-uclogic-core.c, the driver binds, but
>>>>> the resulting interface is still a mouse. evtest shows no pen events.
>>>>> This suggests the device is still in "firmware mode" and never gets
>>>>> switched into the vendor reporting mode that exposes the pen interfac=
e.
>>>>>
>>>>> Key observations from testing
>>>>> -----------------------------
>>>>> 1. lsusb reports only one interface (bNumInterfaces =3D 1, interface =
0,
>>>>> =C2=A0=C2=A0 HID class, mouse). It has only two interrupt endpoints:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x81 (IN, 64 bytes)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x01 (OUT, 64 bytes)
>>>>> =C2=A0=C2=A0 Note: There is NO endpoint 0x03, which is the endpoint u=
sed by
>>>>> =C2=A0=C2=A0 uclogic_ugee_v2_probe_endpoint in hid-uclogic-params.c. =
Any attempt
>>>>> =C2=A0=C2=A0 to send magic bytes to 0x03 fails with "Invalid endpoint=
 address".
>>>>>
>>>>> 2. Reading the string descriptor at index 0x64 under LANGID 0x0409
>>>>> =C2=A0=C2=A0 successfully returns a 14-byte binary blob (13 bytes of =
content).
>>>>> =C2=A0=C2=A0 Raw HEX: 0e03289a78e60300ff1fd8130100
>>>>> =C2=A0=C2=A0 (Other indexes return normal strings like the serial num=
ber and
>>>>> =C2=A0=C2=A0 "hanvon ugee Tech"). Reading index 0x64 does NOT switch =
the device.
>>>>>
>>>>> 3. Sending the UGEE v2 magic bytes (02 b0 04 00 00 00 00 00 00 00)
>>>>> =C2=A0=C2=A0 via SET_REPORT (Feature 0x02, Output 0x02, Feature 0x03)=
 returns
>>>>> =C2=A0=C2=A0 success, but the device never re-enumerates.
>>>>>
>>>>> 4. A vendor-specific control request (bRequest 0xb0, wValue 0x0402)
>>>>> =C2=A0=C2=A0 times out.
>>>>>
>>>>> 5. Note: Sending unexpected control transfers to this device can caus=
e
>>>>> =C2=A0=C2=A0 the USB HID interface to hang. It requires a complete po=
wer cycle
>>>>> =C2=A0=C2=A0 (unplugging USB and power) to recover.
>>>>>
>>>>> Request
>>>>> -------
>>>>> Could someone with access to the Xencelabs USB documentation, or
>>>>> someone who has reverse-engineered the 520d, share the correct
>>>>> sequence to switch this device into vendor mode?
>>>>>
>>>>> Specifically:
>>>>> =C2=A0 - Is the 0x64 string descriptor read the right trigger, or is =
a
>>>>> =C2=A0=C2=A0=C2=A0 specific control transfer required?
>>>>> =C2=A0 - If a control transfer is needed, what is the correct bReques=
t,
>>>>> =C2=A0=C2=A0=C2=A0 wValue, wIndex, and endpoint?
>>>>> =C2=A0 - Are there known quirks for this device?
>>>>>
>>>>> If a capture from the Windows driver is needed, I can provide one.
>>>>> If you have any hints, I will be happy to prepare a proper patch
>>>>> with hid-uclogic-params.c changes and re-test.
>>>>>
>>>>> I am attaching the text files with:
>>>>> =C2=A0 - lsusb -v output for 28bd:520d
>>>>> =C2=A0 - the raw HID report descriptor (usbhid-dump)
>>>>> =C2=A0 - the string descriptor enumeration (showing 0x64)
>>>>> =C2=A0 - dmesg logs showing the binding behavior.
>>>>>
>>>>> Thank you very much for your time.
>>>>>
>>>>> Best regards,
>>>>> Willows
>>>>>
>>
>>
>
>

