From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] input: mt: Move tracking and pointer emulation to
 input-mt
Date: Tue, 30 Nov 2010 22:50:15 +0100
Message-ID: <4CF57197.7070000@euromail.se>
References: <1291014802-17061-1-git-send-email-rydberg@euromail.se> <1291014802-17061-4-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:47129 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab0K3Vuo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 16:50:44 -0500
In-Reply-To: <1291014802-17061-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> @@ -132,12 +128,10 @@ static void parse_touch(struct w8001 *w8001)

>  			input_report_abs(dev, ABS_MT_POSITION_X, x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y, y);
>  			input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
> -			if (w8001->trkid[i] < 0)
> -				w8001->trkid[i] = trkid++ & MAX_TRACKING_ID;
> +			input_report_slot_state(dev, true);


			input_mt_report_slot_state(dev, true);

>  		} else {
> -			w8001->trkid[i] = -1;
> +			input_report_slot_state(dev, false);


			input_mt_report_slot_state(dev, false);

>  		}
> -		input_report_abs(dev, ABS_MT_TRACKING_ID, w8001->trkid[i]);
>  	}
>  
>  	input_sync(dev);


Henrik

