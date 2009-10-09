From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Poll rate change and closing indication to polled input device
Date: Fri, 9 Oct 2009 13:12:02 +0100
Message-ID: <20091009121201.GE5082@sirena.org.uk>
References: <1255089779.28243.24.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33853 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760536AbZJIMMk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 08:12:40 -0400
Content-Disposition: inline
In-Reply-To: <1255089779.28243.24.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Onkalo Samu <samu.p.onkalo@nokia.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 09, 2009 at 03:02:59PM +0300, Onkalo Samu wrote:

> I would like to change the polling rate of the polled input device
> on the fly depending on the use case. One possible way is to directly
> modify poll_interval from my driver. However, I would like to introduce
> functions which can be used to set / get polling rate like 

> input_polled_device_set_rate(...)

> input_polled_device_get_rate(...)

> Another missing thing is an indication when the polled device is closed.
> This can be used to turn off the HW which is not used anymore.

> What do you think, is it ok to introduce these additions to the polled
> input device?

It'd be really good to have this control exposed to user space in a
standard fashion.  Other devices that generate constant data rates like
touchscreens could also benefit from it, changing their output rate
depending on the needs of user space to give a power saving.
