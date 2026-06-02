Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2D377567;
	Tue,  2 Jun 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385271; cv=none; b=aQ3Rxu+O9W2yhnHYavfaFumTyM3foQUqWeZTC3w1MFFwO8t6si8rKp4FIDU00UMgP0Z3jAXTgbOP0X35dImMtIuLwcgl6DYYSzJmcKk3XIUbfLPbrNSvQpNP31RWjOBUOt/0HEcYZYwQmUVA0OSccpj3s2b6WPJP36bXbww7Fgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385271; c=relaxed/simple;
	bh=3euCun7Jp5CRBu0O+v8ACnx6GZBdjsUp/93zV0Jkqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5Q/GgtWnhdo5xdkoPCXPVWqBIU2t59QnPlOc+Pn14/2zZkvprfOzdiS1U0pYdosMJzuOhk2P2HhXonAHIyZpVZDSbMjlY3uw3QKdd8GtM5G+dh++FCE6l0weik5V0hMc5VPX3JHo1u9Nvz40Lz65OINNOgV4P3TWXz/RGl0WuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Xm911NpV; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Xm911NpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780385230;
	bh=vsF8kWjgQSV1qS0tbe1TS4ygkPiCw+uDiqzC3knABzY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Xm911NpVIVge5CC3kHPdzrBF4AwuWOo5+8nXsv8bso3/cWjHlGoyJcsaCAGQUHKhb
	 HDrz916Pj7jwn3kcGobcDRQ3OLDjjwnEW/Y7d247i7QyljdG0NkhzEpZAubfGX41SU
	 TIEI56egkCUwBayVxQkeXtbxk0NUH/PBAaII2qqU=
X-QQ-mid: esmtpgz11t1780385214t2e033139
X-QQ-Originating-IP: YkueepEfC1E+8Z0tCC5Lyrr2sBaHIPI6QH1s42k0c08=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Jun 2026 15:26:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18430485532748447633
EX-QQ-RecipientCnt: 7
From: Xu Rao <raoxu@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	raoxu@uniontech.com
Subject: Re: [PATCH] HID: usbhid: switch HIDBP devices to boot protocol
Date: Tue,  2 Jun 2026 15:26:52 +0800
Message-ID: <C8E9803E69FFBFC6+20260602072653.3053911-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026060216-freezable-donated-99e5@gregkh>
References: <2026060216-freezable-donated-99e5@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OOCyznbq6KdUpkzm7v6h9rLygkgDqf97HAJmFMeWZljY+5hCjePIHUD4
	TiDAW6LrZiuCpFCPiBZ91dKh88sw2CgSrDujzkWnUzEosG7qJWY3545TZEd/8ixXBcFrnGz
	ZUbipKAHZvFBwUqWXYVpSjuCXzVZx15+mDtkj4FBunS1mNy5ADJpfDaGa9/PajgVCpR1cX7
	Ll2DJvJUHvQtMhvpWASc/xEn9mzRaPMW8DcaYvY2u7DKzqaEHNT49T7oTYZ5dnj918LJtQ8
	5tEmzvuk3zprfbejUd2SFNs0IH/n8vuOtgAWJ/xW1/+WnRJBWX3JpXfvE/Q5eMfs7zoNTeP
	UTWwzcNh4My2cl/QXN3EgIT1AOR1sbOr8qhOIQEpEEc8rkhIwldsYo8lVybQlcJfpZpY3ca
	zj6QQi1NtrS4yET1haPq31gntOOef30J9qdTpNynmvWNnAP3pgKN9e6Fc9Jv8yqMPk9Va9c
	BKLWwcAto8JFq++yZ/eZqTe56mDngPjTMjHDCnPJ2XZsfQm6FNZMjBTbmBKZ6F5o9J5BMdY
	/e5PzLr9rbRtlQrbKwWs4/T99GuJKYwRfPjaaCJc0TehNPhRYlBJietccmsnhfnnnG8UmiI
	8B5igi86J/um26idGa2BSPTAvSmbxCjhs9pvod4XnRW4Wdyt43neoJuhhOmmvtwClVszjTs
	Oe3wVt/kQ8PPP7NgXb/c73HUh3/uLy5+gSJQ34fX15ikajJLr3UP1YCfcTAx/MNyxTBrBIh
	h+bzcbzFz1Q+lFJtx9NQJEBv+602ixwlBV8GxZJWYSIcF125hY4bla2a5INjxCGQ5AC91Ed
	z508NFG4hy7I4Tv62h+nRNy0JGp9+KTY9485mChowVXAp1MEAOnOnGTX56GkQOrfGtAojk4
	2Fq3TBYa0jpjyYQfOvpTSx+Is+IpwJg/pMH0vJGg452x0CN2CfnQSsneH7GsK7Rj9uFxesG
	LZ60FpupeJ9bkCslhrn/U4+YGyA9a3QRJz+rguHjee9Ivo5Hu53pq4GOaLF+O2yO9vQgCGP
	iVQkRYfg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Hi Greg,

> > Do not depend on firmware or a previous driver to leave the
> > interface in boot protocol. Send SET_PROTOCOL(BOOT) during probe
> > before the interrupt URB can be opened.
> >
> > Keep failures non-fatal. Some devices may reject the request while
> > still sending boot-compatible reports. For those devices, the
> > existing driver behavior is preferable.
>
> Do you really use these drivers for devices?  If so, why?
>
> And shouldn't the failure be fatal?  If not, why even attempt to send
> it?

After checking the actual device path again, you are right: the devices
I had in mind use the normal usbhid/hid-generic path, not usbkbd or
usbmouse.

This patch came from reading the simple HID Boot Protocol drivers and
noticing that they decode fixed boot reports without explicitly selecting
boot protocol first. So this was a code-inspection cleanup rather than a
fix for a device that I can show is bound to these drivers.

Given that I do not have a real user of usbkbd/usbmouse to justify the
change and test coverage properly, please ignore/drop this patch.

Sorry for the noise, and thanks for pointing this out.

thanks,

Xu Rao
