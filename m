From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Add support for the new unibody macbooks
Date: Tue, 04 Nov 2008 19:48:59 +0100
Message-ID: <4910991B.5010903@euromail.se>
References: <49103CFA.1010707@euromail.se> <49106747.8060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33110 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520AbYKDStN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Nov 2008 13:49:13 -0500
In-Reply-To: <49106747.8060709@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Henrik Rydberg napsal(a):
>> The unibody MacBook 5 and MacBook Pro 5 come with a new version of
>> the bcm5974 trackpad. This patch adds the USB device ids and the
>> appropriate quirks.
> 
> Hi, thanks for the patch, but you omitted hid_blacklist addition.
> 
> Jiri K. (HID maintainer) is out for a while, expect longer rtt ;).

Yes, I sent it separately, sorry about the confusion. I will resend
the whole patch shortly, with the blacklist included. Thanks!

