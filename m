From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [hid-multitouch] supported device details
Date: Mon, 23 Jan 2012 10:44:51 +0100
Message-ID: <CAN+gG=HaoL5Nd2NTctBfdSE5Mt4Nz9zAhuTJwAz9ZFrEsKoxcg@mail.gmail.com>
References: <1327304925.2789.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35239 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab2AWJow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jan 2012 04:44:52 -0500
Received: by werb13 with SMTP id b13so1936940wer.19
        for <linux-input@vger.kernel.org>; Mon, 23 Jan 2012 01:44:51 -0800 (PST)
In-Reply-To: <1327304925.2789.2.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gustavo <gjasso@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gustavo,

thanks for the pid.

Out of curiosity, why do you need the vendor driver?
I tested it, and the only thinks it does with my eGalax is to invert Y =
axis.

Cheers,
Benjamin

On Mon, Jan 23, 2012 at 08:48, Gustavo <gjasso@gmail.com> wrote:
> Hi, here is the lsusb output for an eGalax touchscreen properly detec=
ted
> by hid-multitouch (also needs vendor driver):
>
> Bus 004 Device 002: ID 0eef:725e D-WAV Scientific Co., Ltd
>
> --
> Gustavo
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
