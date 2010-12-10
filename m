From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 18:41:08 +0100
Message-ID: <4D026634.4000602@euromail.se>
References: <1292001842-5000-1-git-send-email-rydberg@euromail.se> <20101210173611.GA1630@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:45402 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752504Ab0LJRlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 12:41:14 -0500
In-Reply-To: <20101210173611.GA1630@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/2010 06:36 PM, Dmitry Torokhov wrote:

> On Fri, Dec 10, 2010 at 06:24:02PM +0100, Henrik Rydberg wrote:
>> +#define MT_TOOL_ENVELOPE	2	/* rectangle corner - legacy use only */
> 
> Legacy to me implies we can upgrade, but this is hardware limitation.
> Can we say "rectangle corner - used by older hardware"?
> 


How about "- older hw only", to stay within a single line?

Henrik
