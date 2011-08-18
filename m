From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 08:58:53 -0500
Message-ID: <20110818135853.GA28313@thinkpad-t410>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53845 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab1HRN66 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 09:58:58 -0400
Content-Disposition: inline
In-Reply-To: <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 09:57:09AM +0800, JJ Ding wrote:
> v3 hardware's packet format is almost identical to v2 (one/three finger touch),
> except when sensing two finger touch, the hardware sends 12 bytes of data.

This looks mostly similar in substance to the patch I sent, although
with some good improvements resulting from your better knowledge of the
hardware :)

One suggestion below. I'll test as soon as my build finishes.

> @@ -582,10 +739,26 @@ static void elantech_set_input_params(struct psmouse *psmouse)
>  		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
>  		break;
> +
> +	case 3:
> +		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
> +		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
> +		/* range of pressure and width is the same as v2 */
> +		input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
> +				     ETP_PMAX_V2, 0, 0);
> +		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
> +				     ETP_WMAX_V2, 0, 0);
> +		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
> +		input_mt_init_slots(dev, 2);
> +		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
> +		break;

The case 3 code is nearly identical to case 2. How about this?

	case 2:
		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
		/* fall through */

	case 3:
		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
		/* range of pressure and width is the same as v2 */
		input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
				     ETP_PMAX_V2, 0, 0);
		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
				     ETP_WMAX_V2, 0, 0);
		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
		input_mt_init_slots(dev, 2);
		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
		break;
