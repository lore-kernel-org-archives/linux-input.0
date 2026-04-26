Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7E4C6C
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777168833; cv=pass; b=r+oKoRpou/6hmc7EpDptKMJcp5wxs1RwAFfD75BoOKctGV05wMk/Vzu6Lzpu1crgVKczKU0qpEDoy5VvXFPjpyDxC2L5w3v+AjJ3EBLvqBvWoh0ZGkjExpyFE84ahRH7ivupHBnwGpjeuCXztjmvIBZONNIXWTUvekCQ0i42o7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777168833; c=relaxed/simple;
	bh=3EmKKcdSbo1bYhw/2BproWkmD5PtZPJvDfR7VR8pCVo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uOxIgtFRtzp80eyOrHCQwCq0ljMQbRFIaC6+bLF5equ+cxWy/O3Mqr/6YrAvxRxokNM0h7KoR8VDFEpZd2AWO498i0rh4I46pDL/KD3FZTlSuZK3zmjBK6eUPlFpigCa5L4BF2le//K/5DmdQzp1rRv0ulI5bmtS6AjDfcuEj9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3DncFOr; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3DncFOr"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dca00c1591so2887733a34.3
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 19:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777168831; cv=none;
        d=google.com; s=arc-20240605;
        b=fqOBEXM0fgx6BkTo7j5oG6YU2Se5NjiuIxvf3tdTO+HFTJLAejJOrcx4FBbNghuqtv
         jrQLM5s+3n0X1LDV9STNJZbomT5Mjlsg7PYvwelzr1/J9xUMAHfKlh6uhyf2MhHEYa7E
         T80z6rjzBQaol+9pN1QRVNiwnbHhZN7eO9xgtzezwsqQLsVnPEh3SaSTwiA6up+Ma/lU
         YNS4i2IwnMv8TddkwJMde+2TbTaN0KWIWClswA+aG4Oy+n8tkeK5ICrNt4UpSFNUL4Cl
         7+2s6YVCjzjLMYonrBHSDn/Jl41jx6EfOyMv7/iHheHr/BoIULoBe5YZD66SwBCT2Z6H
         DmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Zo8vxeDPp/MX9x4fc4JbpDqrrXY9z+GHDCCnQjfbQYQ=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=ZvyY00xNNu9IkG0XyCrDhBfbqDAz7wR9A6Nuh6Gmkdp4wIZzesvn/z0eD/BjolcIYw
         roVwWmUvPE9gKW83xQ3sl/tQ/WaLyfMfaJLzD7yVhSUvN+tyAxYcPhX3nJgQ/BipvNYL
         bQtwSQAXGBfaW9gDzl/ndy0vD8+7QGCKnzRlDMX/O++3Qre+S2oZmvfe7k5EccyhXRJn
         VgHwavcYkAcBcM7p73njhuezTU3/4t7osyA4l5Z48wwoJ06Jfh8KGMS9LSO20LKqvyLS
         Lynu9CNqXwft/A64xW6ZSq26LiEcYm8+dJ0ZP+2IzagygXox1kamUrHc2/co8Udxe5nb
         wTRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777168831; x=1777773631; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo8vxeDPp/MX9x4fc4JbpDqrrXY9z+GHDCCnQjfbQYQ=;
        b=J3DncFOriwDKrq9PNalUNO0AosgcvZV1jPHYR4QQ2N7pXimi18tNabcRkIpPVqG3Vp
         yR/rhz3i3OkzgBPQbQ/1YgZW+BSUFnO2Mf4T7X/YnhTMNewvIAJWYFg0/d+QiDRQ5QoJ
         e/EwzEFJBCeIaRwFe/bGCLBj5MDM08zRMs3diI/eEe9KasT1dHwVHiXh6+zj7dxy9U/j
         HX1YCDEimpUZn6dzOSG3BezSwRrMXW+zKyX4GhrBjjNzh1ygj35Bdjd2LzeOS1HS9LsJ
         yoN+N9j+4TG0jLn5hY4V51hmeJPNyOxE1m0Fcmj3CyF5QYzY3IBvgCmgL7UizASAnhhe
         Q3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777168831; x=1777773631;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo8vxeDPp/MX9x4fc4JbpDqrrXY9z+GHDCCnQjfbQYQ=;
        b=bS9v4timhsvnc6AZF/tBfZzPpFfZy/FSdvrb3pXXDcIeL9xoT8KBJbn1T3BH8utk04
         ReY4aj1oYMgBHSsKg+r05H5ouG5RWi3gBF3iRpDt7PKLWrNWNO604lLSwvkixJ2+t61d
         FGxjix9STD1AQbVYwz0Cxy/Yp5QX1yaWK5/bWh7B0UasKJBb965g59hQ4Sj8lNw95oGA
         M+P11pqd0vTLJus9zSUe7icH7H5V1mlvMp6Pip2rMRR2bQLDJkBUYqXYwu5X4eFwKCPc
         AsGH0LZo0BDXK976dRLweBsa0nYid9Pmwn0s80A+zqw35nv1ANF/wPHP/7XPd9J1YlIn
         uWpg==
X-Gm-Message-State: AOJu0Yyx+Th3PpDpZMxeKe7lGzrKKGf+Y8F24Uy8FtmuNux3AlXlwr0S
	2vCvQBqkjIEFp7j3NH5M5h3x+0RNwSfxuUT8GwjU5fGokLwzL5l2yQFfqegj7WdwyCQ9ytRy79j
	csiTqF9bEkGBfvmNOkldaxQhkPWUYfjVyQcHrvMQ=
X-Gm-Gg: AeBDiesNY0HzF6IRjx5eIAGvIztBcHk7+0jNKMPHxZSk0GrGHJwM6gdCCMqW/zR+htG
	qI9lM1SEYRr9+ucidEInqkAsDuncLkLl3cUxiitxGkGHZvFZC+tNbvdVWXQJrx0w+6KykOuMMeb
	DMkXzE6jqE5rZys9p5lRQKFPEfuyDHCywVoEQ1ge/zF/Lq+AcwN32d7Fjpd5yj0U3wpXJAdeZVX
	yV4dtg99uinRNnZtlRpP0M0NnryjcJ6f6hsH8i777lPEuasi02wJLt0pFQxRZiOEKVLsUrZrips
	t1jL5yiH415mcrm06PnbL7jRfRS4FlWH0plw9B/DYjQRfURubBlqc0/9AiS3Yq11PAhcfqvvrg=
	=
X-Received: by 2002:a05:6830:906:b0:7dc:dbe4:3f25 with SMTP id
 46e09a7af769-7dcdbe440dfmr14807889a34.28.1777168831404; Sat, 25 Apr 2026
 19:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?15nXldeg15kg15HXmdeY15XXnw==?= <jony10biton@gmail.com>
Date: Sun, 26 Apr 2026 05:00:20 +0300
X-Gm-Features: AQROBzBbcIEnGWp6FF9A7P4CJ8dHR4UrQ0tHkTX0SPUt1IPQozfqfPtEEERbomQ
Message-ID: <CADsO33iSRHjn=iZunyokTtQSbEav3pJmXk5OGhSDb5FYMbbrxQ@mail.gmail.com>
Subject: [BUG] Intel ISH (Lunar Lake) firmware rejected on ASUS Vivobook 16
 Flip TP3607SH
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

 I'm reporting a bug with ISH firmware loading on a Lunar Lake-based
2-in-1
 laptop (ASUS Vivobook 16 Flip TP3607SH).

 =3D=3D Hardware =3D=3D

   Vendor:  ASUSTeK COMPUTER INC.
   Product: ASUS Vivobook 16 Flip TP3607SH_TP3607SH
   Family:  ASUS Vivobook 16 Flip
   CPU:     Intel Core Ultra 7 258V (Lunar Lake)
   Kernel:  6.19.13-200.fc43.x86_64
   ISH:     00:12.0 (intel_ish_ipc loaded)

 =3D=3D Symptom =3D=3D

 On every boot, the ISH firmware loader fails with:

   intel_ish_ipc 0000:00:12.0: ISH loader: load firmware:
     intel/ish/ish_lnlm.bin cmd 2 failed 10
   (repeated 3 times, then ISH gives up)

 The generic ish_lnlm.bin from linux-firmware is loaded into memory
but the
 ISH bootloader rejects it (cmd 2 =3D START, error 10 =3D rejected).

 =3D=3D Impact =3D=3D

 Without a working ISH:
   - No IIO sensors visible under /sys/bus/iio/devices/
   - iio-sensor-proxy cannot detect orientation
   - No SW_TABLET_MODE events from Intel HID driver
   - Screen rotation and tablet mode are completely non-functional

 The DSDT _QAC method (EC query 0xAC, triggered on hinge fold) reads
hinge
 angle from EC RAM 0x90CF =E2=80=94 a value populated by the ISH. Without I=
SH,
the
 entire tablet detection chain is broken.

 =3D=3D What I tried =3D=3D

 The Windows driver package for this device ships two ISH firmwares:
   - ishheci.inf.../FwImage/0003/ishS_SI_5.8.0.7725.bin  (991 KB)
   - ishheciextensiontemplate.inf.../FwImage/0003/ishS_SI.bin  (523
KB)

 Both are $CPD/$ISHM format (verified with hexdump). I renamed the
larger
 one to ish_lnlm_ef534c00_621ac0c8.bin (using DMI CRC32 values: vendor
 ef534c00, product 621ac0c8) and installed it to
/lib/firmware/intel/ish/.

 Result: same "cmd 2 failed 10" failure. After rmmod/modprobe, a
different
 error appeared ("Timed out waiting for HW ready"), likely a hardware
state
 issue from the hot-reload. After a full reboot: back to "cmd 2 failed
10".

 =3D=3D Root cause hypothesis =3D=3D

 Based on the similar report for Samsung Galaxy Book5 (also Lunar
Lake), and
 feedback from Intel engineer Zhang Lixu, the understanding is:

   The ISH bootloader on Lunar Lake is baked into ME/BIOS and
validates the
   signature of the loaded firmware. The Windows firmware is signed for the
   Windows HECI loading protocol. The Linux ISHTP FW-Loader uses a
different
   mechanism and requires an OEM-signed firmware specifically
built/signed for
   Linux.

   ASUS has not contributed such a firmware to linux-firmware.git. The
only
   vendor-specific Lunar Lake ISH firmwares currently in linux-firmware are
   for CRC prefix 53c4ffad (HP/Lenovo?), not ef534c00 (ASUSTeK).

 =3D=3D Request =3D=3D

 1. Can anyone confirm whether my root-cause analysis is correct =E2=80=94
i.e., that
    the Windows firmware is genuinely incompatible with the Linux ISHTP loa=
der
    due to signing, not just naming?

 2. Is there a known process for requesting that ASUS contribute the
correct
    firmware? I'm happy to open a bug on ASUS's Linux tracker or
contact their
    developer relations if that would help.

 3. Are there other Lunar Lake ASUS users hitting this? I'd like to
know if
    it's device-specific or affects the entire ASUSTeK Lunar Lake lineup.

 DMI info for reference:
   sys_vendor CRC32:    ef534c00  ("ASUSTeK COMPUTER INC.")
   product_name CRC32:  621ac0c8  ("ASUS Vivobook 16 Flip
TP3607SH_TP3607SH")
   product_family CRC32: f25e936f ("ASUS Vivobook 16 Flip")

 Thanks, jony....
