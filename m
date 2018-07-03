From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Date: Tue, 3 Jul 2018 23:57:48 +0300
Message-ID: <CAHp75VeEjhcYF4Fy4O_srdv_nEGGjGwAHhZufscB_tiLQVQ=FQ@mail.gmail.com>
References: <20180612032831.29747-1-bhe@redhat.com>
 <20180612032831.29747-2-bhe@redhat.com>
 <CAHp75Vd6v4+RTq-5uw_BJpT6=w2KGjTfU+rEst6+8igs2cyntw@mail.gmail.com>
 <20180612093812.GC1820@MiWiFi-R3L-srv>
 <CAHp75Vf_kBLkE6v=JyOdfNoWktWEfKs7JzRP1XEc4TeuT5xqfw@mail.gmail.com>
 <CAHp75Vdaqj+n=F7wSB9PFGpf9Ok2XZzKcq_H0DzmtjmN-4UUfw@mail.gmail.com>
 <20180703145503.GA1225@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180703145503.GA1225@MiWiFi-R3L-srv>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Baoquan He <bhe@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, brijesh.singh@amd.com, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, baiyaowei@cmss.chinamobile.com, Frank Rowand <frowand.list@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org, Michael Ellerman <mpe@ellerman.id.au>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input <linux-input@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>, Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Haiyang Zhang <haiyangz@microsoft.com>, Maarten
List-Id: linux-input@vger.kernel.org

On Tue, Jul 3, 2018 at 5:55 PM, Baoquan He <bhe@redhat.com> wrote:
> On 06/12/18 at 05:24pm, Andy Shevchenko wrote:
>> On Tue, Jun 12, 2018 at 5:20 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:

>> > I briefly looked at the code and error codes we have, so, my proposal
>> > is one of the following
>>
>> >  - use -ECANCELED (not the best choice for first occurrence here,
>> > though I can't find better)
>>
>> Actually -ENOTSUPP might suit the first case (although the actual
>> would be something like -EOVERLAP, which we don't have)
>
> Sorry for late reply, and many thanks for your great suggestion.
>

> I am fine to use -ENOTSUPP as the first returned value, and -ECANCELED
> for the 2nd one.

I have no strong opinion, but I like (slightly better) this approach ^^^

> Or define an enum as you suggested inside the function
> or in header file.

>
> Or use -EBUSY for the first case because existing resource is
> overlapping but not fully contained by 'res'; and -EINVAL for
> the 2nd case since didn't find any one resources which is contained by
> 'res', means we passed in a invalid resource.
>
> All is fine to me, I can repost with each of them.

>> >  - use positive integers (or enum), like
>> >   #define RES_REPARENTED 0
>> >   #define RES_OVERLAPPED 1
>> >   #define RES_NOCONFLICT 2

-- 
With Best Regards,
Andy Shevchenko
