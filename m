From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 09/12] Input: synaptics - add image sensor support
Date: Mon, 4 Jul 2011 23:42:20 +0200
Message-ID: <20110704214220.GE23915@polaris.bitmath.org>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-10-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:36927 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1GDVkd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 17:40:33 -0400
Content-Disposition: inline
In-Reply-To: <1309324042-22943-10-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

Hi Daniel,

> Synaptics makes (at least) two kinds of touchpad sensors:
>  * Older pads use a profile sensor that could only infer the location
>    of individual fingers based on the projection of their profiles
>    onto row and column sensors.
>  * Newer pads use an image sensor that can track true finger position
>    using a two-dimensional sensor grid.
> 
> Both sensor types support an "Advanced Gesture Mode":
>  When multiple fingers are detected, the touchpad sends alternating
>  "Advanced Gesture Mode" (AGM) and "Simple Gesture Mode" (SGM)
>  packets.
>  The AGM packets have w=2, and contain reduced resolution finger data
>  The SGM packets have w={0,1} and contain full resolution finger data
> 
> Profile sensors try to report the "upper" (larger y value) finger in
>  the SGM packet, and the lower (smaller y value) in the AGM packet.
>  However, due to the nature of the profile sensor, they easily get
>  confused when fingers cross, and can start reporting the x-coordinate
>  of one with the y-coordinate of the other.  Thus, for profile
>  sensors, "semi-mt" was created, which reports a "bounding box"
>  created by pairing min and max coordinates of the two pairs of
>  reported fingers.
> 
> Image sensors can report the actual coordinates of two of the fingers
>  present.  This patch detects if the touchpad is an image sensor and
>  reports finger data using the MT-B protocol.
> 
> NOTE: This patch only adds partial support for 2-finger gestures.
>       The proper interpretation of the slot contents when more than
>       two fingers are present is left to later patches.  Also,
>       handling of 'number of fingers' transitions is incomplete.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

I guess the real question here is: do the following patches really
help? Creating additional logic to band-aid yet another special case,
which still does not give full MT support, seems to create more
problems than it solves. If the code was needed to ensure proper five
finger support to userspace, then maybe one could live with
it. However, as it stands, keeping the semi-mt behavior also for the
slightly better devices may not be such a bad idea, after all.

_Iff_ the whole series can be formulated as true protocol B support
(no special flags, please), and _iff_ it helps to use software finger
tracking for less than four fingers, then please do tell, and we can
add that part to the input core to simplify the synaptics
implementation a bit.

Thanks.
Henrik
