From: James Feeney <james@nurealm.net>
Subject: Re: [PATCH 2/2] HID: input: fix assignment of .value
Date: Tue, 23 Apr 2019 11:54:07 -0600
Message-ID: <37009110-5a11-7ed4-3315-e87b98cc45b7@nurealm.net>
References: <20190423154615.18257-2-benjamin.tissoires@redhat.com>
 <20190423172117.CC66520835@mail.kernel.org>
Reply-To: james@nurealm.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423172117.CC66520835@mail.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 4/23/19 11:21 AM, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 2dc702c991e3 HID: input: use the Resolution Multiplier for high-resolution scrolling.
> 
> The bot has tested the following trees: v5.0.9.
> 
> v5.0.9: Failed to apply! Possible dependencies:
>     724f54bc0063 ("HID: input: make sure the wheel high resolution multiplier is set")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha
> 

This patch will only apply *after* the application of the first patch, since they "overlap".

Yes, that is probably not the best circumstance.  I think Benjamin wanted to keep the issue in patch 2/2 distinct.

Was the first patch applied before attempting application of the second patch?

James
