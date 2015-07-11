From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH] HID: cp2112: fix to force single data-report reply
Date: Sat, 11 Jul 2015 19:48:44 +0800
Message-ID: <CAAj6DX3RKA-sd=os7ZCpymt2ri4PYgMtnaOwc7wxTFCGoDD2EQ@mail.gmail.com>
References: <1434867625-3062-1-git-send-email-borneo.antonio@gmail.com>
	<55939F3E.7070505@cumulusnetworks.com>
	<alpine.LNX.2.00.1507081115220.10183@pobox.suse.cz>
	<559CFA67.70301@cumulusnetworks.com>
	<alpine.LNX.2.00.1507081240530.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1507081240530.10183@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 8, 2015 at 6:41 PM, Jiri Kosina <jkosina@suse.com> wrote:
> On Wed, 8 Jul 2015, Ellen Wang wrote:
>
>> > > Works as described.  Thank you!
>> > >
>> > > By the way, I tested the code with and without your fix on my rev 2 chip,
>> > > and
>> > > it behaved the same way as you describe on your rev 1 chip.
>> >
>> > Ellen, are you okay with me applying the patch with
>> >
>> >     Tested-by: Ellen Wang <ellen@cumulusnetworks.com>
>> >
>> > ?
>> >
>> > Thanks,
>>
>> Yes.  Thank you.
>
> Ammended with Cc: stable tag, and applied to for-4.2/upstream-fixes.
> Thanks,

Thanks!

Antonio
