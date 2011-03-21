From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v3 5/5] hid-multitouch: migrate 3M PCT touch screens to hid-multitouch
Date: Mon, 21 Mar 2011 20:56:59 +0100
Message-ID: <AANLkTimFF3pgMMgOcEhYnRm5adgsCL5S6Hjkz+GFcpCT@mail.gmail.com>
References: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
	<1300454876-5017-6-git-send-email-benjamin.tissoires@enac.fr>
	<20110321090533.GE3784@polaris.bitmath.org>
	<AANLkTinAPFnHA=MWbb=Yu7U0AXrxHv2-95M=OequsAL7@mail.gmail.com>
	<20110321190606.GA1792@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40933 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab1CUT5B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 15:57:01 -0400
In-Reply-To: <20110321190606.GA1792@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

thanks a lot for spotting this.
I think the modification is safe, but I'll give a final test tomorrow
against our hardware.

Thanks,
Benjamin

On Mon, Mar 21, 2011 at 20:06, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> I tested it against 3M1968. I'll try to have it again to make more t=
esting.
>> What symptoms do you have?
>
> With the modification below, it works as expected, and you can add
>
> =A0 =A0Reviewed-and-tested-by: Henrik Rydberg <rydberg@euromail.se>
>
> Thanks!
>
> Henrik
>
> ---
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 7684e96..0f5b89f 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -424,6 +424,8 @@ static int mt_event(struct hid_device *hid, struc=
t hid_field *field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->last_field_inde=
x && field->index =3D=3D td->last_field_index)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fallback to the gen=
eric hidinput handling */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
