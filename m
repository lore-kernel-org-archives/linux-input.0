Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C194334B4;
	Mon,  3 Aug 2026 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782805; cv=none; b=tIu3NZm8ux10XX/+dqOuimaW7GDhRtjOXt7pD9IdrxVej7zZd2sP4i8eiom+QaUs/PN/EbTSWI63dzFgZEIvR8n7j0t5E6PvC0QQRpnH2bazX9CfXubQP9VMLmIglxvk8570/ti2TkMyQWgYRXmCPaBGhCkbMo4np0m91S/jwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782805; c=relaxed/simple;
	bh=rIMJRpl5kvXDmI1HGnpY7KwxLc0Ewml/cH/9GxZfWyU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i9fNJ3e1YVqSEjDnJO63BsFOyrOxSzQaU2Uaa2dJEJ2UQqJjMbe95qECsqGHUKnUYXY3k1Lr4lNeOz0QnR2LppIHQMn9X0ZaoTN+wcVrxkPjaaBm2Y4R7SvC10Vk3sSu+igQPxkV7uN5OjSVEKdvRwnEaMKtHv7dlT55wzN9a6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LArVBrbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LArVBrbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA821F00ADE;
	Mon,  3 Aug 2026 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782801;
	bh=ONvpdSDyouIRHCq5OCjGRc3aybzg8Rk7GZ3w/+urjws=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LArVBrbdOM+Ow7nvl2n3mC6EIyD9sL8EIaNqGqAUSluhaFRzQdTOXlsa454dx9vqf
	 oMWN1BhYAg8lNmEUUtf4IyXrG6kdZcaaQNXxFnnfBjPjTt0uVqMgZmJ9DxldYZ2gPr
	 xNCSJkEb+hG0KwcXATw59wxx/KfDHYJsO8IexDnGPv1GCi2LGwNlyX0FCQQMFTqdfa
	 zL+m2UQiPEudpEYmAYAhwl6XlvS7/dtayMQwaKV+51AUy+liBs4eN7drz9eT014gaO
	 3gR/qSdP6ovpoRxwTu4QpkQUeGzvU/PvbSH1sFR1r2xKgtc13uKN4PeB6VPELxvczr
	 I9GvcnO0jFPnQ==
Date: Mon, 3 Aug 2026 20:46:39 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Colin Blower <colin@1101b.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: Add support for G915 TKL receiver
 0xc545
In-Reply-To: <eb945a79-d9ef-4194-be41-2ec81d6d8f3c@app.fastmail.com>
Message-ID: <9qn62516-0053-9p16-o9nq-9s69407prs63@xreary.bet>
References: <eb945a79-d9ef-4194-be41-2ec81d6d8f3c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Jul 2026, Colin Blower wrote:

> The Logitech G915 TKL has a lightspeed receiver with a product id of
> 0xc545. This receiver seems to behave like 0xc547 receiver.
> 
> Add a definition for this new receiver id and a mapping for the
> recvr_type_gaming_hidpp_ls_1_3 type, the receiver now reports battery
> status of the connected keyboard.
> 
> Signed-off-by: Colin Blower <colin@1101b.com>
> ---
>  drivers/hid/hid-ids.h         | 1 +
>  drivers/hid/hid-logitech-dj.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1059922baaac..0089a5e88ec9 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -967,6 +967,7 @@
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2    0xc543
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3    0xc547
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4    0xc54d
> +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_5    0xc545
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY 0xc53a
>  #define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER   0xc548
>  #define USB_DEVICE_ID_SPACETRAVELLER   0xc623
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 381e4dc5aba7..49b96ff2bc36 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -2102,6 +2102,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>                 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
>          .driver_data = recvr_type_gaming_hidpp_ls_1_3},
> +       { /* Logitech lightspeed receiver (0xc545) */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_5),
> +        .driver_data = recvr_type_gaming_hidpp_ls_1_3},
> 
>         { /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),

Your mail client whitespace-damaged this patch. I've fixed it manually and 
applied, but please look into fixing it for your further submissions.

Thanks,

-- 
Jiri Kosina
SUSE Labs

