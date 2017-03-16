From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor
 support
Date: Thu, 16 Mar 2017 13:01:42 +0100
Message-ID: <1489665702.18490.12.camel@hadess.net>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47911 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdCPMCO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Mar 2017 08:02:14 -0400
In-Reply-To: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com

On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
> As accelerometer sensor becomes more and more popular, there are more
> user scenarios have been developed, "Hinge" is a very important
> usecase
> which needs two accelerometer sensors to calculate the included angle
> of keyboard and screen.
> In this case, two accelerometer sensors will be exposed. Currently,
> IIO interface hasn't other way to distinguish two sensors with same
> sensor type, except sensor name. So a new sensor name "accel_2nd_3d"
> is added for secondary accelerometer sensor.
> 
> In HID level, connection type is a good common property to
> differentiate two sensors with same sensor type.

I've been told in the past not to rely on device names in iio-sensor-
proxy, and this would go against this advice.

As you have a "type" to export, why not export that instead?
