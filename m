Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FE1E7C23
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046196; cv=none; b=Il/jbamoFNcS1U+/5UzjjnhAmo9NbjHlWTXaZvcaAtXo7H82pyumOgYS+j7vMqt/bVYTUCs9vzI+EuEUOXB9rNzb6sqQvjDVirRP8yFOhY2GD1MawNRSFBb6iqwY2Z1AXtNrj2zf6aNaLKexyhDqzx7XdHp0dgfJbPEt5p2DnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046196; c=relaxed/simple;
	bh=IpzQwNX0MlzlMPSB9TjCIHnWBau5kccTq+OzrZkxfGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZj7DIDb8xBtPUzPWr8KQQxcUJRbs6zU/uXdlt/mbHdNAvDCru290phmGkdYHqqTrHcQJxk1Ot3VyaEnKyEsjiD8z3JzTePVHc7BMDzXDDr2xmP3N4gtWEMtDsslpwZRH+3TOuaEPPkHarBijcCVtJWT3ssuqAJpOQnxHZ0hQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtQqep+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtQqep+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CC91F000FF;
	Tue, 22 Sep 2026 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046194;
	bh=b3LHD/oyQLDP9bFuaa3vYxZr64+jxO71ePwXFhRacJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WtQqep+Z6oOfmu1VChMjwjMw9D38xTeZdXXgbpHx8tZJsAaG3h+b6CMTlrxt+UzVd
	 43nMjx+0QKKHi1W2xwk6h2G3GA7oWARnNQ0d7dkszTdG2n2avyuGavVW5CPHHZugl5
	 5fGwJwnn+CeDHV6dPx9e/u0cYQ+AcVkWg2kuxHh2yPcnr9dYEYiutk5oUin6bMdQQ9
	 Yk0rMVuowaeQBkESPaX+PHvAiANnTBpnTCtjORn/IV6ch+YnxWlYDWAer9sEvQb8Mu
	 nWZBIRRJzb0wdLI9e8/y2w4MgM9O9jtMuNre8AX042LI7nuOeeyexuxYBDBjmhXWtJ
	 I6/agCdhPfmzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: Intel-thc-hid: Intel-quicki2c: Fix buffer
 overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922024638.932865-2-even.xu@intel.com>
References: <20260922024638.932865-1-even.xu@intel.com>
 <20260922024638.932865-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:03:14 +0000
Message-Id: <20260922030314.82CC91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: intel-quicki2c: incomplete buffer fix and stale report_len =
causes -EINVAL for large payloads
--

commit 3ae5fe57bf2559497c69a1a1f4feb9ea45f51690
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Fix buffer overflow

The patch modifies buffer allocations in the intel-quicki2c driver to
account for packet headers in addition to the payload length. This is
intended to prevent buffer overflows when the payload reaches its maximum
size.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 0d2ad7bc3648a..2537288b50261 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -606,7 +606,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_=
device *qcdev)
>  	 */
>  	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4=
K);
> =20
> -	qcdev->input_buf =3D devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNE=
L);
> +	qcdev->input_buf =3D devm_kzalloc(qcdev->dev,
> +					HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);
>  	if (!qcdev->input_buf)
>  		return -ENOMEM;
> =20
> @@ -616,7 +617,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_=
device *qcdev)
>  	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_output_len),
>  			     max_report_len);
> =20
> -	qcdev->report_buf =3D devm_kzalloc(qcdev->dev, max_report_len, GFP_KERN=
EL);
> +	qcdev->report_buf =3D devm_kzalloc(qcdev->dev,
> +					 HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);

[Severity: Medium]
Does HIDI2C_PACKET_LEN() add enough space for the headers? It appears to on=
ly
add 2 bytes, but output operations and SET_REPORT might require up to 9 byt=
es
of command headers (e.g., cmd_reg, cmd, data_reg, length).

Also, qcdev->report_len is not updated to match the new size, remaining as
max_report_len just below this allocation.

Will this cause maximum-sized payloads to be incorrectly rejected with -EIN=
VAL?
In quicki2c_init_write_buf(), there is a bounds check:

    if (buf_len > write_buf_len)
        return -EINVAL;

This evaluates the total packet length (including headers) against the
unadjusted report_len (passed as write_buf_len), causing valid maximum-sized
payloads to be rejected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922024638.9328=
65-1-even.xu@intel.com?part=3D1
