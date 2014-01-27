From: simon@mungewell.org
Subject: Re: [PATCH v2 2/2] HID: sony: Add output events for the multi-touch
 pad on the Dualshock 4.
Date: Mon, 27 Jan 2014 15:40:46 -0500
Message-ID: <d3172725c00c3ddcc924d036820b7f5c.squirrel@mungewell.org>
References: <1390835857-4523-1-git-send-email-frank.praznik@oh.rr.com>
    <1390835857-4523-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:43257 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbaA0Ukr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 15:40:47 -0500
In-Reply-To: <1390835857-4523-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>


> +	for (n = 0; n < 2; n++) {
> +		__u16 x, y;
> +
> +		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
> +		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
> +
> +		input_mt_slot(input_dev, n);
> +		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
> +					!(rd[offset] >> 7));
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +
> +		offset += 4;
> +	}

Sorry I have another point/question....

Doesn't this 'spam' the Multitouch interface every incoming report,
regardless on whether anything has actually change? ie. Should HID-Sony
track the values, and only send when it detects a change...

Simon

