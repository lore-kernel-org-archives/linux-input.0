From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor
 support
Date: Fri, 17 Mar 2017 14:14:33 +0100
Message-ID: <1489756473.18490.20.camel@hadess.net>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
         <1489665702.18490.12.camel@hadess.net>
         <AE3E3DFA698D6144A7445C92D1D41E2F10BE185E@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50643 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdCQNQl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Mar 2017 09:16:41 -0400
In-Reply-To: <AE3E3DFA698D6144A7445C92D1D41E2F10BE185E@SHSMSX103.ccr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Song, Hongyan" <hongyan.song@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

On Fri, 2017-03-17 at 01:21 +0000, Song, Hongyan wrote:
> Hi,
> 	Thanks for your comments. But I am not sure what your "type"
> mean.

I mean the connector type, which you use to differentiate the 2
accelerometers. You should export this data instead of changing the
name of the sensor.

> If you mean "sensor type", I expose it as second ACC, the sensor type
> is the same with the exist ACC,
> It cannot be used as a distinction.
> If you mean the "connection type" I used in the patch, "connection
> type" is only defined in HID driver,
> It is not a common property in IIO. So not good to expose it out.
> 
> 
> BR
> Song Hongyan  
> 
> -----Original Message-----
> From: Bastien Nocera [mailto:hadess@hadess.net] 
> Sent: Thursday, March 16, 2017 8:02 PM
> To: Song, Hongyan <hongyan.song@intel.com>; linux-input@vger.kernel.o
> rg; linux-iio@vger.kernel.org
> Cc: jikos@kernel.org; jic23@kernel.org; Pandruvada, Srinivas <sriniva
> s.pandruvada@intel.com>
> Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC
> sensor support
> 
> On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
> > As accelerometer sensor becomes more and more popular, there are
> > more 
> > user scenarios have been developed, "Hinge" is a very important 
> > usecase which needs two accelerometer sensors to calculate the 
> > included angle of keyboard and screen.
> > In this case, two accelerometer sensors will be exposed.
> > Currently, 
> > IIO interface hasn't other way to distinguish two sensors with
> > same 
> > sensor type, except sensor name. So a new sensor name
> > "accel_2nd_3d"
> > is added for secondary accelerometer sensor.
> > 
> > In HID level, connection type is a good common property to 
> > differentiate two sensors with same sensor type.
> 
> I've been told in the past not to rely on device names in iio-sensor-
> proxy, and this would go against this advice.
> 
> As you have a "type" to export, why not export that instead?
> NrybXǧv^)޺{.n+{zn)w*jgݢj/zޖ2ޙ&)ߡaGhj:+vw٥
