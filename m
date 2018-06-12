From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Date: Tue, 12 Jun 2018 17:24:47 +0300
Message-ID: <CAHp75Vdaqj+n=F7wSB9PFGpf9Ok2XZzKcq_H0DzmtjmN-4UUfw@mail.gmail.com>
References: <20180612032831.29747-1-bhe@redhat.com>
 <20180612032831.29747-2-bhe@redhat.com>
 <CAHp75Vd6v4+RTq-5uw_BJpT6=w2KGjTfU+rEst6+8igs2cyntw@mail.gmail.com>
 <20180612093812.GC1820@MiWiFi-R3L-srv>
 <CAHp75Vf_kBLkE6v=JyOdfNoWktWEfKs7JzRP1XEc4TeuT5xqfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAHp75Vf_kBLkE6v=JyOdfNoWktWEfKs7JzRP1XEc4TeuT5xqfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1561eoWH0uzbU5w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 12, 2018 at 5:20 PM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jun 12, 2018 at 12:38 PM, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On 06/12/18 at 11:29am, Andy Shevchenko wrote:
>>> On Tue, Jun 12, 2018 at 6:28 AM, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>>> > +{
>>>
>>> > +       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
>>> > +               if (p->end < res->start)
>>> > +                       continue;
>>> > +               if (res->end < p->start)
>>> > +                       break;
>>>
>>> > +               if (p->start < res->start || p->end > res->end)
>>> > +                       return -1;      /* not completely contained */
>>>
>>> Usually we are expecting real eeror codes.
>>
>> Hmm, I just copied it from arch/powerpc/kernel/pci-common.c. The
>> function interface expects an integer returned value, not sure what a
>> real error codes look like, could you give more hints? Will change
>> accordingly.
>
> I briefly looked at the code and error codes we have, so, my proposal
> is one of the following

>  - use -ECANCELED (not the best choice for first occurrence here,
> though I can't find better)

Actually -ENOTSUPP might suit the first case (although the actual
would be something like -EOVERLAP, which we don't have)

>  - use positive integers (or enum), like
>   #define RES_REPARENTED 0
>   #define RES_OVERLAPPED 1
>   #define RES_NOCONFLICT 2
>
>
>>> > +               if (firstpp == NULL)
>>> > +                       firstpp = pp;
>>> > +       }
>>>
>>> > +       if (firstpp == NULL)
>>> > +               return -1;      /* didn't find any conflicting entries? */
>>>
>>> Ditto.
>
> Ditto.
>
>>>
>>> > +}
>>> > +EXPORT_SYMBOL(reparent_resources);
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
