From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid-input: Use a larger event buffer for MT devices
Date: Mon, 14 Jun 2010 20:17:41 +0200
Message-ID: <4C167245.1050907@euromail.se>
References: <1276516181-4519-1-git-send-email-rydberg@euromail.se> <AANLkTinI8w5vCi-VOf_IybZmOBDe8gjlJymZNSmmpkpk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:57111 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751018Ab0FNSR7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 14:17:59 -0400
In-Reply-To: <AANLkTinI8w5vCi-VOf_IybZmOBDe8gjlJymZNSmmpkpk@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Ping Cheng wrote:
[...]
> Do we really want to use a hardcoded number here? Considering you have
> used the same value in your "input: bcm5974" patch, adding it as an
> ifdef in linux/input.h should not be an overkill in design and offers
> the other drivers a chance to use it.

Well, I think it is. The fact that it appears more than once rather points to
the general duplication between HID and special input devices. A function like
"input_device_needs_more_bandwidth()" would be clean, but it just does not seem
worth it.

Henrik

