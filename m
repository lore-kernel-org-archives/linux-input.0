From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2 v2] HID: magicmouse: Removing report_touches switch
Date: Wed, 4 Jul 2012 09:40:49 +0200
Message-ID: <20120704074049.GA380@polaris.bitmath.org>
References: <1341341621-15560-1-git-send-email-miletus@chromium.org>
 <4FF35597.7020408@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:47637 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986Ab2GDHk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 03:40:28 -0400
Content-Disposition: inline
In-Reply-To: <4FF35597.7020408@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Andrew de los Reyes <adlr@chromium.org>

On Tue, Jul 03, 2012 at 01:27:03PM -0700, Chase Douglas wrote:
> On 07/03/2012 11:53 AM, Yufeng Shen wrote:
> >Remove the report_touches switch as it is not so useful to turn
> >off reporting touch events for a touch device. Let the userspace
> >to do the filtering if the turning off is needed.
> >
> >V2: Remove report_touches as suggeted by Chase Douglas
> >
> >Signed-off-by: Yufeng Shen <miletus@chromium.org>
> 
> Acked-by: Chase Douglas <chase.douglas@canonical.com>

Hi Chase,

While testing the new patches, I noticed that only four fingers would
come through; a fifth finger would make everything freeze. This
behavior is also present without the new patches. Didn't we have ten
fingers working at some point?

Cheers,
Henrik
