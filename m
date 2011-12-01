From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 2/2] Input: tsc2007 - Add a z1_low_threshhold platform
 data parameter
Date: Thu, 1 Dec 2011 14:19:48 +0800
Message-ID: <20111201141948.13162071@feng-i7>
References: <1322554378-348-1-git-send-email-feng.tang@intel.com>
	<1322554378-348-2-git-send-email-feng.tang@intel.com>
	<20111129092310.GB21758@core.coreip.homeip.net>
	<20111130103418.4514b630@feng-i7>
	<20111201054726.GC16816@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21337 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab1LAGTB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Dec 2011 01:19:01 -0500
In-Reply-To: <20111201054726.GC16816@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Clark, Joel" <joel.clark@intel.com>

On Thu, 1 Dec 2011 13:47:26 +0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Wed, Nov 30, 2011 at 10:34:18AM +0800, Feng Tang wrote:
> > On Tue, 29 Nov 2011 17:23:10 +0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > > On Tue, Nov 29, 2011 at 04:12:58PM +0800, Feng Tang wrote:
> > > > This originates from a patch in Meego IVI kernel with the name
> > > > 	linux-2.6.37-connext-0027-tsc2007.patch
> > > > There is no author info excepte a line "From  MeeGo
> > > > <kernel@meego.com>"
> > > > 
> > > > When integrating tsc2007 on Intel IVI platform, there are a lot
> > > > of noise data whose z1 value is around 10 which is not a sane
> > > > "z1". So add a "z1_low_threshhold" to filter those nosie data,
> > > > to make the device work properly.
> > > 
> > > Sounds like a task for userspace to ignore pressure that is too
> > > low. Bonus points for making it configurable so user can adjust
> > > sensitivity.
> > 
> > Actually, there is one more point :), without this patch, the
> > driver won't work on our platforms.
> > 
> > The tsc2007_soft_irq will keep reading the input data unless there
> > is no valid pressure data. In our case, those noise data will be
> > seen as valid data during tsc2007_calculate_pressure(), and the
> > tsc2007_soft_irq will run endlessly.
> 
> Even if we add the pressure threshold would not that noise cause
> endless stream of interrupts?

No, there is no endless interrupts for tsc2007. Without the z1
threshold, the while circle in tsc2007_soft_irq will run endlessly
as the noise data will be seen as a valid data:

		rt = tsc2007_calculate_pressure(ts, &tc);
		if (rt == 0 && !ts->get_pendown_state) {
			/*
			 * If pressure reported is 0 and we don't have
			 * callback to check pendown state, we have to
			 * assume that pen was lifted up.
			 */
			break;
		}

With the z1 threshold check, the rt will be 0 for noise data, and the
code flow broke out.

> 
> Also, what kind of z2 is reported with low z1? And do you implement
> get_pendown_state()?

z2 seems normal as some data between 3000-4000. We don't have a
get_pendown_state().

Thanks,
Feng
> 
> Thanks.
> 
