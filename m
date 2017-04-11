From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/2] xen,input: add xen-kbdfront module parameter for
 setting resolution
Date: Tue, 11 Apr 2017 11:35:35 +0200
Message-ID: <7298823d-0896-2ec9-363d-bde965b264bf@suse.com>
References: <20170411085028.6750-1-jgross@suse.com>
 <20170411085028.6750-2-jgross@suse.com>
 <c7608f78-912b-c777-0aa9-1db64fb003f4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c7608f78-912b-c777-0aa9-1db64fb003f4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On 11/04/17 11:26, Oleksandr Andrushchenko wrote:
> On 04/11/2017 11:50 AM, Juergen Gross wrote:
>> Add a parameter for setting the resolution of xen-kbdfront in order to
>> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   drivers/input/misc/xen-kbdfront.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c
>> b/drivers/input/misc/xen-kbdfront.c
>> index 3900875dec10..90e7981a7768 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -41,6 +41,12 @@ struct xenkbd_info {
>>       char phys[32];
>>   };
>>   +enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
>> +static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
> if you are about to release yet another version of the series,
> could you please also rename "size" to "ptr_size/pointer_size/XXX",
> so later when I add multi-touch support I can have
> "mtouch_size" module parameter and they are consistent all together?

Sure. After all I think I can merge the patches, as reading width and
height a second time while connecting the device seems to be pointless.

While logically patch 2 seems to correct the connection process there
was never a problem with it being wrong: width and height would have
been already read during probing of the device so missing to read them
again wouldn't lead to any wrong settings.


Juergen
