From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Why hid-sensor-hub's IIO doesn't work properly in >= 4.3
 (possibly badly bisected)
Date: Fri, 27 Jan 2017 00:07:27 +0100
Message-ID: <CAJZ5v0hYwyV+j+38rdqo81x0p5jWyLzHijYFY5RmnODzRUK0qg@mail.gmail.com>
References: <1484927552.21721.17.camel@hadess.net> <1485443735.5845.30.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1485443735.5845.30.camel@hadess.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Richard Hughes <richard@hughsie.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 26, 2017 at 4:15 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2017-01-20 at 16:52 +0100, Bastien Nocera wrote:
>> Hey,
>>
>> TLDR:
>> # first bad commit: [50ba22479c324c0d9dc8134d519dcba92d83a8a7] Merge
>> back earlier ACPI PM material for v4.3.
>>
>> hid-sensor-hub devices only start sending events through the IIO
>> trigger after a suspend/resume cycle.
>>
>> Other IIO drivers don't seem to exhibit those problems.
>
> I had another go, trying to break into the merge commit, and it's
> slightly more precise, but still doesn't make any sense to me.
>
> # first bad commit: [3431e490b50356b56084305a2e93b3a980802b22] Merge
> branch 'acpi-scan' into acpi-pm
>
> Any ideas? I'm running out of them...

The parents of this merge are 5af310a8ee70 and 1dcc3d3362b0.

Can you please check if the problem is present in any of them alone?

If not, it is theoretically possible that the merge itself had
introduced it (as this is not a trivial merge).

Thanks,
Rafael
