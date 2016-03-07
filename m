From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Date: Mon, 7 Mar 2016 15:34:44 -0300
Message-ID: <CABxcv=kEDoP3_Q3OKh1rGJ3=nFxRydu7L7bv5C=bNbmXyFt8dQ@mail.gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35520 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbcCGSe6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2016 13:34:58 -0500
Received: by mail-ig0-f194.google.com with SMTP id ww10so823573igb.2
        for <linux-input@vger.kernel.org>; Mon, 07 Mar 2016 10:34:44 -0800 (PST)
In-Reply-To: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-input@vger.kernel.org, linux-rockchip@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Julien Chauveau <chauveau.julien@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hello Andreas,

On Mon, Mar 7, 2016 at 3:24 PM, Andreas F=C3=A4rber <afaerber@suse.de> =
wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
