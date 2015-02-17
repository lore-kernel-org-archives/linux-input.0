From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Mon, 16 Feb 2015 22:23:03 -0500
Message-ID: <CAN+gG=F7kJXmvCV7CiQxfdn9wv8a9EkcLjaj9G8fbV=hqkYecQ@mail.gmail.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:40836 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbbBQDXE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 22:23:04 -0500
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Feb 6, 2015 at 3:04 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> This is the second episode of the Lenovo 2015 party :)
>
> Thanks to Andrew, we now have an idea within the driver of what are the extra
> buttons aimed for, and the patch series looks cleaner.
> Many thanks for your help.
>
> I marked only patches 1/7, 2/7 and 3/7 as stable because they are really
> stable fixes. Without the rest of the series, user-space can cope with the
> kernel result, and so there is IMO no need to backport too many patches in
> stable. I bet distributions will cherry-pick the rest of the series however.
>

Guys,

any chances we consider this for 3.20 (or whatever it will be numbered)?
I'd really like to see this accepted upstream in one way or one other
so we will prevent the mess we had to deal with last year.

Cheers,
Benjamin

> Benjamin Tissoires (7):
>   Input: synaptics - fix middle button on Lenovo 2015 products
>   Input: synaptics - handle spurious release of trackstick buttons
>   Input: synaptics - do not retrieve the board id on old firmwares
>   Input: synaptics - retrieve the extended capabilities in query $10
>   Input: synaptics - remove TOPBUTTONPAD property for Lenovos 2015
>   Input: synaptics - re-route tracksticks buttons on the Lenovo 2015
>     series
>   Input: synaptics - Remove X1 Carbon 3rd gen from the topbuttonpad list
>
>  drivers/input/mouse/synaptics.c | 129 +++++++++++++++++++++++++++++-----------
>  drivers/input/mouse/synaptics.h |  28 +++++++++
>  2 files changed, 122 insertions(+), 35 deletions(-)
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
