From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Input: synaptics - reject out of range position values
Date: Thu, 7 Jun 2012 15:13:41 -0500
Message-ID: <20120607201341.GC15138@thinkpad-t410>
References: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com>
 <20120606153538.GC23884@thinkpad-t410>
 <CAGS+omBQ0PLvjRFVWrSSm1v3fegO5V968s7kLT3hGj3+Bhoebg@mail.gmail.com>
 <20120607195658.GB15138@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35648 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2FGUNo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jun 2012 16:13:44 -0400
Content-Disposition: inline
In-Reply-To: <20120607195658.GB15138@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Jun 07, 2012 at 02:56:58PM -0500, Seth Forshee wrote:
> > What is the y value reported at the top of the pad?
> > Also, what are the max & min values reported by your device when queried?
> >   Do they match the values that are actually reported?
> 
> The largest y value I see reported is 5490.

Forgot to say, this touchpad doesn't support reporting the min and max
values.

