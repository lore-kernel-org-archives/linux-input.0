From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: wacom: Use half of brightness for low state
Date: Wed, 15 Aug 2012 10:30:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208151029570.7026@pobox.suse.cz>
References: <1343755676-2999-1-git-send-email-przemo@firszt.eu> <CAF8JNh+55Z4ZmBA=2yF7HBz464ZYs68NSU5OEYSkqP-s_bvEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33456 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab2HOIaP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 04:30:15 -0400
In-Reply-To: <CAF8JNh+55Z4ZmBA=2yF7HBz464ZYs68NSU5OEYSkqP-s_bvEYg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Przemo Firszt <przemo@firszt.eu>, linux-input@vger.kernel.org

On Fri, 3 Aug 2012, Ping Cheng wrote:

> On Tue, Jul 31, 2012 at 10:27 AM, Przemo Firszt <przemo@firszt.eu> wrote:
> > Intuos4 WL leds have 2 states: high and low. With no activity tablet
> > uses low state; using pen triggers high state. Both can be set
> > independently, but it would require setting another led device to
> > control them separately. This patch uses the brightness set through leds
> > subsytem as high and half of that value as low.
> >
> > Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> 
> Acked-by: Ping Cheng <pingc@wacom.com> for the whole set.
> 
> Thank you, Przemo, for your effort.

I have now applied both patches, thank you guys.

-- 
Jiri Kosina
SUSE Labs
