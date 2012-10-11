From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Thu, 11 Oct 2012 17:07:24 +0900
Message-ID: <20121011080722.GE11726@opensource.wolfsonmicro.com>
References: <1349875236-5707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1349875236-5707-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121011073955.GA30395@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55136 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754870Ab2JKIHh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 04:07:37 -0400
Content-Disposition: inline
In-Reply-To: <20121011073955.GA30395@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 11, 2012 at 12:39:55AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 10, 2012 at 10:20:35PM +0900, Mark Brown wrote:
> > Saves a little code and eliminates the possibility of introducing some
> > leaks.

> *sigh* OK, I guess devm_* is here to stay and I have to get on with the
> program. I am still unhappy that half of the patches converting/using
> devm_* APIs are wrong (not these ones), but I will apply these 3.

What's the error pattern you're seeing?  I've not noticed much of an
issue here, but if there is one perhaps we can do something to make the
error more obvious or harder to introduce.
