From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time
 configuration
Date: Thu, 17 May 2018 09:08:59 -0400
Message-ID: <d35b6720-62e3-e9d4-dbe5-a04d75dde0b7@oracle.com>
References: <20180514144029.16019-1-andr2000@gmail.com>
 <20180514144029.16019-2-andr2000@gmail.com> <20180516171528.GD21971@dtor-ws>
 <e9882c52-3641-7c32-1f64-dd9c4f35de5f@gmail.com>
 <20180516210817.GF21971@dtor-ws>
 <7cecb5d1-5cd3-b63d-d6eb-d1e2dfba9ca6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7cecb5d1-5cd3-b63d-d6eb-d1e2dfba9ca6@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com, konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 05/17/2018 01:31 AM, Oleksandr Andrushchenko wrote:
> I will go with the change you suggested and
> I'll send v4 tomorrow then.



Please make sure your changes to kbdif.h are in Xen first. I believe you
submitted a patch there but I don't see it in the staging tree yet.

-boris
