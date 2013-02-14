From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: synaptics - disable fuzz when using mt slots
Date: Thu, 14 Feb 2013 18:22:43 +0100
Message-ID: <20130214172243.GB538@polaris.bitmath.org>
References: <1359707312-12986-1-git-send-email-djkurtz@chromium.org>
 <20130213215250.GE23390@core.coreip.homeip.net>
 <CAGS+omDJi6EecXHdtYEGg0iXNqTLSnhHPE7ieHQ=ZNXkowJqKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:37591 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331Ab3BNRWD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2013 12:22:03 -0500
Content-Disposition: inline
In-Reply-To: <CAGS+omDJi6EecXHdtYEGg0iXNqTLSnhHPE7ieHQ=ZNXkowJqKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chung-Yih Wang <cywang@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > Hmm, instead of disabling fuzz completely maybe we should disable it
> > only on the derived axes (ABS_X/ABS_Y) for multitouch devices?
> 
> Yes, that should work...  both would end up fuzzed to the same value,
> for a not-so-obvious reason, IMHO :).
> It's a bit tricky, and I like it, but is that what you intended by the
> suggestion?

Since this is inherently a problem when using the mt helper functions,
turning fuzz off there ought to solve this problem transparently, and
for all users.

Thanks, Daniel, for reminding me of this year-old glitch. :-)

Henrik
