From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 18:47:18 +0100
Message-ID: <4D0267A6.5020603@euromail.se>
References: <1292001842-5000-1-git-send-email-rydberg@euromail.se>	<20101210173611.GA1630@core.coreip.homeip.net>	<4D026634.4000602@euromail.se> <AANLkTimnJpmRJCFhOvZndTmL3r21KEdqXr2Bd9ZT3kUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:47490 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391Ab0LJRsJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 12:48:09 -0500
In-Reply-To: <AANLkTimnJpmRJCFhOvZndTmL3r21KEdqXr2Bd9ZT3kUb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>>> Legacy to me implies we can upgrade, but this is hardware limitation.

>>> Can we say "rectangle corner - used by older hardware"?
>>>
>> How about "- older hw only", to stay within a single line?
> 
> Why do we suggest it will only be used by older hardware?


To limit its use - we really do not want to use anything but good contact data
anywhere, but we do not want to leave abundant (= old) hardware out, either.
Why, is there some case where it would be useful, you think?

Henrik
