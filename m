From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] input:Regulator support in ROHM BU21013 touch panel
Date: Wed, 12 Jan 2011 10:51:57 +0000
Message-ID: <20110112105156.GB20911@opensource.wolfsonmicro.com>
References: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
 <20110112084050.GB4644@core.coreip.homeip.net>
 <81C3A93C17462B4BBD7E272753C1057919521AF539@EXDCVYMBSTM005.EQ1STM.local>
 <20110112091553.GA4183@core.coreip.homeip.net>
 <81C3A93C17462B4BBD7E272753C1057919521AF64C@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40440 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752118Ab1ALKyH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 05:54:07 -0500
Content-Disposition: inline
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057919521AF64C@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>, "rydberg@euromail.se" <rydberg@euromail.se>, Bengt JONSSON <bengt.g.jonsson@stericsson.com>

On Wed, Jan 12, 2011 at 11:04:10AM +0100, Naveen Kumar GADDIPATI wrote:
> >> >On Wed, Jan 12, 2011 at 12:05:26PM +0530, Naveen Kumar G wrote:

> >So who/what cares about I2C device name? I do not see how this help
> >anything, but it does make device's name differ from its sysfs name.

> >I believe that driver should only alter names of objects they create and
> >leave other objects alone.

> In our regulator driver platform data, we used to differentiate with device name,
> which is more readable than the client device name. That is why we are sending it through platform data.
> If you are not preferable to use this, we could change it to client device name.

This is not what the regulator API is expecting you to do.  The
regulator API is expecting you to use whatever the device name the
bus/device model ends up giving you by default is.  If you want to
assign other device names for readability or similar reasons that's
another issue which should be taken up with the device core guys.
