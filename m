Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA323183F
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416553; cv=pass; b=q1KiPj3YWHLxdxUjwQXKjJIva+DQfJtKWz5MQrFkuIol9vGTA8ZcVPq2RU13hDfbri9t4IjBa5hM39XNhMDlVKWbY5j8oBjFH6ZiiXObIv+R8diLxCR/JY2F7nyy+NPGD6YGnY5ExxjLFhcr9uuKTgz5MbFctCdpWpz4oMCPJak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416553; c=relaxed/simple;
	bh=tKHwQrCS3W+CzrYrusS9+IwfZncSewOmUEqc/jHtXoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cITR6AWwlUPjlL+sjD1A1XppNn7H90ci9aHU1XE5IV14b6+XsTsKTxXvcC3p5atwWQBUGzuh6ziq4CPRNlxRler8FMFwEQ9Y4gy/0tApP0w+IW6aPu/FkXM+9fAkpNAVVsawFr+VJ4mF8FO6HZAvQxZr7Fouo4/z/vgl55GjGbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNgrk+Qo; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNgrk+Qo"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65956402da9so2457141a12.1
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 14:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770416551; cv=none;
        d=google.com; s=arc-20240605;
        b=G986Y94vComk0+Esl8kxsmxlW2K31B8IN0YEDSrXhBGQpOeSQelnfQO6hcvwc31/K7
         5RyAUXLoHu0JBxqIDcIptv1mVxsJSnFI6rIMnQ5DQ7ZNQTLYW6l3Hi8Kc0YIRhFJs0LJ
         rcNJACdwMd0FXmKYiBlTk3h/c2mGqNjF4IUcdbvZtiSySzDXLoNu2NnFo0En40NQI7AJ
         sbn4rhssIiE5XblahfaWEtwTOdzTSkGKkLJ8iD1Kas1bvK7q/tmiLD/+rt63hJSKXBU3
         NDlKw6vwVDxFKW4Jopbo3lXTwKBW7TYHuVEhmMfm23AZbJtHC+FL5UjGcWRZ9zSL3Ig4
         /Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E8UTPXmc+HrCAjPBirihpCEvgRfcmGIUW0NJNHqLhhU=;
        fh=+d7HqbS7xX7TxGAWl5bCP8owwzAWuHt7vVcP5mgdwLc=;
        b=Zas/DFWS6to8Ht1qQbZpnZjHBhbPfwxtZvn384URA3X/rJ18vpde5R4UwNZ0B4FDO8
         JT5BW/x3fUu8SF9sJ51u+gVE66acEF9X82idgKSftDdxbDgM+6TiwClwOkWaUcrJ867G
         vndy5tX1F3lUeNT0z7azfg819kavu9VhZxY2VsSluGYakRUh/ADnsIzXqq228z8LPmo9
         GoKV1zMKrqVqhBe5qIN5eyxCYUPpMbNFGcmf5FcOIScTFnW5HkNPxlAEGvX/Z+pzmHgh
         HE8WkYt5oyEQdajx2vSXS9YmXEIkW6Ea8lG1lFDWsQeQrnRoozVke6iAsByxXre7wLxD
         XlrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770416551; x=1771021351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8UTPXmc+HrCAjPBirihpCEvgRfcmGIUW0NJNHqLhhU=;
        b=XNgrk+QoRcRs7tw/25Tqmb0qo9WPHBckCHZZyo4NkPinTT1Do1kCvAclXFT/jutZUR
         9wgjBFUnHDOiij3KnJyA/sAXdN85bh1sogiAti4qHTmC8cKBZxNsbest+NbDseOsE+qi
         ZGuw1V2ghPoeiBRxlKjbBipK7g8iKxmNGwRZ8HHZRQ4wm6fI7cJMbaae5wfDQ/2MXgwL
         15ahll/PCBla7ws4gV8RcfsgPpbgUf4bTplr6MEYHhCzl4suFdPD8CYo7VftnlllllL1
         D7TabDVQf1B45oN4cumhCmTnASR9GNob1URNTE3svzh6IxPX3N5z9LQrkfyqjXyHSN6a
         SXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416551; x=1771021351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8UTPXmc+HrCAjPBirihpCEvgRfcmGIUW0NJNHqLhhU=;
        b=A0nVuP9gykVOKYNBkK+zADnrTeRU6kBoGDQ4FlJS+zeOSI2NcgbgPdg4IC/grJhC+d
         8edLKBJX2gkwq4g04PQKcpfeWIUStyJ80x7C0gReHJALB2HOf2DhXQi5ZiZZTT0I0DpE
         LWOyT1gh3CRSSvzhLPHjztqxEiEfuALXYJebFhg0n/Pgal8rLqamfcvUHQPa52nOfpw6
         UUyZfsKdoi6J3OJ+vOwsgfb+4+oieYbMFAtB2LpmuPypK1nzZdcvintTepFpnw9LldDo
         lPoQNQRTg0BcTA6hDBtD7Nqcw1PPEKhexdiZN8VdRXzlJuaLJ9Ya+Cvb1BqMGozcZw0s
         qgqw==
X-Forwarded-Encrypted: i=1; AJvYcCV7pp19FfYnw3Y6ybl7vDZWKuW2y7mZ3SOeM7o/Ys2kiBg+IN7HPEPFlQDN/b4tTvgt8yC65C7truOn6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoonywh3XMGoZHfKkyHWePaFNkg9y95Fh5A846BZY9JBirroN
	YHdB86z6R5GCweDdskl/JeKpm0hHuRvO35y0bk2kZezlFBqZwQrgEyeKM8gI2OXOcmrewM3Cant
	33XMDZIRGHS9eqws5pGY5LKNtXLsxTbI=
X-Gm-Gg: AZuq6aJhwZ3T8qwyk2j1fNwxbqkm0X0m+Sj6q91BcRQ+ZD7ryiaUCDlrFrNVQm5rayc
	CsQxbNb1Mg4ahIbaZIp2Arm4l/R9OoHjAbo9cfBlN1FayPsWUXVTlX5qakkU6G/zTmYzwVwd15D
	FNh9sk3ccsZ2okO8HW4hyoI3Zjp8i/UNCZK5B8Y4hfJyOk7NdH00bAcn6exBZ0BmLnOS109wL6S
	ygbigvlPsR+3qd7Sz6VxmjExWD3V4WldlsqwhWgbIlr8oEqG+83OnSFN49GlAr0FQtH4O4=
X-Received: by 2002:a05:6402:4314:b0:659:4295:970 with SMTP id
 4fb4d7f45d1cf-65984126188mr1802337a12.8.1770416550916; Fri, 06 Feb 2026
 14:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206043600.780298-1-ssp.nesin@crpt.ru>
In-Reply-To: <20260206043600.780298-1-ssp.nesin@crpt.ru>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Sat, 7 Feb 2026 00:22:19 +0200
X-Gm-Features: AZwV_QgUW3iQzGTC_GvYjyiXTbU55q5pLapaLZg-0KHr8z51pPrM3O7gG1JFJeQ
Message-ID: <CAPnwWgMac8-k729=u6xs03KZ9EEgJeuojqOSE2srTxT8J9YnvA@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: fix block size validation in SMBus transfers
To: Rostislav Nesin <ssp.nesin@crpt.ru>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000009f985f064a2f39b9"

--0000000000009f985f064a2f39b9
Content-Type: multipart/alternative; boundary="0000000000009f985c064a2f39b7"

--0000000000009f985c064a2f39b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rostislav,

Thank you for the patch and for reporting this.

The bug is real: an unvalidated data->block[0] in the native SMBus
path can cause OOB access, and your analysis is correct.

However, I'd prefer to fix this in the I2C core rather than in
individual drivers. Here is why:

drivers/i2c/i2c-core-smbus.c already validates block size in the
emulated path (i2c_smbus_xfer_emulated): for I2C_SMBUS_BLOCK_DATA
write, I2C_SMBUS_I2C_BLOCK_DATA, and I2C_SMBUS_BLOCK_PROC_CALL it
rejects data->block[0] > I2C_SMBUS_BLOCK_MAX with -EINVAL. But when
the adapter provides a native smbus_xfer, __i2c_smbus_xfer() calls
it without any prior validation on data->block[0].

This means every native SMBus adapter is exposed. For example,
hid-mcp2221 has the exact same class of bug -- it uses data->block[0]
in the block paths without any upper-bound check. hid-cp2112 happens
to have a driver-level guard, but relying on each driver to do this
independently is fragile.

Fixing it once in __i2c_smbus_xfer() protects all native SMBus
adapters and aligns the native path with the emulated path's contract.

Also note that the correct bound is data->block[0] > I2C_SMBUS_BLOCK_MAX
(i.e. > 32), consistent with the UAPI definition of union i2c_smbus_data
and the emulated path checks. The + 1 in the submitted patch would allow
33, which is already out of spec per the SMBus standard.

Could you please respin the patch against drivers/i2c/i2c-core-smbus.c
instead? Something like in the attached .diff file, added in
__i2c_smbus_xfer() right
after flags &=3D ... and before xfer_func =3D adapter->algo->smbus_xfer

You can keep the same Reported-by, Closes, and Fixes tags. Once this
core patch is in, we won't need separate driver-level checks in
hid-ft260 (or hid-mcp2221).

Thanks,
Michael


On Fri, Feb 6, 2026 at 6:36=E2=80=AFAM Rostislav Nesin <ssp.nesin@crpt.ru> =
wrote:

> In ft260_smbus_xfer(), data->block[0] specifies the data length for
> block transfers. Without proper validation, a caller can set block[0]
> to a value larger than I2C_SMBUS_BLOCK_MAX (32), causing out-of-bounds
> access in both ft260_smbus_write() and ft260_i2c_read(). This
> triggered the out-of-bounds access reported by syzbot.
>
> BUG: KASAN: stack-out-of-bounds in ft260_smbus_write+0x19b/0x2f0
> drivers/hid/hid-ft260.c:486
> Read of size 42 at addr ffffc90003427d81 by task syz.2.65/6119
>
> CPU: 0 UID: 0 PID: 6119 Comm: syz.2.65 Not tainted syzkaller #0
> PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 10/25/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:194 [inline]
>  kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
>  __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
>  ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486
>  ft260_smbus_xfer+0x22c/0x640 drivers/hid/hid-ft260.c:736
>  __i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:591 [inline]
>  __i2c_smbus_xfer+0x4f0/0xf60 drivers/i2c/i2c-core-smbus.c:554
>  i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:546 [inline]
>  i2c_smbus_xfer+0x200/0x3c0 drivers/i2c/i2c-core-smbus.c:536
>  i2cdev_ioctl_smbus+0x237/0x990 drivers/i2c/i2c-dev.c:389
>  i2cdev_ioctl+0x361/0x840 drivers/i2c/i2c-dev.c:478
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
>
> Add validation for data->block[0] > I2C_SMBUS_BLOCK_MAX + 1 at the
> start of I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_I2C_BLOCK_DATA cases to
> protect both read and write paths.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Reported-by: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D64ca69977b37604cd6d9
> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
> Signed-off-by: Rostislav Nesin <ssp.nesin@crpt.ru>
> ---
>  drivers/hid/hid-ft260.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 79505c64dbfe..7bd858e40826 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -659,6 +659,10 @@ static int ft260_smbus_xfer(struct i2c_adapter
> *adapter, u16 addr, u16 flags,
>                 }
>                 break;
>         case I2C_SMBUS_BLOCK_DATA:
> +               if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1) {
> +                       ret =3D -EINVAL;
> +                       goto smbus_exit;
> +               }
>                 if (read_write =3D=3D I2C_SMBUS_READ) {
>                         ret =3D ft260_smbus_write(dev, addr, cmd, NULL, 0=
,
>                                                 FT260_FLAG_START);
> @@ -675,6 +679,10 @@ static int ft260_smbus_xfer(struct i2c_adapter
> *adapter, u16 addr, u16 flags,
>                 }
>                 break;
>         case I2C_SMBUS_I2C_BLOCK_DATA:
> +               if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1) {
> +                       ret =3D -EINVAL;
> +                       goto smbus_exit;
> +               }
>                 if (read_write =3D=3D I2C_SMBUS_READ) {
>                         ret =3D ft260_smbus_write(dev, addr, cmd, NULL, 0=
,
>                                                 FT260_FLAG_START);
> --
> 2.34.1
>

--0000000000009f985c064a2f39b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Rostislav,<br><br>Thank you for the patch and for repor=
ting this.<br><br>The bug is real: an unvalidated data-&gt;block[0] in the =
native SMBus<br>path can cause OOB access, and your analysis is correct.<br=
><br>However, I&#39;d prefer to fix this in the I2C core rather than in<br>=
individual drivers. Here is why:<br><br>drivers/i2c/i2c-core-smbus.c alread=
y validates block size in the<br>emulated path (i2c_smbus_xfer_emulated): f=
or I2C_SMBUS_BLOCK_DATA<br>write, I2C_SMBUS_I2C_BLOCK_DATA, and I2C_SMBUS_B=
LOCK_PROC_CALL it<br>rejects data-&gt;block[0] &gt; I2C_SMBUS_BLOCK_MAX wit=
h -EINVAL. But when<br>the adapter provides a native smbus_xfer, __i2c_smbu=
s_xfer() calls<br>it without any prior validation on data-&gt;block[0].<br>=
<br>This means every native SMBus adapter is exposed. For example,<br>hid-m=
cp2221 has the exact same class of bug -- it uses data-&gt;block[0]<br>in t=
he block paths without any upper-bound check. hid-cp2112 happens<br>to have=
 a driver-level guard, but relying on each driver to do this<br>independent=
ly is fragile.<br><br>Fixing it once in __i2c_smbus_xfer() protects all nat=
ive SMBus<br>adapters and aligns the native path with the emulated path&#39=
;s contract.<br><br>Also note that the correct bound is data-&gt;block[0] &=
gt; I2C_SMBUS_BLOCK_MAX<br>(i.e. &gt; 32), consistent with the UAPI definit=
ion of union i2c_smbus_data<br>and the emulated path checks. The + 1 in the=
 submitted patch would allow<br>33, which is already out of spec per the SM=
Bus standard.<br><br>Could you please respin the patch against drivers/i2c/=
i2c-core-smbus.c<br>instead? Something like in the attached .diff file, add=
ed in __i2c_smbus_xfer() right<br>after flags &amp;=3D ... and before xfer_=
func =3D adapter-&gt;algo-&gt;smbus_xfer<div><br>You can keep the same Repo=
rted-by, Closes, and Fixes tags. Once this<br>core patch is in, we won&#39;=
t need separate driver-level checks in<br>hid-ft260 (or hid-mcp2221).<br><b=
r>Thanks,<br>Michael</div></div><br><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 6, 2026 at =
6:36=E2=80=AFAM Rostislav Nesin &lt;<a href=3D"mailto:ssp.nesin@crpt.ru">ss=
p.nesin@crpt.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">In ft260_smbus_xfer(), data-&gt;block[0] specifies the data =
length for<br>
block transfers. Without proper validation, a caller can set block[0]<br>
to a value larger than I2C_SMBUS_BLOCK_MAX (32), causing out-of-bounds<br>
access in both ft260_smbus_write() and ft260_i2c_read(). This<br>
triggered the out-of-bounds access reported by syzbot.<br>
<br>
BUG: KASAN: stack-out-of-bounds in ft260_smbus_write+0x19b/0x2f0 drivers/hi=
d/hid-ft260.c:486<br>
Read of size 42 at addr ffffc90003427d81 by task syz.2.65/6119<br>
<br>
CPU: 0 UID: 0 PID: 6119 Comm: syz.2.65 Not tainted syzkaller #0 PREEMPT(ful=
l) <br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/25/2025<br>
Call Trace:<br>
=C2=A0&lt;TASK&gt;<br>
=C2=A0__dump_stack lib/dump_stack.c:94 [inline]<br>
=C2=A0dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120<br>
=C2=A0print_address_description mm/kasan/report.c:378 [inline]<br>
=C2=A0print_report+0xcd/0x630 mm/kasan/report.c:482<br>
=C2=A0kasan_report+0xe0/0x110 mm/kasan/report.c:595<br>
=C2=A0check_region_inline mm/kasan/generic.c:194 [inline]<br>
=C2=A0kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200<br>
=C2=A0__asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105<br>
=C2=A0ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486<br>
=C2=A0ft260_smbus_xfer+0x22c/0x640 drivers/hid/hid-ft260.c:736<br>
=C2=A0__i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:591 [inline]<br>
=C2=A0__i2c_smbus_xfer+0x4f0/0xf60 drivers/i2c/i2c-core-smbus.c:554<br>
=C2=A0i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:546 [inline]<br>
=C2=A0i2c_smbus_xfer+0x200/0x3c0 drivers/i2c/i2c-core-smbus.c:536<br>
=C2=A0i2cdev_ioctl_smbus+0x237/0x990 drivers/i2c/i2c-dev.c:389<br>
=C2=A0i2cdev_ioctl+0x361/0x840 drivers/i2c/i2c-dev.c:478<br>
=C2=A0vfs_ioctl fs/ioctl.c:51 [inline]<br>
=C2=A0__do_sys_ioctl fs/ioctl.c:597 [inline]<br>
=C2=A0__se_sys_ioctl fs/ioctl.c:583 [inline]<br>
=C2=A0__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583<br>
=C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]<br>
=C2=A0do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
=C2=A0&lt;/TASK&gt;<br>
<br>
Add validation for data-&gt;block[0] &gt; I2C_SMBUS_BLOCK_MAX + 1 at the<br=
>
start of I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_I2C_BLOCK_DATA cases to<br>
protect both read and write paths.<br>
<br>
Found by Linux Verification Center (<a href=3D"http://linuxtesting.org" rel=
=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>) with Syzkaller.<br>
<br>
Reported-by: <a href=3D"mailto:syzbot%2B64ca69977b37604cd6d9@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+64ca69977b37604cd6d9@syzkaller.appspo=
tmail.com</a><br>
Closes: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D64ca69977b3760=
4cd6d9" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.com/=
bug?extid=3D64ca69977b37604cd6d9</a><br>
Fixes: 6a82582d9fa4 (&quot;HID: ft260: add usb hid to i2c host bridge drive=
r&quot;)<br>
Signed-off-by: Rostislav Nesin &lt;<a href=3D"mailto:ssp.nesin@crpt.ru" tar=
get=3D"_blank">ssp.nesin@crpt.ru</a>&gt;<br>
---<br>
=C2=A0drivers/hid/hid-ft260.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c<br>
index 79505c64dbfe..7bd858e40826 100644<br>
--- a/drivers/hid/hid-ft260.c<br>
+++ b/drivers/hid/hid-ft260.c<br>
@@ -659,6 +659,10 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapte=
r, u16 addr, u16 flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case I2C_SMBUS_BLOCK_DATA:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data-&gt;block[=
0] &gt; I2C_SMBUS_BLOCK_MAX + 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto smbus_exit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_write =3D=
=3D I2C_SMBUS_READ) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D ft260_smbus_write(dev, addr, cmd, NULL, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 FT260_FLAG_START);<br>
@@ -675,6 +679,10 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapte=
r, u16 addr, u16 flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case I2C_SMBUS_I2C_BLOCK_DATA:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data-&gt;block[=
0] &gt; I2C_SMBUS_BLOCK_MAX + 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto smbus_exit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_write =3D=
=3D I2C_SMBUS_READ) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D ft260_smbus_write(dev, addr, cmd, NULL, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 FT260_FLAG_START);<br>
-- <br>
2.34.1<br>
</blockquote></div>

--0000000000009f985c064a2f39b7--
--0000000000009f985f064a2f39b9
Content-Type: application/octet-stream; 
	name="i2c-core-smbus-validate-block-size.diff"
Content-Disposition: attachment; 
	filename="i2c-core-smbus-validate-block-size.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mlbg5wfp0>
X-Attachment-Id: f_mlbg5wfp0

LS0tCiBkcml2ZXJzL2kyYy9pMmMtY29yZS1zbWJ1cy5jIHwgMjkgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pMmMvaTJjLWNvcmUtc21idXMuYyBiL2RyaXZlcnMvaTJjL2kyYy1jb3JlLXNt
YnVzLmMKLS0tIGEvZHJpdmVycy9pMmMvaTJjLWNvcmUtc21idXMuYworKysgYi9kcml2ZXJzL2ky
Yy9pMmMtY29yZS1zbWJ1cy5jCkBAIC01NzYsNiArNTc2LDM1IEBAIHMzMiBfX2kyY19zbWJ1c194
ZmVyKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcHRlciwgdTE2IGFkZHIsCiAKIAlmbGFncyAmPSBJ
MkNfTV9URU4gfCBJMkNfQ0xJRU5UX1BFQyB8IEkyQ19DTElFTlRfU0NDQjsKIAorCS8qCisJICog
VmFsaWRhdGUgYmxvY2sgdHJhbnNmZXIgc2l6ZXMgc28gdGhhdCBhZGFwdGVycyB0aGF0IGltcGxl
bWVudAorCSAqIG5hdGl2ZSBzbWJ1c194ZmVyIHNlZSB0aGUgc2FtZSBjb250cmFjdCBhcyB0aGUg
ZW11bGF0ZWQgcGF0aC4KKwkgKi8KKwlpZiAoZGF0YSkgeworCQlzd2l0Y2ggKHByb3RvY29sKSB7
CisJCWNhc2UgSTJDX1NNQlVTX0JMT0NLX0RBVEE6CisJCWNhc2UgSTJDX1NNQlVTX0kyQ19CTE9D
S19EQVRBOgorCQkJaWYgKGRhdGEtPmJsb2NrWzBdID4gSTJDX1NNQlVTX0JMT0NLX01BWCkgewor
CQkJCWRldl9lcnIoJmFkYXB0ZXItPmRldiwKKwkJCQkJIkludmFsaWQgYmxvY2sgc2l6ZSAlZCAo
bWF4ICVkKVxuIiwKKwkJCQkJZGF0YS0+YmxvY2tbMF0sIEkyQ19TTUJVU19CTE9DS19NQVgpOwor
CQkJCXJldHVybiAtRUlOVkFMOworCQkJfQorCQkJYnJlYWs7CisJCWNhc2UgSTJDX1NNQlVTX0JM
T0NLX1BST0NfQ0FMTDoKKwkJCWlmIChyZWFkX3dyaXRlID09IEkyQ19TTUJVU19XUklURSAmJgor
CQkJICAgIGRhdGEtPmJsb2NrWzBdID4gSTJDX1NNQlVTX0JMT0NLX01BWCkgeworCQkJCWRldl9l
cnIoJmFkYXB0ZXItPmRldiwKKwkJCQkJIkludmFsaWQgYmxvY2sgd3JpdGUgc2l6ZSAlZCAobWF4
ICVkKVxuIiwKKwkJCQkJZGF0YS0+YmxvY2tbMF0sIEkyQ19TTUJVU19CTE9DS19NQVgpOworCQkJ
CXJldHVybiAtRUlOVkFMOworCQkJfQorCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQlicmVhazsK
KwkJfQorCX0KKwogCXhmZXJfZnVuYyA9IGFkYXB0ZXItPmFsZ28tPnNtYnVzX3hmZXI7CiAJaWYg
KGkyY19pbl9hdG9taWNfeGZlcl9tb2RlKCkpIHsKIAkJaWYgKGFkYXB0ZXItPmFsZ28tPnNtYnVz
X3hmZXJfYXRvbWljKQo=
--0000000000009f985f064a2f39b9--
