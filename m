From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: misc: add twl4030-pwrbutton driver
Date: Fri, 6 Mar 2009 01:43:13 -0800
Message-ID: <20090306094312.GB24864@dtor-d630.eng.vmware.com>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090301144018.GA23581@frodo> <20090304090026.GC7394@dtor-d630.eng.vmware.com> <200903051554.40655.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:33338 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbZCFJnX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2009 04:43:23 -0500
Content-Disposition: inline
In-Reply-To: <200903051554.40655.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Samuel Ortiz <sameo@openedhand.com>

On Thu, Mar 05, 2009 at 03:54:40PM -0800, David Brownell wrote:
> On Wednesday 04 March 2009, Dmitry Torokhov wrote:
> > Cool, I will keep it in my tree pending the threaded IRQ issue
> > resolution.
> 
> Speaking of which ... I'd like to confirm that you
> already have the twl4030_keypad.c driver in your tree.
> 
> That was (re) submitted via linux-input on 6-Feb, after
> addressing feedback from the previous version (and cc'd to
> the OMAP list), but I've not heard anything ...
> 
> http://marc.info/?l=linux-omap&m=123391069411717&w=2
> 
> I don't know of a good linux-input archive or I'd
> reference the post from there.
> 
> 

Yep, I have it now. Thanks David.

-- 
Dmitry
