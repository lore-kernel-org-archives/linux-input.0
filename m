From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] linux-input: bcm5974-0.57: mode-switch to atp_open,
	cleanup bug fixed
Date: Tue, 22 Jul 2008 02:55:42 +0200
Message-ID: <1216688142.4768.26.camel@alnilam>
References: <1216466049.6238.0.camel@alnilam>
	 <20080720051016.GA7853@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39840 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752268AbYGVAz5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 20:55:57 -0400
In-Reply-To: <20080720051016.GA7853@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net

Hi Dmitri,

Regarding open/close and suspend/resume, I have difficulties finding out
what the proper behavior is for the various error states that can
appear. I also wonder whether open should commute with suspend or not.
It would be of great help to get answers to the scenarios below.

1. From the state (!opened,!suspended), calling open followed by
suspend, or suspend followed by open, are we in the same state?

2. From the state (!opened,!suspended), calling open fails. What state
are we in?

3. From the state (!opened,suspended), calling open gets us to what
state?

4. From the state (!opened,suspended), calling open fails. Where are we?

5. From the state (opened,suspended), calling resume fails. What state
are we in?

Best regards,
Henrik Rydberg


