Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752235;
	b=f/+cSUhZ581tvH65/zMQ+4UB/yF68GVeQnsDnEYznmNwF7yl0w8kmgTOBUA2b6aQAw52
	 91clQcH89mDkydTYCslN+yVnTkKtKdx7kP5iNR5F1wlxWHlTRGtFQJRWXt6bEefR4ZS3c
	 Qo6DZgQa/OhFTPCSjCJZkmZzjyPmx9Z56baN8Q/27T5MOn/RRQ4+5m1xPs6jtBRs6UhTk
	 QrIP7Xbd0crRpy8CEhvCkACjEmZ3P4CGNoO+MOXr1o84pBc7lwJvJ7iu4Tx2zwX7+42Wu
	 TCs2cx/TH1riX/amJLLSfax/eyocPiL12TJFJpIHrgzP2+te17uHplzThuO4JLInGSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=l4HdJ5S5VMCKSwcStwSNpwxRa6NVyXBGDqAZzTPE57k=;
	b=RIgX+uy5zGoFE3npvpC5hKXoYxh1sq9DMR9xvSbbQqAPwkUN7hIc2V5eYL3A5nDpSAKZ
	 ooGQ/fzM3iXf/d0cp+UwjomcCHhUWURD9oK+2lHGSaoGeg4fojNwQIaXkDyjVDd4PJasN
	 TdUCp/2tqkvMeO4OVZWyIn5T609VNPRyvM7+9pVGLeGo/KAhkQo2OojJZmUCbZWiiTdfW
	 lsJGN3Cp2JXE7lziJPa16CbCaw20rncNI8vFaNAKRfZ9CET6x+wgRE+sm9UpI966gFQHa
	 vmiq3LC3WniBNQz1exJRARIzca7j1gv4af6hOLldkWa9zNiOXZCn7kbwyruWF+NTfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elEvtfZx;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D685606A31E
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 14:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D685606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elEvtfZx
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so7980235e9.1
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 06:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794752233; x=1795357033; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4HdJ5S5VMCKSwcStwSNpwxRa6NVyXBGDqAZzTPE57k=;
        b=elEvtfZxES7KkcnBDfinS0Xt6S6YixikuyoiKEhJ0L9KJJkD9eetWRGtgCjMZQCUYM
         NKi+EhTY3McVYnqDojr6lMuv6qFcKdmHNXTpsGCIV0oPG/JTR9k4Kva/7DM7QL5gXZp5
         +zYSTE9zrqZyprm0XcjAbn5Rsicfc29j53jaIZ9KOWdOlCr7HP0iGO9rin9wVK1K1wOd
         B0RUuNrdzxmjZluV6Vv27RBdxkPVMgTP5voVoDDFQHljR0CG5+sG/nX9obM0pQ2HuaYh
         W/g26i+CNf0788rWlfRppDQ3rn32xmWhk6cxqqtlCfUS+iGD7BNjZNsC7FV/ZCEDxj6R
         HKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794752233; x=1795357033;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4HdJ5S5VMCKSwcStwSNpwxRa6NVyXBGDqAZzTPE57k=;
        b=t+ZKEFwEB/peDt3KFz6qkCORtm3/EQqq9hfOl65xrLeirKTTJm6XAGGzZo3eO58y78
         m0OSc1y/19vsp7lIBB5Gb2p+RtHdVwDDfT2+prl+MZ4ICKXa5qYTZ3ycl46WTLVyQzwI
         7rjQm8/sjVqExsjn4dh2ewpDYSE/oR0V64Br6fzfEEvAx34218641WQvIV04bRbaqeFU
         85RZhi9kjtDE9l/dJx/XQrVZRXGyOyXI0zJfFlgJb17YYoQFdfDwiaLVb+0akMVFKwzZ
         iB8oNx6T+sPEQ43QjjSOLxB6/A+/cSeo0qVKpH+U64ns682g8Lu9prJy5wpSqVIR35ra
         BNMg==
X-Gm-Message-State: APuU4Z9l3NvZ/qQ29SVtBQbx0s84ODSiZbAhJKeIiHxqCmUj4DgTte6U
	63lYYB8Yr/OCwY3Xj7cNio+8k6HVvVnT/mTBSTz0H4G/PW9BWrCUH7H3pK1Ufv9q
X-Gm-Gg: AYBFou1JoiqPTgQsK0OtR6n/Px0TgsLOWceebiks50iwbZlpSIdNp1QBWgim6p5YdLg
	BFa8EfXhVaELtOrHm4uvVSjaCVjyr9r0hbVCGjUq2W3iADePsZ2xj+Wmc146E7ePQdPnrZNzK6i
	kXS3vtk611qmCh+y89DFHQsvfbW1KJiGMekZXX5JEDJL3IAORnO84luyak96ZuNaCAPENw4YZvd
	ewmHYYfAlvPdleGvh5VAUX8hyrXRgDBzfLOL6VbtLfBl9nW2CHBBi9bLofUpOWv+TfsTMcwLPT6
	0hHKdg/7waMXtrcoamUlZoswC6turXk3cX+eY10wxcLPl3MJ3iHYrhGiwghWdQY2YI3r/Uq4Yrj
	F186wfwY8YJQv0K8L8wCTMgY4MOULKzb2DcxxNF9ClzfeMQUKnIFOcyLL+MQauBeDCqKiMcNRZq
	kDTT3hfYbpE+YlESxWZQpe4EetTaNM6+SujuInuhXFBzDGd6huc3539GeFXJOMm4N2havLFSs9r
	kxgRS/C9JrSGiR9/Az5wZzChXumV99SLvqyKuLMW52VrfW4iLTPsDTAXvSIaOfy1dX40qWNSRS/
	0MkeKocH6BXTNhflbR5pi4EuXjmlywLfvQ==
X-Received: by 2002:a05:600c:3d91:b0:4bb:6861:657d with SMTP id 5b1f17b1804b1-4bb686166e8mr69336785e9.21.1794752233527;
        Sun, 15 Nov 2026 06:17:13 -0800 (PST)
Received: from localhost ([154.192.120.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e1esm196962175e9.3.2026.11.15.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:17:13 -0800 (PST)
Date: Sun, 15 Nov 2026 19:17:07 +0500
From: Shehriyar Qureshi <thatdevsherry@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
Subject: [REPORT]: lenovo laptop FN keys depressed indefinitely
Message-ID: <avm-d6i-aYVzApKz@thatdevsherry.pk>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, I've noticed a weird keyboard behaviour related to function keys with Fn key on my laptop.

There seem to be related bug reports on bugzilla, and seem to be related to Lenovo laptops.

Somewhat related bug: https://bugzilla.kernel.org/show_bug.cgi?id=220689

Reproduce steps:
1. Press and hold Fn key
2. Press and hold a function key briefly (volume keys f1-f4) in my test
3. Release Fn key first
4. Release function key

This flow causes the "Fn+F__" key to not emit a "release" event, and pretends as if it is
depressed indefinitely.

This causes weird behaviour like having to press Fn+F__ again and when releasing it that time, it
registers the "release" event. Another weird result is volume going up or down infinitely as
desktop environment thinks "KEY_VOLUMEDOWN" is being held pressed.

Notes
=====

- When the reproduce steps are performed, if I press Fn+F__ key again, no event emits. When I release
it, the "release" event gets emitted. I can then use the key again.


evtest
======

Command: sudo evtest /dev/input/event4

Test involves using F2 key, Fn+F2 is volume down.

First output is when I press and release quickly, F2 is not registered, KEY_VOLUMEDOWN is never
released.

Second output is releasing after being pressed for a short while. In that case, F2 gets registered
and released, but similar to first ouptut, KEY_VOLUMEDOWN never registers release.

Output
======

Input driver version is 1.0.1
Input device ID: bus 0x11 vendor 0x1 product 0x1 version 0xab83
Input device name: "AT Translated Set 2 keyboard"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    ...
    Event code 28 (KEY_ENTER)
    Event code 29 (KEY_LEFTCTRL)
    ...
    Event code 59 (KEY_F1)
    Event code 60 (KEY_F2)
    Event code 61 (KEY_F3)
    Event code 62 (KEY_F4)
    Event code 113 (KEY_MUTE)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    ...
    Event code 143 (KEY_WAKEUP)
    ...
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML) state 0
    Event code 1 (LED_CAPSL) state 0
    Event code 2 (LED_SCROLLL) state 0
Key repeat handling:
  Repeat type 20 (EV_REP)
    Repeat code 0 (REP_DELAY)
      Value    250
    Repeat code 1 (REP_PERIOD)
      Value     33
Properties:
Testing ... (interrupt to exit)
Event: time 1794746296.253899, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1c
Event: time 1794746296.253899, type 1 (EV_KEY), code 28 (KEY_ENTER), value 0
Event: time 1794746296.253899, -------------- SYN_REPORT ------------
Event: time 1794746297.498438, type 4 (EV_MSC), code 4 (MSC_SCAN), value e3
Event: time 1794746297.498438, type 1 (EV_KEY), code 143 (KEY_WAKEUP), value 1
Event: time 1794746297.498438, -------------- SYN_REPORT ------------
Event: time 1794746297.653019, type 4 (EV_MSC), code 4 (MSC_SCAN), value ae
Event: time 1794746297.653019, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
Event: time 1794746297.653019, -------------- SYN_REPORT ------------
Event: time 1794746297.771531, type 4 (EV_MSC), code 4 (MSC_SCAN), value e3
Event: time 1794746297.771531, type 1 (EV_KEY), code 143 (KEY_WAKEUP), value 0
Event: time 1794746297.771531, -------------- SYN_REPORT ------------
Event: time 1794746297.817435, type 4 (EV_MSC), code 4 (MSC_SCAN), value 3c
Event: time 1794746297.817435, -------------- SYN_REPORT ------------
Event: time 1794746301.453571, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1794746301.453571, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL), value 1
Event: time 1794746301.453571, -------------- SYN_REPORT ------------
Event: time 1794746301.502108, type 4 (EV_MSC), code 4 (MSC_SCAN), value 2e
Event: time 1794746301.502108, type 1 (EV_KEY), code 46 (KEY_C), value 1
Event: time 1794746301.502108, -------------- SYN_REPORT ------------

The above output is when i release the key quickly. If I hold Fn+F__ down for a while, I get

Event: time 1794746690.784458, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1c
Event: time 1794746690.784458, type 1 (EV_KEY), code 28 (KEY_ENTER), value 0
Event: time 1794746690.784458, -------------- SYN_REPORT ------------
Event: time 1794746694.681139, type 4 (EV_MSC), code 4 (MSC_SCAN), value e3
Event: time 1794746694.681139, type 1 (EV_KEY), code 143 (KEY_WAKEUP), value 1
Event: time 1794746694.681139, -------------- SYN_REPORT ------------
Event: time 1794746694.905681, type 4 (EV_MSC), code 4 (MSC_SCAN), value ae
Event: time 1794746694.905681, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
Event: time 1794746694.905681, -------------- SYN_REPORT ------------
Event: time 1794746695.049700, type 4 (EV_MSC), code 4 (MSC_SCAN), value e3
Event: time 1794746695.049700, type 1 (EV_KEY), code 143 (KEY_WAKEUP), value 0
Event: time 1794746695.049700, -------------- SYN_REPORT ------------
Event: time 1794746695.161552, type 4 (EV_MSC), code 4 (MSC_SCAN), value 3c
Event: time 1794746695.161552, type 1 (EV_KEY), code 60 (KEY_F2), value 1
Event: time 1794746695.161552, -------------- SYN_REPORT ------------
Event: time 1794746695.190177, type 4 (EV_MSC), code 4 (MSC_SCAN), value 3c
Event: time 1794746695.190177, -------------- SYN_REPORT ------------
Event: time 1794746695.220520, type 4 (EV_MSC), code 4 (MSC_SCAN), value 3c
Event: time 1794746695.220520, -------------- SYN_REPORT ------------
Event: time 1794746695.250893, type 4 (EV_MSC), code 4 (MSC_SCAN), value 3c
Event: time 1794746695.250893, -------------- SYN_REPORT ------------
Event: time 1794746695.256962, type 4 (EV_MSC), code 4 (MSC_SCAN), value 3c
Event: time 1794746695.256962, type 1 (EV_KEY), code 60 (KEY_F2), value 0
Event: time 1794746695.256962, -------------- SYN_REPORT ------------
Event: time 1794746697.588690, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1794746697.588690, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL), value 1
Event: time 1794746697.588690, -------------- SYN_REPORT ------------
Event: time 1794746697.778538, type 4 (EV_MSC), code 4 (MSC_SCAN), value 2e
Event: time 1794746697.778538, type 1 (EV_KEY), code 46 (KEY_C), value 1
Event: time 1794746697.778538, -------------- SYN_REPORT ------------

Notice Fn+F2 sent KEY_VOLUMEDOWN, after a while when I release Fn (KEY_WAKEUP), it sees it
be released, and then the already pressed F2 key gets emitted as pressed.

When I then release F2, it registers release of F2, but KEY_VOLUMEDOWN never registered
release event.

libinput
========

Device:                  AT Translated Set 2 keyboard
Kernel:                  /dev/input/event4
Id:                      serial:0001:0001
Group:                   7
Seat:                    seat0, default
Capabilities:            keyboard
Tap-to-click:            n/a
Tap-and-drag:            n/a
Tap button map:          n/a
Tap drag lock:           n/a
Left-handed:             n/a
Nat.scrolling:           n/a
Middle emulation:        n/a
Calibration:             n/a
Scroll methods:          none
Scroll button:           n/a
Scroll button lock:      n/a
Click methods:           none
Clickfinger button map:  n/a
Disable-w-typing:        n/a
Disable-w-trackpointing: n/a
Accel profiles:          n/a
Rotation:                0.0
Area rectangle:          n/a

Machine details
===============

Thinkpad T14s Gen 2a (20XG)
Arch Linux 7.3.4-arch1-2
KDE Plasma 6.8.2
