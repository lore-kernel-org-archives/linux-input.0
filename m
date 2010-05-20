From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH][RFC] input: Add KEY_MIC_MUTE
Date: Thu, 20 May 2010 18:00:00 +0100
Message-ID: <1274374800.27274.3795.camel@localhost.localdomain>
References: <1274374228.24413.150.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39731 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0ETRAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 13:00:04 -0400
In-Reply-To: <1274374228.24413.150.camel@laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: linux-input@vger.kernel.org

On Thu, 2010-05-20 at 11:50 -0500, Jerone Young wrote:
> Today Lenovo Thinkpads are coming with a new key for muting the
> microphone. They started this with the T400s & it is now on T410(s)/510,
> W510/W710, L412/512, X100e, Edge 13/14/15 Thinkpads. Currently 12
> models, with more coming in the foreseeable future.

There's a "Microphone" usage name listed in the HID Usage Tables (under
Consumer Page) which would probably do fine.

Do this button toggle the mute status?

Cheers

