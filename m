From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid-multitouch: Add quirk for VTL touch panels
Date: Thu, 20 Nov 2014 10:27:14 -0500
Message-ID: <CAN+gG=F5AENtv0a-sK3WmvYLdVUWEyteXce1avX7+eRSeOAswQ@mail.gmail.com>
References: <1416422480-3241-1-git-send-email-mathieu.magnaudet@enac.fr>
	<CAN+gG=GN4dwXr_qEHMfMddGHkMKECZMUwTM+xbNmY_gibthLmA@mail.gmail.com>
	<alpine.LNX.2.00.1411201421100.4454@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1411201421100.4454@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mathieu Magnaudet <mathieu.magnaudet@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 20, 2014 at 8:21 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 19 Nov 2014, Benjamin Tissoires wrote:
>
>> though this patch works for this particular device, I just thought at
>> something which may solve the problem in a different way. I asked
>> Mathieu to test the different solution, so I'd rather you to wait for
>> final confirmation before merging this patch.
>
> Thanks for the heads up, I am putting this patch on hold until further
> notice from you or Mathieu.
>

Mathieu confirmed this morning that using hid_hw_raw_request instead
of hid_hw_request while _setting_ the input_mode works for this
particular touchscreen. So I think we will simply switch to use this
sync operation instead of relying on the async one. We will need to
test this change a little bit, but it should be safe for BT and I2C at
least.

So, yes, we will drop this patch and have a better one in the next few
days. Thanks for holding this one :)

Cheers,
Benjamin
