Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693EF3D47DB
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656940; cv=pass; b=UbrVv3b+6cLk4nP0zAexnccAIqOE3JUnW7btKPVxtrrTrJV6jdVZeoQuyfPtsxHmS1UzAfroyRk63kWsafNkIdt4w7NwYm6NttahpqdIiRa/FtvMxfNXqadfWdQlNvP6IaA0RUGaHzCiHVoA5GwRXRgHVvupYUGmkD4zSQ3YwnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656940; c=relaxed/simple;
	bh=fw4l6Y9kpKC050algLTER/1Mw6N22TkDOhBPegwIMFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKvToq1VVeSKEjwOLlvzmljfga2MfIHt5Z5gFkLe0JetoJbSBAVauC5t3gGdFM5T4LPKuwEgQxCZc+DBMbZCMWY1NIfa6qaR/pn5+ORM47kEBklVdyzLRx6AcCDrN2zbEeSkCOxe/Np3T0o7kFyWURxclwunDbUBs0sROXc+TC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkzzLs2D; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkzzLs2D"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso84888586d6.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 00:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778656938; cv=none;
        d=google.com; s=arc-20240605;
        b=bIKFIHK0kBzv64sK1sqXEmHzOTJdepz6ML2Vw1vpXxWyQrye0zxi4Wu7OUSnpgDGI+
         h3E+YPEHOWyhUShIXuLjNb3GKyg73W80CelS7iaf3K88V3BoZgcZmGz6MVpWz9w44Lo3
         DeBAqSHDznrytlJfxnpmSdAaq+ongz11f7IyIQxNXoBLGuS1WOMSooeAJhS7uwFFFZlB
         LIPhNV2q6VNuOmEesIFPRuM1qmHpu6wArZe5u1m/FXtTHcTKZXXNgTEWkdrv9pTk/3SI
         jfIHzgtHVMO5J+pRiSMvwJsF0LUleqLZ8HLD1cFRa1qZRhVUw5XkFKxVC+jeT+IplXqA
         umCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxIsDtM+kZD8aHQyQ8BqjHfjjKGIY780pGvgJoNLbYk=;
        fh=rNN5BMwzx0Rq+SHMLACxqj6HL7q/poqqnvglPkzWSWY=;
        b=XMaBp5ZDP8DtLsoRA2Mo//yI/IVwTxZHAQqBBBrDMYRsjSEPkvRDVkaqv8mcPL1eCR
         D7Dd5yl2/nUcStj1p4XvkkNg8ajuToL0jCu70oFDkxHEyAFdVZbcLJMgIfo0L41DbvUW
         aejiMZHMAlLDI4v0ioVGQ2C9XZeDSXPxY1QP9NNF1ZjC2A3JXPRIrXyaEEtvSLyK7cc7
         1rb8PwDNajRECVxhclgUXYgv6rV+tsi0/Kns7JdFFZpSA4yJ6/1t/99mw8JprDthFEQ3
         cLengs2l2AYz+d6V1yeEWBGZ3e1/Q6P4xRJaJgCTGjNRzW92FSbOA4UEQu5aMlCvFNf5
         h0zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778656938; x=1779261738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxIsDtM+kZD8aHQyQ8BqjHfjjKGIY780pGvgJoNLbYk=;
        b=HkzzLs2Dih+BwcgUDmz1NLZe3ljwG9wAFZC74s9bW0CJylx8Fqk0F7+wbnhpgbD8pL
         I+T9j4UM4LkpYUEHHGIsVZlGD7aeZQo2GnBsgva/gW3d/BeNG0MWIXOn/rpCCaMeERr/
         NestRZXOy/nv1A0AduJ/m2RkmZ+7TfBm2Q3emO2X/tsGIRTVOenuhYanrXaSrBuU2TqD
         Mu2/VoUMQhW0rp0YG8TTa48sZnK02fuBkPHU8XcmhOfVowQ1wF7B/bci8oSuez2aqteG
         I+tY1qqnxiHbnHsq+iZQ0HKCJgTKTV9U5s/mDwIFfyYwGlUFzI/UQEKgztBRwta5fdeN
         DLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778656938; x=1779261738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxIsDtM+kZD8aHQyQ8BqjHfjjKGIY780pGvgJoNLbYk=;
        b=c3ICxZ11qg/9eIINhZ5AlKUGPOjnmiX4SiH7UV+6q17lodSUTzz15jh4E8Vtyk9k/L
         h4FPhiJ0UPO/iP/3+gplc1HvXet7+ThHYw0hRxToeV8RuRttGwGmP1hJdw2o5dFP7LcN
         /brn2FxEitdr79v7CbgXiQaqm/Dc7dxhTt0M2oL64qkr04zUyWP1pWIJ14Fr4tkG2mFH
         gaU3zOmPbCj/hjAyX1xM1r//0WsxOP3y31fkgnWBtX+qAw+1IeIudfznH7bL2JKL3yRu
         mWbWKHv4zjfu1udCdep79Ui4AEj4UMbEORnV78lO3lxqiD42LCXx0/ld+VwNFyCfnC1S
         0AgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QPdMMpnODcEH5NZP0rxloGvcjVOKYAnJCN4atmkOmuEJaPgiUmNMB/DVTAAc4ZJMi5QlfeBqaofQ4uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNiPUnZ9vziFnWHNicNdbiB9nku2ZLCe6df9T9AnO6EV2jvp2K
	NTBBmvhNPW+30qBqtc1fhrZmQatXXuujw6t8wUzaA9fsuy9YP7u9qmQViXzRiFLxAPC5E5ekEPB
	0EzcC3QNj8cwnh2utAN+em1Cf/ciwglylF+yNUatP
X-Gm-Gg: Acq92OGtsLTY2NTCnPERpeSpFwJdj4JWddsZY4OC6524C/ld5VEiQx2+HhqqDQ8+T4D
	eOoO7cjhtc2YOswGmEQF2fTctw7LH/c4m6BbuVPkUj98r0FlT5SzB6faGlMme+OfsDb6QDLbp0e
	179PjsCACWIu6jAFqnca8MqxEhqdShn0lokEN1Po3rJbGdxSzHNTZhtrvfm5rSkuF2JKSiQP8F1
	bslRXUiW6Z0iYmvW134R8Tib7KBDYIm5xXgNCYSteiBf++Lpmvpy5QhiXtVp1cqIJO+OtqSC3kW
	DXaWB2006oX1q9NG/ow/Rnf8a23eVb+pB6J9Q6ucHqqfbTQ=
X-Received: by 2002:ad4:5de2:0:b0:8a4:58ff:f0f8 with SMTP id
 6a1803df08f44-8c7bc91aee7mr39517186d6.29.1778656937884; Wed, 13 May 2026
 00:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415114752.1181079-1-bsevens@google.com> <417rqoq0-1q2q-r96q-p258-240n74nr3n14@xreary.bet>
In-Reply-To: <417rqoq0-1q2q-r96q-p258-240n74nr3n14@xreary.bet>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Wed, 13 May 2026 09:22:06 +0200
X-Gm-Features: AVHnY4Izbu0Ai7nyIzCLs8uOUlEqsAXjajieTz9n8wj66x1tZU2-nY6BVcW8kjg
Message-ID: <CAGCho0UsyC5-c9r-EvNE1TG-O=jQDGdSu1gz18aY1hdaKpwC9A@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: Fix heap buffer overflow in mcp2221_raw_event()
To: Jiri Kosina <jikos@kernel.org>
Cc: Rishi Gupta <gupt21@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 at 17:47, Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 15 Apr 2026, Benoit Sevens wrote:
>
> > From: Beno=C3=AEt Sevens <bsevens@google.com>
> >
> > A heap buffer overflow can occur in the mcp2221_raw_event() function
> > when handling I2C read responses. The driver failed to check if the
> > total incoming data length fits within the originally allocated buffer
> > `mcp->rxbuf`.
> >
> > Fix this by introducing `rxbuf_len` to `struct mcp2221` to keep track
> > of the allocated buffer size. Initialize it in `mcp_i2c_smbus_read()`
> > and `mcp_smbus_xfer()`, and ensure the copied data length combined with
> > the current index does not exceed this length in `mcp2221_raw_event()`.
> >
> > Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
>
> Unfortunately the patch seems to have been somehow mangled by your mail
> client:
>
>         patching file drivers/hid/hid-mcp2221.c
>         Hunk #1 succeeded at 126 (offset 7 lines).
>         Hunk #2 FAILED at 324.
>         patch: **** malformed patch at line 173: u16 addr,
>
> Fix for the same issue has later been submitted by Florian Pradines [1],
> so I will be taking that one and adding you as Reported-by: or so, ok?
>
> Thanks.
>
> [1] https://lore.kernel.org/all/20260509094517.2691246-1-florian.pradines=
@gmail.com/
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

That sounds good to me. Thanks for adding me in the Reported-by

One thing though: Florian's patch doesn't set `mcp->rxbuf_size` in all
places. I believe it should be set in every place where `mcp->rxbuf`
is set. There are 2 places in `mcp_smbus_xfer` where it is missing
(see my original patch):

```c
@@ -538,6 +541,7 @@ static int mcp_smbus_xfer(struct i2c_adapter
*adapter, u16 addr,

                        mcp->rxbuf_idx =3D 0;
                        mcp->rxbuf =3D data->block;
+                       mcp->rxbuf_size =3D sizeof(data->block);
                        mcp->txbuf[0] =3D MCP2221_I2C_GET_DATA;
                        ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 1=
);
                        if (ret)
@@ -561,6 +565,7 @@ static int mcp_smbus_xfer(struct i2c_adapter
*adapter, u16 addr,

                        mcp->rxbuf_idx =3D 0;
                        mcp->rxbuf =3D data->block;
+                       mcp->rxbuf_size =3D sizeof(data->block);
                        mcp->txbuf[0] =3D MCP2221_I2C_GET_DATA;
                        ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 1=
);
                        if (ret)
```

Thanks,

Benoit
