Received: from mail.attrio.net (mail.attrio.net [167.235.71.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA83B47F3;
	Mon, 10 Aug 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.71.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355837; cv=none; b=k/51l95nUCf5+O8iR2KHfACV31/vn9NaLrEHKXjrCZ2ZJqbNcPYP6HzAdwtgPCeo05MznJT/KC/wLljJQ7oWeAh1ljrY04voYUFF1K9TAmpkKtTTXZzCyCUGYb2ldm7ak2eSUEc89AGhJQgBBGm2f9JoHilLnvw9Qi1ocXW7Cjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355837; c=relaxed/simple;
	bh=D1Iip0pMjyoncMTjzwRHFjbAJ/7U4vT65XMNG45ZABY=;
	h=From:Content-Type:Date:Cc:To:MIME-Version:Message-ID:Subject; b=q5Ni+alg0NNNAVLREITddBsDfDWXsybk82CmVkNr3yiHHYX0YBu0a8L58b8I0VzyzhIhRcvbs8QuSgCt6gqzbWFhNohOqr7ATNE4rm6KPSfJiD+ywJOB/9vryD/n5qUqvnv7MBEqu2g5hQSq3uhaaqmCFVmsahxPJoaFFb3sLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=leypold.cz; spf=pass smtp.mailfrom=leypold.cz; dkim=pass (2048-bit key) header.d=leypold.cz header.i=@leypold.cz header.b=fNaIN1Rj; arc=none smtp.client-ip=167.235.71.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=leypold.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leypold.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leypold.cz header.i=@leypold.cz header.b="fNaIN1Rj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id DF294AF034;
	Mon, 10 Aug 2026 11:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leypold.cz; s=mdkim;
	t=1786355833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3PO7o0uZ1gbi2+0e4KW7FZAhEaE8wv6oNKEqk9TF+VM=;
	b=fNaIN1RjuJtnqhJU84TL3oVHvqEYXUqC1agPl56kfZPfwB11PEJTyBAr2fJBCxj8506iBV
	TcislMiyomGpwhNVqedp3TdyEJnhGk+bcbbyBUsvJQPgjpDQS61dROuSORaa87bmg+kZcg
	Euu3q+tAoji4yE6nwljWjHqGkGnGFjPeiMAqMvkc/JecSK4/K1fgNglc1iPnnVXeXs94be
	WnEcHNW4/4cA72tjsLwOUDqz7rNeFOsVw7dWJJsxgRGYKOu8MQsVDgv1llm9/h/2im/8G/
	LWg/OLBgt716MryhqHaYkjamn/7Ws5FtyQ6BqoHSfqWzNZvJfFovVvwtkGWcsQ==
From: "Tomas Leypold" <tomas@leypold.cz>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 10 Aug 2026 11:57:11 +0200
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, nfraprado@collabora.com
To: jikos@kernel.org, bentiss@kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5a6e9d44-52ca-4707-5b72-66d92dd799c4@leypold.cz>
Subject: [BUG] =?utf-8?q?usbhid=3A?= logitech bolt =?utf-8?q?(046d=3Ac548)?= 
 spuriously wakes system from suspend
User-Agent: SOGoMail 5.12.9
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hi, I've got an logitech mx keys s keyboard with a logi bolt receiver
(046d:c548)
that wakes my pc from suspend on its own, no input involved, just a
moment after it goes to sleep. Reproducible on two different machines,
both nixos. One's a laptop with s2idle, the other's a pc with s3/deep.

Aug 09 00:08:07 w01 kernel: PM: suspend entry (deep)
Aug 09 00:08:12 w01 kernel: ACPI: PM: Preparing to enter system sleep
state S3
Aug 09 00:08:12 w01 kernel: ACPI: PM: Waking up from system sleep state=
 S3
Aug 09 00:08:12 w01 kernel: PM: suspend exit

Sometimes replugging the receiver into a different USB port fixes it
temporarily, for a while.

HID=5FQUIRK=5FALWAYS=5FPOLL
(https://lore.kernel.org/linux-input/20260407-logi-bolt-hid-quirk-alway=
s-poll-v1-1-4dae0fda344e@collabora.com/)
doesn't seem relevant to this issue. 6.18.41 doesn't have that quirk,
7.1.6 does, and the bug happens on both.

In forums, people with the same problem recommend a udev rule setting
power/wakeup to disabled. That disables keyboard wake entirely.

After some debugging I found a more targeted workaround with no
downsides that I know of: unbinding usbhid from interface 0 (the
keyboard interface) right before suspend, rebinding after resume.
Remote wakeup stays armed, so a keypress still wakes the machine
normally.

Tried unbinding each of the four interfaces on its own, only interface
0 makes a difference.

Here's the systemd-sleep script, drop it in
/usr/lib/systemd/system-sleep/50-bolt-unbind, or wherever your distro
puts these, and chmod +x:

#!/bin/sh
find=5Fdev() {
   for d in /sys/bus/usb/devices/*/idProduct; do
     [ -r "$d" ] || continue
     v=3D$(cat "$(dirname "$d")/idVendor" 2>/dev/null)
     p=3D$(cat "$d" 2>/dev/null)
     [ "$v" =3D "046d" ] && [ "$p" =3D "c548" ] && basename "$(dirname
"$d")" && return
   done
}
case "$1" in
   pre)
     dev=3D$(find=5Fdev)
     [ -n "$dev" ] || exit 0
     echo "$dev:1.0" > /sys/bus/usb/drivers/usbhid/unbind
     ;;
   post)
     dev=3D$(find=5Fdev)
     [ -n "$dev" ] || exit 0
     echo "$dev:1.0" > /sys/bus/usb/drivers/usbhid/bind
     ;;
esac

No idea what the right fix looks like on the kernel side, just wanted
to share what I found.

Happy to run further tests and try out patches.

Best regards,
Tomas Leypold


