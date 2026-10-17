Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3D4CF47D
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792271771; cv=none; b=kqnTxOAlvx45/766ZwOkYcDnczDNSd2e4+6i9WH+WoRqCvBsFd0nif82q+pqhM3GqjvCkTLzAKq2A7HB8Z7y++4CGzJb+PbaNNzyMzIeDixe91rIgo0SiNr2MyXuey7TQxuo99E6p6F4CjOUCigb7XSq9Otv7IvJupy9b5Pg3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792271771; c=relaxed/simple;
	bh=EkmDemNJ8l1H8fKNZd8fu3H+wWrAkFE66ZKT1U2Dzcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU1axA+POXjMMJ8HaHsvYfkHjrD2r6SDmiuz/TeGLXc7o8jJ6mRetPWNSP3u+TOMJDA2KAVhWJtfhk0+ANQx6yuhcbYnIqpR0IvMsqR6O3zUt+0490Ag7NsBzrrEIoWE9eoEeSpa+00aRQEiP4+I5sU89YppmRzOEwyMLD0lLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClM8WFZH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClM8WFZH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10682645e9.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792271768; x=1792876568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Mn+Xv+NMWWWgWW67ZqfSX065alOyQzlTNf7PF/ZeP0=;
        b=ClM8WFZHNDxxPtvcTBVN6DaukK72VbdWSQMvDZ4ETEomt+kAJWB5brc/Ot97bfX5aj
         A7/KhdmOcF9WjS/Eya+xcrxPOpPG7kVwTIAKU+O4TG82RyMDKG38rUpofPAFjQFwmaZA
         fgXrMytTmEGho6BogG7rsF53p5iEUSCpvtb5FQDNXEQMaeCypRqv5YAChbJsn5jC9q7y
         gYNUFGNvVMgqjfRanzEtKXk9mhtOG36XkuwJwr5oMsCxHGh0tqxLJ1Qft89svflzN2Cf
         +sW99d4bdOPHflawOGjGZ9cFcZJVLzagdMrGIJ6yEDnJwyf1vcmlPcW4av1UmAX2l7Xm
         jSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792271768; x=1792876568;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Mn+Xv+NMWWWgWW67ZqfSX065alOyQzlTNf7PF/ZeP0=;
        b=ZZ9EYf5Qyd3IDAFy3sut2bAgVlGa8YutCeVdvBRnF/26HSpM2cs+mLqYEbu8XsLUfa
         wgEhuH+SLn+1w7VA9Byn5+ei2O9Gle88/DdkDcQOu7tqLVv3rMvnDp1oU3DNCwOMC5Pg
         SWT8RRpSlJxcUmVkNu3E+S3oGDPpFMY30lvdJ8PkhtOQ7lxVT56iraOYolh0Xo0Kkshz
         Fx3WayuENvw4/9YvuOaSgWqiLodT9PUOd8MQB//4u1B4PdSrAu2RDgH0RSgHaFfHezRS
         S07Lo55iwg/oHLfkFXNtHnyY/QmBpXdLrOfKoI9Fo3CcGQufhY0mT4HsC6Sw/O3eXqVz
         5Tjw==
X-Gm-Message-State: AFq9FYLm2v9+cH6XlY/EnHC95Sv+yoly3dO7M+HmufxEEC5AT92Bpi4W
	Ok5qMv57xJq0DLLdmJMP8JPMb71zzRiXY62aUTAY+hH586I6N7U2AILt
X-Gm-Gg: AYBFou1S1+DdlmadWuXB77PuOiW9pux5R1B6UAXSDJNAo9lodDMrtDc4lmDoBCvOYwU
	rBWVy/9Dn1fJD2tryhz8zzHNupdH4MtW7r05Wykg2mVu+2GgJkSsyZ39N4Fsd2uEHeY6LWMXTTL
	oGD+I8rGW5JGTkOjbIUhGZc2VCYauRZsigq3LJZNJPyjIjI6rWcLuE7RhLcXfzDlp3FTairPz2m
	boLQyOuZa2Js/hEQ0QfR5l6urdMo2Q/DqVNnkOkyB7EWtzvEatjKT4Il5tJnSbse2DntCyUTiPX
	AMJgadolAXD60L4xSQRbh5ebkDfsmI1Vg+NI8EFL6BiWdjrCeOr48hwvaa1UlogMRkG6IQU5+we
	FI57jgmMxTrlA9vVqmrxpgiylk3a1rY0IImRJvM7mWML8JnnLZ3NJJp81wNGxNrr63U9giLR4FS
	n2WJiuIuwlOhWedEXxrUvuZK4dyAOxNqnZ5aMOpBi9r6rsIdTTlwcq0p/zCxy45JkLOM3zT1OCM
	ky5l67bEKqKLIdNztBtfkzK56clN7ZfPRHIKVA2dJ27qA==
X-Received: by 2002:a05:600c:5250:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a1d7616bfdmr72498685e9.29.1792271768170;
        Sat, 17 Oct 2026 14:16:08 -0700 (PDT)
Received: from ryzen.home.mikecouturier.com ([196.75.90.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm280781965e9.10.2026.10.17.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:16:06 -0700 (PDT)
From: Mike Gleason jr Couturier <mikegleasonjr@gmail.com>
X-Google-Original-From: Mike Gleason jr Couturier <mikegleasonjr@users.noreply.github.com>
To: basti@thomae-home.info
Cc: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: =?UTF-8?q?Re=3A=20Logitech=20G502=20X=20=28046d=3Ac099=29=3A=20REL=5FWHEEL=5FHI=5FRES=20always=20reports=20=C2=B1120?=
Date: Sat, 17 Oct 2026 21:15:57 +0000
Message-ID: <20261017211557.64095-1-mikegleasonjr@users.noreply.github.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <504f3ea7-fd23-428b-873b-12ed8bbce3ca@thomae-home.info>
References: <504f3ea7-fd23-428b-873b-12ed8bbce3ca@thomae-home.info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I see the same behavior with a wired G502 X (046d:c099) and tried
binding hid-logitech-hidpp to it, which nobody had reported yet.

Environment:
  Fedora 44, kernel 7.2.10-200.fc44.x86_64
  libinput 1.31.3, Solaar 1.1.20, GNOME on Wayland

By default both interfaces bind to hid-generic and every wheel event
is REL_WHEEL ±1 / REL_WHEEL_HI_RES ±120, one per detent.

I then forced hid-logitech-hidpp onto the device:

  modprobe hid-logitech-hidpp
  echo "0003 046d c099" > /sys/bus/hid/drivers/logitech-hidpp-device/new_id
  (replug)

Both interfaces bind to logitech-hidpp-device:

  logitech-hidpp-device 0003:046D:C099.0013: input,hidraw0: USB HID v1.11 Mouse [Logitech G502 X] on usb-0000:10:00.4-1/input0
  logitech-hidpp-device 0003:046D:C099.0014: input,hiddev96,hidraw1: USB HID v1.11 Keyboard [Logitech G502 X] on usb-0000:10:00.4-1/input1
  logitech-hidpp-device 0003:046D:C099.0014: HID++ 4.2 device connected.

Only the second interface (input1) reports HID++. Solaar shows the
device has feature 0x2121 (HIRES WHEEL v1), and I set it to high
resolution mode (Onboard Profiles disabled).

With high resolution mode on, libinput still sees 15.00/120 per
event, but there are now roughly 8 events per detent:

  POINTER_SCROLL_WHEEL  +22.240s  vert 15.00/120.0* horiz 0.00/0.0 (wheel)
  POINTER_SCROLL_WHEEL  +22.310s  vert 15.00/120.0* horiz 0.00/0.0 (wheel)
  POINTER_SCROLL_WHEEL  +22.339s  vert 15.00/120.0* horiz 0.00/0.0 (wheel)
  POINTER_SCROLL_WHEEL  +22.405s  vert 15.00/120.0* horiz 0.00/0.0 (wheel)
  ...

So the device does send high-resolution deltas once 0x2121 is in
high resolution mode, but they come in through the mouse interface
(input0), which does not apply the resolution multiplier. The
interface that negotiates HID++ (input1) is not the one that
generates the wheel events.

It looks like the G502 X needs a proper entry in hidpp_devices[] that
handles the split interfaces, not just its ID added. I'm happy to
test patches on this hardware.

Thanks,
Mike
