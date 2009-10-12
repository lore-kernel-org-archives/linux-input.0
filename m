From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] input: bcm5974: report ABS_MT events
Date: Mon, 12 Oct 2009 15:45:28 -0700
Message-ID: <20091012154528.6830da60.akpm@linux-foundation.org>
References: <1255386223-4109-1-git-send-email-rydberg@euromail.se>
	<1255386223-4109-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35910 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758504AbZJLWqL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 18:46:11 -0400
In-Reply-To: <1255386223-4109-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 13 Oct 2009 00:23:43 +0200
"Henrik Rydberg" <rydberg@euromail.se> wrote:

> This patch makes bcm5974 report raw multi-touch (MT) data in the form
> of ABS_MT events. The module parameter (nomt) may be used to turn off
> the effect of this patch.
> 

Why do we need a module parameter to disable the newly-added feature?

IMO, your first patch ("input: bcm5974: retract efi-broken
suspend_resume") is 2.6.32 material whereas this one is 2.6.33
material?

This assumes that the two patches can be safely separated in this
manner, which does appear to be the case.

