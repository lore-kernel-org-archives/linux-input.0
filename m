From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH resend] hid-magicmouse: Increase evdev buffer size
Date: Mon, 04 Apr 2011 14:55:03 -0400
Message-ID: <4D9A1407.6030308@canonical.com>
References: <1301691819-2090-1-git-send-email-chase.douglas@canonical.com> <AANLkTim-tN=siA8tJVCzNZHs+oM0hN-N8Ckc+9ynnNpb@mail.gmail.com> <alpine.LNX.2.00.1104041441530.28516@pobox.suse.cz> <BANLkTikG-ku9mDebcaPKTwv3X0N+OKiyYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47508 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135Ab1DDSzK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 14:55:10 -0400
In-Reply-To: <BANLkTikG-ku9mDebcaPKTwv3X0N+OKiyYQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Simon Budig <simon@budig.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/04/2011 02:13 PM, Jeffrey Brown wrote:
> On Mon, Apr 4, 2011 at 5:43 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> I'd happuly take Chase's patch, but want to make sure that we don't cause
>> any changes that would make backwards compatilibity an issue later.
> 
> There should be no compatibility issues.  However, we might be better
> off in the long term taking (some variation of) these patches instead.

I like the proposed changes, but I want to ensure stable kernel releases
aren't left out of the fix for hid-magicmouse. I don't know the best way
forward, but here's one possibility:

1. Apply my patch to manually set the buffer size hint
2. It gets sent to stable trees due to the 'Cc: stable@kernel.org' line
3. Apply Jeffrey's patches, including a reversion of my buffer size hint

Obviously the extra application and reversion is odd, but this seems the
easiest way forward given that the patches already exist and can be
applied without issue.

Thanks,

-- Chase
