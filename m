From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v2 2/3] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Fri, 10 Mar 2017 20:43:29 +0900
Message-ID: <20170310114329.qpspk32hkrt2v5gq@gangnam.samsung>
References: <20170210021721.12218-1-andi.shyti@samsung.com>
 <CGME20170210021729epcas1p3e11cade2daa21d2dd23839975e29acb6@epcas1p3.samsung.com>
 <20170210021721.12218-3-andi.shyti@samsung.com> <58BF450C.8070000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <58BF450C.8070000@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Chanwoo,

> > +			input_mt_slot(sdata->input, t_id);
> > +			input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
> > +			input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
> > +			input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, maj);
> > +			input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, min);
> > +			input_report_abs(sdata->input, ABS_MT_PRESSURE, area);
> > +			input_report_abs(sdata->input, ABS_MT_ORIENTATION,
> > +								orientation);
> > +			input_sync(sdata->input);
> > +
> 
> When I tested this patch on TM2 board, It looks like it is not well working.
> So, I tried to check the input event by using the evtest tool.
> But, the result don't show the proper ABS_MT_TRACKING_ID event.
> [1] https://cgit.freedesktop.org/evtest/
> 
> According to the mutlti-touch-protocol.txt[2], there are two multi-touch protocol.
> As far as I knew, this driver supports the Protocol B which needs
> the ABS_MT_TRACKING_ID according to the multi-touch-protocol.txt[2].
> [2] Documentation/input/mutlti-touch-protocol.txt
>  
> In our test, the ABS_MT_TRACKING_ID is showed only one time.
> After pressing/releasing finger from touchscreen on first time,
> there are no ABS_MT_TRACKING_ID information from second try with finger.
> 
> I guess that input_mt_report_slot_state() is not calling properly.

Thanks for testing it, with my own tests indeed I didn't check on
that, there is a logical mistake here:

> > +			if (id == STMFTS_EV_MULTI_TOUCH_ENTER) {
> > +				if (!(sdata->in_touch++))
> > +					input_mt_report_slot_state(
> > +							sdata->input,
> > +							MT_TOOL_FINGER, true);
> > +			} else if (id == STMFTS_EV_MULTI_TOUCH_LEAVE) {
> > +				if (!(--sdata->in_touch))
> > +					input_mt_report_slot_state(
> > +							sdata->input,
> > +							MT_TOOL_FINGER, false);
> > +			}

the inner ifs should be removed, they prevent the
ABS_MT_TRACKING_ID to be sent.

I will fix it.

Thanks a lot,
Andi
