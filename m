From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/3] HID: wacom: Consult the application usage when
 determining field type
Date: Tue, 25 Nov 2014 10:29:03 -0500
Message-ID: <CAN+gG=E8KsqqkaHTKadD-b+E3N3J2BQ+7S4F68X3ht+iVGbPMQ@mail.gmail.com>
References: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
	<1416871934-14133-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:53707 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaKYP3F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 10:29:05 -0500
Received: by mail-qg0-f46.google.com with SMTP id z107so568846qgd.5
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 07:29:04 -0800 (PST)
In-Reply-To: <1416871934-14133-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Mon, Nov 24, 2014 at 6:32 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> It is not necessarily sufficient to look only at the physical and logical
> usages when determining if a field is for the pen or touch. Some fields
> are not contained in a sub-collection and thus only have an application
> usage. Not checking the application usage in such cases causes us to
> ignore the field entirely, which may lead to incorrect behavior.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---

This one is Rev-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/wacom_wac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 9565d31..1468f00 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1484,9 +1484,11 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
>  }
>
>  #define WACOM_PEN_FIELD(f)     (((f)->logical == HID_DG_STYLUS) || \
> -                                ((f)->physical == HID_DG_STYLUS))
> +                                ((f)->physical == HID_DG_STYLUS) || \
> +                                ((f)->application == HID_DG_PEN))
>  #define WACOM_FINGER_FIELD(f)  (((f)->logical == HID_DG_FINGER) || \
> -                                ((f)->physical == HID_DG_FINGER))
> +                                ((f)->physical == HID_DG_FINGER) || \
> +                                ((f)->application == HID_DG_TOUCHSCREEN))
>
>  void wacom_wac_usage_mapping(struct hid_device *hdev,
>                 struct hid_field *field, struct hid_usage *usage)
> --
> 2.1.3
>
