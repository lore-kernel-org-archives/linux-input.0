From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] input : wacom_w8001 - report resolution to userland
Date: Mon, 31 Jan 2011 22:28:16 +0100
Message-ID: <20110131212816.GA1603@polaris.bitmath.org>
References: <1296283062-20469-1-git-send-email-pinglinux@gmail.com>
 <20110131115014.GA5576@polaris.bitmath.org>
 <20110131172643.GC31891@core.coreip.homeip.net>
 <AANLkTi=3hoFxhN6WSeHm3F8r5agzm_TMesZ-aVNRkyYi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out21.han.skanova.net ([195.67.226.208]:60233 "EHLO
	smtp-out21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753949Ab1AaV1I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 16:27:08 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=3hoFxhN6WSeHm3F8r5agzm_TMesZ-aVNRkyYi@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

> > I have the following for the resolution reporting:
> 
> 
> It works for me. Although the end result is the same as the v3 since
> params and res have already been set in pen response blok if pen is
> supported, it is more straight forward in logical to anyone who tries
> to understand the code.
> 
> Thank you, Dmitry.

Yep, looks good - thanks!

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Henrik
