From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 2/4] HID: uclogic: merge hid-huion driver in hid-uclogic
Date: Wed, 25 Feb 2015 23:04:42 +0200
Message-ID: <54EE38EA.40702@gmail.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com> <1424822730-14938-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424822730-14938-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
>
> Merge the hid-huion driver into hid-uclogic as all the devices supported
> by hid-huion are in fact UC-Logic devices.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Changed from the original patch:
> - update Makefile, Kconfig accordingly
> - remove one extra pr_err when kzalloc failed (raised by checkpatch.pl)
>
>   drivers/hid/Kconfig       |   8 +-
>   drivers/hid/Makefile      |   1 -
>   drivers/hid/hid-huion.c   | 290 ----------------------------------------------
>   drivers/hid/hid-uclogic.c | 229 +++++++++++++++++++++++++++++++++++-
>   4 files changed, 229 insertions(+), 299 deletions(-)
>   delete mode 100644 drivers/hid/hid-huion.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 152b006..8a55fd7 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -286,12 +286,6 @@ config HID_GT683R
>   	Currently the following devices are know to be supported:
>   	  - MSI GT683R
>
> -config HID_HUION
> -	tristate "Huion tablets"
> -	depends on USB_HID
> -	---help---
> -	Support for Huion 580 tablet.
> -
>   config HID_KEYTOUCH
>   	tristate "Keytouch HID devices"
>   	depends on HID
> @@ -314,7 +308,7 @@ config HID_UCLOGIC
>   	tristate "UC-Logic"
>   	depends on HID
>   	---help---
> -	Support for UC-Logic tablets.
> +	Support for UC-Logic and Huion tablets.

I'm not sure this is worth changing. We'll need to at least add Yiynova and
Ugee here later, which we're likely to forget. Meanwhile, essentially, they're
UC-Logic underneath.

Apart from this (which can be left as is, IMHO):

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

BTW, will you be submitting changes to digimend-kernel-drivers to align it
with what you're submitting upstream?

Nick
