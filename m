Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E83E2743;
	Thu, 23 Apr 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936999; cv=none; b=jGp9KFVKVBUUKefVOm6Z5SXgEDcpuBh9ltQAI4gCAycDnbtLjFWzXghXhAVBKIbQ6t5LGVGLIijP4cl+wHkkr+er0KVlDIb1vLa4hMx858Xf9vQG11gKVw4Fa0isWoXAcPg8iza8OTujSSHdEgQ/MeEtUXnLKgSo1TQL53A8mKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936999; c=relaxed/simple;
	bh=ZgzTPUHrHEG89a2pByzx7AaNtgi4sLit8Q1iSFPT4X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zmg7F9nJdCVACEOXXs2X4jyoEPIydlnAukiSGij3vfzR9oRvQHJ/evxrpaCg9LibqRFWeogTE+TNKj99KRugpUhoAQLkmb9eofRjieAB8N/xlfldFRK34qQsTfboSh7fy9dEkAq6HwayBAyadT1gMAnJkwt3hj5s0RVLMNS7yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=NEQS6XCQ; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="NEQS6XCQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 218D0285DA6;
	Thu, 23 Apr 2026 11:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776936996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MceVaGX9kotYSLyVa/tKTkHDnZT1oMNjgqLFKTu8EQg=;
	b=NEQS6XCQr/AfeN0Mg2sVO4tYgixf5o7X6kV4T6VW8/TpKUFNQfCTGzBVmZ8VedPi1qqHqW
	QiVKZF0yxY+EQWZxIr37aor1op2daVcf5GJonDYOa61S5hNP1ZEPdEVIUHNBHLyRle7hen
	D+r7jHmk/suktLNVm3JX/PT5cJ0eav1nk809NXeKFqWttRvboDDRy0Tsn3B/kGUYOHAmOq
	04nLZ2M+iU/wWAaF4d2uQAELW1QVBgGaWCy54Xk9urNdR36sKGxw0aYVqTPquCHw0ljZug
	TLhU9FFd8TkcFme4XsGKORDSjz7x28t1fJHSD8yIRjFvH1UYD1nlgpXS8ZxKxw==
Message-ID: <9d84ee31-9686-45a9-b6e8-86b739144852@cachyos.org>
Date: Thu, 23 Apr 2026 09:36:00 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable
 bytes
To: Greg KH <greg@kroah.com>
Cc: Taylor Hewetson <taylor@exponent.digital>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418025823.21767-1-taylor@exponent.digital>
 <2026041845-approve-pelvis-9845@gregkh>
 <81ef5ca0-b070-4afc-bda7-3e5a49677115@cachyos.org>
 <2026042330-underarm-reusable-effa@gregkh>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <2026042330-underarm-reusable-effa@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/23/26 5:29 PM, Greg KH wrote:
> On Thu, Apr 23, 2026 at 05:55:00AM +0000, Eric Naim wrote:
>> On 4/18/26 3:14 PM, Greg KH wrote:
>>> On Sat, Apr 18, 2026 at 02:58:23PM +1200, Taylor Hewetson wrote:
>>>> Some USB HID devices (observed on ASUS ROG Azoth via its 2.4GHz
>>>> dongle, USB ID 0b05:1a85) report an iSerialNumber string whose
>>>> USB string descriptor declares a longer length than the actual
>>>> serial, leaving uninitialized firmware memory - including control
>>>> characters such as 0x18 - appended to the returned string.
>>>>
>>>> These non-printable bytes propagate into hid->uniq, which in turn
>>>> populates /sys/class/input/inputN/uniq. Downstream userspace
>>>> components (systemd sd-device property_is_valid(), and by extension
>>>> mutter input enumeration on GNOME Wayland sessions) reject devices
>>>> with control characters in their uniq, rendering otherwise-
>>>> functional input devices unusable in graphical sessions despite
>>>> the kernel input layer correctly translating keypresses.
>>>>
>>>> Truncate hid->uniq at the first byte outside the printable ASCII
>>>> range (0x20..0x7e) after the serial is read.
>>>
>>> Why aren't we doing this in the USB core instead of forcing all users of
>>> this to do it instead?
>>
>> Should it be up to the kernel to do this as well? Currently this is only a
>> problem with systemd because they added this check, and it looks like they
>> have something in mind to fix it as well [1].
>>
>> [1] https://github.com/systemd/systemd/issues/41339#issuecomment-4266429563
> 
> It's either up to the kernel, or every single userspace program that
> reads the strings from a device.  Might as well do it in one place,
> right?

That is a very good point. Thanks for the insight!

> 
> thanks,
> 
> greg k-h


-- 
Regards,
  Eric
