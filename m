From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mousedev: Emulate right and middle buttons
 for single-button touchpads
Date: Wed, 10 Sep 2008 18:05:51 +0200
Message-ID: <48C7F05F.8070308@euromail.se>
References: <48C0893C.6060901@euromail.se> <20080910125228.GA25221@anvil.corenet.prv> <48C7DF08.4060208@euromail.se> <20080910153213.GA6940@USFSHXP-002051>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:51115 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838AbYIJQFz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2008 12:05:55 -0400
In-Reply-To: <20080910153213.GA6940@USFSHXP-002051>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>> Regarding the tapping patch; it is addressing the correctness of
>> already implemented functionality. I can see nothing wrong with that.
>>
> 
> My position that since the isssue can be "fixed" by simply installing
> the proper X driver I'd rather not include it. Mousedev purpose is to
> provide good enough emulation in absence of a native driver and that's
> it. Also, the default value would not work well on high-resiolution
> devices (like Synaptics) and would require user fiddling with kernel
> parameters - not worth it in my opinion.

The parameter could be made dimensionless and the distance test scaled
with the size of the device; the argument invalidates the current patch,
but not the idea itself. Maybe the patch will appear in acceptable form
at some point, but for now, I rest my case.

Henrik
