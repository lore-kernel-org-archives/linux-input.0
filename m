From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Input: ALPS - switch to using
 input_mt_report_finger_count
Date: Wed, 25 Apr 2012 10:50:20 -0500
Message-ID: <20120425155020.GB8540@thinkpad-t410>
References: <20120424060740.GA32333@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51870 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab2DYPuX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 11:50:23 -0400
Content-Disposition: inline
In-Reply-To: <20120424060740.GA32333@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>

On Mon, Apr 23, 2012 at 11:07:41PM -0700, Dmitry Torokhov wrote:
> Instead of open-coded reporting number of fingers on the touchpad
> let's use input_mt_report_finger_count() helper.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> Just compiled, not tested.

It's working fine for me.

Acked-by: Seth Forshee <seth.forshee@canonical.com>

