From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH resend] hid-magicmouse: Increase evdev buffer size
Date: Mon, 4 Apr 2011 13:50:24 +0200
Message-ID: <20110404115024.GA1783@polaris.bitmath.org>
References: <1301691819-2090-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:51050 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1DDMJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 08:09:34 -0400
Content-Disposition: inline
In-Reply-To: <1301691819-2090-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Simon Budig <simon@budig.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 01, 2011 at 05:03:39PM -0400, Chase Douglas wrote:
> The evdev buffer isn't big enough when you get many fingers on the
> device. Bump up the buffer to a reasonable size, matching what other
> multitouch devices use. Without this change, events may be discarded in
> the evdev buffer before they are read.
> 
> Reported-by: Simon Budig <simon@budig.de>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: stable@kernel.org
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---

Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks, Chase.

Henrik
