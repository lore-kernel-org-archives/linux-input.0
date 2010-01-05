From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Questions about Multi-touch Protocal
Date: Tue, 05 Jan 2010 13:42:13 +0100
Message-ID: <1262695333.8529.8.camel@pancake>
References: <4B42D998.4050303@samsung.com>  <4B432BDB.3000103@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:60167
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab0AEMsa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2010 07:48:30 -0500
In-Reply-To: <4B432BDB.3000103@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz

> The TOUCH and WIDTH parameters have a geometrical interpretation; imagine
> looking through a window at someone gently holding a finger against the glass.
> You will see two regions, one inner region consisting of the part of the finger
> actually touching the glass, and one outer region formed by the perimeter of the
> finger. The diameter of the inner region is the ABS_MT_TOUCH_MAJOR, the diameter
> of the outer region is ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the
> finger harder against the glass. The inner region will increase, and in general,
> the ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR, which is always smaller than
> unity, is related to the finger pressure.

> In addition to the MAJOR parameters, the oval shape of the finger can be
> described by adding the MINOR parameters, such that MAJOR and MINOR are the
> major and minor axis of an ellipse. Finally, the orientation of the oval shape
> can be describe with the ORIENTATION parameter.

> Hope this explains it a bit further.
Very interesting writeup, thanks a lot. Is there any currently any
hardware which is available to end-users and does support these
features? AFAIR most capacitive touchscreens don't have high enough
resolution to actually detect, e.g., twisting. If there's a commercial
option, I'd like to hear about it..

Florian
-- 
0666 - Filemode of the Beast

