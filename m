From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 04/23 v6] Input: atmel_mxt_ts - warn if sysfs could not be created
Date: Mon, 16 Jul 2012 10:34:14 +0800
Message-ID: <CAGS+omCtWiWWeW241mxh_jcYXVfsmBVcKT8VZS_f-war=L+gJQ@mail.gmail.com>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
 <1340888904-15620-5-git-send-email-djkurtz@chromium.org> <20120705172230.GB31383@core.coreip.homeip.net>
 <20120705191539.GA14454@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120705191539.GA14454@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 6, 2012 at 3:15 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> On Thu, Jul 05, 2012 at 10:22:30AM -0700, Dmitry Torokhov wrote:
>> Hi Daniel, Henrik,
>>
>> On Thu, Jun 28, 2012 at 09:08:05PM +0800, Daniel Kurtz wrote:
>> > If sysfs entry creation fails, the driver is still usable, so don't
>> > just abort probe.  Just warn and continue.
>> >
>>
>> I understand that I am a bit late to the party :) but I do not agree
>> with this change. Failure to create attributes is not sometihng that
>> user could cause (at least not easily) and thus would not be a setup
>> issue but something more severe. I believe we should fail loading the
>> driver so sysfs attribute breakage will be noticed as soon as possible,
>> instead of discovering it much much later in the process.
>>
>> So I think we should revert this one.
>
> Ok, I agree. Applied and pushed.
>
> Daniel, I should probably have asked this before: what was the reason
> for this patch in the first place?
>
> Thanks,
> Henrik

No additional reason beyond what is stated in the commit message -
that the driver is still usable without its sysfs entries, so no need
to abort probe.

I'm fine with reverting back to the fail fast approach, too.

Thanks,
Daniel
