From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [Patch 08/10] input: Touchscreen driver for the PCAP
Date: Tue, 8 Jul 2008 22:24:12 +0200
Message-ID: <20080708202412.GD18479@datenfreihafen.org>
References: <20080707184000.411913919@datenfreihafen.org> <20080707184131.286622542@datenfreihafen.org> <20080707161212.ZZRA012@mailhub.coreip.homeip.net> <20080707202200.GB3449@datenfreihafen.org> <487319FB.5040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([78.47.116.19]:34633 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbYGHUUM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Jul 2008 16:20:12 -0400
Content-Disposition: inline
In-Reply-To: <487319FB.5040907@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, Daniel Ribeiro <wyrm@openezx.org>

Hello.

On Tue, 2008-07-08 at 15:40, Eric Miao wrote:
> 
> Well, one small nit: I'm not a language lawyer, but I don't think usage of
> u_int32_t/u_int16_t/u_int8_t is encourage nowadays, use uin32_t/uint16_t/uint8_t
> or u32/u16/u8.
> 
> Note: I'm not going to start an argument on which is the correct one to
> use, so it's totally up to you.

I would like to discuss this with Daniel and then submit a patch for all this
files to make them consistent. Doing this now would make life harder as some are
already acked, I need to take care with different maintainers, etc.

Hope this is ok with you.

regards
Stefan Schmidt
