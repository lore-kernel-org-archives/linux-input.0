From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: tps6507x-ts - convert to polled input device
 infrastructure
Date: Tue, 18 Jun 2013 23:17:32 -0700
Message-ID: <20130619061732.GC26181@core.coreip.homeip.net>
References: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
 <1370843627-30823-3-git-send-email-dmitry.torokhov@gmail.com>
 <A4887BF146CD57468F700B415D2F47015A132E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54221 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab3FSGRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 02:17:35 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so4653947pdj.8
        for <linux-input@vger.kernel.org>; Tue, 18 Jun 2013 23:17:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A4887BF146CD57468F700B415D2F47015A132E@DBDE04.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

On Wed, Jun 12, 2013 at 07:12:31AM +0000, Vishwanathrao Badarkhe, Manish wrote:
> Hi Dmitry,
> 
> On Mon, Jun 10, 2013 at 11:23:47, Dmitry Torokhov wrote:
> > There is no need to roll our own polling scheme when we already have
> > one implemented by the core.
> 
> Please let me know, on which branch this patch series is based on? 
> I failed to apply these patches on master branch of "linux-next". 

Linux-next should work, I do not have anything else for this driver
pending in my queue.

Thanks.

-- 
Dmitry
