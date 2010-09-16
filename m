From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/7] add tnetv107x input drivers
Date: Thu, 16 Sep 2010 11:29:43 -0700
Message-ID: <87sk197d9k.fsf@deeprootsystems.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
	<87vd658thn.fsf@deeprootsystems.com>
	<201009161111.56465.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39485 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab0IPS3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 14:29:51 -0400
Received: by pzk34 with SMTP id 34so425558pzk.19
        for <linux-input@vger.kernel.org>; Thu, 16 Sep 2010 11:29:51 -0700 (PDT)
In-Reply-To: <201009161111.56465.dmitry.torokhov@gmail.com> (Dmitry Torokhov's
	message of "Thu, 16 Sep 2010 11:11:56 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Thursday, September 16, 2010 10:53:56 am Kevin Hilman wrote:
>> Cyril Chemparathy <cyril@ti.com> writes:
>> > Texas Instruments' TNETV107X is an ARM1176 based SoC, with on-chip
>> > touchscreen and keypad controllers.  This patch series adds drivers for
>> > these controllers.
>> 
>> Dmitry,
>> 
>> With you're review/ack, I can merge these via the davinci tree so the
>> drivers can merge with the platform code that goes with them.  That way
>> we can avoid potential conflicts from other davinci changes touching the
>> same platform files.
>
> Kevin,
>
> I am OK with the drivers coming through your tree, however I am not yet
> completely happy with the patches (as they were posted - their initial
> version).
>

Sure, I'll wait for your review and will not merge them without your
ack.

Thanks,

Kevin



