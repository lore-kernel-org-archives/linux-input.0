Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C835E959
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542183; cv=none; b=TBxLuy9qw3bjkV8NpbGZ7FADXfVKPtBdNNFl3quK26AkNB+kup85nszHYgRD6T4OlBaO3qed+6ufkWwuy5sDvp7Tb7dzQ8sg7cT4MT+CJXRV0+mkG5vc+aWPARjRM34oGiZNpUSJSHIXd67NvhNBNF2vx2T/opI5HRFGAo2/JEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542183; c=relaxed/simple;
	bh=qnr8nN8bPN6mTJdahLe5J5PZ11l4allTcA9H/p/8fa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgJnXRJSEX6X7q/5ctmTY3TyxlnFp6ZBOHTPVd6QH4GkpoI2xsloVhI676TVwMVKBsd79eHIIMe5GwuWO4S/BPpqJ/7Y+dR7FTyYrwGkob9hpmAKLf5gRBTDnXP0bSW7DnfqX7LWkJPlmFC0F9kdt/7x5j7jnuTcuHddCLQMEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=E97EPv1c; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="E97EPv1c"
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 1E36F81B59;
	Tue, 03 Mar 2026 15:42:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rgmsBS2GImI0-TsoTzKKW;
	Tue, 03 Mar 2026 15:42:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1772541774; bh=vdGF3un+L+r/0x9JCD1ro4HSlUqkOMQjFEVLYt5PUmw=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=E97EPv1cGOF4GJ4ESqZcA1KPxg4e8NQVX+h9+KTP/MSE9aKFQEcesZ6gALtWsqJ6d
	 oJH8yPopc/I6PxJZTRgj2pyzHUQxa/rsY88FuaTQKZzlx4L1nrFeEuINprOC84zUBm
	 eT3ua8zjIIdZyEumw0QyXUiogZxTcxkN5kKPXfzw=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
Message-ID: <24d0e259-3da5-48a4-aaa3-1d407e72d64d@rosa.ru>
Date: Tue, 3 Mar 2026 15:42:53 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd: add keymap fixup for notebooks using 0x6e
 as Fn modifier
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, mpearson-lenovo@squebb.ca
References: <20260218041352.797625-1-m.novosyolov@rosa.ru>
 <aZVZokRqcqWMfLbM@google.com>
Content-Language: en-US
From: Mikhail Novosyolov <m.novosyolov@rosa.ru>
In-Reply-To: <aZVZokRqcqWMfLbM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

18.02.2026 09:26, Dmitry Torokhov пишет:
> On Wed, Feb 18, 2026 at 07:13:52AM +0300, Mikhail Novosyolov wrote:
>> Commit dc8c9c171ef3 ("Input: atkbd - map F23 key to support default
>> copilot shortcut") mapped scancode 0x6e to KEY_F23 to support the
>> Microsoft Copilot key on Lenovo, HP, and Dell notebooks.
>>
>> However, some notebook platforms (including Positron Proxima 15 and
>> possibly others based on the same OEM design) use scancode 0x6e for the
>> Fn modifier key instead of a dedicated Copilot key. When 0x6e generates
>> KEY_F23 events, the Fn key breaks Fn combinations such as Fn+F5
>> (touchpad toggle).
>>
>> On these platforms, the hardware relies on 0x6e being unmapped to
>> properly handle Fn combinations at the firmware level. When the kernel
>> maps it to KEY_F23, desktop environments intercept this as a global
>> hotkey and toggle the touchpad, but cannot re-enable it because the
>> firmware no longer recognizes Fn as a valid modifier.
>>
>> Userspace solutions (systemd hwdb) cannot fix this because the keycode
>> mapping happens in the atkbd driver before events reach userspace.
>> A kernel-level quirk is required.
> ? That is exactly what udev hwdb is for. Use it. Check 60-keyboard.hwdb
> for examples.
>
> Thanks.

Thanks. Probably I tried hwdb incorrectly.

Now I've tried like 
https://github.com/systemd/systemd/commit/d2502f55a2d9dc13f82cc1551a0639843fefb69e

user@rosa-jr4mnj ~ $ cat /etc/udev/hwdb.d/61-positron-fn-fix.hwdb
evdev:atkbd:dmi:bvn*:bvr*:bd*:svn*Positron*:pnG1569*:*
  KEYBOARD_KEY_6e=fn
user@rosa-jr4mnj ~ $ sudo systemd-hwdb update
and reboot.

It seems to work correctly.

>
