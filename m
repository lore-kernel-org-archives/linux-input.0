From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
Date: Tue, 12 Jun 2018 15:46:10 +0200
Message-ID: <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612074856.28451-2-andr2000@gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> This is the sync up with the canonical definitions of the input,
> sound and display protocols in Xen.
> 
> Changes to kbdif:
> 1. Add missing string constants for {feature|request}-raw-pointer
>    to align with the rest of the interface file.
> 
> 2. Add new XenStore feature fields, so it is possible to individually
>    control set of exposed virtual devices for each guest OS:
>      - set feature-disable-keyboard to 1 if no keyboard device needs
>        to be created
>      - set feature-disable-pointer to 1 if no pointer device needs
>        to be created
> 
> 3. Move multi-touch device parameters to backend nodes: these are
>     described as a part of frontend's XenBus configuration nodes
>     while they belong to backend's configuration. Fix this by moving
>     the parameters to the proper section.
> 
> Unique-id field:
> 1. Add unique-id XenBus entry for virtual input and display.
> 
> 2. Change type of unique-id field to string for sndif to align with
> display and input protocols.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>

I'm fine with this patch being added via the input tree with the other
patches. In case I should take it via the Xen tree, please send me a
note.


Juergen
