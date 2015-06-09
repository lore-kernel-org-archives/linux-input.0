From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] USB: HID: Fix fields from pen report ID being interpreted
 for multitouch.
Date: Tue, 9 Jun 2015 17:47:54 -0400
Message-ID: <CAN+gG=FaVGZs1-K0xQ2ESO32NL6qG1OfGuVpzyqbdbVR-m0=Dg@mail.gmail.com>
References: <1433881917-3627-1-git-send-email-brentadam@smarttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36818 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbbFIVrz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 17:47:55 -0400
In-Reply-To: <1433881917-3627-1-git-send-email-brentadam@smarttech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brent Adam <brentadamdev@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brent Adam <brentadam@smarttech.com>

On Tue, Jun 9, 2015 at 4:31 PM, Brent Adam <brentadamdev@gmail.com> wrote:
> Fields like HID_DG_CONTACTCOUNT are outside of the physical collection,
> but within the application collection and report ID.  Make sure to catch
> those fields that are not part of the mt_report_id and return 0 so they
> can be processed with the pen.  Otherwise, the wrong HID_DG_CONTACTCOUNT
> will be applied to cc_index and result in dereferencing a null pointer in
> mt_touch_report.
>
> Signed-off-by: Brent Adam <brentadam@smarttech.com>
> ---
>  drivers/hid/hid-multitouch.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 6a9b05b..2ee8800 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -781,6 +781,9 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>          */
>         if (field->physical == HID_DG_STYLUS)
>                 return 0;
> +       else if ((field->physical == 0) &&
> +                (field->report->id != td->mt_report_id))

Hmm... That seems wrong.
td->mt_report_id is set in mt_touch_input_mapping(), so checking for
it before even entering the function seems a little bit odd and
activates my bug alert system :)

Could you please share the report descriptor of the device you are
trying to fix? Ideally, if you could get this by running hid-recorder
(http://bentiss.github.io/hid-replay-docs/) that would be even better
because you could also record some events from the pen and from the
touch.

I would also like to see a comment in the code which explains why we
need to have a special case to abort earlier.

Cheers,
Benjamin

> +               return 0;
>
>         if (field->application == HID_DG_TOUCHSCREEN ||
>             field->application == HID_DG_TOUCHPAD)
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
