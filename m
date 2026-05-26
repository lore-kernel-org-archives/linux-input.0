Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5C3DD869
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799102; cv=pass; b=rx37IVEBi3C4aPbAc5X1FGBdi3qUrLko+wqnqLXO+VrGt97snfW36ycPICvdm00AiVGY+fxjopxMAIOfChVcoBFxifs+0TsLaG3YFr8xjPNEOVyWpwG+Z+8qIb2X6HpzlAIEOFjIFAmPicBrDd7ADUR3Um4h2FbO/r/dE26Gou0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799102; c=relaxed/simple;
	bh=CgBlypuEYTo2HQXqTkutdYc8HE5wMmZHy4z9TLpms9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r8tp2G7F5JQFEY9RZ+PXlH6ks7xPu9z6OlbaZozz5Ioam6Lu9EgsV85NApcDl+AR3wNsmRp6w26nVrPTKz7fXcvXd93hAu2J93PGKzGXdL1VTENDdunJ5RMRe7EDpi4XOEwFrSkc3heCk55kF2J63JKh1QA4PeZHfJSsZ6Ql9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBxxNPeH; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBxxNPeH"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7c5d8f45465so101622197b3.1
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 05:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799100; cv=none;
        d=google.com; s=arc-20240605;
        b=LFCMGI52XyTqI9Qq7U0jWPT251qdM7t7f0naRc/2yTRZh1MPTlpahodjnv1CQYYY4O
         Ynk8j7uuC81+qv3cGhqXGMVNLgeRo74/KaisezZEJ2SkUKvrrH1enwzcsTb0Q8Q+VEsJ
         JjFyfesqZUxpT7cWdt9F7cbwhQPYXuLVTNILj1WTYbok5LXM5XPs97Y+eIjTkpld2Hio
         Iv9O0zYPb9XZgPrHcezBIWStEQUhkoyFhYyRwO0cnbpVFHgMVnqwgJD7Ck9mPXkCzvXE
         OGU1JtPQIiZU1pBdfhXjPNWF4bgeYkO6tQdtdvQRKZnm1EzLzXbsJCJOG1ZV6tlWneUo
         WDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=g6KF3rJKefWF8qjEkGgYomJNAdU9kTnw4/vw4Ply0+w=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=c70aA5zExS+0qHwCet5BsFlVN8ZY20U/wcsH80yDlQB3+NLkPX7yneM7XF4VF+wADq
         aUHyFPbEHV9V/lyjKd1z40vgvVn8mIzDCaAP9DiFfbQeUM97rIDIBi7S3MOqsVHPhoK+
         mQ7Mtauhqa81OgJmTmeMBFQNMZbmiHXrYBH0ecYHVtzUgEKxO6KOhoSTazikvB/7uEfo
         uejQ/HQ3UiqFr7UonrujRcbKnlqwFt+uzUrm4DuTEqjqXdZ0HEdh7A/MxtXsPwDrtLY6
         PPBdu6okPD+clWsmtnAKPummZzUnEc9YEUVNO0XvVLRiESYoLvnuNi/2h3o+2VsA5ivM
         irHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779799100; x=1780403900; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g6KF3rJKefWF8qjEkGgYomJNAdU9kTnw4/vw4Ply0+w=;
        b=SBxxNPeH5S6BaB793O0PEVBoTKAvJ9peWhiEK5GRkq59NQdDqva1900q285pH4mtte
         F4taJWU3JKin40clv4VF8ohydUaIxd1/bZJz65n9nedDNCPLU5qdQcFttBSTVqNDyORn
         7A71wexWIg0fj8k7ZjxZW9mJNEXWgXJra43ByFDNWVdzxASUQZDAZLd59R4sWZBWaruQ
         KEfqtfHpJMOR3rN+ool0s4VSLB1UfTQw1b96CbyCW2Q69ulH/bkLu6gquGXQqlWuVIkM
         /DMfJKT+InKdBbjpcNU5hJVRdw/7VLTryWtWcd4FHyAds3m9/LQVUUeFFE9+p8cBEtMa
         8aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799100; x=1780403900;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6KF3rJKefWF8qjEkGgYomJNAdU9kTnw4/vw4Ply0+w=;
        b=Aw3e+rVzZgGS2PxEZKTZinwcSm88xvpkWhrn1KuzdzM0D64QgwWejNILUrmcjrKdB8
         KpwS+A1toORiQuyNrv+QrU8v/FtyA1CjhgO6d2xzM5x1GyDLrMzayrMb4wQsxDypORiB
         qL87TEzfE+ZFgBYqqiYXT7S2I5QlJvq+gMC3RCO4xY4W6+9DLEFQvGvJQ4usbJ2dpjLV
         pZ5DYol7TDEQSZKSbOuuhEPZfkt1x39pRNSh+6+k13q2kuLAjcj101uPX7gkcIlwGZ6v
         mOFK+o60ekXsR7hWfGvyWbHA7m1wuS3AAv3DSltrPtMC9tV6WW7IGpUT7nr03tBcfQay
         PKRQ==
X-Gm-Message-State: AOJu0Yw4NuKqgVbeOXP9DAaH5Vhf8vqq8lS+pb9UJjsBpw5diq7CloyA
	v4LL2jYeYGHg1cpKq0yDMnvTVJANBbl2AlA7YRNkNyyw+IXGJVd/9dWAQycUzl5pGHzVFT3dGWP
	6Oo72ydoARbhNzVWcTmuO7YyOtL+dtPwmrB9v
X-Gm-Gg: Acq92OE2kd+AYVDReLX9Z0o5hb/CVTkCBZdZy7wV+zVCUUU6K1S9/7e5zpO7BeYqU/y
	Kz4sMo0LKxyiygc+eIFRf0uQxaz+vI3UnJpmqPaIryAtTpnJGOOkMKNsEmZpJ/64N2Veqh+fYAN
	bpC/6T6BrlR/hYa+T+7WQv7L6PScoXe4jhp2jGvb5ChBRjqJ4yjL4Ia+BmGA/mjoZ5TP/Ol5e3X
	mbAUDd267XeBY6W2V4a/LsgYlstePYKCAFx3/mnov8kKKNQTaN/SYZpHHfJxv+W1yWvMsvW71cA
	aN2Szis=
X-Received: by 2002:a05:690c:6702:b0:7bd:8cd8:d6b6 with SMTP id
 00721157ae682-7d3344d949emr202279867b3.22.1779799099729; Tue, 26 May 2026
 05:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marijn Schouten <mhkbst@gmail.com>
Date: Tue, 26 May 2026 14:29:10 +0200
X-Gm-Features: AVHnY4K3B8p9vQesfHEL399CHY6KUHKJMCOlwyZkoZwc908p7eCWkMxeZxzmFtc
Message-ID: <CACDFhJxBzJ_Q-VN8Q2PNN47J_Lgj4fSwX5GsaSnjw1eN3T=sQA@mail.gmail.com>
Subject: [old REGRESSION] brightness keys on HP Elitebook 840 G3
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LS (not subscribed please CC)

The last kernel version that the brightness keys on my HP Elitebook
840 G3 worked on was 4.19.208, and they did not work from 5.4.150 on.
I was not able to test any intermediate versions.

I'm currently on 5.15.208. I've been using sysfs as a workaround:
"echo 700 > /sys/class/backlight/intel_backlight/brightness".

I get this failing dmesg output when pressing brightness down and brightness up:

$ dmesg |tail -n 8
[  682.502592] atkbd serio0: Unknown key pressed (translated set 2,
code 0x92 on isa0060/serio0).
[  682.502614] atkbd serio0: Use 'setkeycodes e012 <keycode>' to make it known.
[  682.584414] atkbd serio0: Unknown key released (translated set 2,
code 0x92 on isa0060/serio0).
[  682.584435] atkbd serio0: Use 'setkeycodes e012 <keycode>' to make it known.
[  683.334480] atkbd serio0: Unknown key pressed (translated set 2,
code 0x97 on isa0060/serio0).
[  683.334501] atkbd serio0: Use 'setkeycodes e017 <keycode>' to make it known.
[  683.449715] atkbd serio0: Unknown key released (translated set 2,
code 0x97 on isa0060/serio0).
[  683.449737] atkbd serio0: Use 'setkeycodes e017 <keycode>' to make it known.

Should this be fixed in drivers/input/keyboard/atkbd.c? I tried:

--- drivers/input/keyboard/atkbd.c.orig    2026-05-26 13:34:12.275821222 +0200
+++ drivers/input/keyboard/atkbd.c    2026-05-26 13:40:52.309840298 +0200
@@ -1162,6 +1162,12 @@
     atkbd->keycode[scancode] = KEY_HANJA;
     __set_bit(scancode, atkbd->force_release_mask);

+    /* HP brightness keys mapping for translated mode */
+    if (atkbd->translated) {
+        atkbd->keycode[0x112] = KEY_BRIGHTNESSDOWN;
+        atkbd->keycode[0x117] = KEY_BRIGHTNESSUP;
+    }
+
 /*
  * Perform additional fixups
  */

but it did not work...

With kind regards,

Marijn (not subscribed please CC)
