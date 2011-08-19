From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Fri, 19 Aug 2011 10:23:46 +0800
Message-ID: <87liuq3zrh.fsf@emc.com.tw>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <20110818135853.GA28313@thinkpad-t410> <20110818142500.GC28313@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:36922 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1HSCV1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 22:21:27 -0400
In-Reply-To: <20110818142500.GC28313@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>

Hi Seth,

On Thu, 18 Aug 2011 09:25:00 -0500, Seth Forshee <seth.forshee@canonical.com> wrote:
> On Thu, Aug 18, 2011 at 08:58:53AM -0500, Seth Forshee wrote:
> 
> Sorry, that should have been:
> 
> 	case 2:
> 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
> 		/* fall through */
> 
> 	case 3:
> 		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
> 		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
> 		if (etd->reports_pressure) {
> 			input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
> 					     ETP_PMAX_V2, 0, 0);
> 			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
> 					     ETP_WMAX_V2, 0, 0);
> 		}
> 		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
> 		input_mt_init_slots(dev, 2);
> 		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
> 		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
> 		break;
Looks nice, thank you, I will change it.

jj
