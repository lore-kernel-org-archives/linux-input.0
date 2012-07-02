From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: magicmouse: Implement Multi-touch Protocol B (MT-B)
Date: Mon, 2 Jul 2012 12:07:41 +0200
Message-ID: <20120702100741.GA1496@polaris.bitmath.org>
References: <1340913271-588-1-git-send-email-miletus@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:39536 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877Ab2GBKHb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 06:07:31 -0400
Content-Disposition: inline
In-Reply-To: <1340913271-588-1-git-send-email-miletus@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Andrew de los Reyes <adlr@chromium.org>

On Thu, Jun 28, 2012 at 03:54:31PM -0400, Yufeng Shen wrote:
> The driver for Apple Magic Trackpad/Mouse currently uses
> Multi-touch Protocol A (MT-A) to report touch events and uses
> ABS_MT_TRACKING_ID to do finger tracking. The fact of the device
> being able to track individual finger makes it possible to
> report touch events using MT-B. This patch adds the support
> for the driver to report MT-B and makes it configurable through
> module parameter so that existing codes that are relying on its
> MT-A implemtation don't get affected.

Are there any such codes? Most systems, if not all, seem to use mtdev,
which can handle both protocols. I do not think a parameter switch is
a good idea. Switching to MT-B or leaving things as is look like the
viable options.

Thanks,
Henrik
