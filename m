From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 09:36:11 -0800
Message-ID: <20101210173611.GA1630@core.coreip.homeip.net>
References: <1292001842-5000-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:63144 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab0LJRgU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 12:36:20 -0500
Content-Disposition: inline
In-Reply-To: <1292001842-5000-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 10, 2010 at 06:24:02PM +0100, Henrik Rydberg wrote:
> +#define MT_TOOL_ENVELOPE	2	/* rectangle corner - legacy use only */

Legacy to me implies we can upgrade, but this is hardware limitation.
Can we say "rectangle corner - used by older hardware"?

-- 
Dmitry
