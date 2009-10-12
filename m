From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Mon, 12 Oct 2009 17:42:08 +0200
Message-ID: <ac3eb2510910120842m3129b76fyaa11b509e7f97038@mail.gmail.com>
References: <20091006074533.GA28889@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:57878 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbZJLPng (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 11:43:36 -0400
In-Reply-To: <20091006074533.GA28889@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com

On Tue, Oct 6, 2009 at 09:45, Kyungmin Park <kmpark@infradead.org> wrote:
> This patch includes two haptic devices, isa1000 and isa1200
> ISA1000 is gpio based haptic, but isa1200 is based on I2C
> Both are working on Samsung SoCs and tested.
>
> To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
> You can adjust the level by echo ${level} > /sys/class/haptic/${name}/enable
> or
> With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}/oneshot

Please never add any custom files to the top-level of a class
directory. This place is reserved for devices, and not for custom
files. It's a serious bug in the layout and API of sysfs that this
allowed at all.

If you need these subsystem-wide contols please use a bus and not a
class to stuff these files into a place where they don't mix up with
the list of devices belonging to a class. Buses have all devices in a
devices/ subdir so they will not conflict.

Thanks,
Kay
