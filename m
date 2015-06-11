From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
Date: Thu, 11 Jun 2015 17:07:34 +0200
Message-ID: <1434035254.5707.21.camel@hadess.net>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
	 <1434034458-1968-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40736 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbFKPHj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2015 11:07:39 -0400
In-Reply-To: <1434034458-1968-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>, linux-iio@vger.kernel.org

On Thu, 2015-06-11 at 08:54 -0600, Simon Wood wrote:
> [resent as I screwed up addressing... sorry]
> 
> This patch is a RFC/POC for the idea of using the iio-subsystem as 
> the
> 'proper' way to communicate the state of motion enabled controllers 
> to
> the Linux internals.
> 
> I have started with the hid-sony driver, with support for the 
> SixAxis's
> 3 Accelerometers. Proper trigger/buffer support will follow shortly, 
> along
> with support for the DS4 and PSMove controllers (which have a much 
> more
> extensive set of motion hardware).
> 
> Once the sensor data is available (over iio) I envision that it will 
> be
> considerably easier to write motion tracking, flight control and AHRS
> software in a consistant manner.

Given that the software reading from the sensors will need to be root,
how will you send the data from those devices to the applications?

> Hopefully this will become the standard way of connecting 
> controllers,
> motion controls and head mounted displays.


