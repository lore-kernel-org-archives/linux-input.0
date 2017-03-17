From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor
 support
Date: Fri, 17 Mar 2017 14:16:34 +0100
Message-ID: <1489756594.18490.22.camel@hadess.net>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
         <1489716812.10281.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35472 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdCQNQm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Mar 2017 09:16:42 -0400
In-Reply-To: <1489716812.10281.4.camel@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Song, Hongyan" <hongyan.song@intel.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>

On Fri, 2017-03-17 at 02:13 +0000, Pandruvada, Srinivas wrote:
> On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
> > As accelerometer sensor becomes more and more popular, there are
> > more
> > user scenarios have been developed, "Hinge" is a very important
> > usecase
> > which needs two accelerometer sensors to calculate the included
> > angle
> > of keyboard and screen.
> > In this case, two accelerometer sensors will be exposed. Currently,
> > IIO interface hasn't other way to distinguish two sensors with same
> > sensor type, except sensor name. So a new sensor name
> > "accel_2nd_3d"
> > is added for secondary accelerometer sensor.
> 
> This type of interface will not satisfy all cases. We have some hubs
> with  many accelerometers attached. Same case is also true even for
> discrete sensors. So there should be some framework way to expose
> location of sensors.

So you're nacking as well?

> ACPI has special method called _PLD (Physical Device Location), which
> can  be used to specify location of any device. So we need to be able
> to export such information to user space. We can add for each sensor
> the location information.
> 
> I can propose some ABI for exporting location information.

There were patches floating around to do this, but they were never
finished:
http://www.spinics.net/lists/linux-acpi/msg51540.html

Cheers
