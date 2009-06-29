From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH 0/2] fix gpio-keys debouncing and timer sleep issues
Date: Mon, 29 Jun 2009 13:32:28 +0300
Message-ID: <1246271548.20530.207.camel@jani-desktop>
References: <20090626002345.07928230@dxy.sh.intel.com>
	 <cover.1246015395.git.ext-jani.1.nikula@nokia.com>
	 <20090629055940.GC12821@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55269 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759259AbZF2Kct (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 06:32:49 -0400
In-Reply-To: <20090629055940.GC12821@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "alek.du@intel.com" <alek.du@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>

On Mon, 2009-06-29 at 07:59 +0200, ext Dmitry Torokhov wrote:
> I intend to apply the both patches. It is unfortunate that we need to
> use both a timer and a workqueue, I wonder what would it take to
> implement something like reschedule_delayed_work() that would adjust
> the delay in the same fashion that mod_timer() does?

Hi Dmitry -

Since a delayed_work is simply a work_struct and a timer_list, the only
overhead here is the one line timer function. A work_struct per button
is of course an addition to the original in both Alek's patch and mine,
but I guess there are no alternatives if gpio_get_value may sleep.

I did think about something like reschedule_delayed_work myself, but
tackling the locking issues seemed like too much work compared to this
simple solution.


BR,
Jani.


