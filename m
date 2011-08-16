From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid-multitouch: Filter collections by application usage.
Date: Tue, 16 Aug 2011 09:29:31 +0200
Message-ID: <CAN+gG=FzdOQrdr=wuRMGHw31GQqsm_0aoXVUXSx7qiQb5TmfsA@mail.gmail.com>
References: <1313451868-79836-1-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37709 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1HPH3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 03:29:32 -0400
In-Reply-To: <1313451868-79836-1-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jeffbrown@android.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, rydberg@euromail.se, chatty@enac.fr

Hi Jeff,

thank you for resubmitting this patch set.

Acked-By: Benjamin Tissoires <Benjamin_Tissoires@logitech.com>

Cheers,
Benjamin

On Tue, Aug 16, 2011 at 01:44,  <jeffbrown@android.com> wrote:
> From: Jeff Brown <jeffbrown@android.com>
>
> This change fixes two problems.
>
> First, it ensures that the hid-multitouch driver does not incorrectly
> map GenericDesktop usages that are intended for other applications,
> such as a Mouse.
>
> Second, it sets the appropriate input properties so that user-space
> can distinguish TouchScreen devices (INPUT_PROP_DIRECT) from
> TouchPad devices (INPUT_PROP_POINTER) and configure them accordingly.
>
> Signed-off-by: jeffbrown@android.com
> ---
> =A0drivers/hid/hid-multitouch.c | =A0 10 ++++++++++
> =A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 58d0e7a..4ee21ac 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -213,6 +213,16 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
> =A0 =A0 =A0 =A0struct mt_class *cls =3D td->mtclass;
> =A0 =A0 =A0 =A0__s32 quirks =3D cls->quirks;
>
> + =A0 =A0 =A0 /* Only map fields from TouchScreen or TouchPad collect=
ions.
> + =A0 =A0 =A0 =A0 * We need to ignore fields that belong to other col=
lections
> + =A0 =A0 =A0 =A0 * such as Mouse that might have the same GenericDes=
ktop usages. */
> + =A0 =A0 =A0 if (field->application =3D=3D HID_DG_TOUCHSCREEN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_DIRECT, hi->input->p=
ropbit);
> + =A0 =A0 =A0 else if (field->application =3D=3D HID_DG_TOUCHPAD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_POINTER, hi->input->=
propbit);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0switch (usage->hid & HID_USAGE_PAGE) {
>
> =A0 =A0 =A0 =A0case HID_UP_GENDESK:
> --
> 1.7.0.4
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
