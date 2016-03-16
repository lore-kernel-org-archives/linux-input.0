From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
Date: Wed, 16 Mar 2016 11:47:56 -0300
Message-ID: <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33513 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934858AbcCPOr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 10:47:57 -0400
Received: by mail-io0-f195.google.com with SMTP id g203so4226074iof.0
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 07:47:57 -0700 (PDT)
In-Reply-To: <1458129209-15449-1-git-send-email-afaerber@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-input@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Julien Chauveau <chauveau.julien@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

Hello Andreas,

On Wed, Mar 16, 2016 at 8:53 AM, Andreas F=C3=A4rber <afaerber@suse.de>=
 wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>
> Rename sub-nodes to avoid new dtc unit address warnings when copied.
>
> While at it, adopt the dashes convention for the node name.
>
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
