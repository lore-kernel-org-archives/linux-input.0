From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: [PATCH 3.12-rc1] USB: input: cm109.c: Convert high volume dev_err()
 to dev_err_ratelimited()
Date: Mon, 23 Sep 2013 10:51:09 -0700
Message-ID: <52407F8D.7050902@canonical.com>
References: <1378830193-48384-1-git-send-email-tim.gardner@canonical.com> <20130919215246.GB16015@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130919215246.GB16015@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 09/19/2013 02:52 PM, Dmitry Torokhov wrote:
> Hi Tim,
> 
> On Tue, Sep 10, 2013 at 10:23:13AM -0600, Tim Gardner wrote:
>> BugLink: http://bugs.launchpad.net/bugs/1222850
>>
>> This input device can get into a state that produces a high
>> volume of device status errors. Attempt to throttle these
>> error messages such that the kernel log is not flooded.
>>
> 
> Only 2 of these printks need to be rate-limited, as other failures are
> fatal to the driver since it will not resubmit the IO.
> 
> Also I think we need to try and resubmit control URB to try and execute
> buzzer command if previous one failed.
> 
> BTW, EPROTO/EILSEQ errors mentioned in the launchpad bug seem to relate
> to timeout/CRC errors reported by the host controller, so it must indeed
> be the extender that is misbehaving.
> 
> Thanks.
> 

Looks good to me.

rtg
-- 
Tim Gardner tim.gardner@canonical.com
