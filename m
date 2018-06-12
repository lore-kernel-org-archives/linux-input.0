From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 3/3] Input: xen-kbdfront - allow better run-time
 configuration
Date: Tue, 12 Jun 2018 15:50:08 +0200
Message-ID: <5fbac8d0-a3cf-af8a-690e-947752a53ab6@suse.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-4-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612074856.28451-4-andr2000@gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> It is now only possible to control if multi-touch virtual device
> is created or not (via the corresponding XenStore entries),
> but keyboard and pointer devices are always created.
> In some cases this is not desirable. For example, if virtual
> keyboard device is exposed to Android then the latter won't
> automatically show on-screen keyboard as it expects that a
> physical keyboard device can be used for typing.
> 
> Utilize keyboard and pointer device XenStore feature fields to
> configure which virtual devices are created:
>  - set "feature-disable-keyboard" to 1 if no keyboard device
>    needs to be created
>  - set "feature-disable-pointer" to 1 if no pointer device
>    needs to be created
> Keep old behavior by default.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Suggested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
> Tested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
