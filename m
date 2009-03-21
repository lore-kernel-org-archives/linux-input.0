From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: elantech.c provide a workaround for jumpy cursor on firmware 2.34
Date: Fri, 20 Mar 2009 22:46:37 -0700
Message-ID: <200903202246.37383.dmitry.torokhov@gmail.com>
References: <20090320053509.GA3633@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:14565 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbZCUFqn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 01:46:43 -0400
In-Reply-To: <20090320053509.GA3633@adopmeer.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arjan,

On Thursday 19 March 2009 22:35:09 Arjan Opmeer wrote:
>
> +	if (etd->jumpy_cursor) {
> +		/* Discard packets that are likely to have bogus coordinates */
> +		if (fingers > old_fingers) {
> +			elantech_debug("elantech.c: discarding packet\n");
> +			goto discard_packet_v1;

Can we do this unconditionally for the v1 protocol and not have an
extra konb? Do you have access to boxes with unbroken V1 to test?

Thanks.

-- 
Dmitry

