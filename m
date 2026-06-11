Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841B3F0763;
	Thu, 11 Jun 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181399; cv=none; b=avMF6xyeyaXi3PNwGhsBpzrwF2IvODxkpjbDH0BxDWTip1GE8ref2ffdXtNGlsePf6sUzl5ZfJWbY4CyLIjylbqu6tU0cOl8IYWMGWZPqFWK5cv1RwBwPo6EyQ+5EfqygdEn2zyXH9qciElccqDSWbelF481pRsGNSa8kFNow/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181399; c=relaxed/simple;
	bh=g2yGgM3PSDOhiWsJhwnknDKGrWwUImcJLib0jpQm1ew=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=J6eMOBdLZ974R/JYprRxt+DVmm8w+G0qv8sWQUeIqSaKXf57Q1qXRzUvzNET33fPPfabRVi4U6TotMxg/c1cizjtwnc+Phh6BuPCyIr2JSfkAaIpKoZ70Z3kC6C5X50ePQm/ta9Rl72NvIrIzfO+/rCoW6F/CHl1Csdxe+3OWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UkTMSfKE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UkTMSfKE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:References:From:Subject:Cc:To:Message-Id:Date:
	Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g2yGgM3PSDOhiWsJhwnknDKGrWwUImcJLib0jpQm1ew=; b=UkTMSfKEJrYyK77CxpKCg/sRML
	jGh121TczuUSy+NhyLJHDljbgz3gCJZqxlpkVbXSEjV3Kh1CPbKKiVemKXDooL0I6PdBttPOVvDKC
	lJdWRjjsHUV9OmaE8YNkGbvhElIU3gJbw0+g98DSQQ6iFvACC4KXk+WLhDYsH5qetdOQtUO88eF0o
	HZy0bdEQmVxYJ2apzIDcTlaSpPHbr+UAZzfhMYcPWmcWYAMwj36KrSm/T55I73qcD46Yw+DbMvEFc
	+uaCNq+eJt6y3rUxXVBFpaPvEkppArSASrDpfkSuKdusIq413OXkLStuEyKtTKTDle1jFjHC34FCl
	hDjq3FUQ==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wXedz-00G6iZ-OY; Thu, 11 Jun 2026 14:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 09:36:18 -0300
Message-Id: <DJ683OX3NK4L.2RJZVBL63OCYZ@igalia.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Heitor Alves de
 Siqueira" <halves@igalia.com>
Cc: "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires"
 <bentiss@kernel.org>, <kernel-dev@igalia.com>, <linux-usb@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com>
Subject: Re: [PATCH] HID: hiddev: Use kref to track struct hiddev lifetime
From: "Heitor Alves de Siqueira" <halves@igalia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260608-hiddev_kref-v1-1-cd240c95423f@igalia.com>
 <aib06cgHVLIb9vtl@google.com>
In-Reply-To: <aib06cgHVLIb9vtl@google.com>

Hi Dmitry,

On Mon Jun 8, 2026 at 3:44 PM -03, Dmitry Torokhov wrote:
> Hi Heitor,
>
> On Mon, Jun 08, 2026 at 01:33:03PM -0300, Heitor Alves de Siqueira wrote:
>> If a USB HID device is disconnected while userspace still holds the
>> hiddev node open, hiddev_disconnect() and hiddev_release() can race on
>> the embedded existancelock mutex. Syzbot has triggered this with kfree()
>> happening during the mutex slow path.
>>=20
>> Fix by introducing a kref in struct hiddev, and moving kfree() into a
>> dedicated release callback. This way, struct hiddev will only be freed
>> after both hiddev_release() and hiddev_disconnect() are done.
>
> This looks like a common issue with usb_register_dev() that does not
> allow tying the lifetime of the created device, lifetime of user of the
> created device, and userspace accessing it. Ideally the class device
> would be embedded into struct hiddev, and tie its lifetime with lifetime
> of the chardev associated with it and userspace accessors using it. tie
> its lifetime with lifetime of the chardev associated with it and
> userspace accessors using it. See cdev_device_add() and how it is being
> used by multiple subsystems and how they handle class devices.=20

Thank you for your review! I see now, usb_register_dev() does not seem
to be the best if we want to tie the lifetimes together... At least, I
don't think its intended for this usecase, especially if we want to
embed the cdev into struct hiddev. I've been looking at some of the
other drivers that use cdev_device_add(), and noticed that we'd have to
manually handle some things that usb_register_dev() conveniently does
for us (although most seem quite straightforward like minor allocation
and device creation).

I'll give it a try for hiddev, and make sure we don't change any of the
class device paths or leave any open ends with the rest of the usbhid
subsystem. One of the USB gadget drivers already uses cdev_device_add(),
so hopefully it won't be too much trouble.

Thanks,
Heitor
