From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Thu, 09 Dec 2010 03:01:52 +0100
Message-ID: <4D003890.2010809@euromail.se>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se>	<4CFFC3C2.1080905@canonical.com>	<AANLkTikmomm2hd7AAJMTnY+=J2wPyVvodv2Ft0jFe7w2@mail.gmail.com>	<20101208235805.GE15294@core.coreip.homeip.net>	<4D002CE8.2060803@euromail.se> <AANLkTinzyNBT2u2QyFwpbJJDAPK1j5-tJZZzd8Q+eSMS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:35006 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756812Ab0LICCc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 21:02:32 -0500
In-Reply-To: <AANLkTinzyNBT2u2QyFwpbJJDAPK1j5-tJZZzd8Q+eSMS@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>

> What are the "points" here? Do you mean the points inside the envelope
> or number of envelopes?


Oh well, I take this and Chase's comments as a hint that the documentation
should have a section of MT_TOOL types, and each tool type should be explained,
in particular the new MT_TOOL_ENVELOPE. It should also help when/if converting
the Pen&Touch logic to MT.

Thanks.
Henrik
