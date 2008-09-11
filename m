From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mousedev: Emulate right and middle buttons
 for single-button touchpads
Date: Thu, 11 Sep 2008 08:31:51 +0200
Message-ID: <48C8BB57.9020704@euromail.se>
References: <48C0893C.6060901@euromail.se> <20080910125228.GA25221@anvil.corenet.prv> <48C7DF08.4060208@euromail.se> <20080910153213.GA6940@USFSHXP-002051> <48C7F05F.8070308@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:48228 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750801AbYIKGcC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2008 02:32:02 -0400
In-Reply-To: <48C7F05F.8070308@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Henrik Rydberg wrote:
>>> Regarding the tapping patch; it is addressing the correctness of
>>> already implemented functionality. I can see nothing wrong with that.
>>>
>> My position that since the isssue can be "fixed" by simply installing
>> the proper X driver I'd rather not include it. Mousedev purpose is to
>> provide good enough emulation in absence of a native driver and that's
>> it. Also, the default value would not work well on high-resiolution
>> devices (like Synaptics) and would require user fiddling with kernel
>> parameters - not worth it in my opinion.
> 
> The parameter could be made dimensionless and the distance test scaled
> with the size of the device; the argument invalidates the current patch,
> but not the idea itself. Maybe the patch will appear in acceptable form
> at some point, but for now, I rest my case.

Actually, the tap_move parameter is already dimensionless - the
mousedev_touchpad functions emulates movements on an imaginary screen
of resolution 256x256. Thus, with the following description change

-MODULE_PARM_DESC(tap_move, "Tap distance for touchpads in absolute mode (res)");
+MODULE_PARM_DESC(tap_move, "Tap move radius (256 * fraction of screen)");

it should be clear that the parameter does not depend on device resolution.
It could even be made a constant in the code, if that is preferred.

Henrik
