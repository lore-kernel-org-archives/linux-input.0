From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 8/7] Input: synaptics - Remove X250 from the topbuttonpad list
Date: Fri, 27 Feb 2015 11:22:04 +0100
Message-ID: <CADscph1hyBDGS1Eh9_MSbZfE2sLy+SH+eC0wSNC+LEEt8WtFMg@mail.gmail.com>
References: <1423760953-30365-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:38010 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbB0KWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 05:22:06 -0500
In-Reply-To: <1423760953-30365-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org

On 12 February 2015 at 18:09, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Lenovo X250 has a PnpID of LEN0046, but it does not have
> the top software button requirement.

Confirmed.

> For the record, Lenovo T450s and W541 have a PnpID of
> LEN200f and LEN004a, so they are not on the top software
> button list.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Hi Dmitry,
>
> we got our hands on 3 new Lenovo laptops, and only one appears in the
> top buttonpad list. Again no need to CC stable this one I think.
>
> Cheers,
> Benjamin
>
>  drivers/input/mouse/synaptics.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 7267738..fa3d683 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -184,7 +184,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
>         "LEN0041",
>         "LEN0042", /* Yoga */
>         "LEN0045",
> -       "LEN0046",
>         "LEN0047",
>         "LEN0049",
>         "LEN2000",
> --
> 2.1.0

Reviewed-by: Daniel Martin <consume.noise@gmail.com>
