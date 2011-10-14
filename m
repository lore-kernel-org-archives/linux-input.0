From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v2] hid-magicmouse: Magic Trackpad has 1 button, not 2
Date: Fri, 14 Oct 2011 10:08:33 -0700
Message-ID: <4E986C91.4030801@canonical.com>
References: <4E97CB16.2040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42035 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab1JNRIi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 13:08:38 -0400
In-Reply-To: <4E97CB16.2040806@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Daniel van Vugt <vanvugt@gmail.com>, linux-input@vger.kernel.org

On 10/13/2011 10:39 PM, Daniel van Vugt wrote:
> hid-magicmouse was advertising the Apple Magic Trackpad as having 2
> buttons (left and right) when it actually only has 1 button.
> 
> Advertising multiple buttons makes Xorg disable all button 2 and 3
> emulation (using multi-finger clicks). So Xorg users don't get working
> right/middle-click emulation out of the box.
> 
> This patch makes hid-magicmouse correctly only report one real button
> for Magic Trackpad, which in turn makes Xorg enable multi-finger click
> support to emulate right/middle buttons.
> 
> [http://launchpad.net/bugs/862094]
> 
> Signed-off-by: Daniel van Vugt <vanvugt@gmail.com>
> Reviewed-by: Chase Douglas <chase.douglas@canonical.com>
> ---
>  drivers/hid/hid-magicmouse.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index f0fbd7b..2ab7175 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -405,6 +405,13 @@ static void magicmouse_setup_input(struct input_dev
> *input, struct hid_device *h
>  			__set_bit(REL_HWHEEL, input->relbit);
>  		}
>  	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
> +		/* input->keybit is initialized with incorrect button info
> +		 * for Magic Trackpad. There really is only one physical
> +		 * button (BTN_LEFT == BTN_MOUSE). Make sure we don't
> +		 * advertise buttons that don't exist...
> +		 */
> +		__clear_bit(BTN_RIGHT, input->keybit);
> +		__clear_bit(BTN_MIDDLE, input->keybit);
>  		__set_bit(BTN_MOUSE, input->keybit);
>  		__set_bit(BTN_TOOL_FINGER, input->keybit);
>  		__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);

To'ing Jiri Kosina, the HID maintainer.

Thanks again Daniel!
