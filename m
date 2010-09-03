From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/5] input: wacom: Add support for the Bamboo Touch trackpad
 (rev3)
Date: Fri, 03 Sep 2010 15:06:21 +0200
Message-ID: <4C80F2CD.2040708@euromail.se>
References: <1283516247-11624-1-git-send-email-rydberg@euromail.se> <1283516247-11624-4-git-send-email-rydberg@euromail.se> <6753EB6004AFF34FAA275742C104F952022BB10E@wacom-nt10.wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:32934 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752325Ab0ICNGe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Sep 2010 09:06:34 -0400
In-Reply-To: <6753EB6004AFF34FAA275742C104F952022BB10E@wacom-nt10.wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pingc@wacom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/03/2010 03:01 PM, Ping Cheng wrote:
[...]

> +	input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
> +	input_report_key(input, BTN_MIDDLE, (data[1] & 0x04) != 0);
> +	input_report_key(input, BTN_4, (data[1] & 0x02) != 0);
> +	input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
> 
> Since you are assigning meaningful defaults to three of the tablet
> buttons instead of using BTN_#, can we move one more step to make the
> fourth button useful out-of-box too? I am thinking of something like
> BTN_FORWARD and BTN_BACK while getting rid of the BTN_MIDDLE. So, it
> would be:
> 
> 	input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
> 	input_report_key(input, BTN_FORWARD, (data[1] & 0x04) != 0);
> 	input_report_key(input, BTN_BACK, (data[1] & 0x02) != 0);
> 	input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
> 
> Does this make sense to you?


Well, this is all a matter of taste, isn't it. If middle-button emulation works
out of the box, for the benefit of us old X users who seem unwilling to ever let
go of the click-to-paste functionality, then I would not mind terribly.

Henrik
