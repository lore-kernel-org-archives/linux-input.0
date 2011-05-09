From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 9 May 2011 16:47:29 +0100
Message-ID: <20110509154729.GA5043@srcf.ucam.org>
References: <20110407181800.27b441b1@destiny.ordissimo>
 <20110509143828.GA2632@srcf.ucam.org>
 <4DC80A53.7050609@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58860 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1EIPrt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2011 11:47:49 -0400
Content-Disposition: inline
In-Reply-To: <4DC80A53.7050609@windriver.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Anisse Astier <anisse@astier.eu>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentin.chary@gmail.com>

On Mon, May 09, 2011 at 08:37:55AM -0700, Andy Ross wrote:

> How would that work?  If it's an extra sysfs node, it would require an
> extra file descriptor in the reader.  And if it's an event inside the
> input stream, that would require the reader implement handling to throttle
> the polling rate.  The point here was to avoid having to poll the
> (noisy) accelerometer stream just for gross orientation changes.

Yes, so the accelerometer driver should (in-kernel) know that a coarse 
orientation event has occured and then send an appropriate uevent to 
userspace indiciating that it has new data.

> http://build.meego.com/package/files?package=sensorfw-pegatron&project=Trunk

Yeah, that's absolutely dreadful. Don't do that.

> Does it really need to be "fixed"?  If this were a whole class of
> hardware, then I guess I'd agree.  But right now it's one quirky
> device.

I'm going to NAK anything that reports "Coarse orientation change" to 
userspace without providing any context.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
