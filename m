From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: evdev: discard oldest event on buffer overflow
Date: Thu, 28 Oct 2010 09:51:38 +0200
Message-ID: <4CC92B8A.7090104@euromail.se>
References: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:37496 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932582Ab0J1HwL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Oct 2010 03:52:11 -0400
In-Reply-To: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On 10/27/2010 07:09 PM, Bill Gatliff wrote:

> On a buffer overflow, the head and tail pointers collide.
> This makes the buffer suddenly look empty, rather than
> full, which may confuse applications.


This is actually an important regulatory effect which increases the ability for
the client to catch up.

> This patch moves the tail pointer up one event on a buffer
> overflow, which "consumes" the oldest event in the buffer
> to make room for the incoming event.  Thus, although data
> is lost due to the overflow (which is unavoidable), the
> data that remains is both recent and still time-ordered.


As Dmitry said, snapping discards to the event synchronization boundaries could
be useful, but I doubt it is really worthwhile.

Henrik
