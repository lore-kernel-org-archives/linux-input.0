From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 22/22 v4] Input: atmel_mxt_ts - parse T6 reports
Date: Mon, 18 Jun 2012 23:29:59 +0800
Message-ID: <CAGS+omDgwEYMOPxsk4gjbZSO7ocz=PPzqtowBEsfnRb=0ogi4w@mail.gmail.com>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
 <1339992522-22073-23-git-send-email-djkurtz@chromium.org> <4FDF44C1.70500@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36220 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab2FRPaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 11:30:20 -0400
Received: by gglu4 with SMTP id u4so3766168ggl.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jun 2012 08:30:19 -0700 (PDT)
In-Reply-To: <4FDF44C1.70500@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org

On Mon, Jun 18, 2012 at 11:09 PM, Nick Dyer <nick.dyer@itdev.co.uk> wro=
te:
> Daniel Kurtz wrote:
>> The normal messages sent after boot or NVRAM update are T6 reports,
>> containing a status, and the config memory checksum. =A0Parse them a=
nd dump
>> a useful info message.
>
> This can cause a lot of dmesg output - for instance you get 2 message=
s per
> calibration, and the chip can trigger them itself if noise suppressio=
n or
> anti-touch calibration are enabled. So perhaps dev_dbg()?

Sounds good to me.

>
> --
> Nick Dyer
> Software Engineer, ITDev Ltd
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
