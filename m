From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 16/16] HID: wiimote: Enable NO_INIT_REPORTS quirk
Date: Thu, 17 Nov 2011 14:11:50 +0100
Message-ID: <CANq1E4QAWqE0Ag+-pVSgHZAR=WKw9d8WQ2505SKM7wnf0sK3hg@mail.gmail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
	<1321190839-3517-17-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1111161805250.15187@pobox.suse.cz>
	<CANq1E4T-mMYgEZFSEcZnWZvPCBRg1J=f8zJSc-OOqVK9bJ9dsA@mail.gmail.com>
	<alpine.LNX.2.00.1111161938430.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48113 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQNLw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:11:52 -0500
Received: by wwe5 with SMTP id 5so2878372wwe.1
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:11:51 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1111161938430.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 7:39 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 16 Nov 2011, David Herrmann wrote:
>
>> >> -#define WIIMOTE_VERSION "0.2"
>> >> +#define WIIMOTE_VERSION "0.3"
>> >
>> > Do we really need this?
>> >
>> > I generally prefer not having any file versioning for the files that are
>> > implicitly tracked by kernel git.
>>
>> No, not at all. But I thought this was common practice. I have removed
>> it all together. The next series will be updated.
>
> It definitely might make sense for your internal tracking during driver
> development. I just would like to have it dropped for final merge.
>
> Otherwise, I have just finished first round of review, and overall the
> driver looks fine, thanks!

Great. I've resent the revised patches. Let me know if there are any
other issues.

> --
> Jiri Kosina
> SUSE Labs
>

Cheers
David
