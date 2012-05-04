From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/5] input: Introduce MT_CENTER_X and MT_CENTER_Y
Date: Fri, 4 May 2012 15:48:31 +0200
Message-ID: <20120504134831.GA8263@polaris.bitmath.org>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
 <1336136030-18503-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:56691 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713Ab2EDNnr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 May 2012 09:43:47 -0400
Content-Disposition: inline
In-Reply-To: <1336136030-18503-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin, Stephane,

> Microsoft published a new version of their multitouch specification.
> They introduced a new multitouch field: MT_CENTER_X|Y.

I would like a bit of elaboration here, since I am not convinced the
mapping should be directly translated to the MT protocol.

Clearly, the basic idea to be able to model an assymmetric tool is
good. Without an angle description, however, there seems to be a
mismatch in the degrees of freedom. In win8, one can place the hot
spot in a corner of the rectangle, but one cannot make the rectangle
into an ellipse in that direction. In linux, one can put the ellipse
in the wanted direction, but the hot spot is always in the center. To
first order, both models allow for finger-rotation information, but in
different ways. Adding more parameters requires a bit more
thought. Perhaps one should use the newly found win8 parameters to
reshape the pointing ellipse to start with.

Thanks,
Henrik
