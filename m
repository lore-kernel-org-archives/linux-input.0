From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] HID: ntrig remove if and drop an indent
Date: Fri, 11 Mar 2011 11:40:13 +1000
Message-ID: <20110311014012.GB8970@barra.bne.redhat.com>
References: <alpine.LNX.2.00.1102261156480.2160@pobox.suse.cz>
 <1299550408-11457-2-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:46111 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab1CKBkl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 20:40:41 -0500
Content-Disposition: inline
In-Reply-To: <1299550408-11457-2-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, rydberg@euromail.se, chatty@enac.fr

On Mon, Mar 07, 2011 at 09:13:28PM -0500, Rafi Rubin wrote:
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
>  drivers/hid/hid-ntrig.c |  456 +++++++++++++++++++++++------------------------
>  1 files changed, 227 insertions(+), 229 deletions(-)


Tested-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter

> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 56a88d9..60796dc 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -552,268 +552,266 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  	if (field->application == HID_DG_PEN)
>  		return 0;
>  
> -        if (hid->claimed & HID_CLAIMED_INPUT) {
> -		switch (usage->hid) {
> -		case 0xff000001:
> -			/* Tag indicating the start of a multitouch group */
> -			nd->reading_mt = 1;
> -			nd->first_contact_touch = 0;
> -			break;
> -		case HID_DG_TIPSWITCH:
> -			nd->tipswitch = value;
> -			/* Prevent emission of touch until validated */
> -			return 1;
> -		case HID_DG_CONFIDENCE:
> -			nd->confidence = value;
> -			break;
> -		case HID_GD_X:
> -			nd->x = value;
> -			/* Clear the contact footer */
> -			nd->mt_foot_count = 0;
> -			break;
> -		case HID_GD_Y:
> -			nd->y = value;
> -			break;
> -		case HID_DG_CONTACTID:
> -			nd->id = value;
> -			break;
> -		case HID_DG_WIDTH:
> -			nd->w = value;
> -			break;
> -		case HID_DG_HEIGHT:
> -			nd->h = value;
> +	switch (usage->hid) {
> +	case 0xff000001:
> +		/* Tag indicating the start of a multitouch group */
> +		nd->reading_mt = 1;
> +		nd->first_contact_touch = 0;
> +		break;
> +	case HID_DG_TIPSWITCH:
> +		nd->tipswitch = value;
> +		/* Prevent emission of touch until validated */
> +		return 1;
> +	case HID_DG_CONFIDENCE:
> +		nd->confidence = value;
> +		break;
> +	case HID_GD_X:
> +		nd->x = value;
> +		/* Clear the contact footer */
> +		nd->mt_foot_count = 0;
> +		break;
> +	case HID_GD_Y:
> +		nd->y = value;
> +		break;
> +	case HID_DG_CONTACTID:
> +		nd->id = value;
> +		break;
> +	case HID_DG_WIDTH:
> +		nd->w = value;
> +		break;
> +	case HID_DG_HEIGHT:
> +		nd->h = value;
> +		/*
> +		 * when in single touch mode, this is the last
> +		 * report received in a finger event. We want
> +		 * to emit a normal (X, Y) position
> +		 */
> +		if (!nd->reading_mt) {
>  			/*
> -			 * when in single touch mode, this is the last
> -			 * report received in a finger event. We want
> -			 * to emit a normal (X, Y) position
> +			 * TipSwitch indicates the presence of a
> +			 * finger in single touch mode.
>  			 */
> -			if (!nd->reading_mt) {
> -				/*
> -				 * TipSwitch indicates the presence of a
> -				 * finger in single touch mode.
> -				 */
> -				input_report_key(input, BTN_TOUCH,
> -						 nd->tipswitch);
> -				input_report_key(input, BTN_TOOL_DOUBLETAP,
> -						 nd->tipswitch);
> -				input_event(input, EV_ABS, ABS_X, nd->x);
> -				input_event(input, EV_ABS, ABS_Y, nd->y);
> -			}
> +			input_report_key(input, BTN_TOUCH,
> +					 nd->tipswitch);
> +			input_report_key(input, BTN_TOOL_DOUBLETAP,
> +					 nd->tipswitch);
> +			input_event(input, EV_ABS, ABS_X, nd->x);
> +			input_event(input, EV_ABS, ABS_Y, nd->y);
> +		}
> +		break;
> +	case 0xff000002:
> +		/*
> +		 * we receive this when the device is in multitouch
> +		 * mode. The first of the three values tagged with
> +		 * this usage tells if the contact point is real
> +		 * or a placeholder
> +		 */
> +
> +		/* Shouldn't get more than 4 footer packets, so skip */
> +		if (nd->mt_foot_count >= 4)
>  			break;
> -		case 0xff000002:
> -			/*
> -			 * we receive this when the device is in multitouch
> -			 * mode. The first of the three values tagged with
> -			 * this usage tells if the contact point is real
> -			 * or a placeholder
> -			 */
>  
> -			/* Shouldn't get more than 4 footer packets, so skip */
> -			if (nd->mt_foot_count >= 4)
> -				break;
> +		nd->mt_footer[nd->mt_foot_count++] = value;
>  
> -			nd->mt_footer[nd->mt_foot_count++] = value;
> +		/* if the footer isn't complete break */
> +		if (nd->mt_foot_count != 4)
> +			break;
>  
> -			/* if the footer isn't complete break */
> -			if (nd->mt_foot_count != 4)
> -				break;
> +		/* Pen activity signal. */
> +		if (nd->mt_footer[2]) {
> +			/*
> +			 * When the pen deactivates touch, we see a
> +			 * bogus frame with ContactCount > 0.
> +			 * We can
> +			 * save a bit of work by ensuring act_state < 0
> +			 * even if deactivation slack is turned off.
> +			 */
> +			nd->act_state = deactivate_slack - 1;
> +			nd->confidence = 0;
> +			break;
> +		}
>  
> -			/* Pen activity signal. */
> -			if (nd->mt_footer[2]) {
> -				/*
> -				 * When the pen deactivates touch, we see a
> -				 * bogus frame with ContactCount > 0.
> -				 * We can
> -				 * save a bit of work by ensuring act_state < 0
> -				 * even if deactivation slack is turned off.
> -				 */
> -				nd->act_state = deactivate_slack - 1;
> +		/*
> +		 * The first footer value indicates the presence of a
> +		 * finger.
> +		 */
> +		if (nd->mt_footer[0]) {
> +			/*
> +			 * We do not want to process contacts under
> +			 * the size threshold, but do not want to
> +			 * ignore them for activation state
> +			 */
> +			if (nd->w < nd->min_width ||
> +			    nd->h < nd->min_height)
>  				nd->confidence = 0;
> -				break;
> -			}
> +		} else
> +			break;
>  
> +		if (nd->act_state > 0) {
>  			/*
> -			 * The first footer value indicates the presence of a
> -			 * finger.
> +			 * Contact meets the activation size threshold
>  			 */
> -			if (nd->mt_footer[0]) {
> -				/*
> -				 * We do not want to process contacts under
> -				 * the size threshold, but do not want to
> -				 * ignore them for activation state
> -				 */
> -				if (nd->w < nd->min_width ||
> -				    nd->h < nd->min_height)
> -					nd->confidence = 0;
> -			} else
> -				break;
> -
> -			if (nd->act_state > 0) {
> -				/*
> -				 * Contact meets the activation size threshold
> -				 */
> -				if (nd->w >= nd->activation_width &&
> -				    nd->h >= nd->activation_height) {
> -					if (nd->id)
> -						/*
> -						 * first contact, activate now
> -						 */
> -						nd->act_state = 0;
> -					else {
> -						/*
> -						 * avoid corrupting this frame
> -						 * but ensure next frame will
> -						 * be active
> -						 */
> -						nd->act_state = 1;
> -						break;
> -					}
> -				} else
> +			if (nd->w >= nd->activation_width &&
> +			    nd->h >= nd->activation_height) {
> +				if (nd->id)
>  					/*
> -					 * Defer adjusting the activation state
> -					 * until the end of the frame.
> +					 * first contact, activate now
>  					 */
> +					nd->act_state = 0;
> +				else {
> +					/*
> +					 * avoid corrupting this frame
> +					 * but ensure next frame will
> +					 * be active
> +					 */
> +					nd->act_state = 1;
>  					break;
> -			}
> -
> -			/* Discarding this contact */
> -			if (!nd->confidence)
> -				break;
> -
> -			/* emit a normal (X, Y) for the first point only */
> -			if (nd->id == 0) {
> +				}
> +			} else
>  				/*
> -				 * TipSwitch is superfluous in multitouch
> -				 * mode.  The footer events tell us
> -				 * if there is a finger on the screen or
> -				 * not.
> +				 * Defer adjusting the activation state
> +				 * until the end of the frame.
>  				 */
> -				nd->first_contact_touch = nd->confidence;
> -				input_event(input, EV_ABS, ABS_X, nd->x);
> -				input_event(input, EV_ABS, ABS_Y, nd->y);
> -			}
> +				break;
> +		}
>  
> -			/* Emit MT events */
> -			input_event(input, EV_ABS, ABS_MT_POSITION_X, nd->x);
> -			input_event(input, EV_ABS, ABS_MT_POSITION_Y, nd->y);
> +		/* Discarding this contact */
> +		if (!nd->confidence)
> +			break;
>  
> +		/* emit a normal (X, Y) for the first point only */
> +		if (nd->id == 0) {
>  			/*
> -			 * Translate from height and width to size
> -			 * and orientation.
> +			 * TipSwitch is superfluous in multitouch
> +			 * mode.  The footer events tell us
> +			 * if there is a finger on the screen or
> +			 * not.
>  			 */
> -			if (nd->w > nd->h) {
> -				input_event(input, EV_ABS,
> -						ABS_MT_ORIENTATION, 1);
> -				input_event(input, EV_ABS,
> -						ABS_MT_TOUCH_MAJOR, nd->w);
> -				input_event(input, EV_ABS,
> -						ABS_MT_TOUCH_MINOR, nd->h);
> -			} else {
> -				input_event(input, EV_ABS,
> -						ABS_MT_ORIENTATION, 0);
> -				input_event(input, EV_ABS,
> -						ABS_MT_TOUCH_MAJOR, nd->h);
> -				input_event(input, EV_ABS,
> -						ABS_MT_TOUCH_MINOR, nd->w);
> -			}
> -			input_mt_sync(field->hidinput->input);
> -			break;
> +			nd->first_contact_touch = nd->confidence;
> +			input_event(input, EV_ABS, ABS_X, nd->x);
> +			input_event(input, EV_ABS, ABS_Y, nd->y);
> +		}
>  
> -		case HID_DG_CONTACTCOUNT: /* End of a multitouch group */
> -			if (!nd->reading_mt) /* Just to be sure */
> -				break;
> +		/* Emit MT events */
> +		input_event(input, EV_ABS, ABS_MT_POSITION_X, nd->x);
> +		input_event(input, EV_ABS, ABS_MT_POSITION_Y, nd->y);
> +
> +		/*
> +		 * Translate from height and width to size
> +		 * and orientation.
> +		 */
> +		if (nd->w > nd->h) {
> +			input_event(input, EV_ABS,
> +					ABS_MT_ORIENTATION, 1);
> +			input_event(input, EV_ABS,
> +					ABS_MT_TOUCH_MAJOR, nd->w);
> +			input_event(input, EV_ABS,
> +					ABS_MT_TOUCH_MINOR, nd->h);
> +		} else {
> +			input_event(input, EV_ABS,
> +					ABS_MT_ORIENTATION, 0);
> +			input_event(input, EV_ABS,
> +					ABS_MT_TOUCH_MAJOR, nd->h);
> +			input_event(input, EV_ABS,
> +					ABS_MT_TOUCH_MINOR, nd->w);
> +		}
> +		input_mt_sync(field->hidinput->input);
> +		break;
>  
> -			nd->reading_mt = 0;
> +	case HID_DG_CONTACTCOUNT: /* End of a multitouch group */
> +		if (!nd->reading_mt) /* Just to be sure */
> +			break;
>  
> +		nd->reading_mt = 0;
> +
> +
> +		/*
> +		 * Activation state machine logic:
> +		 *
> +		 * Fundamental states:
> +		 *	state >  0: Inactive
> +		 *	state <= 0: Active
> +		 *	state <  -deactivate_slack:
> +		 *		 Pen termination of touch
> +		 *
> +		 * Specific values of interest
> +		 *	state == activate_slack
> +		 *		 no valid input since the last reset
> +		 *
> +		 *	state == 0
> +		 *		 general operational state
> +		 *
> +		 *	state == -deactivate_slack
> +		 *		 read sufficient empty frames to accept
> +		 *		 the end of input and reset
> +		 */
> +
> +		if (nd->act_state > 0) { /* Currently inactive */
> +			if (value)
> +				/*
> +				 * Consider each live contact as
> +				 * evidence of intentional activity.
> +				 */
> +				nd->act_state = (nd->act_state > value)
> +						? nd->act_state - value
> +						: 0;
> +			else
> +				/*
> +				 * Empty frame before we hit the
> +				 * activity threshold, reset.
> +				 */
> +				nd->act_state = nd->activate_slack;
>  
>  			/*
> -			 * Activation state machine logic:
> -			 *
> -			 * Fundamental states:
> -			 *	state >  0: Inactive
> -			 *	state <= 0: Active
> -			 *	state <  -deactivate_slack:
> -			 *		 Pen termination of touch
> -			 *
> -			 * Specific values of interest
> -			 *	state == activate_slack
> -			 *		 no valid input since the last reset
> -			 *
> -			 *	state == 0
> -			 *		 general operational state
> -			 *
> -			 *	state == -deactivate_slack
> -			 *		 read sufficient empty frames to accept
> -			 *		 the end of input and reset
> +			 * Entered this block inactive and no
> +			 * coordinates sent this frame, so hold off
> +			 * on button state.
>  			 */
> -
> -			if (nd->act_state > 0) { /* Currently inactive */
> -				if (value)
> -					/*
> -					 * Consider each live contact as
> -					 * evidence of intentional activity.
> -					 */
> -					nd->act_state = (nd->act_state > value)
> -							? nd->act_state - value
> -							: 0;
> -				else
> -					/*
> -					 * Empty frame before we hit the
> -					 * activity threshold, reset.
> -					 */
> -					nd->act_state = nd->activate_slack;
> -
> +			break;
> +		} else { /* Currently active */
> +			if (value && nd->act_state >=
> +				     nd->deactivate_slack)
>  				/*
> -				 * Entered this block inactive and no
> -				 * coordinates sent this frame, so hold off
> -				 * on button state.
> +				 * Live point: clear accumulated
> +				 * deactivation count.
>  				 */
> -				break;
> -			} else { /* Currently active */
> -				if (value && nd->act_state >=
> -					     nd->deactivate_slack)
> -					/*
> -					 * Live point: clear accumulated
> -					 * deactivation count.
> -					 */
> -					nd->act_state = 0;
> -				else if (nd->act_state <= nd->deactivate_slack)
> -					/*
> -					 * We've consumed the deactivation
> -					 * slack, time to deactivate and reset.
> -					 */
> -					nd->act_state =
> -						nd->activate_slack;
> -				else { /* Move towards deactivation */
> -					nd->act_state--;
> -					break;
> -				}
> -			}
> -
> -			if (nd->first_contact_touch && nd->act_state <= 0) {
> +				nd->act_state = 0;
> +			else if (nd->act_state <= nd->deactivate_slack)
>  				/*
> -				 * Check to see if we're ready to start
> -				 * emitting touch events.
> -				 *
> -				 * Note: activation slack will decrease over
> -				 * the course of the frame, and it will be
> -				 * inconsistent from the start to the end of
> -				 * the frame.  However if the frame starts
> -				 * with slack, first_contact_touch will still
> -				 * be 0 and we will not get to this point.
> +				 * We've consumed the deactivation
> +				 * slack, time to deactivate and reset.
>  				 */
> -				input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
> -				input_report_key(input, BTN_TOUCH, 1);
> -			} else {
> -				input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
> -				input_report_key(input, BTN_TOUCH, 0);
> +				nd->act_state =
> +					nd->activate_slack;
> +			else { /* Move towards deactivation */
> +				nd->act_state--;
> +				break;
>  			}
> -			break;
> +		}
>  
> -		default:
> -			/* fall-back to the generic hidinput handling */
> -			return 0;
> +		if (nd->first_contact_touch && nd->act_state <= 0) {
> +			/*
> +			 * Check to see if we're ready to start
> +			 * emitting touch events.
> +			 *
> +			 * Note: activation slack will decrease over
> +			 * the course of the frame, and it will be
> +			 * inconsistent from the start to the end of
> +			 * the frame.  However if the frame starts
> +			 * with slack, first_contact_touch will still
> +			 * be 0 and we will not get to this point.
> +			 */
> +			input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
> +			input_report_key(input, BTN_TOUCH, 1);
> +		} else {
> +			input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
> +			input_report_key(input, BTN_TOUCH, 0);
>  		}
> +		break;
> +
> +	default:
> +		/* fall-back to the generic hidinput handling */
> +		return 0;
>  	}
>  
>  not_claimed_input:
> -- 
> 1.7.2.3
