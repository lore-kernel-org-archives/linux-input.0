From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: ad714x wheel support and other shortcomings
Date: Wed, 2 May 2012 11:06:23 +0200
Message-ID: <4FA0F90F.5040806@analog.com>
References: <E1F92FDB-5546-402F-901D-36A9EDB2B2C0@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:52223
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755354Ab2EBJGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 May 2012 05:06:39 -0400
In-Reply-To: <E1F92FDB-5546-402F-901D-36A9EDB2B2C0@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: "cooloney@kernel.org" <cooloney@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Benoit Bedard <BedardB@Sonatest.com>

On 05/01/2012 05:01 PM, Jean-Francois Dagenais wrote:
> Hi guys,
> (sorry for the long message, but there are A LOT of issues here in this
> driver...)

Hi Jean-Francois,

Thanks for your detailed observations.

A few words about the history of this driver.
Bryan, not longer working for ADI, developed this driver based on
a few routines someone else in ADI developed some time ago.
He didn't had proper hardware that would have allowed him to test
all physical arrangements, such as wheels, touch-pads, etc.

When I took over ownership, I only had a board with a few buttons,
and a really tiny wheel. So testing on my side was basically limited to
the dimensions of the wheel.
I fixed a series of bugs associated with the wheel algo,
such as divide by zero, and other things.

>
> Ok, I took a step back after my failed mod
> (1335460639-1362-2-git-send-email-jeff.dagenais@gmail.com), and discovered many
> shortcomings in the driver code around the wheel feature, hw_init and more
> generically the abs_pos calculation algorithm. It looks like we're the only
> "kernel-participating" party that has tried to integrate the wheel in a real
> system...?
I know some people are using this driver successfully.
But when it comes to the wheel, that could be the case.

>
> This is sort of a story based account of my recent dealings with the ad714x
> driver, I know it's chatty, but please bear with me...
>
> The motion of the wheel near the roll around point (ex. between stages 7 and 0
> for an 8 stage wheel) has a dead zone. This is because the slices of max_coord
> being added up are too large, and near the last segment, the value is greater
> than max_coord, but is capped at max_coord, hence the dead zone. Now this
> effect, caused by the enlarged slices, is tolerable for a slider since there is
> no rolling around, but for the wheel, this is unusable.
>
> Simply shrinking the slice size didn't fix the problem, the values capped at
> max_coord before the mid-point between the last and first stages, making a dead
> zone, then a skip when the finger nears the center of start_stage. So I came up
> with a new algorithm which relocates the positioning one turn of the wheel
> ahead, then modulo's the value back into the max_coord range to eliminate this
> problem.
>
> I had to stepped away from the a_param and b_param based mean calculation
> because (and this is true for the slider as well) it has bumps in it. The bumps
> appear when the determined "highest_stage" changes. The recalculated values
> near this frontier skips ahead or backward by a noticeable amount, hence the
> "bump". It is especially annoying when you keep your finger around a tipping
> point between two stages. The value then skips by a large quantity rapidly back
> and forth. IMPORTANT NOTE: since the slider uses a similar algorithm, I tried
> telling the driver my wheel as a slider to invoke that code, and did the bump
> test there in the middle of my wheel, SAME PROBLEM!
>
> My new algo still grabs the largest response and the two adjacent stages, the
> response "floor" (or 0) is brought up to the smallest of the two adjacent
> stages. This basically eliminates one of the adjacent stages and while
> adjusting the ratio between the largest response and the next largest one. With
> these two stages left, a proportion is given to the largest vs. the other. This
> becomes a vector which offsets the coord (+/-) from the largest response
> stage's center coordinate. Ultra simple and works really well. IT COULD/SHOULD
> BE PORTED TO THE SLIDER and/or to the generic ad714x_cal_abs_pos function.
Sounds good to me.

>
> Once I got that working, I got jerky behaviour from the reported position
> around the edges (i.e. 0 and max_coord). The cause was the flt_pos calculation
> which is basically broken for circular coordinates.
>
> The problem is that when using a max_coord of 1024 for example, then coord 0
> equals coord 1024. So the abs_pos and old flt_pos have to be brought in the
> same "quadrant" (for lack of a better word) for the calculation to be valid.
> But this is still not enough for things to be smooth in the whole range of
> values.
>
> The other issue one encounters is that, even if the values are in the same
> "quadrant" and you modulo the end value, when you add several turns to the
> coordinates for the flt_pos calculation, it doesn't yield the same result as if
> you don't. My solution was to offset the abs_pos and old flt_pos around
> max_coord, make the calculation and "de-offset" the result after. This means
> the calculation is always done using the same scale (i.e. max_coord).
>
> The resulting position is regular and smooth. But then again, my abs_pos was
> fine without the flt_pos calculation. It made me wonder if the filtering, which
> is really just a time-base smoothing function, had been added because of the
> bump problem I talked about earlier. Any thoughts?
Think I changed that in commit f1e430e6369f5edac552d99bff15369ef8c6bbd2.
I did that because the flt_pos gave me better results.
Now that fixed the underlying problem, we should definitely use the abs_pos.

>
> BTW, just so it doesn't go un-noticed in my upcoming patch, while refactoring
> this, I noticed a clear bug in the current ad714x_wheel_cal_abs_pos :
> 	first_before = (sw->highest_stage + stage_num - 1) % stage_num;
> 	highest = sw->highest_stage;
> 	first_after = (sw->highest_stage + stage_num + 1) % stage_num;
> ... this will fail IF start_stage IS NOT 0 for this wheel. I have changed it to
> something like this :
> 	int highest_idx_rel = sw->highest_stage - hw->start_stage;
> 	...
> 	first_before = ((highest_idx_rel + stage_num - 1) % stage_num)
> 	                            + hw->start_stage ;
> 	...
> Agreed?
Good catch! Agreed.

>
> So now, using this strategy, the wheel motion is both precise and has no breaks
> or bumps in it. I even tested the code using stages 1..8 instead of 0..7 and it
> still works correctly. This suggests that my index calculations are ok.
>
> (patch form was too noisy, I will send a patch after I get feedback if you guys
> don't mind)
>
> static void ad714x_wheel_cal_abs_pos(struct ad714x_chip *ad714x, int idx)
> {
> 	struct ad714x_wheel_plat *hw =&ad714x->hw->wheel[idx];
> 	struct ad714x_wheel_drv *sw =&ad714x->sw->wheel[idx];
> 	int stage_num = hw->end_stage - hw->start_stage + 1;
> 	/* index of the highest stage relative to start_stage */
> 	int highest_idx_rel = sw->highest_stage - hw->start_stage;
> 	/* the number of positions between each stages */
> 	int slice_size = DIV_ROUND_CLOSEST(hw->max_coord, stage_num);
> 	int a, b, c; /* the 3 vals to consider */
> 	int dir; /* direction of the adjustment from the highest stage pos */
>
> 	/* Init abs_pos at the highest stage's physical location, but one turn
> 	 * of the wheel ahead (modulo'd later down), then add half the slice
> 	 * size because we want coordinate 0 to be half way between end_stage
> 	 * and start_stage.
> 	 */
> 	sw->abs_pos = (slice_size * highest_idx_rel)
> 		       + hw->max_coord + (slice_size/2);
>
> 	/* grab the three values we are interested in. These are the highest
> 	 * index, and the one before and after, in a circular roll-over type
> 	 * increment and decrement, also considering start_stage != 0.
> 	 */
> 	a = ad714x->sensor_val[((highest_idx_rel + stage_num - 1) % stage_num)
> 			       + hw->start_stage];
> 	b = ad714x->sensor_val[sw->highest_stage];
> 	c = ad714x->sensor_val[((highest_idx_rel + stage_num + 1) % stage_num)
> 			       + hw->start_stage];
>
> 	/* eliminate the smallest val from the equation, by substracting the
> 	 * smallest to all values, in other words, bring the signal reference
> 	 * up to the smallest value of the 3. After this "if-else", 'bM is
> 	 * still the highest val, 'a' contains the second biggest val, and
> 	 * 'dir' contains a record of the direction we need to adjust abs_pos.
> 	 *        : .                          . :
> 	 *      : : :                          : : :
> 	 *  if: a b c  adjust right (1), else: a b c adjust left (-1)
> 	 *
> 	 */
> 	if(a<  c) {
> 		c -= a;
> 		b -= a;
> 		a = c;
> 		dir = 1;
> 	} else {
> 		a -= c;
> 		b -= c;
> 		dir = -1;
> 	}
> 	/* add/substract a proportional to a/a+b quantity to abs_pos */
> 	sw->abs_pos = (sw->abs_pos +
> 		       DIV_ROUND_CLOSEST(a * dir * slice_size, a+b)) %
> 		       hw->max_coord;
> }
>
> static void ad714x_wheel_cal_flt_pos(struct ad714x_chip *ad714x, int idx)
> {
> 	struct ad714x_wheel_plat *hw =&ad714x->hw->wheel[idx];
> 	struct ad714x_wheel_drv *sw =&ad714x->sw->wheel[idx];
> 	int half_coord_range = hw->max_coord/2;
> 	int abs_pos = sw->abs_pos;
> 	int diff = sw->abs_pos - sw->flt_pos;
>
> 	/* try to put both pos within max_coord/2 of each other by adding
> 	 * one turn of the wheel, this turn is removed by modulo after calc.
> 	 */
> 	if (diff>  half_coord_range)
> 		sw->flt_pos += hw->max_coord;
> 	else if (diff<  -half_coord_range)
> 		abs_pos += hw->max_coord;
>
> 	/* if difference is still too great, just use abs_pos */
> 	if (abs(abs_pos - sw->flt_pos)>  half_coord_range)
> 		sw->flt_pos = sw->abs_pos;
> 	else {
> 		/* for the filter to work without "breakage" around the wheel,
> 		 * we need to offset the values to bring the two values around
> 		 * max_coord. Pretend the old flt_pos is max_coord.
> 		 */
> 		diff = hw->max_coord - sw->flt_pos;
> 		abs_pos += diff;
>
> 		sw->flt_pos = (DIV_ROUND_CLOSEST(((hw->max_coord * 30) +
> 						 (abs_pos * 71)), 100) - diff)
> 			       % hw->max_coord;
> 	}
> }
>
>
>
> Alright, while I have your attention... some more questions:
>
> In hw_init, why do we read back all the sys registers but do nothing with the
> data?
There are a few registers that are read-to-clear.
But these shouldn't have any side effects.
Dead code - feel free to remove it.

>
> Also, a few lines further in hw_init:
> ad714x->write(ad714x, AD714X_STG_CAL_EN_REG, 0xFFF);
> ...which completely disregards the settings provided by platform init
> (ad714x->hw->sys_cfg_reg[1]) which are programmed a few lines before for
> nothing basically. I can understand that the driver could "hard-code" the
> calib_en feature for it's behaviour, but writing 0xfff overwrites AVG_F/LP_SKIP
> registers to 0. Since the settings are provided by platform, I would just
> delete the line that does this , and trust the platform to init those properly,
> it is already responsible for writing most of the registers anyway.
Sounds good to me.

>
> Another weird thing is the presence of the 3 STAGE_(LOW/HIGH/COMP)_INT_ENABLE
> registers in the platform init structure, even though the driver specifically
> overwrites those in the ad714x_use_(com/thr)_int functions. I would shrink the
> platform data's sys_cfg_reg array to 5 since these last three registers are
> under the control of the driver, and the other configuration item in these 3
> regs is the GPIO feature, which is not useable by the current driver code
> anyway.
You're right for the sliders and wheels.
Setup routines for these will do a read modify write on affected registers.
However the buttons still need to have a proper config...
>
>
> Thanks for reading through!


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


