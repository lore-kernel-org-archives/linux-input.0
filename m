From: Heorhi Valakhanovich <valahanovich@tut.by>
Subject: Re: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom
 usage
Date: Sun, 25 Aug 2019 23:50:23 +0300
Message-ID: <b72a0562-262e-5373-e2a2-5c1b1e5ca37a@tut.by>
References: <20190611121320.30267-1-nsaenzjulienne@suse.de>
 <cd69abeb3883ff7c7e2ff8dbe4db722f4e981875.camel@suse.de>
 <nycvar.YFH.7.76.1908051437490.5899@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1908051437490.5899@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, dmitry.torokhov@gmail.com, wbauer@tmo.at, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 8/5/19 3:38 PM, Jiri Kosina wrote:
> On Thu, 1 Aug 2019, Nicolas Saenz Julienne wrote:
> 
>>> Some a4tech mice use the 'GenericDesktop.00b8' usage to inform whether
>>> the previous wheel report was horizontal or vertical. Before
>>> c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key") this
>>> usage was being mapped to 'Relative.Misc'. After the patch it's simply
>>> ignored (usage->type == 0 & usage->code == 0). Which ultimately makes
>>> hid-a4tech ignore the WHEEL/HWHEEL selection event, as it has no
>>> usage->type.
>>>
>>> We shouldn't rely on a mapping for that usage as it's nonstandard and
>>> doesn't really map to an input event. So we bypass the mapping and make
>>> sure the custom event handling properly handles both reports.
>>>
>>> Fixes: c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key")
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> ---
>>
>> It would be nice for this patch not to get lost. It fixes issues both repoted
>> on opensuse and fedora.
> 
> Sorry for the delay. I've now queued the patch. Thanks for fixing this,
> 

Any plans to apply this patch on top of 5.2.* and 5.1.* ?
