From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [v1.1,1/3] driver: input :touchscreen : add Raydium crc touch
 function
Date: Fri, 8 Jul 2016 11:56:42 -0700
Message-ID: <20160708185642.GD28589@dtor-ws>
References: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
 <1467988605-44480-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34661 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbcGHS5T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 14:57:19 -0400
Content-Disposition: inline
In-Reply-To: <1467988605-44480-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, groeck@chromium.org, robh@kernel.org, jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jul 08, 2016 at 07:36:45AM -0700, jeffrey.lin wrote:
> >This is not offset, this is size, or length, of CRC.
> I'll change namming as RM_CONTACT_CRC_SIZE
> 
> >> @@ -798,33 +803,54 @@ static void raydium_mt_event(struct raydium_data *ts)
> >>  		input_mt_slot(ts->input, i);
> >>  		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, state);
> >>  
> >> -		if (!state)
> >> -			continue;
> >> -
> >> -		input_report_abs(ts->input, ABS_MT_POSITION_X,
> >> +		if (state == 0x01) {
> 
> >Why we need this change? How is it related to CRC? Do you intent to
> >report contact as active but not emit any position data of state is
> >neither 0 nor 1?
> This is no relationship with CRC, just want to make sure report points as state equal to 1.

If active contact only reported when state is 0x01 you need to update
the statements above like this:

	input_mt_report_slot_state(ts->input, MT_TOOL_FINGER,
				   state == 0x01);

	if (state != 0x01)
		continue;

but I am surprised that your firmware would report anything but 0 for
inactive contact.

Could you document all possible state values?

Thanks.

-- 
Dmitry
