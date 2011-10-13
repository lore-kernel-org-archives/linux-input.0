From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v1 1/1] hid-magicmouse: Magic Trackpad has 1 button, not
 2
Date: Thu, 13 Oct 2011 09:28:32 -0700
Message-ID: <4E9711B0.3070708@canonical.com>
References: <4E96B7D8.3030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37142 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213Ab1JMQ2g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 12:28:36 -0400
In-Reply-To: <4E96B7D8.3030005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel van Vugt <vanvugt@gmail.com>
Cc: linux-input@vger.kernel.org

On 10/13/2011 03:05 AM, Daniel van Vugt wrote:
> hid-magicmouse was advertising the Apple Magic Trackpad as having 2
> buttons (left and right) when it actually only has 1 button.
> 
> Advertising multiple buttons in turn makes the xorg synaptics code
> disable all button 2 and 3 emulation (using multi-finger clicks). So
> xorg users don't get working right/middle-click emulation out of the box.
> 
> This patch makes hid-magicmouse correctly only report one real button
> for Magic Trackpad, which in turn makes xorg enable multi-finger click
> support to emulate right/middle buttons.
> 
> [http://launchpad.net/bugs/862094]
> 
> Signed-off-by: Daniel van Vugt <vanvugt@gmail.com>
> ---
> drivers/hid/hid-magicmouse.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index f0fbd7b..12200e6 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -405,6 +405,8 @@ static void magicmouse_setup_input(struct input_dev
> *input, struct hid_device *h
>  			__set_bit(REL_HWHEEL, input->relbit);
>  		}
>  	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
> +		__clear_bit(BTN_RIGHT, input->keybit);
> +		__clear_bit(BTN_MIDDLE, input->keybit);
>  		__set_bit(BTN_MOUSE, input->keybit);
>  		__set_bit(BTN_TOOL_FINGER, input->keybit);
>  		__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);

Please put a comment above these lines stating that when the trackpad is
put into multitouch mode, the right and middle buttons are not emitted.
I can see someone later wondering why the clearing was there, and if
commenting them out would magically make right and middle button events
be emitted.

With that comment:

Reviewed-by: Chase Douglas <chase.douglas@canonical.com>

Thanks!
