From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re:[v1.1,1/3] driver: input :touchscreen : add Raydium crc touch function
Date: Sat,  9 Jul 2016 07:41:35 -0700
Message-ID: <1468075295-44799-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, groeck@chromium.org, robh@kernel.org
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi dmitry:
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

>If active contact only reported when state is 0x01 you need to update
>the statements above like this:
>
>	input_mt_report_slot_state(ts->input, MT_TOOL_FINGER,
>				   state == 0x01);
>
>	if (state != 0x01)
>		continue;
>
>but I am surprised that your firmware would report anything but 0 for
>inactive contact.
>
>Could you document all possible state values?

Actual, our firmware only can report touch points as 1. Other cases is nothing to do. Can I merge this
part you suggested into the CRC version patch?

Thanks.

Jeffrey
