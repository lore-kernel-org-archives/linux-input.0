From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
Date: Mon, 2 Jul 2018 15:22:50 +0300
Message-ID: <CAHp75VeO-3AAvYXP3=bShpec4YzDRXwEKCAP_HwfQpzoLCcZ1A@mail.gmail.com>
References: <20180617235812.18596-1-youling257@gmail.com> <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
 <32076294-07ac-7801-2220-7468e71c275e@redhat.com> <CAHp75VfPPnqgsHFwfLaUZSYa3i2tUmvWpwgxEAz45q61aU9OGA@mail.gmail.com>
 <20180619080522.40a20951@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619080522.40a20951@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Hans de Goede <hdegoede@redhat.com>, youling257 <youling257@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 19, 2018 at 1:05 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Mon, 18 Jun 2018 16:59:30 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

>> > youling has indicated to me (off-list) that he does not
>> > want to use his real name.
>> >
>> > He has already provided me with the touchscreen details
>> > and dmi strings for this tablet a while ago and I had
>> > writing the exact same quirk on my TODO list already.
>> >
>> > As such I've no doubt that he created this patch and
>> > has the rights to Submit it under the GPL license.
>> >
>> > So I'm going to resubmit this with his S-o-b removed
>> > and replaced with mine. Where the intent of my
>> > S-o-b is to certify point c. of the certificate
>> > of origin, quoting from:
>> >
>> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
>> >
>> > "c. The contribution was provided directly to me by some other person who
>> > certified (a), (b) or (c) and I have not modified it."
>> >
>> > This seems better then me re-creating the exact
>> > same patch from scratch.
>>
>> I guess this will not pass checks Stephen has.
>> So, Stephen, how should we proceed?
>
> That's fine.  I amy report it (If I forget this email), but you can
> just ignore the report.  My scripted checks obviously can't take this
> case into account.

Thanks!

I have pushed to my review and testing queue as is.

-- 
With Best Regards,
Andy Shevchenko
