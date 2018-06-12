From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 2/3] Input: xen-kbdfront - fix multi-touch XenStore
 node's locations
Date: Tue, 12 Jun 2018 15:47:13 +0200
Message-ID: <efd627f7-8d12-c0c1-f21d-36baacc45522@suse.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-3-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612074856.28451-3-andr2000@gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> kbdif protocol describes multi-touch device parameters as a
> part of frontend's XenBus configuration nodes while they
> belong to backend's configuration. Fix this by reading the
> parameters as defined by the protocol.
> 
> Fixes: 49aac8204da5 ("Input: xen-kbdfront - add multi-touch support")
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
