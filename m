From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch 0/7] updates for xpad
Date: Thu, 03 Apr 2008 23:44:02 +0300
Message-ID: <47F54192.80100@gmail.com>
References: <20080317192250.208635026@gmail.com> <20080403162520.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:34179 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139AbYDCUoH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Apr 2008 16:44:07 -0400
In-Reply-To: <20080403162520.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Anssi,
> 
> On Mon, Mar 17, 2008 at 09:22:50PM +0200, Anssi Hannula wrote:
>> What follows is a few patches for xpad fixing some issues, adding new
>> ids, and Brian's xbox360 wireless patch adapted for current xpad.c.
>>
>> They are against current mm, i.e. 'match xbox 360 devices with
>> interface info' should be applied first.
>>
> 
> I applied everything to xpad branch of my tree. Please take a look and
> see if I am missing anything and I will merge it into master.
> 
> Thank you.

They seem ok :)

BTW, "xpad - enable force feedback on xbox 360 controllers only" seems
to fix a null pointer dereference, I got a report from Edgar Simo that
he experienced system hang when trying to use force feedback with a
non-360 controller.

Maybe you should push it to the current stable trees as well?

-- 
Anssi Hannula
