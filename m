From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 1/2] HID: Show I2C bus type in hid_connect()
Date: Tue, 29 Sep 2015 08:35:05 +0200
Message-ID: <CADscph2Dv+TwELECbw7tDkKv0je4euie03pi-s_duhFn7ZZh=w@mail.gmail.com>
References: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36485 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbbI2GfG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 02:35:06 -0400
Received: by ykdt18 with SMTP id t18so204378327ykd.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 23:35:05 -0700 (PDT)
In-Reply-To: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>

On 28 September 2015 at 14:15, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> For I2C HID devices output currently looks like:
>
>   hid-multitouch ... input,hidraw0: <UNKNOWN> HID v1.00 Mouse ...
>
> Add knowledge about I2C bus to hid_connect() so that it shows "I2C"
> correctly instead of "<UNKNOWN>".
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/hid/hid-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 70a11ac38119..7f1baba081a1 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1678,6 +1678,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>         case BUS_BLUETOOTH:
>                 bus = "BLUETOOTH";
>                 break;
> +       case BUS_I2C:
> +               bus = "I2C";
> +               break;
>         default:
>                 bus = "<UNKNOWN>";
>         }

Already queued:
    https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-4.4/upstream&id=0678072755b6672b19ee0fd42748a003912fca09
