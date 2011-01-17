From: Walter Goossens <waltergoossens-CmkmPbn3yAE@public.gmane.org>
Subject: Re: [PATCH] alter_ps2: Add devicetree support
Date: Mon, 17 Jan 2011 22:04:03 +0100
Message-ID: <4D34AEC3.60801@home.nl>
References: <4D040D1C.2020705@home.nl>
	<1295245760-4566-1-git-send-email-thomas@wytron.com.tw>
	<AANLkTi=8+Q5dm+5Pa-cYkmaBWQ4S7jgjZOL0ovtmrdxB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <AANLkTi=8+Q5dm+5Pa-cYkmaBWQ4S7jgjZOL0ovtmrdxB-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 1/17/11 7:59 AM, Grant Likely wrote:
> On Sun, Jan 16, 2011 at 11:29 PM, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org> wrote:
>> From: Walter Goossens <waltergoossens-CmkmPbn3yAE@public.gmane.org>
>>
>> Signed-off-by: Walter Goossens <waltergoossens-CmkmPbn3yAE@public.gmane.org>
>> Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
>> ---
>>  drivers/input/serio/altera_ps2.c |   16 ++++++++++++++++
>>  1 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
>> index 7998560..93054a1 100644
>> --- a/drivers/input/serio/altera_ps2.c
>> +++ b/drivers/input/serio/altera_ps2.c
>> @@ -19,6 +19,9 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/io.h>
>>  #include <linux/slab.h>
>> +#ifdef CONFIG_OF
>> +#include <linux/of.h>
>> +#endif
>>
>>  #define DRV_NAME "altera_ps2"
>>
>> @@ -173,6 +176,16 @@ static int __devexit altera_ps2_remove(struct platform_device *pdev)
>>        return 0;
>>  }
>>
>> +#ifdef CONFIG_OF
>> +static struct of_device_id altera_ps2_match[] = {
>> +       {
>> +               .compatible = "altera,altera_ps2",
>> +       },
> So is this an FPGA soft core PS2 device?  Is there any kind of version
> attached to the soft core?  The compatible value should specify an
> exact version of the implementation that this driver works with.
> (Newer core versions can claim compatibility with older ones, so the
> driver's compatible list doesn't need to be exhaustive).
>
What's the preferred way of versioning components in a device-tree?
Quite a few components inside an fpga will get a new version number with
every release of the tools. For example components supplied by Altera
will get a new number with every release of their IP library (approx.
twice a year) even when (at least from a software point of view) there
is nothing changed in the core. Should we add the number to the
"compatible" name and possibly get slightly more bulky drivers, or add a
version tag to the components where a driver can make decisions based on
the version of the core (if needed)?
Another way to reduce the number of lines in a compatible section would
be to add both their versioned and unversioned compatible entry in the
dts so drivers not needing a specific version don't need to supply the
entire list.
We do have the version numbers available when generating the DTS and
NiosII is still quite new to device-tree so we are still flexible in
fixing this in the best possible way.

> Otherwise, this patch looks correct.
>
> g.
>
>> +       {},
>> +}
>> +MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
>> +#endif /* CONFIG_OF */
>> +
>>  /*
>>  * Our device driver structure
>>  */
>> @@ -182,6 +195,9 @@ static struct platform_driver altera_ps2_driver = {
>>        .driver = {
>>                .name   = DRV_NAME,
>>                .owner  = THIS_MODULE,
>> +#ifdef CONFIG_OF
>> +               .of_match_table = altera_ps2_match,
>> +#endif
>>        },
>>  };
>>
>> --
>> 1.7.3.4
>>
>>
>
>
