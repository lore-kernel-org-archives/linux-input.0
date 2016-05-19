From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: feed more data into entropy pool
Date: Thu, 19 May 2016 08:46:34 +0200
Message-ID: <ba503db5-c438-429a-f968-fde9b4a089f0@bitmath.org>
References: <20160518213244.GA3167@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay7.public.one.com ([91.198.169.215]:48518 "EHLO
	mailrelay7.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcESHCM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 03:02:12 -0400
In-Reply-To: <20160518213244.GA3167@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, djkurtz@chromium.org

Hi Dmitry,

On 05/18/2016 11:32 PM, Dmitry Torokhov wrote:
> Commit 4369c64c79a22 ("Input: Send events one packet at a time")
> significantly reduced amount of entropy input core was feeding to the rest
> of the system, because only the very first event in the event block would
> be used as source of entropy.
> 
> With this change we will be calling add_input_randomness() for every event
> that is not filtered by the input core as a duplicate. In addition, all
> EV_SYN events are ignored.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Henrik Rydberg <rydberg@bitmath.org>

Thanks for this, it has been nagging me as well.

> -	disposition = input_get_disposition(dev, type, code, &value);
> +	if (disposition != INPUT_IGNORE_EVENT && type != EV_SYN)
> +		add_input_randomness(type, code, value);

As a comment, it is not immediately clear to me how this will affect latency,
although it appears rather harmless.

Thanks,
Henrik

