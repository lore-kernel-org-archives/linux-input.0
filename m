From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: hid-input: Fix accessing freed memory during driver
 unbind
Date: Sat, 1 Aug 2015 14:11:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508011410170.925@pobox.suse.cz>
References: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com> <alpine.LNX.2.00.1507291506500.925@pobox.suse.cz> <20150729174619.GC23178@dtor-ws> <CAJKOXPcsHAj7_pggVw9eeU-C1_zKuZJA7oUodtXp=ZJH4AWg9w@mail.gmail.com> <20150730001026.GH23178@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150730001026.GH23178@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 29 Jul 2015, Dmitry Torokhov wrote:

> > Another and less intrusive fix would be:
> > 
> >     char *name = dev->battery->desc->name;
> >     struct power_supply_desc *psy_desc = dev->battery->desc;
> >     power_supply_unregister(dev->battery);
> >     kfree(name);
> >     kfree(psy_desc);
> 
> I would much rather prefer this to the other version as it does not
> leave memory hanging around, potentially indefinitely, but ultimately it
> is up to Jiri. 

I must have been in some broken state of mind when applying the original 
one, thanks a lot for catching my brainfart, Dmitry!

Kryzstof, could you please send me properly formatted patch with the 
above, on top of your previous fix?

Thanks.

-- 
Jiri Kosina
SUSE Labs
