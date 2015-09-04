From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v1] HID: sensor-hub: Fixup for Lenovo ThinkPad Helix 2
 sensor hub report
Date: Fri, 4 Sep 2015 14:48:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509041448230.30132@pobox.suse.cz>
References: <1441295896-23314-1-git-send-email-fernandodsl@gmail.com> <1441310422.3164.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36172 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310AbbIDMsm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Sep 2015 08:48:42 -0400
In-Reply-To: <1441310422.3164.1.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Fernando D S Lima <fernandodsl@gmail.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 3 Sep 2015, Srinivas Pandruvada wrote:

> On Thu, 2015-09-03 at 12:56 -0300, Fernando D S Lima wrote:
> > There is an error in the report descriptor of the Thinkpad Helix 2 
> > where
> > logical minimum value (557376) is greater than logical maximum 
> > (491200)
> > for all of the magnetic flux axis data fields. This error results in 
> > a
> > report descriptor parsing failure that causes the sensors attached to 
> > the
> > hub not to be detected.
> > 
> > dmesg excerpt:
> > [   19.866905] drivers/hid/hid-core.c: logical range invalid 0x88140 
> > 0x77ec0
> > [   19.866914] hid-sensor-hub 0018:2047:0855.0007: item 0 1 0 8 
> > parsing failed
> > [   19.866926] hid-sensor-hub 0018:2047:0855.0007: parse failed
> > [   19.866933] hid-sensor-hub: probe of 0018:2047:0855.0007 failed 
> > with error -22
> > 
> > Add a report fixup to change magnetic flux logical minimums to 
> > -557376
> > for the parsing to succeed and the sensors to get detected.
> > After applying the fix the sensors get detected, with corresponding 
> > drivers
> > (hid-accel-3d,hid-gyro-3d,etc) loaded, and its possible to read their 
> > values.
> > 
> > Signed-off-by: Fernando D S Lima <fernandodsl@gmail.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-4.3/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

