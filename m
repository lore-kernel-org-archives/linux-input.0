Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794643103;
	b=XfAjg9nPDJpzAqOCd8w57D70hEMrPYPKqo2Cf1BoNuH8pCe6u/itrJStRmyY94LEG/Eo
	 XtQ6QCRkN+Oig+fY/wD9d+A7FzW4ghGpHS+vFaWpKu0R7+zC0MrlmA+HSuAuveAcCakVI
	 Q2YRytUR38CmrMNTWLy3ZBzhjiVfl3Yygrz6DRsvPrZiH7UYePQ5pEu1607yb3E3Pey2t
	 pZKdSHfpCOJVCpWTn9lw7Fq7zdEd+bZEFMnCknNjQGah/5bQp3XcF7k0HwjEoafQvkDGj
	 BSWBdpqceQn/CG2s08EckheZI9/7tUVJMfFV+V1i2xRVXPtJv/qq16EVFhidAZy7Okw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fH8xyR9GaPBsRxXtD1+NUn7yLY4DJpsFGBlspSqLDtE=;
	b=wGKWvtsqjsCzZWHhfNj7jf7MG92Z/cf9Z5Cuk3SDXtiuhefY1oWRYNtjk3fWXn42Dz1Y
	 LQOGXXGAIkX2GBIyhxh4MQy7wpBctgpjfQRIxKwWo8GabyE2lXg+H9jusB5gsbyTjyhfA
	 j7npXOLvdRPXoV1l4sao2fRDf+PMoCaL+6w0BF9Co45TETqnWd0huVC1gEIeNay5URiDa
	 OdtLBzO1yBmPAgd0hNiGruD5tpPuBc4nh6zQ8LkIJKVzW9WHU/gN/V+4KWZY70dj41BSY
	 DOsSTNwdZzaOCe7dQZsyKaAM0Gf2TdfxZm5rQty8z8o95ojJ3F5pSwRU4jTM+yr+scA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAAxX+UN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65135606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 07:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65135606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAAxX+UN
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930c0f9c1b1so274305085a.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 23:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794643102; cv=none;
        d=google.com; s=arc-20260327;
        b=BzUA7p7vYqQz0E7oKGq953N+9+x6To6a9/Dl1gs90dZE66S2F0Y1ykdwIfrl7gB2gt
         BR9s/MnVbg0T23O8g2jFM/KV8RAG+0EMFM8BC5OBUrESdujkyYdodNbwK0NEODuA2OX6
         vZ5T/JzM7NRwab4U8nCS2WZRjHSNMrKdYeXbmGh7sJLF3qf/ALj6an2m/6rGMz9LvQMC
         GjL51XlBoLreUQp8kAVlrYtoO7nD/nJqYK52plWYrpZ/vQM2qJXwgFuCSRYsrbzi10Th
         BH50IFXOtaEv0/3eJYepwm5qc5Yr/EWkOP9IHkF25pXKQGiQBM+ExUldfkJ+fc/bhkMw
         JGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fH8xyR9GaPBsRxXtD1+NUn7yLY4DJpsFGBlspSqLDtE=;
        fh=ktILtpnh8AXB+huSjgLqwIZrOXtEysOZDtRPFQjY1eI=;
        b=mmF7i7EEaQHIVw99o0ZZ+8XEOMNBQLjoEiK0qAr+4Taf7xdp0NTbmr37/nY+yW6q0Z
         dJbjqDChf6OPh4+UVuG1ciF4gcWUYp9DWfMZrEfmHGBgD0iyRk4UvyJ6c778qdw2rKQl
         5ta2xuuKL0VrmFtAQtI2Nw0XQjCHB2le3IhEzX6P+bib+96XMRhE6DdXTIXVHIAsoP5V
         SELHsQNN+S+9lk+XNyMQ7tlMJKIsu/PaYmpT8c+FDXZoTLLcq5x0cuDGg6xEPhUDtipS
         XLEtxslKbefI4ygsfQ3pAio8GRj4il/is8J3y5+mw3H5Ak3/IcHfUGz6iLfC2GbR6uOS
         tw8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794643102; x=1795247902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fH8xyR9GaPBsRxXtD1+NUn7yLY4DJpsFGBlspSqLDtE=;
        b=sAAxX+UN38A00AmlaqSrXYI7rAeAjXqW9GPoUyY0/5bVTdUk6AZErkgLVPOQVADoMF
         KyNJg1Dd2fr5nJEmG7kQGijo9k4wSCXKjoPNHks1SX3tpu8QMn6zwWV5ewmY3/m1LGqA
         bFHQOMAGeaaG447Z11IN8r8HWbgW4J2P1RT8K7ywsQS5dSIihPhStZlvMcH81bjwV7p5
         305YcvIpda0q2VllhlHhH3zGFwIASa6wYQ6EmlxC92Hyah22EMoerbJ82Pgd9bnB8/xk
         yvc3QDyhOPf9nw012K6AYqjnaMaXDNTvLZCSlA/mW/sRNBIQwmV4vSmijezyZ1cFpq2E
         sPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794643102; x=1795247902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fH8xyR9GaPBsRxXtD1+NUn7yLY4DJpsFGBlspSqLDtE=;
        b=atzD63g+H0eSYTwqqSTtmVdkImpR2wg58/P2CVG9SphcCRDDtbFMjbbqkMOSRjSO1t
         pT/fiojdGe3hp4zjTFJEYKZuc4vDfIn5e42nZOgh59Od5308lPCm81YAok+5a2aYmlMu
         R5DVo1aaixqTug9QlJqDJu+JQfkX8UHJxo3T7ceVQUdsDj4bRXvvOa8sNnakuFMM+S0V
         mhqisQ1PwiEVivS/ywRvtPY98R8B1gw7OJ4AFbpuyePb+AumKK4nR0QhPCWJZFR9M8tS
         V+u2/2pWq7ZtlFahIneqDQh/NT77MiL1A+qo3KXINzMC/AqV+szoncYslsMiEKfI2vdb
         2e7w==
X-Gm-Message-State: APuU4Z+U4u6DxCgRqviS1nomF9Nm39wgDdtSSppJ7vIBKPoBQ11n7GK3
	Yy3HczT2L07Tyz3z0lzZeO+uZB1d+UuCd7kFCYY19C7hetJtjfGYeFIacMfzZTWigneukO7xJeX
	g1Stt/BnAVquUAlF99SFC6Ft7PshoP3r7Vue9
X-Gm-Gg: AYBFou3et/88DMepfyitN4FOZj3D2lAot92ctLqnHQN5l40cJSshWdcBwR9BGmuCqvt
	+wmG2Xj//3LPUFkUwnLO//roIKD98eQggo6CzLIFSCFjDPAzr9UT1snp568rFyXmeHxUjPb6DV4
	7HaJ4G/OwIaJvJo1gI/iY4k07q26O5+bDG0OPa+4r2tait0D0ZD9g4Fd1ueTsElNFH3mDsnI5ps
	SZBPbI0J7Ty+A6RZlNYMpduafEy0NTjwVn3w1ZlYX7kiiBRwbdxvn7F34DcuUIPJIBGhn7j1rlq
	1BY5lxBlWMyhs+NzlYrLV7pdiXSmKEcaWYDoM9tnZwSvANtcK6OiL2b2Nk5UuphzzHLfDIZs1ZP
	SUdwbXEKUlEDK/pRvm+3xrS6hvJ76oIrTHNDY8cRW/OiMYZoxKvXv9tRniwlz7DySKEy3WkM=
X-Received: by 2002:a05:620a:4385:b0:949:6982:3f0c with SMTP id
 af79cd13be357-949698240admr49465885a.19.1794643102326; Fri, 13 Nov 2026
 23:58:22 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMX8SmaXHh-dzH2n6pRhQr8q=iN=Ui7T3TC42e35LBUjvMaH1Q@mail.gmail.com>
In-Reply-To: <CAMX8SmaXHh-dzH2n6pRhQr8q=iN=Ui7T3TC42e35LBUjvMaH1Q@mail.gmail.com>
From: Ali Lin <alexlin901107@gmail.com>
Date: Sat, 14 Nov 2026 15:58:10 +0800
X-Gm-Features: AclHuK9OD-1dRkAk7hg2LVikoKEOpM6xeD9JXNxhkHhmRw2wcVilFf37-UWNvsQ
Message-ID: <CAMX8SmaVN0aghH4zmwn8nUg9y6Uz0JGovrTWTSD4Yngnfa3bmQ@mail.gmail.com>
Subject: Re: [REGRESSION] HID: Corsair K70 RAPIDFIRE interface 1 times out on
 Linux 7.3.4
To: linux-input@vger.kernel.org
Cc: regressions@lists.linux.dev, jikos@kernel.org, bentiss@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have updated the diagnostic Gist with two complete boot captures for
each kernel on the same machine, using the same Corsair Gaming K70
RAPIDFIRE keyboard (USB ID 1b1c:1b3a, bcdDevice 3.08) connected to USB
path 1-4 via the Intel xHCI controller at 0000:00:14.0 (8086:a36d) on
Arch Linux:

https://gist.github.com/Alexlin7/65e0705265c7c369d83f9d4a7515faed

Results (2 tests per kernel):
- Linux 6.18.63-2-lts (tests 1 and 2): Both HID interfaces initialize
and bind successfully with no probe timeouts:
  hid-generic 0003:1B1C:1B3A.0001: input,hiddev96,hidraw0
  hid-generic 0003:1B1C:1B3A.0002: hiddev97,hidraw1

- Linux 7.3.4-arch1-1 (tests 1 and 2): Interface 0 registers normally,
while interface 1 consistently fails to probe with -110 (ETIMEDOUT):

  Test 1:
  [   36.929333] archlinux kernel: usbhid 1-4:1.1: can't add hid device: -1=
10
  [   36.930375] archlinux kernel: usbhid 1-4:1.1: probe with driver
usbhid failed with error -110

  Test 2:
  [   36.929377] archlinux kernel: usbhid 1-4:1.1: can't add hid device: -1=
10
  [   36.930405] archlinux kernel: usbhid 1-4:1.1: probe with driver
usbhid failed with error -110

Additional diagnostic notes:
- USB topology confirms interface 1 is bound to usbhid on 6.18.63 LTS
and left unbound ([none]) on 7.3.4.
- Both 7.3.4 descriptor captures report LIBUSB_ERROR_TIMEOUT when
retrieving interface 1's report descriptor, and fail to read device
status (errno 11).
- The 6.18.63 LTS captures mark both report descriptors unavailable
(as expected while bound to the kernel driver), so those are not
complete report-descriptor dumps.

These captures confirm a 100% reproducible, kernel-version-dependent
initialization failure across two boots per kernel. I have not yet
identified the first bad kernel version or commit, and the logs alone
do not establish whether this interface 1 timeout directly causes the
lock LED malfunction.

Please let me know if additional traces, quirk testing, or a kernel
bisect would be helpful when I next have physical access to the
machine.

Best regards,
Weibo Lin


Ali Lin <alexlin901107@gmail.com> =E6=96=BC 2026=E5=B9=B411=E6=9C=8814=E6=
=97=A5=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=882:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> I would like to report a possible Linux HID regression affecting the
> Corsair Gaming K70 RAPIDFIRE keyboard (USB ID 1b1c:1b3a).
>
> On Linux 7.3.4-arch1-1, the keyboard works for normal typing, but the
> Num Lock, Caps Lock, and Scroll Lock indicator LEDs do not function
> correctly after boot.
>
> Unplugging and reconnecting the keyboard restores normal operation.
>
> The problem was not observed when booting Linux 6.18.63-2-lts on the
> same machine.
>
> System information:
>
> - Distribution: Arch Linux
> - Architecture: x86_64
> - CPU: Intel Core i5-8500
> - Motherboard: ASUS PRIME H310M-K
> - BIOS: 3204 (2023-12-14)
> - Keyboard: Corsair Gaming K70 RAPIDFIRE
> - USB ID: 1b1c:1b3a
> - Device revision: 3.08
> - USB speed: Full Speed (12 Mbps)
> - USB host controller: xhci_hcd
>
> Test results:
>
> Linux 7.3.4-arch1-1:
>
> - HID initialization timeout reproduced on two separate boots.
> - Normal keyboard input continues to work.
> - Lock indicator LEDs do not function correctly until the keyboard is
> reconnected.
> - USB interface 1 fails to bind to usbhid.
>
> Linux 6.18.63-2-lts:
>
> - One successful boot observed.
> - Keyboard input and Lock indicator LEDs work normally.
> - Both keyboard HID interfaces initialize successfully.
> - No corresponding HID initialization timeout was observed.
>
> Relevant kernel messages on Linux 7.3.4:
>
> [   36.929377] usbhid 1-4:1.1: can't add hid device: -110
> [   36.930405] usbhid 1-4:1.1: probe with driver usbhid failed with error=
 -110
>
> The USB topology on the affected kernel shows:
>
> Port 004, If 0: Driver=3Dusbhid
> Port 004, If 1: Driver=3D[none]
>
> Additionally, the USB descriptor collection for interface 1 reports:
>
> bInterfaceNumber 1
> wDescriptorLength 29
> Warning: can't get report descriptor, LIBUSB_ERROR_TIMEOUT
>
> Additional observations:
>
> On Linux 7.3.4, the HID timeout occurs approximately 36.9 seconds
> after kernel startup. Subsequent USB devices are enumerated shortly
> afterward.
>
> On Linux 6.18.63 LTS, the keyboard HID interfaces initialize at
> approximately 1.3 seconds.
>
> During one boot with Linux 7.3.4, systemd-udevd also displayed a
> stop-job delay in the initramfs shutdown phase. The system eventually
> booted successfully.
>
> I have not determined whether the delayed USB enumeration and udev
> stop-job observation share the same underlying cause.
>
> Steps to reproduce:
>
> 1. Connect the Corsair K70 RAPIDFIRE directly to a motherboard USB port.
> 2. Boot Arch Linux using kernel 7.3.4-arch1-1.
> 3. Observe that normal keyboard input works, but the Lock indicator
> LEDs do not function correctly.
> 4. Check the kernel log for the usbhid interface 1 timeout.
> 5. Unplug and reconnect the keyboard.
> 6. Observe that the Lock LEDs function normally after reconnection.
>
> Diagnostic logs:
>
> https://gist.github.com/Alexlin7/65e0705265c7c369d83f9d4a7515faed
>
> The Gist includes:
>
> - Linux 7.3.4 kernel boot log
> - Linux 6.18.63 LTS kernel boot log
> - USB topology
> - Corsair K70 USB descriptors
>
> The exact kernel version or commit introducing the issue has not yet
> been identified.
>
> The affected computer is located at my family home, and I do not have
> regular physical access to it. I can perform additional tests when I
> next have access to the machine, although hardware testing responses
> may be delayed.
>
> Thanks.
> Weibo Lin
>
> #regzbot introduced: v6.18..v7.3.4
