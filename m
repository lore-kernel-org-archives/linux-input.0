From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
 protocol
Date: Thu, 20 Nov 2008 00:34:33 +0100
Message-ID: <4924A289.6030906@euromail.se>
References: <49142351.9080805@euromail.se>	 <20081119113508.ZZRA012@mailhub.coreip.homeip.net> <1227113699.7181.103.camel@jg-vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57850 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751021AbYKSXek (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2008 18:34:40 -0500
In-Reply-To: <1227113699.7181.103.camel@jg-vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jg@laptop.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jim Gettys wrote:
[...]
> Also, I'm still concerned about using elipses. I doubt very much any
> hardware will ever be reporting elipses; more likely are parallelograms,
> or trapezoids, other simple geometric figures, rather than a center with
> size and orientation.

The bcm5974 chip is doing precisely this.

Henrik

