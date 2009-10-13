From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Poll rate change and closing indication to polled input device
Date: Tue, 13 Oct 2009 10:19:54 +0100
Message-ID: <20091013091953.GA25856@rakim.wolfsonmicro.main>
References: <1255089779.28243.24.camel@4fid08082>
 <20091009121201.GE5082@sirena.org.uk>
 <20091009162717.GC1092@core.coreip.homeip.net>
 <20091009181012.GA21731@sirena.org.uk>
 <20091013010841.GB21626@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56569 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754992AbZJMJUb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 05:20:31 -0400
Content-Disposition: inline
In-Reply-To: <20091013010841.GB21626@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Onkalo Samu <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org

On Mon, Oct 12, 2009 at 06:08:42PM -0700, Dmitry Torokhov wrote:
> On Fri, Oct 09, 2009 at 07:10:12PM +0100, Mark Brown wrote:

> > It definitely needs to be implemented in the drivers but they need to
> > present an interface to userspace which seems best placed in the core to
> > factor out code and help make sure that the interface is standardised.

> It seems to me that this kind of functionality belongs to PM core.
> Userspace probably does not really care about output rate and other
> details but rather wants to putsome devices into a low power mode in
> general.

That's useful as well and having this doesn't preclude other forms of
runtime power management but there is also value in this kind of
subsystem specific control too.  

In the case of touchscreens we should be able to get some useful
information out of userspace - applications like handwriting recognition
will want 150-200 samples/second but for something like a finger
operated menu 10-20 samples/second will be enough.  This should result
in a win, especially bearing in mind that each point is going to
translate into a wakeup for the application layer, and also reduces the
amount of manual tuning that might be required.
