From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/4] HID: (thingm) introduces blink(1) mk2
Date: Tue, 15 Apr 2014 14:50:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404151450050.32344@pobox.suse.cz>
References: <1397508620-15244-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397508620-15244-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
List-Id: linux-input@vger.kernel.org

On Mon, 14 Apr 2014, Vivien Didelot wrote:

> This patchset introduces the support of the blink(1) mk2 device, after a
> refactoring of the thingm driver. It removes non-standard sysfs attributes and
> uses work queues to fix the usage of triggers with this device.

Queued for 3.16. Thanks,

-- 
Jiri Kosina
SUSE Labs
