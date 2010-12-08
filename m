From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input: mt: Add hovering distance axis
Date: Wed, 8 Dec 2010 15:31:12 -0800
Message-ID: <AANLkTinGhQC59jqdyJkVLs+mL9BydZp8gGi7c4XO_CL4@mail.gmail.com>
References: <1291710468-2022-1-git-send-email-rydberg@euromail.se>
	<4CFFC45C.2040107@canonical.com>
	<20101208180521.GA31522@core.coreip.homeip.net>
	<AANLkTinKVcc3KA3S_7-vwQWtDuUFZ2LSmjgrCrZXcRw5@mail.gmail.com>
	<4CFFD11D.4070107@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CFFD11D.4070107@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 8, 2010 at 10:40 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> On 12/08/2010 07:20 PM, Ping Cheng wrote:
>>
>> ABS_DISTANCE is used in wacom driver as the distance between the tool
>> tip and the tablet.
>
>
> Thanks for the confirmation. While at it, what are the units for the distance,
> for instance for the Cintiq?

mm? I am not so sure. It is a rough count of how far the tool is away
from the tablet.

Ping
