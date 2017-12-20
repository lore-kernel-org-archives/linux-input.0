From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1] HID: sony: Print reversed MAC address via %pMR
Date: Wed, 20 Dec 2017 10:40:58 +0100
Message-ID: <CAO-hwJ++gQX+72q8AfnM8q8-MzHyFbxUhnjL+=kSQKeUQ+H1KQ@mail.gmail.com>
References: <20171211130612.34715-1-andriy.shevchenko@linux.intel.com>
 <1DD62093774CEE42AFC16E785A1088049E247090@USCULXMSG13.am.sony.com> <1513704018.7000.207.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:41287 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754643AbdLTJlA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Dec 2017 04:41:00 -0500
Received: by mail-qt0-f176.google.com with SMTP id i40so27530616qti.8
        for <linux-input@vger.kernel.org>; Wed, 20 Dec 2017 01:41:00 -0800 (PST)
In-Reply-To: <1513704018.7000.207.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Andy,

On Tue, Dec 19, 2017 at 6:20 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2017-12-13 at 02:22 +0000, Colenbrander, Roelof wrote:
>> On 12/11/2017 05:07 AM, Andy Shevchenko wrote:
>> > Reversed MAC addresses can be printed directly using %pMR specifier.
>
>> Looks good and in a quick test seems to function.
>>
>> Acked-by: Roderick Colenbrander <roderick.colenbranderer@sony.com>
>>
>
> Benjamin, perhaps it's good enough to being applied?

This question should be directed to Jiri :)

Anyway:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
