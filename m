Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795252602;
	b=5Fg8qxaOdbzavN+2Eee5DnQSzy0vDPthgQgRe5khj6rBWOshBryUDNK9Lx86mnm27iz3
	 CWGdfwVXleCILSWmNcKDMXfE2ekFF1vWLjCcSUkjsE5sLat58t+vN9tpZIe38qnIc0vBQ
	 amajLA3vPgCBd4nwiWcMAnN1qDuEOeABoeuM8IUzukm3xZ7bBYChEge28K8UfTFyWqAfK
	 8HDzZxzqfewJLVU0b35rxA2uo2C6imRI18WaqnqvVCDx9AfndNXS98pZYeDD35a9RI98R
	 4eruNJOxE2cnONcTShXK0jDs64AVynIRpdvfy0AN07e58slhrdeD8Jjz5NO4CwKmJyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795252602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
	b=fkitup02fELfXL+R7yDFjAJxP2e7LyRU49AoGS+Ifs2zUY8SHUKTqZ6YAZCdZBj07TOc
	 6fyglZF+nBNWm7HysyYDQ6YFFNlGlUzUCr+PBL/3CnYS8UJViQTmyXgtlT5TaEN+aMfs4
	 IHw6G7h30pu+zAdtdNrnyOhB/uwN5n3afUWgFleDHn0S50Al6QvFKf/YAWPPbPZSQM6jX
	 hDEcrqYRInB2q3HDKPrXPbNrCQtWtRBQfKjIaiJM+btTqxYeCpC3oyGsA5SgzYny9le4T
	 JYOiz+kOw6PKXd2xTC4uCs86bKOHdr+2wqKK91+QfXHAhy1rmkoPmYQYjHK7/x0Iqnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FrB49q/N";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1A606A325
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 09:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0A1A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FrB49q/N
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5365d725440so17451551cf.0
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 01:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795252601; cv=none;
        d=google.com; s=arc-20260327;
        b=CMaLG7c4YMrJXd5G9Ri3Y2A9Aox1eNpPQjLJETsd3Xb3DQfvzH3ZLIcIGo4Qm50Lr5
         aAeyWcIHkxHkttQv5jMI1V0ZIF2UFb/8aV7Nel32Ky9q2EZzFUnLcgurbISHmh+poLNd
         cPTG2QFqDqOGrHkFTVOM9FUZV9fQsXyGn+f3OysYnh9I/O2Bx1fQiz6RwEvYmvNTS8L2
         AL/cCX63RT4XMF7nbttUZUtmKo3LwLpEJGtXzyUpea72HC0j6Ow0uY/dlzhOQA9KOOVk
         S6cYD4Wc1mBCB6YDE0cmvY7Ctwk5pnU1NjtN6I/ws8gzq5dHgv4IDqItraUPIHoiL8Wa
         /p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
        fh=r6EOrE+1YwJX6imn7D9htxuf1+oTlgjSpRDkLmwIbPk=;
        b=rvTJsdcY4cr2UVfUAnHAZNt1QZ6+CwREytjFJBKbKMjg8Jh6IXoOMJEsHRYhYBahSu
         Kp6dN2widLAoH2Vl5qJU3YDMtg6JdPxxcTUMuKH+TqOPEHVOGLD8qY2FlpN7uWGZlGbs
         wIwkcp6sbkcjGlsRezuQ9JymQf5ZXEIr5d1Iyq4YWSmeqCX6PUvnqYfk3J3Hpcj7eA0j
         0y5ETQaT7GGrgocmmeqoom/rUfBovpWgQXHk3raqbDERCDohclrPapzCpaqETE6Ao3Bj
         +NEl8Y9Jke8exEh4IXpRB+0n7yY5KfAoHfmrDemj4Z2T98GP2Yn0rYauPcuk7LskYY5j
         xmkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795252601; x=1795857401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
        b=FrB49q/NGInqbswWV4b5DupYEM1AOAsEXsFXaq+6sIXvhpWVXJFnJl8d5xh3I/wxDp
         TZfvIeIxdg0RoU38W0pctgCPSH6htNH3LORCMQ/ifrkQgkMWLehXuycM9XFs8b12QZPE
         lA/i9Dvw8QAci4N7jEZGXYAeJX3qErCdaBVkSUmpm5531/qa/i0Dnz6LCHiwFGPXVLYt
         gpiOv+eEbb+s8WE4NpTkOMEZ06FOfCi9KbwpCiSbba3R8OqQtTDYS6rxPNUQBZEg+leF
         Oa47L1RVYFB3Dl5bHqDv6nQrcvB0MMDqoiV0pnTMNQtohIgHkz+Do44dQ9RblRXou2n6
         MTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795252601; x=1795857401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
        b=reqi5Y4EbO3iU7bA9ccjtkyts0L4CfneNvAiZUHwPgsPc4gszEeknTmSycgThcE32J
         J5kiq12wdIHLP9ZPhDd69PgJKyztbzkJQErxkXmMABSd5n5ps72toYaHDaxWBVvjJO2w
         sMS4EgUObeMadevzclRCJlA+AnChOhfNC7EGQVUEBG2unhG1lTCOWGfekjeSXO9XMybc
         DATI5xrNGArbMONXfja8bkVBiloX2q2ihIpwub2JXkDqKQcKp4mbOAcbqwHL9jyAlkzZ
         xcnGf5TSxMAkyGP9wgGArW3qtAQrkGHvnlnXYS2/IxCfIKYUa5ElSa2a9DdmppkwdeRS
         TcRQ==
X-Forwarded-Encrypted: i=1; AL+hErHTc/d3aJiOzB5NMTChhDQR3jRoctJG9fPOmG1C1Ez7SaHSt6FL4oVfWp5j7hL/yn2B+3fA9ijvOZV3SQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/WfQW3R7bq7wEHTlt2OXELMxtsQK4LjpL0gH+ZoEY5RrippVgK
	ymbdaBB8Oq3pejZDPIntRbsHwP7ow+3SpoZd/91cZO5w/iGNr2jeg54c/iZVFa6xOVgLcJ+qFmt
	L1Bpk2NAI+VxAEqTGJAvRSIgkwy2RFzE=
X-Gm-Gg: AZFdTZcjozssCnNkLEuoBUiEvbtmnF9peVE86eUvOdL3hqF1v1HTXHoNIsYB7+QPk9t
	3s+olUIRKKW6cnL+Aa+dKWVBrCuhBRavhGK1QmRp7zhKp2Fk5f9poHPzHYgpVldv5uFYN1AbauO
	Xj8U1G5rVBcJGlu1BzpOaLd7JdDaOnRNN06JMYu6MjfC+HVsZ1flFiZcgiRAxpFjrj2BphXyTq7
	Qd+aRVyeFPsJvhBntgeOS0Hp7dEzwF9pFbjab5XeW1r/8gXHoNv7SeydyS8VwiEbYtbFV2BvUp7
	CpdbRq4YAwlKt6vxMiRWvhtOEzEQELp0WnoIG/phPNLNWq7RXFnuGm1oao9muKdyLg3Vz88joXx
	3VRaQfbrV6X+86qKhbFodsD6pmW7KJ4vuImxuSNKR4qqcTthMYNNqzU6i4es7/mx4xwd71A==
X-Received: by 2002:a05:622a:5815:b0:54b:f7a6:5354 with SMTP id
 d75a77b69052e-55d76a27b40mr96605951cf.26.1795252600828; Sat, 21 Nov 2026
 01:16:40 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO6oLZF6OZmWeQWo07TJ+GpVPz_LGnwd2cyuiJWD-6JuuiJnZw@mail.gmail.com>
 <CAO6oLZHcHxp0tfdgFNvX5WucVe9AOYM3mBNJHFOrEa3YC15faQ@mail.gmail.com>
In-Reply-To: <CAO6oLZHcHxp0tfdgFNvX5WucVe9AOYM3mBNJHFOrEa3YC15faQ@mail.gmail.com>
From: Adam <testyiprywatnosc@gmail.com>
Date: Sat, 21 Nov 2026 10:16:30 +0100
X-Gm-Features: Aa3M54ryWe-nia4M9Q1ukuyExKMCK8n9O_DYx5CThGSr8x6rSKTl5VXn1VRWliE
Message-ID: <CAEru=6L_Z0bTENvObfQei7G3gMTR-ytdfr5pRPkALtbc+s4FFA@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: A Kishki <alaa6394@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, lovekeshsolanki00@gmail.com, 
	linux-i2c@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Thank you =E2=80=94 your SDA hold workaround also works on my laptop:

- HP Pavilion Gaming 15-ec1xxx
- Board: 87B2
- BIOS: F.35
- Kernel: 7.3.4-arch1-1, Arch Linux
- Touchpad: ELAN0718:00, 04F3:30FD
- Controller: AMDI0010:03, base 0xfedc5000

The controller had IC_SDA_HOLD=3D0x00010001. Changing it to 0x00010048
and rebinding the controller allowed the touchpad to initialize and
deliver input events.

I installed a boot service using your approach, with additional error
handling. After a normal reboot, the service logged:

IC_SDA_HOLD=3D0x00010001
IC_SDA_HOLD verified: 0x00010001 -> 0x00010048
Controller rebound to i2c_designware

The touchpad worked after that reboot. So far this is one confirmed
successful reboot with the service; I will check further boots and
suspend/resume.

One detail on Arch: mapping /dev/mem while the controller was still
bound failed with EPERM, despite Secure Boot being disabled and
lockdown inactive. The kernel has CONFIG_IO_STRICT_DEVMEM=3Dy. Mapping
after unbinding the controller worked.

Thanks again for finding this. This provides an additional successful
test on board 87B2 with BIOS F.35, which may help scope an upstream
fix.

Best regards,
Adam

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM A Kishki <alaa6394@gmail.com> wrote=
:
>
> Hi,
>
> I found the cause on the same laptop. It is the SDA hold time of the
> touchpad's I2C controller, not a reset race in i2c-hid.
>
> Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
> (08/18/2021), Ubuntu kernel 7.0.0-43-generic.
>
> IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):
>
>   normal boot, touchpad dead:         0x00010001
>   boot via HP startup menu, works:    0x00010048
>
> The ACPI tables give no hold time for this controller, so
> i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
> time setting if no one set it"). After a normal boot that is the reset
> value, a TX hold of one clock, so the touchpad NACKs its address. The
> startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
> workarounds help, and probably why the live ISOs worked, if they were
> booted from the F9 menu.
>
> To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
> wrote 0x00010048 to the register through /dev/mem and bound it again.
> The touchpad probed at once and works with hid-multitouch. A rebind
> without the write changes nothing, because the driver reads the same
> value back.
>
> I run this as a boot-time workaround:
> https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix
>
> A real fix probably belongs in i2c-designware, for example a DMI quirk
> that sets the hold time for this model. I'm happy to test patches.
>
> Thanks,
> Ahmed Alkishki
>
> On Sun, Nov 15, 2026 at 10:53=E2=80=AFPM A Kishki <alaa6394@gmail.com> wr=
ote:
>>
>> Hi,
>>
>> I found the cause on the same laptop. It is the SDA hold time of the
>> touchpad's I2C controller, not a reset race in i2c-hid.
>>
>> Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
>> (08/18/2021), Ubuntu kernel 7.0.0-43-generic.
>>
>> IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):
>>
>>   normal boot, touchpad dead:         0x00010001
>>   boot via HP startup menu, works:    0x00010048
>>
>> The ACPI tables give no hold time for this controller, so
>> i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
>> time setting if no one set it"). After a normal boot that is the reset
>> value, a TX hold of one clock, so the touchpad NACKs its address. The
>> startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
>> workarounds help, and probably why the live ISOs worked, if they were
>> booted from the F9 menu.
>>
>> To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
>> wrote 0x00010048 to the register through /dev/mem and bound it again.
>> The touchpad probed at once and works with hid-multitouch. A rebind
>> without the write changes nothing, because the driver reads the same
>> value back.
>>
>> I run this as a boot-time workaround:
>> https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix
>>
>> A real fix probably belongs in i2c-designware, for example a DMI quirk
>> that sets the hold time for this model. I'm happy to test patches.
>>
>> Thanks,
>> Ahmed Alkishki
