From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sun, 01 Aug 2010 09:36:42 +0200
Message-ID: <4C55240A.8010105@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:51483 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab0HAHhN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Aug 2010 03:37:13 -0400
In-Reply-To: <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 07/31/2010 09:53 PM, Chris Bagwell wrote:

[...]
> I've seen xf86-input-synaptics patches floating around that try to detect
> jumps-because-of-averaging from the size of delta and discard but it is easy
> to be mistaken.  Probably its better to detect BTN_TOOL_DOUBLETAP
> transitions back to 0 and treating similar to both fingers being lifted to
> account for expected jump.


Looks good. Detecting "finger configuration changed" based on the number of
fingers is probably the closest one can get to MT behavior without actually
using it.

Henrik
