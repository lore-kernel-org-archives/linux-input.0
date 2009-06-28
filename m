From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.30-rc1: touchpad disabled on hibernation
Date: Sun, 28 Jun 2009 12:22:06 +0200
Message-ID: <20090628102205.GC8673@ucw.cz>
References: <4A438BA7.9010800@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35642 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbZF1Kul (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2009 06:50:41 -0400
Content-Disposition: inline
In-Reply-To: <4A438BA7.9010800@tuffmail.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, jikos@suse.cz

On Thu 2009-06-25 15:37:27, Alan Jenkins wrote:
> The synaptics touchpad on my EeePC 701 dies on hibernation.  2.6.30 was
> fine, and it doesn't happen on suspend to ram either.  There are no
> obvious error messages, but maybe this boot message is relevant:
> 
> Platform driver 'i8042' needs updating, please use dev_pm_ops

Just to track regression...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
