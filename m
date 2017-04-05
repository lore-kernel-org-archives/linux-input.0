From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Revert "Input: bma150 - avoid binding to bma180 if IIO
 bma180 driver present" and "Input: bma150 - extend chip detection for
 bma180"
Date: Wed, 5 Apr 2017 14:37:23 -0700
Message-ID: <20170405213723.GA8076@dtor-ws>
References: <631685e1205d8b1b45d61e57070310d89d535b74.1491057884.git.hns@goldelico.com>
 <cce3c9da-8092-1092-56f5-46afecffeb19@redhat.com>
 <20170401164632.GD17130@dtor-ws>
 <C162E895-4ECF-4047-AD75-3C358142CDBB@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33435 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755870AbdDEVh1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Apr 2017 17:37:27 -0400
Content-Disposition: inline
In-Reply-To: <C162E895-4ECF-4047-AD75-3C358142CDBB@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Aniroop Mathur <a.mathur@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org

On Wed, Apr 05, 2017 at 09:16:28PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 01.04.2017 um 18:46 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > On Sat, Apr 01, 2017 at 04:59:26PM +0200, Hans de Goede wrote:
> >> Hi,
> >> 
> >> On 01-04-17 16:44, H. Nikolaus Schaller wrote:
> >>> This reverts commit baf28d91e7b1 ("Input: bma150 - avoid binding to bma180 if IIO bma180 driver present")
> >>> and commit ef3714fdbc8d ("Input: bma150 - extend chip detection for bma180")
> >>> 
> >>> Rationale: initially (2012) the GTA04 device using a bma180 chip simply refereced
> >>> the bma150 platform driver in its board file [1] which happened to work in all
> >>> scenarios that were tested.
> >>> 
> >>> When conversion to DT started (2014), we needed to make the driver be still
> >>> recognised. Hence we introduced the compatibility to the bma180 chip in
> >>> Linux 3.15-rc5 [2] without further checks if it is really 100% compatible. This
> >>> worked flawlessly for years with the GTA04 device.
> >>> 
> >>> Recently (2016), Hans de Goede pointed out that the chips are not as similar
> >>> as they appeared and the driver works with the bma180 for the GTA04 only
> >>> by good luck. He proposed to remove the bma180 support completely [3], but
> >>> we still did need it until we have a replacement. Thus, a condifional compile
> >>> was added.
> >>> 
> >>> We have now developed a generic iio-input-bridge which works with any 2 or
> >>> 3 axis iio based accelerometer. It has been tested on GTA04 and Pyra and
> >>> works as expected. Therefore we can remove the bma180 support from this
> >>> driver completely. User-space API compatibility can be restored by using the
> >>> iio-input-bridge.
> >>> 
> >>> Maybe it is time to convert the bma150 driver to iio as well and retire the
> >>> accelerometer input drivers completely but this is a different story and task.
> >>> 
> >>> [1]: https://github.com/neilbrown/linux/blob/gta04/3.2.y/arch/arm/mach-omap2/board-omap3gta04.c#L976
> >>> [2]: https://patchwork.kernel.org/patch/3961171/
> >>> [3]: https://patchwork.kernel.org/patch/9325481/
> >>> 
> >>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> 
> >> Looks good to me:
> >> 
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Changed subject slightly (we are not reverting because patches were
> > defective, we are removing support for bma180), and applied.
> 
> Just noticed: the subject in linux-next has a typo:
> Should IMHO be "Input: bma150 - remove support for bma180"
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f069b5a0b27ad4a87e9351e54fbcab3d3f8a9fd5

Yeah, I screwed up there. Unfortunately it is buries too deep now.

Thanks.

-- 
Dmitry
