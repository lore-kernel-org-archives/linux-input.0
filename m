From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 23/27] HID: wacom: leds: use the ledclass instead of
 custom made sysfs files
Date: Tue, 12 Jul 2016 11:42:02 +1000
Message-ID: <20160712014202.GA25180@jelly.local>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
 <1467729563-23318-24-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:11006 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcGLBmN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 21:42:13 -0400
Content-Disposition: inline
In-Reply-To: <1467729563-23318-24-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jul 05, 2016 at 04:39:19PM +0200, Benjamin Tissoires wrote:
> The now obsolete sysfs files for LEDs and EKRemote are kept for backward
> compatibility.
> Both the EKR (read-only) and the regular Cintiqs and Intuos are now
> sharing the same led API.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-wacom |   5 +
>  drivers/hid/wacom.h                          |  19 +++
>  drivers/hid/wacom_sys.c                      | 191 +++++++++++++++++++++++++--
>  3 files changed, 205 insertions(+), 10 deletions(-)
> 
[...]

> +static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
> +				  struct wacom_led *led, unsigned int group,
> +				  unsigned int id, bool read_only)
> +{
> +	int error;
> +	char *name;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL,
> +			      "%s::wacom-led_%d.%d",
> +			      dev_name(dev),
> +			      group,
> +			      id);

let's use something other than the - and _ mix please. I'd prefer
wacom-led-0.1 but I'll also accept wacom_led_0.1, the mix is a bit of an
eyesore.

also, arguably you don't need the "led" bit, see e.g.  "input3::capslock" so
even "input123::wacom-0.1" would be ok too.

Cheers,
   Peter

