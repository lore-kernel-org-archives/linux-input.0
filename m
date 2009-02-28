From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Input notifier support
Date: Sun, 01 Mar 2009 00:34:38 +0100
Message-ID: <87skly16gh.fsf@basil.nowhere.org>
References: <20090225044730.GA9106@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:45223 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZB1Xgb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 18:36:31 -0500
In-Reply-To: <20090225044730.GA9106@july> (Kyungmin Park's message of "Wed, 25 Feb 2009 13:47:30 +0900")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Kyungmin Park <kmpark@infradead.org> writes:

> Some hardware doesn't connected with key button and led. In this case key should be connected with led by software. Of course each application can control it however it's too big burden to application programmer.
>
> So add input notifier and then use it at other frameworks such as led.
> Of course, other input device can use this one.
>
> Any commnets are welcome.

It looks like the perfect interface for a password stealing root kit.

Yes there are probably other ways to do this, but still this seems to
make it very easy.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
