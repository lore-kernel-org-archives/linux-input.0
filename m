From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] input: misc: add twl4030-pwrbutton driver
Date: Thu, 5 Mar 2009 15:54:40 -0800
Message-ID: <200903051554.40655.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090301144018.GA23581@frodo> <20090304090026.GC7394@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n21.bullet.mail.mud.yahoo.com ([68.142.206.160]:30984 "HELO
	n21.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751809AbZCEXyo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Mar 2009 18:54:44 -0500
In-Reply-To: <20090304090026.GC7394@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Samuel Ortiz <sameo@openedhand.com>

On Wednesday 04 March 2009, Dmitry Torokhov wrote:
> Cool, I will keep it in my tree pending the threaded IRQ issue
> resolution.

Speaking of which ... I'd like to confirm that you
already have the twl4030_keypad.c driver in your tree.

That was (re) submitted via linux-input on 6-Feb, after
addressing feedback from the previous version (and cc'd to
the OMAP list), but I've not heard anything ...

http://marc.info/?l=linux-omap&m=123391069411717&w=2

I don't know of a good linux-input archive or I'd
reference the post from there.


