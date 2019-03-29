From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4] HID: core: move Usage Page concatenation to Main item
Date: Fri, 29 Mar 2019 08:51:37 +0100
Message-ID: <CAO-hwJJ926=ivk0avup_H3nAOYCbjkWT1M12wjyizJA2uojqtQ@mail.gmail.com>
References: <20190327101848.25477-1-nsaenzjulienne@suse.de>
 <BYAPR02MB5607E9396127F67A9A2BEC948A590@BYAPR02MB5607.namprd02.prod.outlook.com>
 <CAO-hwJLatVKwgevfdFk1Lqqpg3H7Oc28_VEkiyxPXne3fhSrqw@mail.gmail.com> <BYAPR02MB560797BC61D1AE47761139B48A5A0@BYAPR02MB5607.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR02MB560797BC61D1AE47761139B48A5A0@BYAPR02MB5607.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Junge, Terry" <terry.junge@poly.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jiri Kosina <jikos@kernel.org>, "oneukum@suse.de" <oneukum@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 29, 2019 at 1:48 AM Junge, Terry <terry.junge@poly.com> wrote:
>
> On Thursday, March 28, 2019 6:49 AM Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >>
> >> Hi Nicolas,
> >>
> >> V4 looks good to me.
> >
> >Looks good to me too.
> >
> >Terry, can I consider this as a formal Rev-by you?
>
> Benjamin,
>
> Yes, thank you. What is the normal way of formally indicating Rev-by?
>

Thanks.

So giving a rev-by is described in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
section 13.

Basically, you just answer a patch with: "Reviewed-by: Your Name
<your@address.sth>" (without quotes).

This has 2 benefits: it's formal, and everybody understands it, and
patchwork (at https://patchwork.kernel.org/patch/10873179/ for this
patch) will catch it. Then with the patchwork client, I can apply the
patch without having to manually add your tag :) (no need to resend
one here, unless you want to  give a try, I'll apply it manually).

Cheers,
Benjamin
