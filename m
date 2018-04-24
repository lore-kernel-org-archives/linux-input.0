From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH] Input: xen-kbdfront - allow better run-time configuration
Date: Tue, 24 Apr 2018 08:55:19 +0300
Message-ID: <8ef84389-4659-d4bb-271f-53155062b7b6@gmail.com>
References: <20180418150445.9805-1-andr2000@gmail.com>
 <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
 <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
 <20180423185325.GB66646@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423185325.GB66646@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, lyan@suse.com, boris.ostrovsky@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 04/23/2018 09:53 PM, Dmitry Torokhov wrote:
> On Thu, Apr 19, 2018 at 02:44:19PM +0300, Oleksandr Andrushchenko wrote:
>> On 04/19/2018 02:25 PM, Juergen Gross wrote:
>>> On 18/04/18 17:04, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> It is now only possible to control if multi-touch virtual device
>>>> is created or not (via the corresponding XenStore entries),
>>>> but keyboard and pointer devices are always created.
>>> Why don't you want to go that route for keyboard and mouse, too?
>>> Or does this really make no sense?
>> Well, I would prefer not to touch anything outside Linux and
>> this driver. And these settings seem to be implementation specific.
>> So, this is why introduce Linux module parameters and don't extend
>> the kbdif protocol.
> Why do you consider this implementation specific? How other guests
> decide to forego creation of relative pointer device or keyboard-like
> device?
>
> You already have "features" for absolute pointing device and multitouch,
> so please extend the protocol properly so you indeed do not code
> something implementation-specific (i.e. module parameters).
Ok, but in order to preserve the default behavior, e.g.
pointer and keyboard devices are always created now, I'll have
to have reverse features in the protocol:
  - feature-no-pointer
  - feature-no-keyboard
The above may be set as a part of frontend's configuration and
if missed are considered to be set to false.

>
> Thanks.
>
