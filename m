Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E112DB7BA;
	Thu, 23 Apr 2026 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776923769; cv=none; b=drT5O4NWUJAmdx7b0SNITQzy6IAo076bq5BGAoyVq9/7dWxdMS6ZLWNOHWRVcYdauUpk9pDhdJ4n+ce91E9hqkKQCeeiPHHsFS+aEQVg1sIIJLcrxJCamP3BVbLTvV8KXafPt15voezF/6JmQHci6zGgH1rN0wq7eKg1UK5UK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776923769; c=relaxed/simple;
	bh=y2T59Rw3vxwCrlZYZiYw4dVdhS+aAg5edBljwda3arI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqWoZ5bV4FMW3r9muN+5EROEM3du+oTsS6IF+zRP2s/zWzzPRhXwTkfxSk85ZnCO1HLrB1rq+BCi87zT5V+tj4AqEX+tM7CB+mUXreFt/H46YHLy5jf105T71PuwsDIcjXw3/lUkJSQsRIRi7gUTUNwvMh/OlMq4EKOj+DLLODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=WOrLv112; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="WOrLv112"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2785285E29;
	Thu, 23 Apr 2026 07:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776923765; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QYpQy/uD+KUgLec3Od9MDMAF7kM14x1itr/KOHrURSc=;
	b=WOrLv112ayAi3eMRvGPj9hSvS9LDNs970/E0SJbeCaR65wmOAibmOg/nZcRj3YKZfTdWMN
	9KY8xN+/LD8k/6LmdMfNCzKbmq1HugPeijfoBVA+yeikzxNg7U2+fRiDiaJe1rS+h2M0Fs
	4elylBhFSB9cYQJqayoOoaDvCbN0LsTTlbAABAyu8PdlxziBtAesFNw79hDmVDJjdIxMk7
	DkDUNoHl2e3YAFOKb0zltJY8F/7gzIzmZ09On4pXTaulJDjiZ/K/r/aD5pmgr4hColfYEv
	lK5b+kkeotd6hTX/pm11eHaWonhSvKiuhEOGmz06Vxv2Ttvz3ZH0l6GlWhl/KA==
Message-ID: <81ef5ca0-b070-4afc-bda7-3e5a49677115@cachyos.org>
Date: Thu, 23 Apr 2026 05:55:00 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable
 bytes
To: Greg KH <greg@kroah.com>, Taylor Hewetson <taylor@exponent.digital>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418025823.21767-1-taylor@exponent.digital>
 <2026041845-approve-pelvis-9845@gregkh>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <2026041845-approve-pelvis-9845@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/18/26 3:14 PM, Greg KH wrote:
> On Sat, Apr 18, 2026 at 02:58:23PM +1200, Taylor Hewetson wrote:
>> Some USB HID devices (observed on ASUS ROG Azoth via its 2.4GHz
>> dongle, USB ID 0b05:1a85) report an iSerialNumber string whose
>> USB string descriptor declares a longer length than the actual
>> serial, leaving uninitialized firmware memory - including control
>> characters such as 0x18 - appended to the returned string.
>>
>> These non-printable bytes propagate into hid->uniq, which in turn
>> populates /sys/class/input/inputN/uniq. Downstream userspace
>> components (systemd sd-device property_is_valid(), and by extension
>> mutter input enumeration on GNOME Wayland sessions) reject devices
>> with control characters in their uniq, rendering otherwise-
>> functional input devices unusable in graphical sessions despite
>> the kernel input layer correctly translating keypresses.
>>
>> Truncate hid->uniq at the first byte outside the printable ASCII
>> range (0x20..0x7e) after the serial is read.
> 
> Why aren't we doing this in the USB core instead of forcing all users of
> this to do it instead?

Should it be up to the kernel to do this as well? Currently this is only a
problem with systemd because they added this check, and it looks like they
have something in mind to fix it as well [1].

[1] https://github.com/systemd/systemd/issues/41339#issuecomment-4266429563

> 
> thanks,
> 
> greg k-h


-- 
Regards,
  Eric
