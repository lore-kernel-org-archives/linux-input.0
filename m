From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH 6/7] HID: logitech-hidpp: support the G700 over wireless
Date: Fri, 7 Sep 2018 10:33:15 -0700
Message-ID: <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com> <20180907103450.13890-7-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-7-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com
Cc: jikos@kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, simon@mungewell.org, Olivier Gay <ogay@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Fri, 7 Sep 2018 at 03:35, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> The G700 is using a non unifying receiver, so it's easy to add its support
> in hid-logitech-hidpp now.
> [snip]
> @@ -3671,6 +3671,9 @@ static const struct hid_device_id hidpp_devices[] = {
>         { /* Solar Keyboard Logitech K750 */
>           LDJ_DEVICE(0x4002),
>           .driver_data = HIDPP_QUIRK_CLASS_K750 },
> +       { /* G700 over Wireless */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
> +         .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },

As someone who's new to the codebase, it seems rather confusing to me
that HIDPP_QUIRK_UNIFYING would be present here for a device that
doesn't use a Unifying receiver. Am I misunderstanding, or should we
consider renaming the quirk or adding some clarifying comment?
(Similarly for the G900 in the next patch.)

>
>         { LDJ_DEVICE(HID_ANY_ID) },
>
> --
> 2.14.3
>

Thanks,

Harry Cutts
Chrome OS Touch/Input team
