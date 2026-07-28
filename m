Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942C283FE5
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245414; cv=none; b=PQvAVuDqDgHO/zVPGSiNfICWArWh6/1nm/Rl46UbEagLnEUzdcVkT7rDqpMPYMkeEYXbrd38t9YoG70mFl9Uhwlk1YhR2yMoBqw4DMduH2HqQ+yCv9VrvXQ/GcfhMax6fPi6niRek0GkvZIX8HKn3onPJLUBTidCH7z8DVNOMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245414; c=relaxed/simple;
	bh=juPJ9J/Zy3im3SWMaEOEYz5LdmnzGzpQTTp2LflxLxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZGXk7Wr5u7c8KWbPEukSl2VNKB3IRkjPGoANw4l4IC0k8tW8lc8Zdl3dokdeI1Mbi7NK2pUIeI0BxNlMZwlgC8P6SQxstCyQalDKn/joZP0PrJlgM3w3lRQ9y+YZQ7agL66WP8YYwRqf6hMBmtx1eIUZ89mnzkV5cvTYjip+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHxnpxw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHxnpxw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7401F000E9;
	Tue, 28 Jul 2026 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245412;
	bh=iCMc3ItkdVwx/coRZ1z+5PVuqz9ueHB9lv4gN4HbDgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHxnpxw9zBNyKQWBab4XKOyK8H8VlckRLYc49yoXPezdQDT9ODqZn/p7F41mIqNqi
	 SbYoN11nXBLOSH6MjP0qthk65yMR4H7PlxVhiHMpBMu/1Zlm7piVb44K90AcFFfP1w
	 uvplXyJ0LCtllSuQsAnHXE/t5wAb7Va4hbt4QlrTjwu7i6Cq4cEaciJ8eAfyd0+q2B
	 /zssNLuM7MhGHrUYuhbnv4UgZ/4r9+BMlzpE3EJkuO2TWmZEmhU0j3sZBUEfCgpxQe
	 mCSKTCsOT+UvkoujhTSIjRGLvCISxa0j0fcfIHQzWMzFK1FnciRVf31sHyAqirteUb
	 G2eVUirCGk99w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] HID: mcp2221: clear rxbuf after I2C/SMBus
 transfer completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728131442.834604-3-yijiangshan@kylinos.cn>
References: <20260728131442.834604-1-yijiangshan@kylinos.cn>
 <20260728131442.834604-3-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:30:11 +0000
Message-Id: <20260728133012.2C7401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race condition leading to NU=
LL pointer dereference or Use-After-Free.

Pre-existing issues:
- [High] Silent I2C data corruption due to brittle lock-step synchronizatio=
n.
- [High] Unkillable task hang (infinite loop) on 0-length payload.
- [High] Kernel stack buffer overflow or broken I2C_SMBUS_BLOCK_DATA read d=
ue to SMBus API misuse.
- [High] Out-of-bounds read in the HID raw event handler due to missing rep=
ort size validation.
--

--- Patch [2]: [PATCH v2 2/3] HID: mcp2221: clear rxbuf after I2C/SMBus tra=
nsfer completes ---
commit 3603851056413fb3957e5edfb92c7c98a7d4fdf4
Author: Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

This patch clears the caller-supplied buffer pointer in mcp->rxbuf and rese=
ts
mcp->rxbuf_size when an I2C/SMBus transfer completes or times out. This aims
to prevent a write use-after-free where a delayed or spurious
MCP2221_I2C_GET_DATA report could memcpy device data into a freed memory
region.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index 5c7fc56c7c671..9e03d1f733ff8 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -343,7 +343,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
> =20
>  	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 4);
>  	if (ret)
> -		return ret;
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does the driver's timeout
handling lead to silent data corruption?

When waiting for a report, the driver uses a lock-step timeout:

drivers/hid/hid-mcp2221.c:mcp_send_data_req_status() {
        t =3D wait_for_completion_timeout(&mcp->wait_in_report,
                                        msecs_to_jiffies(4000));
        if (!t)
                return -ETIMEDOUT;
}

If this times out, the driver starts a new transfer. However, if a delayed =
HID
report from the timed-out transfer arrives later, mcp2221_raw_event()
unconditionally completes the wait:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
        buf =3D mcp->rxbuf;
        memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
        mcp->rxbuf_idx =3D mcp->rxbuf_idx + data[3];
        mcp->status =3D 0;
        break;
        ...
        complete(&mcp->wait_in_report);
}

Can this wake up the new transfer and mistakenly copy the old, delayed data
into the new transfer's buffer?

> =20
>  	mcp->rxbuf_idx =3D 0;
> =20
> @@ -365,7 +365,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
>  			} else {
>  				usleep_range(980, 1000);
>  				mcp_cancel_last_cmd(mcp);
> -				return ret;
> +				goto out;
>  			}
>  		} else {
>  			retries =3D 0;

[Severity: High]
This is a pre-existing issue, but does this loop risk an unkillable task ha=
ng
if a 0-length payload is received?

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
        if (!mcp_get_i2c_eng_state(mcp, data, 2)
                && (data[3] =3D=3D 0)) {
                mcp->status =3D 0;
                break;
        }
}

If a USB device continuously returns a 0-length payload, mcp2221_raw_event()
sets mcp->status =3D 0 and calls complete().

The read loop then observes a success and resets retries =3D 0, but rxbuf_i=
dx
does not advance. Does this cause the loop to spin infinitely?

> @@ -375,6 +375,10 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
>  	usleep_range(980, 1000);
>  	ret =3D mcp_chk_last_cmd_status_free_bus(mcp);
> =20
> +out:
> +	mcp->rxbuf =3D NULL;
> +	mcp->rxbuf_size =3D 0;

[Severity: High]
Could this lockless clearing introduce a Time-Of-Check to Time-Of-Use race?

In mcp2221_raw_event(), which runs asynchronously in softirq context, the
code checks the pointer and then dereferences it:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
        if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
        ...
        buf =3D mcp->rxbuf;
        memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
}

If this function clears mcp->rxbuf concurrently after mcp2221_raw_event()
passes the check but before assigning it to buf, couldn't buf become NULL,
causing memcpy() to trigger a panic?

> +
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does the driver misuse the SMBus API,
potentially causing a kernel stack buffer overflow?

For I2C_SMBUS_BLOCK_DATA reads, the driver uses data->block[0] as the
input read length:

drivers/hid/hid-mcp2221.c:mcp_smbus_xfer() {
        case I2C_SMBUS_BLOCK_DATA:
                if (read_write =3D=3D I2C_SMBUS_READ) {
                        ...
                        ret =3D mcp_i2c_smbus_read(mcp, NULL,
                                                MCP2221_I2C_RD_RPT_START,
                                                addr, data->block[0] + 1,
                                                data->block);
}

If an in-kernel driver calls i2c_smbus_read_block_data(), data.block[0] is =
an
uninitialized stack variable. Does the driver then use this uninitialized
stack garbage as the read length, causing mcp2221_raw_event() to blindly co=
py
up to 255 bytes into the 34-byte data.block array on the caller's kernel
stack?

[Severity: High]
This isn't a bug introduced by this patch, but does mcp2221_raw_event()
perform out-of-bounds reads due to missing report size validation?

The function receives the size of the incoming HID report but never validat=
es
it before accessing fields far into the buffer:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
#if IS_REACHABLE(CONFIG_IIO)
                memcpy(&mcp->adc_values, &data[50], sizeof(mcp->adc_values)=
);
#endif
...
        case MCP2221_GET_SRAM_SETTINGS:
                switch (data[1]) {
                case MCP2221_SUCCESS:
                        memcpy(&mcp->mode, &data[22], 4);
}

If a malicious USB device presents a HID report descriptor with a very small
report size, will the driver read past the bounds of the allocation on the
kernel heap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728131442.8346=
04-1-yijiangshan@kylinos.cn?part=3D2
