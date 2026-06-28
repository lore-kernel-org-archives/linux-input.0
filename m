Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686434E74B
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640265; cv=none; b=LSteZa0CPH5O0UgiGbUPhxdEdGgxMzcgz3Iiao8W1aUM+i175orsee4FV3GSlyHAoanStu+wScMXN/S35HRjTDUuNvWE1/kRjLEH2e+jAkrM2EqeHXWUfAYdF+TNJqhOaSsz5jdRiZiKtceeeDx2VEq7ggCd6E+K3vTD2f56zKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640265; c=relaxed/simple;
	bh=35SNSucFb/Uzrykl2zEjnF+mYflAqPZh4HwGT+NVpbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZx7r7lJ7Ts4Jg0WXyQ2bqE/NwMZqTD3Ikj+X9u+6DHTNmBZpIlLIkaIyAp9pnBcNyuzRYX0huoAtVlGX9xgwlrbOaSS4VsV+W040oWn/QkB1JbefJAn5IQw/Lej5ZgGppOpkMTvwJMCH6Chc3AiNsxuqkaW+OFkfUtVLSTWYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVTDoaPo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVTDoaPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105A41F000E9;
	Sun, 28 Jun 2026 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782640262;
	bh=QHJmB5kOGr4b4/MZbWP7J7WkiLkxYHIF2ZOcK1Bo1/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVTDoaPoalblNezab/0ENgzeZb/YSzs/uyaQeAOipcBSeURu1YW++H2EJgQLv7bif
	 AVtvxKfw/pzVyq2itXwDECVRA3fZwNqWDF2KzpzfMcA1oRsQ8ldb2U5Hv/h5elMBYR
	 R2KPDASFH+gHTQOcpO5uZLv6glHlHkNY7knMX52qk/q0mm61kyb6DkCq6InCIa8/I2
	 SB+W9Y+S9ImxKywz3GfSDKO9Ppec3zQTFxkI3jEdCGUYkkTpKoVvh3CWTQOuhLS5qJ
	 XK7QwQZnZvcm0jwiImPZWxkJQQ9PMN3RxiGfQi4YTQBH8h8ve3+rtukdYQpdd9LDlT
	 6a06hbRVMoUAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2221: reject short input reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628093658.43445-1-alhouseenyousef@gmail.com>
References: <20260628093658.43445-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 09:51:01 +0000
Message-Id: <20260628095102.105A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free and kernel stack corruption due to un-cleared m=
cp->rxbuf on timeout.
- [Critical] Stack buffer overflow due to using uninitialized memory as I2C=
 read length.
- [High] Delayed USB reports indiscriminately complete pending waits, causi=
ng state desynchronization.
- [High] Static retries variable underflow causes infinite loop of workqueu=
e rescheduling.
--

commit 421d556dea19ceb8f40a640c782b6801d60f43cd
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: mcp2221: reject short input reports

The MCP2221 raw-event callback reads fixed offsets from the 64-byte input
report, including data[50] and a variable payload beginning at data[4].
This rejects reports whose size does not match the protocol and completes
the pending command with -EMSGSIZE.

Closes: https://syzkaller.appspot.com/bug?extid=3D1018672fe70298606e5f

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index e4ddd8e9293b6..311b51c17b4e4 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -861,6 +861,12 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  	u8 *buf;
>  	struct mcp2221 *mcp =3D hid_get_drvdata(hdev);
> =20
> +	if (size !=3D sizeof(mcp->txbuf)) {
> +		mcp->status =3D -EMSGSIZE;
> +		complete(&mcp->wait_in_report);
> +		return 1;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does mcp2221_raw_event() indiscriminately
complete pending waits for any incoming report without matching it to the
pending request?

If a previous request times out, and a delayed USB response arrives later,
it appears it could prematurely wake up a new command's wait queue with
incorrect status and data:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
	...
	case MCP2221_I2C_WR_DATA:
	...
		complete(&mcp->wait_in_report);
		break;
	...
}

[Severity: Critical]
This isn't a bug introduced by this patch, but can this lead to stack
corruption if a request times out?

In mcp_i2c_smbus_read(), if mcp_send_data_req_status() fails or times out,
it returns immediately without clearing mcp->rxbuf:

drivers/hid/hid-mcp2221.c:mcp_i2c_smbus_read() {
	...
	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 4);
	if (ret)
		return ret;
	...
}

Since mcp->rxbuf can point to a caller-provided stack buffer (like
union i2c_smbus_data), the stack frame is popped upon return. If a delayed
USB response arrives later, wouldn't mcp2221_raw_event() blindly write into
this dangling mcp->rxbuf pointer?

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
	...
			if (data[2] =3D=3D MCP2221_I2C_READ_COMPL ||
			    data[2] =3D=3D MCP2221_I2C_READ_PARTIAL) {
				...
				buf =3D mcp->rxbuf;
				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
	...
}

[Severity: Critical]
This is a pre-existing issue, but does mcp_smbus_xfer() use uninitialized
stack memory as the I2C read length during a block read?

drivers/hid/hid-mcp2221.c:mcp_smbus_xfer() {
	...
			ret =3D mcp_i2c_smbus_read(mcp, NULL,
						MCP2221_I2C_RD_RPT_START,
						addr, data->block[0] + 1,
						data->block);
	...
}

The union i2c_smbus_data provided by the caller is uninitialized stack memo=
ry
on read. This configures mcp->rxbuf_size to an arbitrarily large value. Cou=
ld
this lead to a massive stack buffer overflow when mcp2221_raw_event() copies
up to this value into the statically sized 34-byte data->block stack buffer?

[Severity: High]
This is a pre-existing issue, but could the statically scoped retries varia=
ble
in mcp_init_work() cause an infinite reschedule loop?

drivers/hid/hid-mcp2221.c:mcp_init_work() {
	static int retries =3D 5;
	...
reschedule_task:
	...
	if (!retries--)
		return;

	/* Device is not ready to read SRAM or FLASH data, try again */
	schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
}

Since retries is static, when initialization fails 6 times, it reaches 0,
returns, and decrements to -1. On a subsequent failure, retries starts at -=
1.
Because !(-1) is false, it bypasses the return, decrements to -2, and
unconditionally schedules the delayed work every 100ms forever.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628093658.4344=
5-1-alhouseenyousef@gmail.com?part=3D1
