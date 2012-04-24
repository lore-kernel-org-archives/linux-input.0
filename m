From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: ALPS - switch to using
 input_mt_report_finger_count
Date: Tue, 24 Apr 2012 08:34:48 +0200
Message-ID: <20120424063448.GA7654@polaris.bitmath.org>
References: <20120424060740.GA32333@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:45260 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2DXGbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 02:31:09 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 9CE7CE801
	for <linux-input@vger.kernel.org>; Tue, 24 Apr 2012 08:31:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120424060740.GA32333@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Chase Douglas <chase.douglas@canonical.com>

On Mon, Apr 23, 2012 at 11:07:41PM -0700, Dmitry Torokhov wrote:
> Instead of open-coded reporting number of fingers on the touchpad
> let's use input_mt_report_finger_count() helper.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> Just compiled, not tested.

Thanks for this, Dmitry. I noticed the patch in the stream, but was
never cc:d, so it slipped.

Henrik
