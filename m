Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BE4A21
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347099; cv=none; b=L9YYfTa/GdjmPGI4dIaK5kuQUThOhrJLldYlwJrDkwwglzT+76ZAppgwEa850JMkR5V6/r6qEpwcXL0Gq95i4QVfS9M6iwLFOVXc8oNr81TAYEb0rYJrEP/7EqOpiVXGu5iYlT0m9yIDqWjTQx4kendfRiow3qP/zwYdqHixEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347099; c=relaxed/simple;
	bh=m6nUZw1xxBl7JKkg6qshdJPFvlUEzfRiCrxUD3kuwrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQIxdWubuGLDFY1jHouMGfEvU4rUqKAFB/4XkrnHp5VVzUlmgj0aO38fyJWIZq7GOjY8chfPSkiosH6iAEkryQisfHPnnb4Rainv4o68UnrB+yuEt+HWQuxzjq2y6RYn3mPfhhTXuarQvlLkGy6p0fQbmi+6AEbPY6gNWy/rSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/uhjk4N; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/uhjk4N"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1831130a12.3
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789347098; x=1789951898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sThmSBuZMUkb8DDGUqicKukOQFBAznEQKWcs9Ox5tcc=;
        b=V/uhjk4NwVQVIx1l96czB4eNzQaGPj6RKu+bOeTr1FpD12bpHIAze0NSzo1AoZa1Wt
         08Xz7UzQ/rXyOItt7SMDB9gQCAv4bKdq90Nf5vAveWK56IDionKm4eahJwxKSQaR3Rcp
         0UdH7DvLTLdYJn/XluSZEF+Ii8T3uu57XLKpqBLXhwBmljP3+nFsdDwPayMNUhTbNB4U
         KyE2e36VKcltyC4HtJnl7hGUKVIlRLEAz3UclpANVzz0e54AGrUTF6etCqH2/3Vk6PPJ
         2R+6+A1aZ51Z6Ro23toxsw2C4cOt9yGOCgtLIQzCqtCS19M/s25sYT9p6Edl0Nr/K8Lb
         rwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789347098; x=1789951898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sThmSBuZMUkb8DDGUqicKukOQFBAznEQKWcs9Ox5tcc=;
        b=S2CyIkHffOxWeBZXAhV2neaKmHzTR5Hwebu3UugKD+CuchvQUuTuJ5ag8AIlE4ml7+
         Z4ouzU81MDw9NKYCTDt20ks9MDf1MVh97LTlw5kjRVIuHIdEIBT75sKLXR5+Z8c+IUNi
         3pNbkTG5QR+l+Qp2A54loratgel6v5z2yPwF9Hdr8ko2wm7RXWrZy0SLTFZFiaeugr4x
         ah7ksJdL+Hs2IyJeHKGrY6rSRLUEWnt67YjIRpdxEJa0wSjQbOqqXBFDoJ5WXjooQquS
         Z1+UiDd3npgBRQNsZTxrQIyQtkiijOlBsOckM8Q6gjchkrrNSfgJ8HslJfnm+OXAbhtB
         tthA==
X-Gm-Message-State: AFuF++miy9YNGPBgVtKUblYFoceTBkqYtIw3vVwgKJU83CTMqjVSpaYs
	tLfsi4Ozc77XgWoZ5EBt1raHm1bZDUCPA9a/JkWUpHBKYO65FTvTAYCm
X-Gm-Gg: AYBFou2PNsYNRmKDLwNUCCJLSQnM6Wfj/GXnwFIsg6QiIaNw5deNiZhutALg76O0TxP
	a9RPIwlOAWGburdT1FgMw1scC2dVXOZ4xx5onnBr/rDqL5gk2d8sYLTp0tcHuPJFhdlgBxn80IO
	aechBR5G7SEw34aOl9DUjQG2TshjrcKNZtjOFG7sL8aHIA1S7FbXfV5Sl3AjWTkBvW+/LWTyKNI
	AjopdCe46tQZcqmT3ngU1m1HTrQwQ4kIOOmTo0n73cXDl/nGXTga1Zg8Xhm9kAV+EMfpssqxXNQ
	274zKJSreyjbEBSwOZlmTHMug3qAyfZ9WCS8hDsmd9aprfrxrIEIkeuT/BfZmU+dMEa+ZFVxIei
	fxLe2t8bPWYcvVeRzXPtjLIkuKCF2cx3Juv2e1w2x06mzQOgsb2KcoeztkCBw7SfrL8iADOjPKR
	COFTAsyBYCF1XnuDdd2GK67fDriL54Dv1DvsHQHODq5iPXdYumVaIcmyElSumoNYfuDHy4N2ALA
	EwEg/5QCZDQ8FeYuor9EFR86qIAibI97pErnAjIGAMY7QJbqY4=
X-Received: by 2002:a05:6a20:e292:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3db3ff581abmr339027637.0.1789347097663;
        Sun, 13 Sep 2026 17:51:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a598aasm20689137c88.1.2026.09.13.17.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:51:37 -0700 (PDT)
Date: Sun, 13 Sep 2026 17:51:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, 
	syzbot+09103639e39c989e3ed3@syzkaller.appspotmail.com
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix NULL dereference in the PM
 callbacks
Message-ID: <aqdE6RLeWCo7Fngr@google.com>
References: <20260908165925.2030-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908165925.2030-1-yogeshgaur.83@gmail.com>

Hi Yogesh,

On Tue, Sep 08, 2026 at 10:29:25PM +0530, Yogesh Gaur wrote:
> rmi_driver_suspend() and rmi_driver_resume() are exported for the
> transport drivers; hid-rmi calls them straight from its ->suspend and
> ->resume. Both reach code that dereferences the driver data right away:
> 
> 	static int rmi_suspend_functions(struct rmi_device *rmi_dev)
> 	{
> 		struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> 		...
> 		list_for_each_entry(entry, &data->function_list, node) {
> 
> That data is installed by rmi_driver_probe(), which binds only after the
> transport driver has already published rmi_dev via
> rmi_register_transport_device(). A runtime PM suspend of the underlying
> USB interface in that window dereferences NULL:
> 
> 	KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> 	RIP: 0010:dev_get_drvdata include/linux/device.h:989 [inline]
> 	RIP: 0010:rmi_suspend_functions drivers/input/rmi4/rmi_driver.c:283 [inline]
> 	RIP: 0010:rmi_driver_suspend+0x30/0x180 drivers/input/rmi4/rmi_driver.c:994
> 	Call Trace:
> 	 <TASK>
> 	 rmi_suspend+0xa7/0xf0 drivers/hid/hid-rmi.c:448
> 	 hid_suspend+0x4a3/0x530 drivers/hid/usbhid/hid-core.c:1618
> 	 usb_suspend_interface drivers/usb/core/driver.c:1323 [inline]
> 	 usb_suspend_both+0x285/0x1040 drivers/usb/core/driver.c:1446
> 	 usb_runtime_suspend+0x58/0x110 drivers/usb/core/driver.c:2000
> 	 rpm_callback drivers/base/power/runtime.c:460 [inline]
> 	 rpm_suspend+0x8a0/0x17a0 drivers/base/power/runtime.c:698
> 	 pm_runtime_work+0x132/0x1b0 drivers/base/power/runtime.c
> 	 </TASK>
> 
> rmi_disable_irq() and rmi_enable_irq(), reached a few lines further on,
> look the driver data up the same way and then take
> &data->enabled_mutex, so they would fault too.
> 
> There is nothing to suspend or resume before the driver has bound, so
> return success early while the driver data is not there yet.
> 
> Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
> Reported-by: syzbot+09103639e39c989e3ed3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=09103639e39c989e3ed3
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>

Thank you for the patch, but I already have a fix for this:

https://patch.msgid.link/anQe8UiyUR4x0flD@google.com

Thanks.

-- 
Dmitry
