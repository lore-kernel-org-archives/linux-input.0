From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 3/9] nvmem: core: add nvmem_device_find
Date: Wed, 14 Aug 2019 13:52:49 +0100
Message-ID: <31d680ee-ddb3-8536-c915-576222d263e1@linaro.org>
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
 <20190809103235.16338-4-tbogendoerfer@suse.de>
 <8d18de64-9234-fcba-aa3d-b46789eb62a5@linaro.org>
 <20190814134616.b4dab3c0aa6ac913d78edb6a@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190814134616.b4dab3c0aa6ac913d78edb6a@suse.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 14/08/2019 12:46, Thomas Bogendoerfer wrote:
> On Tue, 13 Aug 2019 10:40:34 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
>>
>>
>> On 09/08/2019 11:32, Thomas Bogendoerfer wrote:
>>> nvmem_device_find provides a way to search for nvmem devices with
>>> the help of a match function simlair to bus_find_device.
>>>
>>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>>> ---
>>>    drivers/nvmem/core.c           | 62 ++++++++++++++++++++++--------------------
>>>    include/linux/nvmem-consumer.h |  9 ++++++
>>>    2 files changed, 41 insertions(+), 30 deletions(-)
>>
>> Have you considered using nvmem_register_notifier() ?
> 
> yes, that was the first idea. But then I realized I need to build up
> a private database of information already present in nvmem bus. So I
> looked for a way to retrieve it from there. Unfortunately I couldn't
> use bus_find_device directly, because nvmem_bus_type and struct nvmem_device
> is hidden. So I refactured the lookup code and added a more universal
> lookup function, which fits my needs and should be usable for more.
I see your point.

overall the patch as it is look good, but recently we added more generic 
lookups for DT node, looks like part of your patch is un-doing generic 
device name lookup.

DT node match lookup is in 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/log/?h=generic_lookup_helpers

of_nvmem_match and nvmem_match_name are duplicating the code here.
Looks like its possible to use generic lookups along with custom match 
by splitting __nvmem_device_get() to two functions, one for lookup and 
other for refcounting.

Other missing bit is adding this api to documentation in 
./Documentation/driver-api/nvmem.rst


thanks,
srini
> 
> Thomas.
> 
