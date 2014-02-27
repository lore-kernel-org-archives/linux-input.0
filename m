From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: Re: [PATCH 2/4] Input: wacom: Override 'pressure_max' with value from HID_USAGE_PRESSURE
Date: Thu, 27 Feb 2014 10:39:25 -0800
Message-ID: <CAEoswT3VMyrzBbhsP7qMFaQxQR4HG=gseRTQA9f97Ou70cXzgw@mail.gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
	<1391107728-1306-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:63636 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaB0Sj0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Feb 2014 13:39:26 -0500
Received: by mail-vc0-f172.google.com with SMTP id lf12so2925699vcb.31
        for <linux-input@vger.kernel.org>; Thu, 27 Feb 2014 10:39:25 -0800 (PST)
In-Reply-To: <1391107728-1306-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Thu, Jan 30, 2014 at 10:48 AM, Jason Gerecke <killertofu@gmail.com> wrote:
> The 0xEC sensor is used in multiple tablet PCs and curiously has
> versions that report 256 levels of pressure (Samsung Slate 7)
> as well as versions that report 1024 levels (Lenovo Thinkpad Yoga).
> To allow both versions to work properly, we allow the value of
> HID_USAGE_PRESSURE reported to override pressure_max.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_sys.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index 5be6177..611fc39 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -24,6 +24,7 @@
>  #define HID_USAGE                      0x09
>  #define HID_USAGE_X                    ((HID_USAGE_PAGE_DESKTOP << 16) | 0x30)
>  #define HID_USAGE_Y                    ((HID_USAGE_PAGE_DESKTOP << 16) | 0x31)
> +#define HID_USAGE_PRESSURE             ((HID_USAGE_PAGE_DIGITIZER << 16) | 0x30)
>  #define HID_USAGE_X_TILT               ((HID_USAGE_PAGE_DIGITIZER << 16) | 0x3d)
>  #define HID_USAGE_Y_TILT               ((HID_USAGE_PAGE_DIGITIZER << 16) | 0x3e)
>  #define HID_USAGE_FINGER               ((HID_USAGE_PAGE_DIGITIZER << 16) | 0x22)
> @@ -465,6 +466,14 @@ static int wacom_parse_hid(struct usb_interface *intf,
>                                         wacom_retrieve_report_data(intf, features);
>                                 i++;
>                                 break;
> +
> +                       case HID_USAGE_PRESSURE:
> +                               if (pen) {
> +                                       features->pressure_max =
> +                                               get_unaligned_le16(&report[i + 3]);
> +                                       i += 4;
> +                               }
> +                               break;
>                         }
>                         break;
>
> --
> 1.8.5.3
>
Tested-by: Aaron Skomra <Aaron.Skomra@wacom.com>
