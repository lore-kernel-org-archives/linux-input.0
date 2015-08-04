From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Evdev - Avoid data loss when clock type is changed
Date: Tue, 4 Aug 2015 09:50:49 -0700
Message-ID: <20150804165049.GA37185@dtor-ws>
References: <1438381732-29681-1-git-send-email-aniroop.mathur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33485 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbHDQuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2015 12:50:52 -0400
Received: by pdbnt7 with SMTP id nt7so6627127pdb.0
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2015 09:50:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438381732-29681-1-git-send-email-aniroop.mathur@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: linux-input@vger.kernel.org, a.mathur@samsung.com

Hi Aniroop,

On Sat, Aug 01, 2015 at 03:58:52AM +0530, Aniroop Mathur wrote:
> When clock type is changed, previously stored data is flushed
> and therfore does not reach to upper layer or application.
> Data is critically important along with the timestamp.
> So to avoid data loss and send correct timestamp as well,
> lets not flush data upon clock type change and
> to send correct timestamp, store only monotonic timestamp during write
> and change monotonic clock time to desired clock time during read.

I wonder if this matters that much. The only time where this change would make
difference is when you have a reader thread and then a controlling
thread changing clocks. Then you probably do not want to lose events,
but you also would not know for given event what kind of timestamp it
uses.

On the other hand I expect that your application changes clock type the
very first thing after opening the event device. In this case the
flushing queue does not matter: you are losing events that happened
before you opened the device, so it does not really matter if you lose a
few more in the beginning.

I guess I need better understanding of your use case.

Thanks.

-- 
Dmitry
