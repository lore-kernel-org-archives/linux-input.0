From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/4] Revert to anonymous 'type A' MT protocol for touch
Date: Thu, 7 Jul 2011 15:32:56 -0700
Message-ID: <CANRwn3RO_OuxSH_LwLCNJmi_rpwaCoanY8=vVkhXNSs9i8P4Jg@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
	<20110707213506.GA20310@core.coreip.homeip.net>
	<CAPz4a6Cf+rM17qKVDf7mZrYYv4Dzse4w1wVZaWgrSzb8yppk4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59968 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1GGWc5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 18:32:57 -0400
Received: by wwe5 with SMTP id 5so1396108wwe.1
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 15:32:56 -0700 (PDT)
In-Reply-To: <CAPz4a6Cf+rM17qKVDf7mZrYYv4Dzse4w1wVZaWgrSzb8yppk4A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dima Zavin <dima@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>

On Thu, Jul 7, 2011 at 2:52 PM, Dima Zavin <dima@android.com> wrote:
> Agreed. The next version will correctly use protocol B. When I briefly
> (too briefly clearly :-( ) looked at the original patches, I thought
> they were driver bug fixes. If it's just workarounds for stuff android
> doesn't do, then we should fix our framework.
>
> Jason, do any of these patches fix actual driver bugs or make the
> driver more robust?
>

The only patch which *may* be a bugfix is number 4 ("Only report
multi-touch when pen is out of range"). I can only reproduce
multi-touch + pen oddities under Android, but that could be due to
some kind of filtering from the xf86-input-wacom driver.

The remaining patches are absolutely specific to Android (though still
compatible with desktop distros).

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
