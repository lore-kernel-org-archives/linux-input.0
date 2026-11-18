Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033276;
	b=RRhGOm8W02hkltDWApcjHJtLGyMSGLMPVmNC43Uetl6tOHB6K+BLSGT4IlPOw1CyxTeO
	 PJK/HbdDQUAiE2xJnIon39GCBYL09yGEfjhwmFLOhguiR1zIgfr8JiYy8JuNE0y/Ij+Yf
	 8riSmdIE0KyAjJQBRfh2SAkFVhsxKiVDQni3gcWJkXjFNhNEw25ES/snfKj5Ze/WZ6KUS
	 TFlho1BUH9w91a1bxNon4xpTZCF0F+uPYB8Sjd3/Ju06o/w+YkBi0SIy8eckOMxeAGfaC
	 vfNhpzP7BX4A8AVGgSbJFTIzCmj7QaVWD8SoKQfyybfT72e7TL9h4YhvLJywQD6fz6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hFHXy5vmKV/1YpuCgLPgzSMHYH+DeX18yV+aEJiMe4M=;
	b=YKn5J14enAbyI6koFqKNP3b4uPbGm48Gf13qpQbrVDOMiLob8IGfquQqGUHVH/PYZqKR
	 jU6naJwbtPGWFjzAUOyTlyiKLxi34YtVOf0foKDkZayKIlZzUzmuEWaZXdWudSNiurYV4
	 QgUkOKkxSmjCuyt5wwWA/oRvPyChtwg/mNYjcH5c2/xr3+DScsPNn+StRjsXj/C8YECnb
	 1oaHHIgAOeCYu1LpcqlCTKDm+BAyNxOHyNP/PNcy/xpYomtmqx643nAevDmAwZditBvys
	 syOS2aTVx9KK7rrGnjfk/WjpoqavPDQtjv6s84U8wwDDHsSZBwulXKB2Pc6tIaItnSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfM7TXRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313060A260B
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 20:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7313060A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfM7TXRz
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6d68de53053so1066959eaf.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795033275; cv=none;
        d=google.com; s=arc-20260327;
        b=IhROM1l9RTsixtfmGpJ82dHvPAkXnQrxGArpW/gcRIsJfhvbzAV8VNPyVWLVo8y8SF
         5Th6ONOq2gXMmkEr/ocbCv52ouTyTLfWjqXSutEvQvqoK3ngq8k5dZu5yf3qb8HnY/gc
         xF0LoXaLMZfiBacc1BPVoEVQqBJIUVzBYoqEfEiz8N6Lf0cIWHmXknezrmNJKqUMh4Dx
         uMaxF5bI01N48NcAMT8eltfFz/33YDi7nNy2zd1Q092tlDv34hXPUMSDD1wKoPO1aKZK
         P+8qUDaxNuG4Nrcaw6XxsC8OLGCY5ShZ/E/X4sj+NSZRqyImrlHGTCNYsTiNKlXCfx+C
         DpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=hFHXy5vmKV/1YpuCgLPgzSMHYH+DeX18yV+aEJiMe4M=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=GxdGBg4u3eSSmrM9pZlSNv+EHqGS/8cuBjunWdSdHilquBOnsXCj16Uom45gb2eXsG
         fwjJ7xyNKZ4uO80TfzZdbKcUZXqKxbqICopqnHzGsUR7O5FiGpCHsADatIn0jTnfPFDr
         6bSluwr3sGP8lklp8Xxo2iqbMTwfuS34lg0B+eaK/4tY0MAJV/mmsN4pRfWpXnMp/jgs
         vXFGXQ9qp4DGT8Eae+1m5YfcQcicuZHSlU3VAlE+TvS6N2AMc5h60wTR+tiNwibCenm+
         gwunnfegkyEaq7JV0UjG5YrsmCQ7KC7e1y+ZPaJXStUbiSuB4jy/jiVNBDt+HISbkHbC
         s/RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795033275; x=1795638075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFHXy5vmKV/1YpuCgLPgzSMHYH+DeX18yV+aEJiMe4M=;
        b=lfM7TXRz+oVE/RAdOt80dJEmqE3JN11NDrNY80v34KTJh0zq8xU3sI+P4qJ3N1dH5q
         QrBfzJymZjcIecoCVSogc6pzBvNqwzy4FcZBe/bAdynmdC1rwvFNm9DBZPsug+BrABrs
         lk3DSQa0qyjzsv7FMCdvh+rIdnxc1YPIjY2xQ3mRZ3EU1TRKBWY1f4xRMwNEBU9QPOza
         RResMn43vt7t6d85z7wVloiIVWNXtKMVigXleiMrAACDNf4pNUtYAGX6NX2BdM9LNzh2
         GQhBO/hRjagTx4oY+7Zm03ySpKThT8opzwYdzoVXG8pWpqnlX825hadS4ObuLQk0BAFU
         GD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795033275; x=1795638075;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFHXy5vmKV/1YpuCgLPgzSMHYH+DeX18yV+aEJiMe4M=;
        b=cCoyGX5IeNol8f/xiYOPuz+040jEbFB/wvgEosAxHo3SG1i0inc4cQGrx96wFxMFES
         K4N+oL4ySrbaul7Yo4Ad+qqbd0Z7BjH1jgGE1eZjJvjgZIITnPshRnHwA6atmlN9up45
         a1QGV//nCBxnhYvdkynFsc+FQu2fkNfOgWbDMNete5DKJWMOzQKDFDcl35J3H1AvMpAJ
         psdHaM+XjiALymLAdsjxSP5cE07CzILcHCZLh1XcLPbKlm9H3+DXwv1vCGYzrFdrG1iJ
         tOFu7vkl2AIXd3xzm5LohOLK3BnC/m+M6fMU+jtUdUoN3rzmB99z4+1RF5/ZleDTeBbZ
         Y10A==
X-Gm-Message-State: APuU4Z/vicT2fpy0p+QDIMJhSyzgIXhIvUsoTnNXypuvWnxCoQO9ULCU
	G/e5nLrFPoxUM5/wh1YZYJnVlPpakSdjOpIb3WJU4QuCUiEQowGiBnSNmuwtlafvit96882Rd1Y
	Nntp2m9vurR6jZj05JeqKEZ/jVuy9wFA/nBXu
X-Gm-Gg: AYBFou3kI3frHjVMM9uQ7jEPm9rr2pbK9lebjCr4uMKvnvQZS5r7tE6kgAI+WYI5Wmc
	g46BloD4SY8B/QFtvWR4b/AFgiEkghvHsn03cWugJURMIwC7Mfh2a6z/hbU3rXj0m1x+8soVjOW
	/AS5/pnbzzA7HOVEErE2XMeuZUPdz0gq1lAqqBqQVxxGq9sxIW2WIH/mDkILhJ2V0k53FTsY45i
	TwI74B8Oq0pXEdbfeNndNF05P4iN5tkw1LEoICxEmX4/SwYrYBpXzUkSVIRQfiGtDs4oPBWEpCv
	YfONL3cDKf84tcLOabioJqcJArK0SjkbXc+v4yfuoYh6ZpzIGQrc6suvtu2OTyvWZ7OlF0pTSPp
	CGWOhtlEAEFz4dpCbuTJPE8jWjr/HOpRHtNzaMMR4wraoloaH+ymLgqmI2bDEKupSgE09
X-Received: by 2002:a05:6820:a006:b0:71a:7b15:6159 with SMTP id
 006d021491bc7-71b1858a8acmr2210052eaf.52.1795033275224; Wed, 18 Nov 2026
 12:21:15 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Rog=C3=A9rio_Valois?= <valois.rogerio@gmail.com>
Date: Wed, 18 Nov 2026 17:21:03 -0300
X-Gm-Features: AclHuK8MFzTDZoqIwqo71-o5VOzU_3WzA8lr7HeX_JO8N11gx-nGKkenPJ-p5H4
Message-ID: <CAGwXKD-WZRwa5O9b2zjLUrv3aa3_ehj9cEv7+G2aYKXtg3yAXg@mail.gmail.com>
Subject: i2c-hid/hid-multitouch: FocalTech FTCS0038 (2808:0105) touchpad
 intermittently stalls, libinput reports "Touch jump" (Lenovo Yoga Slim 7i,
 Meteor Lake)
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am seeing an intermittent touchpad problem on a Lenovo Yoga Slim 7i
and would like to know if it is a known issue, or what I should debug
next. I am not a kernel developer, so please tell me if I am missing
something.

Hardware / software:
- Lenovo 14IMH9, Intel Core Ultra 5 125H (Meteor Lake)
- BIOS NPCN35WW (latest available)
- Fedora 45, kernel 7.3.3-300.fc45.x86_64, GNOME on Wayland,
  libinput 1.32.0
- Touchpad: FTCS0038:00 2808:0105, i2c-hid over i2c_designware (i2c-0),
  drivers i2c_hid_acpi + hid_multitouch

Symptom:
Intermittently the pointer stops following my finger, clicks are
delayed or lost, and a late press is then combined with a later drag,
so text gets selected by accident. While this happens libinput prints:

  FTCS0038:00 2808:0105 Touchpad: kernel bug: Touch jump detected and
  discarded.

followed by "log rate limit exceeded (5 msgs per 24h)", so there are
probably more such events than I can see. Events still reach libinput
(it is not completely dead), but they arrive after gaps with large
jumps. It happens during normal use, on battery, without suspend and
without screenshot tools. I first noticed it after resume from suspend,
but it also happens without any suspend.

Recovery:
Unbinding and rebinding only the device restores normal operation:

  echo i2c-FTCS0038:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind
  echo i2c-FTCS0038:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/bind

Reloading i2c_hid_acpi and hid_multitouch also works. So the I2C
controller seems fine and the device (or its state) is what gets stuck.

Kernel log:
No I2C timeout or HID error is logged when the failure happens.

What I tried:
- Runtime PM is "unsupported" for the i2c device. Setting power/control
  to "on" for the controller (0000:00:15.0) did not prevent the problem.
- Earlier tests on Ubuntu (GNOME and KDE) showed the same behavior.
  Pop!_OS with COSMIC looked stable in a short test (not long-term).

Unrelated(?):
The firmware also logs a periodic ACPI error (missing symbol AWAC.HOR
in EC method _Q18, roughly once an hour). At first I suspected a link,
but it happens without any touchpad problem, so I now think it is
separate. It is reported at
https://bugzilla.kernel.org/show_bug.cgi?id=3D222291

Questions:
1. Is this a known problem with this touchpad or this platform?
2. Is there a quirk or workaround I should try?
3. What would be the most useful debugging (i2c-hid dynamic debug,
   tracing of the I2C transfers, something else)? I can run a debug
   kernel or test patches.

Thanks,
Rog=C3=A9rio Valois
