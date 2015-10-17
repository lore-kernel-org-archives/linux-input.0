From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] Input: edt-ft5506 - Adding support for FT5506
Date: Sat, 17 Oct 2015 09:30:12 -0700
Message-ID: <20151017163012.GA13470@dtor-ws>
References: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33009 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbbJQQaP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 12:30:15 -0400
Content-Disposition: inline
In-Reply-To: <1445004869-31986-1-git-send-email-fcooper@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com

On Fri, Oct 16, 2015 at 09:14:25AM -0500, Franklin S Cooper Jr wrote:
> This series adds support for the FT5506 tsc. The biggest difference
> between this tsc vs the ones currently supported by the driver is the
> ability to handle upto 10 touch points.
> 
> The FT5506 tsc that I currently have seems to be based on the M09
> firmware which I have documentation for. However, I haven't been able
> to find documentation for the tsc that use the M06 firmware. Therefore,
> the calculation I made to determine the amount of data to read for the M06
> is at best an educated guess.
> 
> If anyone has the doc for the old firmware please send it to me if
> possible or double check the code I use to determine the amount of bytes
> to read.
> 
> Also I had to work around a weird bug that I'm only seeing on the FT5506.
> I tested this patch set on another board (AM437x SK) that uses the FT5306
> and didn't see any problems.
> 
> This patchset is built on top of linux-input master
> 
> Franklin S Cooper Jr (4):
>   Input: edt-ft5x06 - Use max support points to determine how much to
>     read
>   Input: edt-ft5x06 - Add support for different max support points
>   Input: edt-ft5x06 - Add support for FT5506
>   Input: edt-ft5x06 - Work around FT5506 firmware bug

Applied with minor changes to the #2.

Thanks!

-- 
Dmitry
