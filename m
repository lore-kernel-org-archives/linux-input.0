From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?=
        <thomas_os@shipmail.org>
Subject: Re: [PATCH 4/4] input/vmmouse: Update the backdoor call with support
 for new instructions
Date: Wed, 21 Aug 2019 17:48:23 +0200
Message-ID: <027a55d6-ab26-ef9c-bd89-93a38f96160b@shipmail.org>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-5-thomas_os@shipmail.org> <20190821050925.GA566@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821050925.GA566@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org, Doug Covelli <dcovelli@vmware.com>
List-Id: linux-input@vger.kernel.org

On 8/21/19 7:09 AM, Dmitry Torokhov wrote:
> On Sun, Aug 18, 2019 at 04:33:16PM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Use the definition provided by include/asm/vmware.h
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: <linux-input@vger.kernel.org>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> Reviewed-by: Doug Covelli <dcovelli@vmware.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Please feel free to merge with the rest of the patches introducing
> VMWARE_HYPERCALL.

Thanks, Dmitry!

I have a version 2 of the patch were the only difference is that edx is 
initialized to zero which is default for vmcall / vmmcall. Can I use 
your ack for that one as well?

Thanks,

Thomas
