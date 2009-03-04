From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 19/22] input: elantech touchpad driver miss-recognising
 logitech mice
Date: Wed, 4 Mar 2009 12:39:03 -0800
Message-ID: <20090304123903.a76bb23b.akpm@linux-foundation.org>
References: <200903041959.n24Jx9cY028481@imap1.linux-foundation.org>
	<20090304202435.GA16259@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59781 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754448AbZCDUjx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 15:39:53 -0500
In-Reply-To: <20090304202435.GA16259@adopmeer.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: dtor@mail.ru, linux-input@vger.kernel.org, apw@shadowen.org

On Wed, 4 Mar 2009 21:24:35 +0100
Arjan Opmeer <arjan@opmeer.net> wrote:

> On Wed, Mar 04, 2009 at 11:59:09AM -0800, akpm@linux-foundation.org wrote:
> > From: Arjan Opmeer <arjan@opmeer.net>
> > 
> > Some Logitech mice react to the magic knock like an Elantech touchpad
> > would. This leads to those mice being misdetected as Elantech touchpads.
> > Add a version query to elantech_detect() to distinguish the two.
> 
> Andrew, I am confused. To what should this patch apply? Notice the version
> query result debug print that gets removed and added. The test for a real
> touchpad that now exists twice.

It appears that the patch already was appiled (woo-hooo!) but it still
applied on top of itself.  It happens sometimes.
